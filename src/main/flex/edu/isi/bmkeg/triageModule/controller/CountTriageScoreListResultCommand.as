package edu.isi.bmkeg.triageModule.controller
{	
	import org.robotlegs.mvcs.Command;

	import edu.isi.bmkeg.triage.rl.services.ITriageService;
	import edu.isi.bmkeg.triageModule.model.*;
	import edu.isi.bmkeg.triage.rl.events.*;
	
	import flash.events.Event;
	
	public class CountTriageScoreListResultCommand extends Command
	{
	
		[Inject]
		public var event:CountTriageScoreListResultEvent;

		[Inject]
		public var listModel:TriageCorpusPagedListModel;
				
		[Inject]
		public var triageModel:TriageModel;

		override public function execute():void {

			if( triageModel.corpora.length > 0 ) {
				listModel.pagedListLength = event.count / 
						triageModel.corpora.length;
			}		
		}
		
	}
	
}