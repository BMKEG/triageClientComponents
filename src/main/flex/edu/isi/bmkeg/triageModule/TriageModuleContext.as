package edu.isi.bmkeg.triageModule
{
	import com.devaldi.controls.flexpaper.FlexPaperViewer;
	
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.Corpus_qo;
	import edu.isi.bmkeg.digitalLibrary.events.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.ListTargetArticleListPagedEvent;
	import edu.isi.bmkeg.digitalLibrary.rl.services.IDigitalLibraryService;
	import edu.isi.bmkeg.digitalLibrary.rl.services.impl.DigitalLibraryServiceImpl;
	import edu.isi.bmkeg.digitalLibrary.rl.services.serverInteraction.IDigitalLibraryServer;
	import edu.isi.bmkeg.digitalLibrary.rl.services.serverInteraction.impl.DigitalLibraryServerImpl;
	import edu.isi.bmkeg.digitalLibraryModule.view.*;
	import edu.isi.bmkeg.ftd.rl.events.*;
	import edu.isi.bmkeg.ftd.rl.services.IFtdService;
	import edu.isi.bmkeg.ftd.rl.services.impl.FtdServiceImpl;
	import edu.isi.bmkeg.ftd.rl.services.serverInteraction.IFtdServer;
	import edu.isi.bmkeg.ftd.rl.services.serverInteraction.impl.FtdServerImpl;
	import edu.isi.bmkeg.pagedList.events.*;
	import edu.isi.bmkeg.pagedList.model.*;
	import edu.isi.bmkeg.triage.events.*;
	import edu.isi.bmkeg.triage.services.IExtendedTriageService;
	import edu.isi.bmkeg.triage.services.impl.ExtendedTriageServiceImpl;
	import edu.isi.bmkeg.triage.services.serverInteraction.IExtendedTriageServer;
	import edu.isi.bmkeg.triage.services.serverInteraction.impl.ExtendedTriageServerImpl;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triage.rl.services.ITriageService;
	import edu.isi.bmkeg.triage.rl.services.impl.TriageServiceImpl;
	import edu.isi.bmkeg.triage.rl.services.serverInteraction.ITriageServer;
	import edu.isi.bmkeg.triage.rl.services.serverInteraction.impl.TriageServerImpl;
	import edu.isi.bmkeg.triageModule.controller.*;
	import edu.isi.bmkeg.triageModule.events.*;
	import edu.isi.bmkeg.triageModule.model.*;
	import edu.isi.bmkeg.triageModule.view.*;
	import edu.isi.bmkeg.triageModule.view.popups.*;
	
	import edu.isi.bmkeg.utils.uploadDirectoryControl.*;
	import edu.isi.bmkeg.utils.serverUpdates.events.ServerUpdateEvent;
	import edu.isi.bmkeg.utils.serverUpdates.services.IServerUpdateService;
	import edu.isi.bmkeg.utils.serverUpdates.services.impl.ServerUpdateServiceImpl;
	import edu.isi.bmkeg.utils.serverUpdates.services.serverInteraction.IServerUpdateServer;
	import edu.isi.bmkeg.utils.serverUpdates.services.serverInteraction.impl.ServerUpdateServerImpl;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.core.IInjector;
	import org.robotlegs.utilities.modular.mvcs.ModuleContext;

	public class TriageModuleContext extends ModuleContext
	{

		public function TriageModuleContext(contextView:DisplayObjectContainer,  injector:IInjector)
		{
			super(contextView, true, injector);
		}
		
		override public function startup():void
		{		
			
			mediatorMap.mapView(TriageCorpusControl, TriageCorpusControlMediator);
			mediatorMap.mapView(TriagedArticleList, TriagedArticleListMediator);
			mediatorMap.mapView(TriagedArticleCitationView, TriagedArticleCitationViewMediator);
			mediatorMap.mapView(ExplanationFeatureDisplay, ExplanationFeatureDisplayMediator);
			
			// Need a bit of extra detail to deal with popups
			mediatorMap.mapView(UploadPdfsPopup, UploadPdfsPopupMediator, null, false, false);
			mediatorMap.mapView(ClassifierPopup, ClassifierPopupMediator, null, false, false);
			
			injector.mapSingleton(TriageModel);
			injector.mapSingleton(TriageCorpusPagedListModel);
			
			injector.mapSingletonOf(ITriageService, TriageServiceImpl);
			injector.mapSingletonOf(ITriageServer, TriageServerImpl);
			injector.mapSingletonOf(IExtendedTriageService, ExtendedTriageServiceImpl);
			injector.mapSingletonOf(IExtendedTriageServer, ExtendedTriageServerImpl);
			injector.mapSingletonOf(IDigitalLibraryService, DigitalLibraryServiceImpl);
			injector.mapSingletonOf(IDigitalLibraryServer, DigitalLibraryServerImpl);
			injector.mapSingletonOf(IFtdServer, FtdServerImpl);
			injector.mapSingletonOf(IFtdService, FtdServiceImpl);

			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Simple pushed messages from the server.
			injector.mapSingletonOf(IServerUpdateServer, ServerUpdateServerImpl);
			injector.mapSingletonOf(IServerUpdateService, ServerUpdateServiceImpl);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// pushed messages from the server.
			commandMap.mapEvent(ServerUpdateEvent.SERVER_UPDATE, 
				ServerUpdateCommand);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// list the corpora on the server
			commandMap.mapEvent(ListCorpusEvent.LIST_CORPUS, 
				ListCorpusCommand);
			commandMap.mapEvent(ListCorpusResultEvent.LIST_CORPUS_RESULT, 
				ListCorpusResultCommand);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// list the Classification models on the server
			commandMap.mapEvent(ListTriageClassificationModelEvent.LIST_TRIAGECLASSIFICATIONMODEL, 
				ListTriageClassificationModelCommand);
			commandMap.mapEvent(ListTriageClassificationModelResultEvent.LIST_TRIAGECLASSIFICATIONMODEL_RESULT, 
				ListTriageClassificationModelResultCommand);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// list rule sets on the server
			commandMap.mapEvent(ListFTDRuleSetEvent.LIST_FTDRULESET, 
				ListFTDRuleSetCommand);
			commandMap.mapEvent(ListFTDRuleSetResultEvent.LIST_FTDRULESET_RESULT, 
				ListFTDRuleSetResultCommand);

			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// load the target corpus
			commandMap.mapEvent(FindTriageCorpusByIdEvent.FIND_TRIAGECORPUS_BY_ID, 
				FindTriageCorpusByIdCommand);
			commandMap.mapEvent(FindTriageCorpusByIdResultEvent.FIND_TRIAGECORPUSBY_ID_RESULT, 
				FindTriageCorpusByIdResultCommand);

			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// List triage corpora slaves of a given corpus. 
			commandMap.mapEvent(ListTriageCorpusEvent.LIST_TRIAGECORPUS, 
				ListTriageCorpusCommand);
			commandMap.mapEvent(ListTriageCorpusResultEvent.LIST_TRIAGECORPUS_RESULT, 
				ListTriageCorpusResultCommand);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Run a paged list query for TriageDocument objects
			// associated with a given TriageCorpus. 
			commandMap.mapEvent(ListTriageScoreListPagedEvent.LIST_TRIAGESCORELIST_PAGED, 
				ListTriageScoreListPagedCommand);
			commandMap.mapEvent(ListTriageScoreListPagedResultEvent.LIST_TRIAGESCORELIST_PAGED_RESULT, 
				ListTriageScoreListPagedResultCommand);
			commandMap.mapEvent(CountTriageScoreListResultEvent.COUNT_TRIAGESCORELIST_RESULT, 
				CountTriageScoreListResultCommand);
			commandMap.mapEvent(PagedListRetrievePageEvent.PAGEDLIST_RETRIEVE_PAGE
					+TriageCorpusPagedListModel.LIST_ID, 
					TriageCorpusPagedListRetrievePageCommand);
			commandMap.mapEvent(CountPagedListLengthEvent.COUNT_PAGED_LIST_LENGTH
				+TriageCorpusPagedListModel.LIST_ID, 
				CountTriageCorpusPagedListCommand);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Change selection of the triagedDocument List control
			// Run a query for the Triaged document. 
			commandMap.mapEvent(FindTriagedArticleByIdEvent.FIND_TRIAGEDARTICLE_BY_ID, 
				FindTriagedArticleByIdCommand);
			commandMap.mapEvent(FindTriagedArticleByIdResultEvent.FIND_TRIAGEDARTICLEBY_ID_RESULT, 
				FindTriagedArticleByIdResultCommand);
			
			commandMap.mapEvent(FindTriageScoreByIdEvent.FIND_TRIAGESCORE_BY_ID, 
				FindTriageScoreByIdCommand);
			commandMap.mapEvent(FindTriageScoreByIdResultEvent.FIND_TRIAGESCOREBY_ID_RESULT, 
				FindTriageScoreByIdResultCommand);

			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Change selection of the targetArticleCitation List control
			// Run a query for the Document. 
			commandMap.mapEvent(FindArticleCitationDocumentByIdEvent.FIND_ARTICLECITATIONDOCUMENT_BY_ID, 
					FindArticleCitationDocumentByIdCommand);
			commandMap.mapEvent(FindArticleCitationDocumentByIdResultEvent.FIND_ARTICLECITATIONDOCUMENTBY_ID_RESULT, 
					FindArticleCitationDocumentByIdResultCommand);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Update the classification code of a triagedDocument 
			commandMap.mapEvent(UpdateTriagedArticleEvent.UPDATE_TRIAGEDARTICLE, 
					UpdateTriagedArticleCommand);
			commandMap.mapEvent(UpdateTriagedArticleResultEvent.UPDATE_TRIAGEDARTICLE_RESULT, 
					UpdateTriagedArticleResultCommand);

			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Upload files to server
			commandMap.mapEvent(UploadTriagePdfFileEvent.UPLOAD_TRIAGE_PDF_FILE, 
				UploadTriagePdfFileCommand);
			commandMap.mapEvent(UploadTriagePdfFileResultEvent.UPLOAD_TRIAGE_PDF_FILE_RESULT, 
				UploadTriagePdfFileResultCommand);

			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Train Classifier
			commandMap.mapEvent(TrainClassifierEvent.TRAIN_CLASSIFIER, 
				TrainClassifierCommand);
			commandMap.mapEvent(TrainClassifierResultEvent.TRAIN_CLASSIFIER_RESULT, 
				TrainClassifierResultCommand);

			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Run Classifier
			commandMap.mapEvent(RunClassifierPredictEvent.RUN_CLASSIFIER_PREDICT, 
				RunClassifierPredictCommand);
			commandMap.mapEvent(RunClassifierPredictResultEvent.RUN_CLASSIFIER_PREDICT_RESULT, 
				RunClassifierPredictResultCommand);

			commandMap.mapEvent(ClearTriageCorpusEvent.CLEAR_TRIAGE_CORPUS, ClearTriageCorpusCommand);

			this.dispatchEvent(new ListCorpusEvent( new Corpus_qo() ));
			
		}
		
		override public function dispose():void
		{
			mediatorMap.removeMediatorByView(contextView);
			super.dispose();
		}
		
	}
	
}