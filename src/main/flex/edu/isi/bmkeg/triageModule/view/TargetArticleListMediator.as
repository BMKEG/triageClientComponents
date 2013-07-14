package edu.isi.bmkeg.triageModule.view
{
	
	import edu.isi.bmkeg.pagedList.events.*;
	import edu.isi.bmkeg.pagedList.model.*;
	
	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
	import edu.isi.bmkeg.triage.model.TriageCorpus;
	import edu.isi.bmkeg.triage.model.qo.TriageScore_qo;
	
	
	import edu.isi.bmkeg.triage.events.*;
	import edu.isi.bmkeg.triage.model.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.FindArticleCitationDocumentByIdEvent;
	import edu.isi.bmkeg.triageModule.events.*;
	import edu.isi.bmkeg.triageModule.model.*;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class TargetArticleListMediator extends Mediator
	{
		[Inject]
		public var view:TargetArticleList;
		
		[Inject]
		public var listModel:TargetCorpusPagedListModel;

		[Inject]
		public var model:TriageModel;
		
		override public function onRegister():void
		{
			
			addContextListener(PagedListUpdatedEvent.UPDATED + TargetCorpusPagedListModel.LIST_ID, 
				targetDocumentsListUpdatedHandler);
						
			addViewListener(FindArticleCitationDocumentByIdEvent.FIND_ARTICLECITATIONDOCUMENT_BY_ID, 
				dispatch);
			
			listModel.pageSize = model.listPageSize;
		
			// If we already have a targetCorpus specified, then run this. 
			if( model.targetCorpus != null ) {
				
				view.documentsList = listModel.pagedList;
				view.listLength = listModel.pagedListLength;
				
			}
			
		}
		
		private function targetDocumentsListUpdatedHandler(event:PagedListUpdatedEvent):void
		{
			
			view.documentsList = listModel.pagedList;
			view.listLength = listModel.pagedListLength;
			
		}
		
	}
	
}