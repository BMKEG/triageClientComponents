package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.digitalLibrary.model.citations.Corpus;

	import edu.isi.bmkeg.triage.events.*;
	import edu.isi.bmkeg.triage.services.IExtendedTriageService;
	
	import edu.isi.bmkeg.triage.model.TriageCorpus;
	
	import edu.isi.bmkeg.triageModule.model.TriageModel;

	import edu.isi.bmkeg.utils.uploadDirectoryControl.UploadToBrowserCompleteEvent;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class SwitchInOutCommand extends Command
	{
		
		[Inject]
		public var event:SwitchInOutEvent;
		
		[Inject]
		public var service:IExtendedTriageService;
		
		override public function execute():void {
			
			service.switchInOutCodes(event.scoreId, event.code);
		
		}
		
	}

}