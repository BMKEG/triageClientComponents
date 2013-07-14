package edu.isi.bmkeg.triageModule.controller
{
	import edu.isi.bmkeg.digitalLibrary.rl.events.FindArticleCitationDocumentByIdResultEvent;
	import edu.isi.bmkeg.triageModule.model.TriageModel;

	import org.robotlegs.mvcs.Command;
	
	public class FindArticleCitationDocumentByIdResultCommand extends Command
	{
		[Inject]
		public var event:FindArticleCitationDocumentByIdResultEvent;
		
		[Inject]
		public var model:TriageModel;
		
		override public function execute():void {
			
			model.currentCitation = event.object;
			
		}
		
	}
	
}