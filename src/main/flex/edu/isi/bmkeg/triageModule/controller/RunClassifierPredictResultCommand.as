package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.triage.rl.events.ListTriageScoreListPagedEvent;
	import edu.isi.bmkeg.triage.events.*;
	import edu.isi.bmkeg.triage.model.qo.TriageCorpus_qo;
	import edu.isi.bmkeg.triage.model.qo.TriageScore_qo;
	import edu.isi.bmkeg.triageModule.model.TriageModel;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class RunClassifierPredictResultCommand extends Command
	{
		
		[Inject]
		public var event:RunClassifierPredictResultEvent;
		
		[Inject]
		public var model:TriageModel;
		
		override public function execute():void
		{
			var tsQo:TriageScore_qo = new TriageScore_qo();
			var tcQo:TriageCorpus_qo = new TriageCorpus_qo();
			tsQo.triageCorpus = tcQo;
			tcQo.name = model.triageCorpus.name;
			
//			this.dispatch(new ListTriageScoreListPagedEvent(tsQo, 0, 100) );

		}
		
	}
	
}