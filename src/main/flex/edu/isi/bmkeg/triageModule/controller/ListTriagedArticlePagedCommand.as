package edu.isi.bmkeg.triageModule.controller
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.triage.model.qo.TriageScore_qo;
	import edu.isi.bmkeg.triage.rl.services.ITriageService;
	import edu.isi.bmkeg.triage.rl.events.*;

	import edu.isi.bmkeg.triageModule.model.TriageModel;

	import flash.events.Event;
	
	public class ListTriagedArticlePagedCommand extends Command
	{
	
		[Inject]
		public var event:ListTriagedArticlePagedEvent;

		[Inject]
		public var model:TriageModel;
		
		[Inject]
		public var service:ITriageService;
				
		override public function execute():void
		{
			
			model.queryTriagedDocument = event.object;	

			service.listTriagedArticlePaged(event.object, event.offset, event.cnt);
			
			model.currentCitation = null;
		}
		
	}
	
}