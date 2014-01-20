package edu.isi.bmkeg.triageModule.controller
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.triage.rl.services.ITriageService;
	import edu.isi.bmkeg.digitalLibrary.model.citations.Corpus;
	import edu.isi.bmkeg.triage.rl.events.*;
	
	import flash.events.Event;
	
	public class FindTriageCorpusByIdCommand extends Command
	{
	
		[Inject]
		public var event:FindTriageCorpusByIdEvent;

		[Inject]
		public var service:ITriageService;
				
		override public function execute():void
		{
			service.findTriageCorpusById(event.id);
		}
		
	}
	
}