package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
	import edu.isi.bmkeg.triage.model.*;
	import edu.isi.bmkeg.triage.model.qo.*;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triageModule.model.*;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateTriageCorpusResultCommand extends Command
	{
		
		[Inject]
		public var event:UpdateTriageCorpusResultEvent;
		
		[Inject]
		public var model:TriageModel;
		
		override public function execute():void
		{	
			this.dispatch(new FindTriageCorpusByIdEvent(event.id));				
		}
		
	}
	
}