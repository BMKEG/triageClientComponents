package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.triageModule.events.TriagedArticleListSelectionChangedEvent;
	import edu.isi.bmkeg.triage.rl.events.FindTriageScoreByIdEvent;
	import edu.isi.bmkeg.triage.rl.services.ITriageService;
	
	import org.robotlegs.mvcs.Command;
	
	public class FindTriageScoreByIdCommand extends Command {
		
		[Inject]
		public var event:FindTriageScoreByIdEvent;
		
		[Inject]
		public var service:ITriageService;

		override public function execute():void {
			service.findTriageScoreById( event.id );	
		}
		
	}
	
}