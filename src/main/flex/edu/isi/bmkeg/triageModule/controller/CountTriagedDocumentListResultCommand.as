package edu.isi.bmkeg.triageModule.controller
{	
	import org.robotlegs.mvcs.Command;

	import edu.isi.bmkeg.pagedList.model.*;

	import edu.isi.bmkeg.triage.rl.services.ITriageService;
	import edu.isi.bmkeg.triageModule.model.*;
	import edu.isi.bmkeg.triage.rl.events.*;
	
	import flash.events.Event;
	
	public class CountTriagedDocumentListResultCommand extends Command
	{
	
		[Inject]
		public var event:CountTriageScoreListResultEvent;

		[Inject]
		public var model:PagedListModel;
				
		override public function execute():void
		{
			model.pagedListLength = event.count;
		}
		
	}
	
}