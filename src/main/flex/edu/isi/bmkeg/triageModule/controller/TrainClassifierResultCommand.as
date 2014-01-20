package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
	import edu.isi.bmkeg.triage.events.*;
	import edu.isi.bmkeg.triage.model.qo.TriageCorpus_qo;
	import edu.isi.bmkeg.triage.model.qo.TriageScore_qo;
	import edu.isi.bmkeg.triageModule.model.TriageModel;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class TrainClassifierResultCommand extends Command
	{
		
		[Inject]
		public var event:TrainClassifierResultEvent;
		
		[Inject]
		public var model:TriageModel;
		
		override public function execute():void
		{
			this.dispatch(new ListCorpusEvent(new Corpus_qo()) );

		}
		
	}
	
}