package edu.isi.bmkeg.triageModule
{
	import edu.isi.bmkeg.ftd.rl.events.*;
	import edu.isi.bmkeg.ftd.rl.services.IFtdService;
	import edu.isi.bmkeg.ftd.rl.services.impl.FtdServiceImpl;
	import edu.isi.bmkeg.ftd.rl.services.serverInteraction.IFtdServer;
	import edu.isi.bmkeg.ftd.rl.services.serverInteraction.impl.FtdServerImpl;
	
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
	import edu.isi.bmkeg.digitalLibrary.rl.services.IDigitalLibraryService;
	import edu.isi.bmkeg.digitalLibrary.rl.services.impl.DigitalLibraryServiceImpl;
	import edu.isi.bmkeg.digitalLibrary.rl.services.serverInteraction.IDigitalLibraryServer;
	import edu.isi.bmkeg.digitalLibrary.rl.services.serverInteraction.impl.DigitalLibraryServerImpl;
	
	import edu.isi.bmkeg.pagedList.model.*;
	import edu.isi.bmkeg.pagedList.events.*;
	
	import edu.isi.bmkeg.triage.events.*;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triage.rl.services.ITriageService;
	import edu.isi.bmkeg.triage.rl.services.impl.TriageServiceImpl;
	import edu.isi.bmkeg.triage.rl.services.serverInteraction.ITriageServer;
	import edu.isi.bmkeg.triage.rl.services.serverInteraction.impl.TriageServerImpl;
	
	import edu.isi.bmkeg.triageModule.events.*;
	import edu.isi.bmkeg.triageModule.model.*;
	import edu.isi.bmkeg.triageModule.controller.*;
	import edu.isi.bmkeg.triageModule.view.*;
 	
	import com.devaldi.controls.flexpaper.FlexPaperViewer;

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
			mediatorMap.mapView(FlexPaperViewer, FlexPaperMediator);
			
			injector.mapSingleton(TriageModel);
			injector.mapSingleton(PagedListModel);
			injector.mapSingletonOf(ITriageService, TriageServiceImpl);
			injector.mapSingletonOf(ITriageServer, TriageServerImpl);
			injector.mapSingletonOf(IDigitalLibraryService, DigitalLibraryServiceImpl);
			injector.mapSingletonOf(IDigitalLibraryServer, DigitalLibraryServerImpl);
			injector.mapSingletonOf(IFtdServer, FtdServerImpl);
			injector.mapSingletonOf(IFtdService, FtdServiceImpl);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// list the corpora on the server
			commandMap.mapEvent(ListCorpusEvent.LIST_CORPUS, ListCorpusCommand);
			commandMap.mapEvent(ListCorpusResultEvent.LIST_CORPUS_RESULT, ListCorpusResultCommand);

			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// load the target corpus
			commandMap.mapEvent(FindCorpusByIdEvent.FIND_CORPUS_BY_ID, FindCorpusByIdCommand);
			commandMap.mapEvent(FindCorpusByIdResultEvent.FIND_CORPUSBY_ID_RESULT, FindCorpusByIdResultCommand);

			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// List triage corpora slaves of a given corpus. 
			commandMap.mapEvent(ListTriageCorpusEvent.LIST_TRIAGECORPUS, ListTriageCorpusCommand);
			commandMap.mapEvent(ListTriageCorpusResultEvent.LIST_TRIAGECORPUS_RESULT, ListTriageCorpusResultCommand);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Run a paged list query for TriageDocument objects
			// associated with a given TriageCorpus. 
			commandMap.mapEvent(ListTriageScoreListPagedEvent.LIST_TRIAGESCORELIST_PAGED, ListTriageScoreListPagedCommand);
			commandMap.mapEvent(ListTriageScoreListPagedResultEvent.LIST_TRIAGESCORELIST_PAGED_RESULT, ListTriageScoreListPagedResultCommand);
			commandMap.mapEvent(CountPagedListLengthEvent.COUNT_PAGED_LIST_LENGTH, CountTriagedDocumentListCommand);
			commandMap.mapEvent(CountTriageScoreListResultEvent.COUNT_TRIAGESCORELIST_RESULT, CountTriagedDocumentListResultCommand);
			commandMap.mapEvent(PagedListRetrievePageEvent.PAGEDLIST_RETRIEVE_PAGE, PagedListRetrievePageCommand);
			
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Change selection of the triagedDocument List control
			// Run a query for the Triaged document. 
			commandMap.mapEvent(FindTriageScoreByIdEvent.FIND_TRIAGESCORE_BY_ID, FindTriageScoreByIdCommand);
			commandMap.mapEvent(FindTriageScoreByIdResultEvent.FIND_TRIAGESCOREBY_ID_RESULT, FindTriageScoreByIdResultCommand);

			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Update the classification code of a triagedDocument 
			commandMap.mapEvent(UpdateTriagedArticleEvent.UPDATE_TRIAGEDARTICLE, UpdateTriagedArticleCommand);
			commandMap.mapEvent(UpdateTriagedArticleResultEvent.UPDATE_TRIAGEDARTICLE_RESULT, UpdateTriagedArticleResultCommand);
			commandMap.mapEvent(ListTriagedArticleResultEvent.LIST_TRIAGEDARTICLE_RESULT, ListTriagedArticleResultCommand);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Load FTD associated with an article. 
			commandMap.mapEvent(RetrieveArticleDocumentEvent.RETRIEVE_ARTICLEDOCUMENT, RetrieveArticleDocumentCommand);
			commandMap.mapEvent(RetrieveArticleDocumentResultEvent.RETRIEVE_ARTICLEDOCUMENT_RESULT, RetrieveArticleDocumentResultCommand);

			commandMap.mapEvent(ClearTriageCorpusEvent.CLEAR_TRIAGE_CORPUS, ClearTriageCorpusCommand);

		}
		
		override public function dispose():void
		{
			mediatorMap.removeMediatorByView(contextView);
			super.dispose();
		}
		
	}
	
}