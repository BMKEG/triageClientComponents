package edu.isi.bmkeg.triageModule.view
{
	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
	import edu.isi.bmkeg.triage.events.*;
	import edu.isi.bmkeg.triage.model.*;
	import edu.isi.bmkeg.triage.model.qo.TriageCorpus_qo;
	import edu.isi.bmkeg.triage.model.qo.TriageScore_qo;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triageModule.model.TriageModel;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
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
			// list the corpora. 
			addViewListener(ListCorpusEvent.LIST_CORPUS, 
				dispatch);
			addContextListener(ListCorpusResultEvent.LIST_CORPUS_RESULT, 
				listCorpusResultHandler);
			
			addViewListener(FindCorpusByIdEvent.FIND_CORPUS_BY_ID, 
				dispatchFindCorpusById);
			addContextListener(FindCorpusByIdResultEvent.FIND_CORPUSBY_ID_RESULT, 
				handleLoadedTargetCorpus);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// List the triage corpora. 
			addViewListener(ListTriageCorpusEvent.LIST_TRIAGECORPUS, 
				dispatch);
			addContextListener(ListTriageCorpusResultEvent.LIST_TRIAGECORPUS_RESULT, 
				listTriageCorpusResultHandler);
			addViewListener(SelectTriageCorpusEvent.SELECT_TRIAGE_CORPUS, 
				dispatchSelectTriageCorpus);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Reset everything
			addViewListener(ClearTriageCorpusEvent.CLEAR_TRIAGE_CORPUS, 
				dispatch);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// On loading this control, we first list all the corpora on the server
			dispatch(new ListCorpusEvent(new Corpus_qo()));
			dispatch(new ListTriageCorpusEvent(new TriageCorpus_qo()));
			
		}

		public function listCorpusResultHandler(event:ListCorpusResultEvent):void {
			view.corpusList = triageModel.corpora;
		}

		public function listTriageCorpusResultHandler(event:ListTriageCorpusResultEvent):void {
			view.slaveList = event.list;
		}
		
		public function dispatchFindCorpusById(event:FindCorpusByIdEvent):void {
			
			triageModel.targetCorpus = new Corpus();
			triageModel.targetCorpus.vpdmfId = event.id;
			
			this.dispatchListTriageScoreListPaged();

			this.dispatch( event );
			
		}
		
		public function dispatchSelectTriageCorpus(event:SelectTriageCorpusEvent):void {
			
			triageModel.triageCorpus = new TriageCorpus();
			triageModel.triageCorpus.vpdmfId = event.vpdmfId;
			triageModel.currentInOutCode = event.inOutCode;
				
			this.dispatchListTriageScoreListPaged();
			
			this.dispatch(new FindTriageCorpusByIdEvent(event.vpdmfId) );
		
		}
		
		private function dispatchListTriageScoreListPaged():void {

			var ts:TriageScore_qo = new TriageScore_qo();
			var tc:TriageCorpus_qo = new TriageCorpus_qo();
			var tt:Corpus_qo = new Corpus_qo();
			
			ts.triageCorpus = tc;
			ts.targetCorpus = tt;
			
			if( triageModel.triageCorpus != null 
				&& triageModel.targetCorpus != null) {	
			
				tc.vpdmfId = String(triageModel.triageCorpus.vpdmfId);
				tt.vpdmfId = String(triageModel.targetCorpus.vpdmfId);
				ts.inOutCode = triageModel.currentInOutCode;
				
				this.dispatch(new ListTriageScoreListPagedEvent(ts, 0, triageModel.listPageSize));
			
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
		
		// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		// Reset everything
		//
		public function clearTriageCorpusHandler(event:ClearTriageCorpusEvent):void {

			view.currentState = "empty";
			view.corpusCombo.selectedIndex = -1;
			dispatch(new ListCorpusEvent(new Corpus_qo()));
			
		}

		
	}
	
}