package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.digitalLibrary.model.citations.Corpus;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;

	import edu.isi.bmkeg.triage.model.TriageCorpus;
	import edu.isi.bmkeg.triage.rl.events.*;

	import edu.isi.bmkeg.triageModule.model.TriageModel;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class FindTriageScoreByIdResultCommand extends Command
	{
		
		[Inject]
		public var event:FindTriageScoreByIdResultEvent;
		
		[Inject]
		public var model:TriageModel;
		
		
		override public function execute():void
		{
			
			model.currentScore = event.object;
			
		}
		
	}
	
}