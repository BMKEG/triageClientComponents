package edu.isi.bmkeg.triageModule.controller
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.digitalLibrary.services.IExtendedDigitalLibraryService;
	import edu.isi.bmkeg.digitalLibrary.events.*;

	import flash.events.Event;
	
	public class LoadHtmlCommand extends Command
	{
	
		[Inject]
		public var event:LoadHtmlEvent;
		
		[Inject]
		public var service:IExtendedDigitalLibraryService;
				
		override public function execute():void
		{
			service.loadHtml(event.vpdmfId);			
		}
		
	}
	
}