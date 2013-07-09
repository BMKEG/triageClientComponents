package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.triage.model.*;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triage.rl.services.ITriageService;
	import edu.isi.bmkeg.triageModule.model.TriageModel;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateTriagedArticleResultCommand extends Command
	{
		
		[Inject]
		public var event:UpdateTriagedArticleResultEvent;

		[Inject]
		public var service:ITriageService;
		
		[Inject]
		public var model:TriageModel;
	
		override public function execute():void {
			
			//model.tdVpdmfId = event.id;

			// go get the updated article from the server for the form
			service.findTriagedArticleById(event.id);	
			
			// go get the updated article from the server for the list
			var td:TriageScore = new TriageScore();
			td.vpdmfId = event.id;
			service.listTriagedArticle(td);		
				
		}
		
	}
	
}