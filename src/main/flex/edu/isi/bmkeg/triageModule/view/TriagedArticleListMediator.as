package edu.isi.bmkeg.triageModule.view
{
	
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
	import edu.isi.bmkeg.pagedList.events.*;
	import edu.isi.bmkeg.pagedList.model.*;
	import edu.isi.bmkeg.triage.events.*;
	import edu.isi.bmkeg.triage.model.*;
	import edu.isi.bmkeg.triage.model.qo.*;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triageModule.events.*;
	import edu.isi.bmkeg.triageModule.model.*;
	
	import mx.core.ClassFactory;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.DataGrid;
	import spark.components.gridClasses.GridColumn;
	import spark.events.GridEvent;
	
	public class TriagedArticleListMediator extends Mediator
	{
		[Inject]
		public var view:TriagedArticleList;
		
		[Inject]
		public var listModel:TriageCorpusPagedListModel;
		
		[Inject]
		public var model:TriageModel;
		
		private var itemRendererClassFactory:ClassFactory;

		private var forward:Boolean = true;
		
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
				dispatch);
			
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
				colN.width = 87;
				colN.dataField = corpus.vpdmfLabel + ".inOut";
				colN.itemRenderer = makeInOutPullDownItemRenderer;
				colN.sortable = true;
				o[corpus.vpdmfLabel] = "XXX";
				dg.columns.addItem(colN);
			}
			
			dg.columnHeaderGroup.addEventListener(
				GridEvent.GRID_CLICK, 
				cycleSortStateListener);
						
		}
		
		
		/** 
		 * Capture the click of the sort function.
		 */ 
		private function cycleSortStateListener( event:GridEvent ): void {
	
			var ts:TriageScore_qo = new TriageScore_qo();
			var tc:TriageCorpus_qo = new TriageCorpus_qo();			
			ts.triageCorpus = tc;
			tc.vpdmfId = String(model.triageCorpus.vpdmfId);
			
			if( event.columnIndex == 0 ) {

				var lcQo:ArticleCitation_qo = new ArticleCitation_qo();
				ts.citation = lcQo;
				lcQo.pmid = "<vpdmf-sort-0>"
				
				model.queryCorpusCount = model.corpora.length;	

			} else if( event.columnIndex == 1 ) {

				var lcQo2:ArticleCitation_qo = new ArticleCitation_qo();
				ts.citation = lcQo2;
				lcQo2.vpdmfLabel = "<vpdmf-sort-0>"

				model.queryCorpusCount = model.corpora.length;	

			} else {
					
				var sortCorpus:String = event.column.headerText;
				var c:Corpus_qo = new Corpus_qo();			
				ts.targetCorpus = c;
				c.name = sortCorpus;
				
				if( this.forward ) {
					ts.inOutCode = "<vpdmf-sort-0>";
					this.forward = false;
				} else {
					ts.inOutCode = "<vpdmf-rev-sort-0>";
					this.forward = true;
				}
				
				ts.inScore = "<vpdmf-rev-sort-1>";
						
				model.queryCorpusCount = 1;	

			}

			this.dispatch(new ListTriagedArticlePagedEvent(
				ts, 0, model.listPageSize));

			
		}
		
		private function triageScoreDataTip(item:Object, column:GridColumn):String 
		{
			var columnName:String = column.headerText;
			var inOut:String = item[columnName + ".inOut"];
			var score:String = item[columnName + ".score"];
			return inOut + " (" + score + ")";
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
		
		// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		// Reset everything
		//
		public function clearTriageCorpusHandler(event:ClearTriageCorpusEvent):void {
			
			view.triageDocumentsList = listModel.pagedList;
			
		}
		
	}
	
}