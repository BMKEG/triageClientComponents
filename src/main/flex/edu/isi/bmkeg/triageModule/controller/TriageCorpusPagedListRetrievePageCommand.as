package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.pagedList.events.*;
	import edu.isi.bmkeg.triage.model.*;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triageModule.model.*;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	public class TriageCorpusPagedListRetrievePageCommand extends Command
	{
	
		[Inject]
		public var event:PagedListRetrievePageEvent;

		[Inject]
		public var model:TriageModel;
				
		override public function execute():void
		{

			if( model.queryTriagedDocument != null ) {
			
				// note that we have to multiply all values pertaining 
				// to the paged list in the flex control by the number of 
				// corpora being processed.
				var offset:int = event.offset;
				var count:int = event.count;
				
				var nCorpora:int = model.queryCorpusCount;
				
				this.dispatch(new ListTriagedArticlePagedEvent(
						model.queryTriagedDocument, 
						event.offset * nCorpora, 
						event.count * nCorpora));
			
			}
			
		}
		
	}
	
}