package edu.isi.bmkeg.triageModule.view
{

	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
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

		override public function onRegister():void {
			
			addContextListener(FindTriageScoreByIdResultEvent.FIND_TRIAGESCOREBY_ID_RESULT, 
				findTriagedArticleByIdResultHandler);

			addContextListener(FindArticleCitationDocumentByIdResultEvent.FIND_ARTICLECITATIONDOCUMENTBY_ID_RESULT, 
				findArticleCitationDocumentByIdResultHandler);

			addContextListener(ListTriagedArticlePagedEvent.LIST_TRIAGEDARTICLE_PAGED, 
				listTriagedArticlePagedHandler);
			
			loadCurrentSelection();
		}
		
		private function findTriagedArticleByIdResultHandler(event:FindTriageScoreByIdResultEvent):void {

			loadCurrentSelection();
		
		}

		private function listTriagedArticlePagedHandler(event:ListTriagedArticlePagedEvent):void {
			
			loadCurrentSelection();
			
		}

		private function findArticleCitationDocumentByIdResultHandler(event:FindArticleCitationDocumentByIdResultEvent):void {
			
			loadCurrentSelection();
			
		}
		
		private function loadCurrentSelection():void {
			
			try {
				
				var a:LiteratureCitation = triageModel.currentCitation;
				
				if (a == null) {

					view.clearFormFields();

				} else {
										
					if (view.loadedArticle !== a) {
						view.loadLiteratureCitation(a);											
					}
				}
			
			} catch (e:ItemPendingError) {

				e.addResponder(new ItemResponder(itemPendingResult, null));
			
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

	}

}