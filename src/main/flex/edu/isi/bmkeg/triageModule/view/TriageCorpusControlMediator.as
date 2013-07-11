package edu.isi.bmkeg.triageModule.view
{
	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.Corpus_qo;
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
			
//			addViewListener(UserRequestCitationsListFilterChangeToCorpusEvent.CHANGE,dispatch);
						
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// list the corpora. 
			addViewListener(ListCorpusEvent.LIST_CORPUS, 
				dispatch);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// When the context loads a corpus, add it to the control
			addContextListener(ListCorpusResultEvent.LIST_CORPUS_RESULT, 
				listCorpusResultHandler);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// When you select a corpus, list the triage corpora. 
			addViewListener(ListTriageCorpusEvent.LIST_TRIAGECORPUS, 
				dispatch);

			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// When you select a corpus, load it. 
			addViewListener(FindCorpusByIdEvent.FIND_CORPUS_BY_ID, 
				dispatchFindCorpusById);

			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// When the context loads a list of TriageCorpus, add it to the control
			addContextListener(ListTriageCorpusResultEvent.LIST_TRIAGECORPUS_RESULT, 
				listTriageCorpusResultHandler);

			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// When you select a TriageCorpus, list it's documents. 
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