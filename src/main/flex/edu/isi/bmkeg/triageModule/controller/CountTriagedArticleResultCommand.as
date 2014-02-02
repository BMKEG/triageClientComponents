package edu.isi.bmkeg.triageModule.controller
{	
	import org.robotlegs.mvcs.Command;

	import edu.isi.bmkeg.triage.rl.services.ITriageService;
	import edu.isi.bmkeg.triageModule.model.*;
	import edu.isi.bmkeg.triage.rl.events.CountTriagedArticleResultEvent;
	
	import flash.events.Event;
	
	public class CountTriagedArticleResultCommand extends Command
	{
	
		[Inject]
		public var event:CountTriagedArticleResultEvent;

		[Inject]
		public var listModel:TriageCorpusPagedListModel;
				
		[Inject]
		public var triageModel:TriageModel;

		override public function execute():void {
			
			if( triageModel.queryCorpusCount > 0 ) {
				listModel.pagedListLength = event.count / 
						triageModel.queryCorpusCount;
			}		
			
		}
		
	}
	
}