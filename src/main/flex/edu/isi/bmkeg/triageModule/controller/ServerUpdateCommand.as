package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.utils.serverUpdates.events.ServerUpdateEvent;
	import edu.isi.bmkeg.triageModule.model.TriageModel;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class ServerUpdateCommand extends Command
	{
		
		[Inject]
		public var event:ServerUpdateEvent;
		
		[Inject]
		public var model:TriageModel;
		
		override public function execute():void
		{
			this.model.message = event.message;
		}
		
	}
	
}