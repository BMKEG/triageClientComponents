package edu.isi.bmkeg.triageModule.controller
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.triage.rl.events.*;
	
	import edu.isi.bmkeg.triageModule.model.TriageModel;
	
	import flash.events.Event;
	
	public class ListTriageCorpusResultCommand extends Command
	{
		
		[Inject]
		public var event:ListTriageCorpusResultEvent;
		
		[Inject]
		public var model:TriageModel;
		
		
		override public function execute():void
		{
			model.triageCorpora = event.list;
		}
		
	}
	
}