package edu.isi.bmkeg.triageModule.controller
{	
	
	import edu.isi.bmkeg.pagedList.model.*;
	
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triageModule.model.*;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	public class ListTriagedArticleResultCommand extends Command
	{
		
		[Inject]
		public var event:ListTriagedArticleResultEvent;
		
		[Inject]
		public var listModel:TriageCorpusPagedListModel;
		
		override public function execute():void
		{
			
			if( event.list.length != 1 ) {
				trace("Error: list update returned more than one element");
				return;
			}
			
			var lvi:LightViewInstance = event.list[0];

			var o:Object = new Object();
			o.vpdmfLabel = lvi.vpdmfLabel;
			o.vpdmfId = lvi.vpdmfId;
			var fields:Array = lvi.indexTupleFields.split(/\<\|\>/);
			var tuple:Array = lvi.indexTuple.split(/\<\|\>/);
					
			for(var i:int=0; i<fields.length; i++) {
				var f:String = fields[i] as String;
				var v:String = tuple[i] as String;					
				v = v.replace(/,/,", ");
				o[f]=v;	
			}
			
			for(var ii:int=0; ii<listModel.pagedList.length; ii++ ) {
				var listObj:Object = listModel.pagedList.getItemAt(ii);
				if( listObj.vpdmfId == o.vpdmfId ) {
					listModel.pagedList.setItemAt(o, ii);
					return;
				}
			}

		}
		
	}
	
}