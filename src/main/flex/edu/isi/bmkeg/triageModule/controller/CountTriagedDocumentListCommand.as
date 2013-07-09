package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.pagedList.events.*;
	
	import edu.isi.bmkeg.triage.model.TriageScore;
	import edu.isi.bmkeg.triage.model.TriageCorpus;
	import edu.isi.bmkeg.digitalLibrary.model.citations.Corpus;

	import edu.isi.bmkeg.triageModule.model.TriageModel;
	import edu.isi.bmkeg.triage.rl.services.ITriageService;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class CountTriagedDocumentListCommand extends Command
	{
	
		[Inject]
		public var event:CountPagedListLengthEvent;

		[Inject]
		public var model:TriageModel;
		
		[Inject]
		public var service:ITriageService;
				
		override public function execute():void
		{
			
			service.countTriageScoreList(model.queryTriagedDocument);
		
		}
		
	}
	
}