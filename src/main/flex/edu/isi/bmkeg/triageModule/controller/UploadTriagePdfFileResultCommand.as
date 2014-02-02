package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triage.events.*;
	import edu.isi.bmkeg.triage.model.qo.TriageCorpus_qo;
	import edu.isi.bmkeg.triage.model.qo.TriageScore_qo;
	import edu.isi.bmkeg.triageModule.model.TriageModel;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class UploadTriagePdfFileResultCommand extends Command
	{
		
		[Inject]
		public var event:UploadTriagePdfFileResultEvent;
		
		[Inject]
		public var model:TriageModel;
		
		override public function execute():void
		{
			var tsQo:TriageScore_qo = new TriageScore_qo();
			var tcQo:TriageCorpus_qo = new TriageCorpus_qo();
			tsQo.triageCorpus = tcQo;
			tcQo.name = model.triageCorpus.name;
			
			//
			// model.queryCorpusCount controls the number of columns 
			// filled in on the TriageArticleList
			//
			model.queryCorpusCount = model.corpora.length;
			
			this.dispatch(new ListTriagedArticlePagedEvent(tsQo, 0, 100) );

		}
		
	}
	
}