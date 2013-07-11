package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.pagedList.model.*;
	
	import edu.isi.bmkeg.triage.rl.events.*;
	
	import edu.isi.bmkeg.triageModule.model.TriageModel;

	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	public class ListTriageScoreListPagedResultCommand extends Command
	{
		
		[Inject]
		public var event:ListTriageScoreListPagedResultEvent;
		
		[Inject]
		public var listModel:PagedListModel;
		
		override public function execute():void
		{
						
			var l:ArrayCollection = new ArrayCollection();

			for each(var lvi:LightViewInstance in event.list) {
					
				var o:Object = new Object();
				o.vpdmfLabel = lvi.vpdmfLabel;
				o.vpdmfId = lvi.vpdmfId;
				var fields:Array = lvi.indexTupleFields.split(/\<\|\>/);
				var tuple:Array = lvi.indexTuple.split(/\<\|\>/);
					
				for(var i:int=0; i<fields.length; i++) {
					var f:String = fields[i] as String;
					var v:String = tuple[i] as String;			
					if( v == null )
						v = "";
					v = v.replace(/,/,", ");
					o[f]=v;	
				}
					
				l.addItem(o);
				
			}
			
			if( event.offset == 0 ) {
				listModel.storeObjectsAt(event.offset, l.toArray(), true);
			} else {
				listModel.storeObjectsAt(event.offset, l.toArray(), false);
			}
			
		}
		
	}
	
}