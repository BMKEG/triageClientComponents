package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.triageModule.model.TriageModel;
	import edu.isi.bmkeg.ftd.rl.events.*;
	import edu.isi.bmkeg.ftd.rl.services.IFtdService;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class ListFTDRuleSetCommand extends Command
	{
	
		[Inject]
		public var event:ListFTDRuleSetEvent;
		
		[Inject]
		public var service:IFtdService;
				
		override public function execute():void
		{	
			service.listFTDRuleSet(event.object);
		}
		
	}
	
}