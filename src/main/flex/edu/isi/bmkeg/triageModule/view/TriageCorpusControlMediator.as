package edu.isi.bmkeg.triageModule.view
{
	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
	import edu.isi.bmkeg.triage.events.*;
	import edu.isi.bmkeg.triage.model.*;
	import edu.isi.bmkeg.triage.model.qo.*;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triageModule.events.*;
	import edu.isi.bmkeg.triageModule.model.TriageModel;
	import edu.isi.bmkeg.triageModule.view.popups.*;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import mx.managers.PopUpManager;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class TriageCorpusControlMediator extends Mediator
	{
		[Inject]
		public var view:TriageCorpusControl;
		
		[Inject]
		public var triageModel:TriageModel;
		
		override public function onRegister():void
		{
												
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// List the triage corpora. 
			addViewListener(ListTriageCorpusEvent.LIST_TRIAGECORPUS, 
				dispatch);

			addViewListener(ActivateTriageCorpusPopupEvent.ACTIVATE_TRIAGE_CORPUS_POPUP, 
				activateTriageCorpusPopup);
			
			addViewListener(ActivateUploadPdfPopupEvent.ACTIVATE_PDF_UPLOAD_POPUP, 
				activatePdfUploadPopup);

			addViewListener(DeleteTriageCorpusByIdEvent.DELETE_TRIAGECORPUS_BY_ID, 
				dispatch);

			addViewListener(ActivateClassifierPopupEvent.ACTIVATE_CLASSIFIER_POPUP, 
				activateClassifierPopup);
			
			addViewListener(SelectTriageCorpusEvent.SELECT_TRIAGE_CORPUS, 
				dispatchSelectTriageCorpus);

			addViewListener(ClearTriageCorpusEvent.CLEAR_TRIAGE_CORPUS, 
				dispatch);

			addViewListener(TrainClassifierEvent.TRAIN_CLASSIFIER, 
				dispatch);

			addViewListener(RunClassifierPredictEvent.RUN_CLASSIFIER_PREDICT, 
				dispatch);

			addContextListener(FindTriageCorpusByIdResultEvent.FIND_TRIAGECORPUSBY_ID_RESULT, 
				findTriageCorpusByIdResultHandler);

			addContextListener(ListCorpusResultEvent.LIST_CORPUS_RESULT, 
				listCorpusResultHandler);

			addContextListener(ListTriageClassificationModelResultEvent.LIST_TRIAGECLASSIFICATIONMODEL_RESULT, 
				listTriageClassificationModelResultHandler);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// On loading this control, we first list all the corpora on the server
			dispatch(new ListCorpusEvent(new Corpus_qo()));
			
			view.predictButton.enabled = false;
			view.trainButton.enabled = false;
			
		}
		
		public function findTriageCorpusByIdResultHandler(event:FindTriageCorpusByIdResultEvent):void {
			view.triageCorpus = event.object;
		}

		public function listCorpusResultHandler(event:ListCorpusResultEvent):void {
			view.triageCorpusList = triageModel.triageCorpora;
		}
		
		public function listTriageClassificationModelResultHandler(event:ListTriageClassificationModelResultEvent):void {
			view.targetCorpusList = triageModel.classificationModels;
		}
		
		public function dispatchFindCorpusById(event:FindCorpusByIdEvent):void {
			
			triageModel.targetCorpus = new Corpus();
			triageModel.targetCorpus.vpdmfId = event.id;
			
			this.dispatchListTriagedArticlePaged();

			this.dispatch( event );
			
		}
		
		public function dispatchSelectTriageCorpus(event:SelectTriageCorpusEvent):void {
			
			triageModel.triageCorpus = new TriageCorpus();
			triageModel.triageCorpus.vpdmfId = event.vpdmfId;
			//triageModel.currentInOutCode = event.inOutCode;
				
			this.dispatch(new FindTriageCorpusByIdEvent(event.vpdmfId));
			this.dispatchListTriagedArticlePaged();
		
		}
		
		private function dispatchListTriagedArticlePaged():void {

			var ts:TriageScore_qo = new TriageScore_qo();
			ts.inScore = "<vpdmf-rev-sort-1>"
			var tc:TriageCorpus_qo = new TriageCorpus_qo();			
			ts.triageCorpus = tc;
			var lc:LiteratureCitation_qo = new LiteratureCitation_qo();
			lc.vpdmfId = "<vpdmf-rev-sort-0>"
			
			ts.citation = lc;
			
			if( triageModel.triageCorpus != null ) {	
			
				tc.vpdmfId = String(triageModel.triageCorpus.vpdmfId);
				//ts.inOutCode = triageModel.currentInOutCode;
				
				triageModel.queryCorpusCount = triageModel.corpora.length;		
				this.dispatch(new ListTriagedArticlePagedEvent(
					ts, 
					0, 
					triageModel.listPageSize * triageModel.queryCorpusCount));
			
			}
			
		}
		
		private function handleLoadedTargetCorpus(event:FindCorpusByIdResultEvent):void {

			this.view.triageCorpusCombo.enabled = true;

			var acQ:ArticleCitation_qo = new ArticleCitation_qo();
			var tsQ:TriageScore_qo = new TriageScore_qo();
			var corpQ:Corpus_qo = new Corpus_qo();
			acQ.triageScores.addItem(tsQ);
			tsQ.targetCorpus = corpQ;
			
			tsQ.inOutCode = "in";
			corpQ.name = triageModel.targetCorpus.name;
			corpQ.vpdmfId = triageModel.targetCorpus.vpdmfId + "";
			
			this.dispatch( new ListTargetArticleListPagedEvent(acQ, 0, 300) );

		}
		
		private function activatePdfUploadPopup(e:ActivateUploadPdfPopupEvent):void {
			
			if( e.triageCorpus == null )
				return;
			
			var popup:UploadPdfsPopup = PopUpManager.createPopUp(this.view, UploadPdfsPopup, true) as UploadPdfsPopup;
			PopUpManager.centerPopUp(popup);
			
			mediatorMap.createMediator( popup );
			
			popup.tc = e.triageCorpus;
			
		}
		
		private function activateClassifierPopup(e:ActivateClassifierPopupEvent):void {
			
			var popup:ClassifierPopup = PopUpManager.createPopUp(this.view, ClassifierPopup, true) as ClassifierPopup;
			PopUpManager.centerPopUp(popup);
			
			mediatorMap.createMediator( popup );
						
		}
		
		private function activateTriageCorpusPopup(e:ActivateTriageCorpusPopupEvent):void {
			
			var popup:TriageCorpusPopup = PopUpManager.createPopUp(this.view, TriageCorpusPopup, true) as TriageCorpusPopup;
			PopUpManager.centerPopUp(popup);
			
			mediatorMap.createMediator( popup );
			
			if( e.corpus == null || e.corpus.name == null )			
				popup.cName.text = "";
			else 
				popup.cName.text = e.corpus.name;
			
			if( e.corpus == null || e.corpus.description == null )			
				popup.desc.text = "";
			else 
				popup.desc.text = e.corpus.description;
			
			popup.vpdmfId = e.corpus.vpdmfId;
			
		}
		
		
		// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		// Reset everything
		//
		public function clearTriageCorpusHandler(event:ClearTriageCorpusEvent):void {

			view.currentState = "empty";
			dispatch(new ListCorpusEvent(new Corpus_qo()));
			
		}

		
	}
	
}