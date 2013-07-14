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
		public var listModel:TriageCorpusPagedListModel;

		[Inject]
		public var model:TriageModel;
		
		override public function onRegister():void
		{
			
			addContextListener(PagedListUpdatedEvent.UPDATED + TriageCorpusPagedListModel.LIST_ID, 
				triageDocumentsListUpdatedHandler);
			
			addContextListener(ClearTriageCorpusEvent.CLEAR_TRIAGE_CORPUS, 
				clearTriageCorpusHandler);
			
			addViewListener(FindTriageScoreByIdEvent.FIND_TRIAGESCORE_BY_ID, 
				dispatch);
			
			addViewListener(SwitchInOutEvent.SWITCH, 
				switchInOutCodes);
			
			listModel.pageSize = model.listPageSize;
			
			// If we already have a triageCorpus specified, then run this. 
			if( model.triageCorpus != null ) {
				
				view.triageDocumentsList = listModel.pagedList;
				view.listLength = listModel.pagedListLength;
				
			}
		}
		
		private function triageDocumentsListUpdatedHandler(event:PagedListUpdatedEvent):void
		{
			if( event.listId != view.id )
				return;
			
			view.triageDocumentsList = listModel.pagedList;
			view.listLength = listModel.pagedListLength;
			
		}
	
		
		private function switchInOutCodes(event:SwitchInOutEvent):void {

			var td:TriageScore = TriageScore(model.currentCitation.triageScores.getItemAt(0));
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