package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.pagedList.events.*;
	import edu.isi.bmkeg.triage.model.*;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triageModule.model.*;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	public class PagedListRetrievePageCommand extends Command
	{
	
		[Inject]
		public var event:PagedListRetrievePageEvent;

		[Inject]
		public var model:TriageModel;
				
		override public function execute():void
		{
			
			this.dispatch(
				new ListTriageScoreListPagedEvent(
					model.queryTriagedDocument, event.offset, event.count
				)
			);
			
		}
		
	}
	
}