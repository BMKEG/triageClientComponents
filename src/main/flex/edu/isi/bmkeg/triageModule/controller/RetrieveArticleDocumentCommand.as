package edu.isi.bmkeg.triageModule.controller
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.ftd.rl.services.IFtdService;
	import edu.isi.bmkeg.ftd.rl.events.*;
	
	import flash.events.Event;
	
	public class RetrieveArticleDocumentCommand extends Command
	{
	
		[Inject]
		public var event:RetrieveArticleDocumentEvent;

		[Inject]
		public var service:IFtdService;
				
		override public function execute():void
		{
			service.retrieveArticleDocument(event.object);
		}
		
	}
	
}