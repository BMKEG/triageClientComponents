package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.pagedList.events.*;
	
	import edu.isi.bmkeg.triage.model.TriageScore;
	import edu.isi.bmkeg.triage.model.TriageCorpus;

	import edu.isi.bmkeg.digitalLibrary.model.citations.Corpus;
	import edu.isi.bmkeg.digitalLibrary.rl.services.IDigitalLibraryService;

	import edu.isi.bmkeg.triageModule.model.TriageModel;
	import edu.isi.bmkeg.triage.rl.services.ITriageService;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class CountTargetCorpusPagedListCommand extends Command
	{
	
		[Inject]
		public var event:CountPagedListLengthEvent;

		[Inject]
		public var model:TriageModel;
		
		[Inject]
		public var digLibService:IDigitalLibraryService;

		[Inject]
		public var triageService:ITriageService;
		
		override public function execute():void {
			
			if( model.queryLiteratureCitation != null ) {
				digLibService.countTargetArticleList(model.queryLiteratureCitation);
			}
			
		}
		
	}
	
}