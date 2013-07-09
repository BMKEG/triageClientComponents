package edu.isi.bmkeg.triageModule.controller
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.triage.rl.services.ITriageService;
	import edu.isi.bmkeg.triage.rl.events.*;
	
	import flash.events.Event;
	
	public class ListTriageCorpusCommand extends Command
	{
	
		[Inject]
		public var event:ListTriageCorpusEvent;

		[Inject]
		public var service:ITriageService;
				
		override public function execute():void
		{
			service.listTriageCorpus(event.object);
		}
		
	}
	
}