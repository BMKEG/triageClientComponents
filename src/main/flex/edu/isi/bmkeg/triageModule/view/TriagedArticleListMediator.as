package edu.isi.bmkeg.triageModule.view
{
	
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
	import edu.isi.bmkeg.pagedList.events.*;
	import edu.isi.bmkeg.pagedList.model.*;
	import edu.isi.bmkeg.triage.events.*;
	import edu.isi.bmkeg.triage.model.*;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triageModule.events.*;
	import edu.isi.bmkeg.triageModule.model.*;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.core.ClassFactory;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.DataGrid;
	import spark.components.gridClasses.GridColumn;
	
	public class TriagedArticleListMediator extends Mediator
	{
		[Inject]
		public var view:TriagedArticleList;
		
		[Inject]
		public var listModel:TriageCorpusPagedListModel;
		
		[Inject]
		public var model:TriageModel;
		
		private var itemRendererClassFactory:ClassFactory;
		
		override public function onRegister():void
		{
			
			addContextListener(PagedListUpdatedEvent.UPDATED + TriageCorpusPagedListModel.LIST_ID, 
				triageDocumentsListUpdatedHandler);
			
			addContextListener(ListCorpusResultEvent.LIST_CORPUS_RESULT, 
				listCorpusResultHandler);
			
			addContextListener(ClearTriageCorpusEvent.CLEAR_TRIAGE_CORPUS, 
				clearTriageCorpusHandler);
			
			addViewListener(FindTriagedArticleByIdEvent.FIND_TRIAGEDARTICLE_BY_ID, 
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
		
		/**
		 * Edit the design of the view
		 */
		private function listCorpusResultHandler(event:ListCorpusResultEvent):void
		{
			
			var dg:DataGrid = view.triageDocumentListDataGrid;
			
			dg.columns.removeAll();
			
			// pmid column
			var col1:GridColumn = new GridColumn();
			col1.headerText = "PMID";
			col1.width = 100;
			col1.dataField = "pmid";
			dg.columns.addItem(col1);
			
			// Citation column
			var col2:GridColumn = new GridColumn();
			col2.headerText = "Citation";
			col2.dataField = "citation";
			dg.columns.addItem(col2);

			//
			// In this case, each data object in the list will have 
			// (a) .pmid (b) .citation data
			// and then values with attribute names 
			//
			// "<Target-Corpus-Name>.inOut"
			//
			// and 
			//
			// "<Target-Corpus-Name>.inOut"
			//
			// for each target corpus.
			//
			var o:Object = new Object();
			o["pmid"] = "1234567";
			o["citation"] = "Someone, Someone (2000) 'blah blah blah', 17:1-99";
			dg.typicalItem = o;
			for( var j:int=0; j<model.corpora.length; j++ ) {
				var corpus:Object = model.corpora.getItemAt(j);			
				var colN:GridColumn = new GridColumn();
				colN.headerText = corpus.vpdmfLabel;
				colN.width = 80;
				colN.dataField = corpus.vpdmfLabel + ".inOut";
				colN.itemRenderer = makeInOutPullDownItemRenderer;
				o[corpus.vpdmfLabel] = "XXX";
				dg.columns.addItem(colN);
			}
						
		}
		
		// This function provides the means of dynamically generating item renderers
		// in the flex control.
		private function get makeInOutPullDownItemRenderer():ClassFactory
		{
			if (itemRendererClassFactory == null)
			{
				itemRendererClassFactory = new ClassFactory();
				itemRendererClassFactory.generator = TriagedArticleList__InOutCodeItemRenderer;
			}
			return itemRendererClassFactory;
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