package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.pagedList.model.*;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triageModule.model.TriageCorpusPagedListModel;
	import edu.isi.bmkeg.triageModule.model.TriageModel;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	import org.robotlegs.mvcs.Command;
	
	public class ListTriagedArticlePagedResultCommand extends Command
	{
		
		[Inject]
		public var event:ListTriagedArticlePagedResultEvent;

		[Inject]
		public var triageModel:TriageModel;
		
		[Inject]
		public var listModel:TriageCorpusPagedListModel;

		override public function execute():void
		{
			
			var l:ArrayCollection = new ArrayCollection();
			var hash:Object = new Object();
			
			for each(var lvi:LightViewInstance in event.list) {
				
				var fields:Array = lvi.indexTupleFields.split(/\{\|\}/);
				var tuple:Array = lvi.indexTuple.split(/\{\|\}/);
				var o:Object = new Object();
				for(var i:int=0; i<fields.length; i++) {
					var f:String = fields[i] as String;
					var v:String = tuple[i] as String;					
					v = v.replace(/,/,", ");
					o[f]=v;	
				}
				
				var pmid:Number = Number(o["ArticleCitation_7"]);
				
				var o2:Object = new Object();
				if( hash[pmid] != null ){
					o2 = hash[pmid];
				} else {
					hash[pmid] = o2;	
					o2["vpdmfId"] = lvi.vpdmfId;
					o2["pmid"] = pmid;
					o2["citation"] = o["ArticleCitation"];
					o2["triagedCorpus"] = o["TriageCorpus"];
					l.addItem(o2);
				}

				var c:String = String(o["TriagedArticle_4"]);
				o2[c + ".vpdmfId"] = lvi.vpdmfId;
				o2[c + ".score"] = o["TriagedArticle_3"];
				o2[c + ".inOut"] = o["TriagedArticle_2"];
				
			}
				
			var nCorpora:int = triageModel.queryCorpusCount;
			var offset:int = event.offset / nCorpora;
			
			if( event.offset == 0 ) {
				listModel.storeObjectsAt(offset, l.toArray(), true);
			} else {
				listModel.storeObjectsAt(offset, l.toArray(), false);
			}
			
		}
		
	}
	
}