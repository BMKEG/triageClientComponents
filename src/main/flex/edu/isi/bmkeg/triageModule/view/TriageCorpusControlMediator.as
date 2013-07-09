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
				dispatch);

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
			var c:Corpus = new Corpus();
			dispatch(new ListCorpusEvent(new Corpus_qo()));
			
			
		}

		public function listCorpusResultHandler(event:ListCorpusResultEvent):void {
			view.corpusList = triageModel.corpora;
		}

		public function listTriageCorpusResultHandler(event:ListTriageCorpusResultEvent):void {
			view.currentState = "corpusLoaded"
			view.slaveList = event.list;
		}
		
		public function dispatchSelectTriageCorpus(event:SelectTriageCorpusEvent):void {

			var ts:TriageScore_qo = new TriageScore_qo();
			var tc:TriageCorpus_qo = new TriageCorpus_qo();
			var tt:TriageCorpus_qo = new TriageCorpus_qo();
			
			tc.vpdmfId = String(event.vpdmfId);
			tt.vpdmfId = String(triageModel.targetCorpus.vpdmfId);
			ts.triageCorpus = tc;
			ts.targetCorpus = tt;
			
			if(event.inOutCode.length > 0) {
				ts.inOutCode = event.inOutCode;
			}
			
			this.dispatch(new ListTriageScoreListPagedEvent(ts, 0, triageModel.listPageSize));

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