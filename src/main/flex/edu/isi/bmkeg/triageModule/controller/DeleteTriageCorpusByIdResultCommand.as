package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
	import edu.isi.bmkeg.triage.model.*;
	import edu.isi.bmkeg.triage.model.qo.*;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triageModule.model.TriageModel;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class DeleteTriageCorpusByIdResultCommand extends Command
	{
		
		[Inject]
		public var event:DeleteTriageCorpusByIdResultEvent;
		
		[Inject]
		public var model:TriageModel;
		
		override public function execute():void
		{	
			model.triageCorpus = null;
			this.dispatch(new ListCorpusEvent(new Corpus_qo()));				
		}
		
	}
	
}