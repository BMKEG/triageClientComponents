package edu.isi.bmkeg.triageModule.view
{

	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.pagedList.*;
	import edu.isi.bmkeg.pagedList.model.*;
	import edu.isi.bmkeg.triage.events.*;
	import edu.isi.bmkeg.triage.model.*;
	import edu.isi.bmkeg.triage.model.qo.TriageScore_qo;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triageModule.events.*;
	import edu.isi.bmkeg.triageModule.model.*;
	
	import flash.events.Event;
	
	import mx.collections.ItemResponder;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.Alert;
	import mx.events.CollectionEvent;
	import mx.managers.PopUpManager;
	import mx.utils.StringUtil;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class TriagedArticleCitationViewMediator extends Mediator
	{
		
		[Inject]
		public var view:TriagedArticleCitationView;
		
		[Inject]
		public var triageModel:TriageModel;

		[Inject]
		public var listModel:PagedListModel;
		
		override public function onRegister():void {
			
			addContextListener(FindTriageScoreByIdResultEvent.FIND_TRIAGESCOREBY_ID_RESULT, 
				findTriagedArticleByIdResultHandler);

			loadCurrentSelection();
		}
		
		private function findTriagedArticleByIdResultHandler(event:FindTriageScoreByIdResultEvent):void {

			loadCurrentSelection();
		
		}

		private function loadCurrentSelection():void {
			
			try {
				
				var td:TriageScore = triageModel.currentScore;
				
				if (td == null) {

					view.clearFormFields();

				} else {
					
					var a:LiteratureCitation = td.citation;
					
					if (view.loadedArticle !== a) {
						view.loadLiteratureCitation(a);											
					}
				}
			
			} catch (e:ItemPendingError) {

				e.addResponder(new ItemResponder(itemPendingResult,null,listModel.selectedIndex));
			
			}			
		
		}

		private function itemPendingResult(result:Object, token:Object = null):void {

			loadCurrentSelection();
			
//			if (citationsListModel.selectedIndex == int(token) &&
//				result is ArticleCitation)
//			{
//				view.loadArticleCitation(ArticleCitation(result));
//			}
		}
		
		// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		// Reset everything
		//
		public function clearTriageCorpusHandler(event:ClearTriageCorpusEvent):void {
			
			view.clearFormFields();
			
		}

		//
		// This function is called directly from within from within
		//
		private function requestFetchObjects(list:PagedList, index:int, count:int):void 
		{
			var td:TriageScore_qo = triageModel.queryTriagedDocument;
						
			dispatch(new ListTriageScoreListPagedEvent(td, index, list.pageSize));
			
		}
		
	}

}