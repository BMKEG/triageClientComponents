package edu.isi.bmkeg.triageModule.controller
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.digitalLibrary.rl.services.IDigitalLibraryService;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;

	import edu.isi.bmkeg.triageModule.model.TriageModel;

	import flash.events.Event;
	
	public class ListTargetArticleListPagedCommand extends Command
	{
	
		[Inject]
		public var event:ListTargetArticleListPagedEvent;

		[Inject]
		public var model:TriageModel;
		
		[Inject]
		public var service:IDigitalLibraryService;
				
		override public function execute():void
		{
			model.queryLiteratureCitation = event.object;	

			service.listTargetArticleListPaged(event.object, event.offset, event.cnt);
			
		}
		
	}
	
}