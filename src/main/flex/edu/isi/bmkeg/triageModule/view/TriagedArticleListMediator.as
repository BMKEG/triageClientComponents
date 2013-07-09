package edu.isi.bmkeg.triageModule.view
{
	
	import edu.isi.bmkeg.pagedList.events.*;
	import edu.isi.bmkeg.pagedList.model.*;
	
	import edu.isi.bmkeg.triage.events.*;
	import edu.isi.bmkeg.triage.model.*;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triageModule.events.*;
	import edu.isi.bmkeg.triageModule.model.*;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class TriagedArticleListMediator extends Mediator
	{
		[Inject]
		public var view:TriagedArticleList;
		
		[Inject]
		public var listModel:PagedListModel;

		[Inject]
		public var model:TriageModel;
		
		override public function onRegister():void
		{
			
			addContextListener(PagedListUpdatedEvent.UPDATED, 
				triageDocumentsListUpdatedHandler);

			addContextListener(FindTriageScoreByIdResultEvent.FIND_TRIAGESCOREBY_ID_RESULT, 
				triagedArticleResultHandler);
			
			addContextListener(ClearTriageCorpusEvent.CLEAR_TRIAGE_CORPUS, 
				clearTriageCorpusHandler);
			
			addViewListener(FindTriageScoreByIdEvent.FIND_TRIAGESCORE_BY_ID, 
				dispatch);
			
			addViewListener(SwitchInOutEvent.SWITCH, 
				switchInOutCodes);
			
			listModel.pageSize = model.listPageSize;
		
		}
		
		private function triageDocumentsListUpdatedHandler(event:PagedListUpdatedEvent):void
		{
			
			view.triageDocumentsList = listModel.pagedList;
			view.listLength = listModel.pagedListLength;
			
		}
		
		private function triagedArticleResultHandler(event:FindTriageScoreByIdResultEvent):void
		{
			/*var td:TriagedDocument = TriagedDocument(event.object);
						
			for each(var lvi:LightViewInstance in event.list) {
				
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
				
				objects.addItem(o);
				
			}
			
			view.triageDocumentsList = objects;*/
			
		}
		
		private function switchInOutCodes(event:SwitchInOutEvent):void {
			
			var td:TriageScore = model.currentScore;
			td.inOutCode = event.code;
			
			dispatch( new UpdateTriagedArticleEvent(td) ); 
						
		}
		
		// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		// Reset everything
		//
		public function clearTriageCorpusHandler(event:ClearTriageCorpusEvent):void {
			
			view.triageDocumentsList = listModel.pagedList;
			
		}
		
	}
	
}