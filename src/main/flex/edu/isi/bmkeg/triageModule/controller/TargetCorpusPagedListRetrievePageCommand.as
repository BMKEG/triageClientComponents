package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.pagedList.events.*;
	import edu.isi.bmkeg.triage.model.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.ListTargetArticleListPagedEvent;
	import edu.isi.bmkeg.triageModule.model.*;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	public class TargetCorpusPagedListRetrievePageCommand extends Command
	{
	
		[Inject]
		public var event:PagedListRetrievePageEvent;

		[Inject]
		public var model:TriageModel;
				
		override public function execute():void
		{
			if( model.queryLiteratureCitation != null ) {
				this.dispatch( new ListTargetArticleListPagedEvent(
						model.queryLiteratureCitation, event.offset, event.count));
			}
			
		}
		
	}
	
}