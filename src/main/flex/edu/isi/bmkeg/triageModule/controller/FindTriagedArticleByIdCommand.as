package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.ArticleCitation_qo;
	import edu.isi.bmkeg.triage.model.qo.TriageScore_qo;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triage.rl.services.ITriageService;
	import edu.isi.bmkeg.triageModule.model.TriageModel;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class FindTriagedArticleByIdCommand extends Command
	{
		
		[Inject]
		public var event:FindTriagedArticleByIdEvent;
		
		[Inject]
		public var model:TriageModel;
		
		[Inject]
		public var service:ITriageService;
		
		override public function execute():void
		{
			
			service.findTriagedArticleById(event.id);
			
			model.currentScores = null;
			model.currentCitation = null;
		}
		
	}
	
}