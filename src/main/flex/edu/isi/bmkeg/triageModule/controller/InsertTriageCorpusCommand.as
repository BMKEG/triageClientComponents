package edu.isi.bmkeg.triageModule.controller
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.triage.rl.services.ITriageService;
	import edu.isi.bmkeg.triage.model.TriageCorpus;
	import edu.isi.bmkeg.triage.rl.events.*;
	
	import flash.events.Event;
	
	public class InsertTriageCorpusCommand extends Command
	{
	
		[Inject]
		public var event:InsertTriageCorpusEvent;

		[Inject]
		public var service:ITriageService;
				
		override public function execute():void
		{
			service.insertTriageCorpus(event.object);
		}
		
	}
	
}