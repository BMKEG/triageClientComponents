package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.ftd.rl.events.*;
	import edu.isi.bmkeg.ftd.model.*;
	import edu.isi.bmkeg.triageModule.model.TriageModel;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	public class RetrieveArticleDocumentResultCommand extends Command
	{
		
		[Inject]
		public var event:RetrieveArticleDocumentResultEvent;
		
		[Inject]
		public var model:TriageModel;
	
		override public function execute():void
		{
			
			if( event.list.length != 1 ) {
				trace("Error: list update returned more than one element");
				return;
			}
							
			var ftd:FTD = FTD(event.list.getItemAt(0));
			model.currentScore.citation.fullText = ftd;

		}
		
	}
	
}