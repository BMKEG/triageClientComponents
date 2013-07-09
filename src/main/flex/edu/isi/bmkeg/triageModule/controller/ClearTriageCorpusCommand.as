package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.triage.events.*;
	import edu.isi.bmkeg.triageModule.model.*;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	public class ClearTriageCorpusCommand extends Command
	{
	
		[Inject]
		public var event:ClearTriageCorpusEvent;

		[Inject]
		public var model:TriageModel;
				
		override public function execute():void
		{
			
			model = new TriageModel();

		}
		
	}
	
}