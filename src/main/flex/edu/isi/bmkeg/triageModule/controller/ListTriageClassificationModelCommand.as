package edu.isi.bmkeg.triageModule.controller
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.triage.rl.services.ITriageService;
	import edu.isi.bmkeg.triage.rl.events.*;
	
	import flash.events.Event;
	
	public class ListTriageClassificationModelCommand extends Command
	{
		
		[Inject]
		public var event:ListTriageClassificationModelEvent;
		
		[Inject]
		public var service:ITriageService;
		
		override public function execute():void
		{
			service.listTriageClassificationModel(event.object);
		}
		
	}
	
}