package edu.isi.bmkeg.triageModule.controller
{	
	
	import edu.isi.bmkeg.digitalLibrary.model.citations.ArticleCitation;
	import edu.isi.bmkeg.pagedList.model.*;
	import edu.isi.bmkeg.triage.model.*;
	import edu.isi.bmkeg.triage.model.*;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triageModule.model.*;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	public class FindTriagedArticleByIdResultCommand extends Command
	{
		
		[Inject]
		public var event:FindTriagedArticleByIdResultEvent;
		
		[Inject]
		public var model:TriageModel;
		
		override public function execute():void
		{
			
			var ts:TriageScore = event.object; 
			
			if( model.currentCitation == null ||
					ts.citation.vpdmfId != model.currentCitation.vpdmfId )
				model.refreshFullText = true;
			else 
				model.refreshFullText = false;
			
			model.currentCitation = ArticleCitation(ts.citation);
			model.features = ts.features;
			
		}
		
	}
	
}