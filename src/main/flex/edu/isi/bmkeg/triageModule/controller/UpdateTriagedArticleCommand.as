package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.digitalLibrary.model.citations.Corpus;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;

	import edu.isi.bmkeg.triage.model.TriageCorpus;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triage.rl.services.*;

	import edu.isi.bmkeg.triageModule.model.TriageModel;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateTriagedArticleCommand extends Command
	{
		
		[Inject]
		public var event:UpdateTriagedArticleEvent;
		
		[Inject]
		public var service:ITriageService;
		
		override public function execute():void
		{
			service.updateTriagedArticle(event.object);
		}
		
		
	}
	
}