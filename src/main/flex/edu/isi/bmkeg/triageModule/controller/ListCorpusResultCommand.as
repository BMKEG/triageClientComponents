package edu.isi.bmkeg.triageModule.controller
{	
	
	import edu.isi.bmkeg.digitalLibrary.model.citations.Corpus;
	import edu.isi.bmkeg.digitalLibrary.rl.events.ListCorpusResultEvent;
	import edu.isi.bmkeg.triage.model.qo.*;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triageModule.model.TriageModel;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	public class ListCorpusResultCommand extends Command
	{
		
		[Inject]
		public var event:ListCorpusResultEvent;
		
		[Inject]
		public var model:TriageModel;
		
		
		override public function execute():void
		{
			model.corpora = new ArrayCollection();
			model.triageCorpora = new ArrayCollection();
			model.classificationModels = new ArrayCollection();
			
			//
			// We filter out the TriageCorpora here. 
			// Need the queryView structure to be able to issue 
			// negation and other constructs in queries 
			//
			for each( var lvi:LightViewInstance in event.list) {
				if( lvi.defName.indexOf("TriageCorpus") == -1 ) {
					var lvi2:LightViewInstance = lvi.clone();
					lvi2.vpdmfLabel = "[-] " + lvi2.vpdmfLabel; 
					model.classificationModels.addItem(lvi2);
					model.corpora.addItem(lvi);
				} else {
					model.triageCorpora.addItem(lvi);
				}
			}
			
			dispatch(new ListTriageClassificationModelEvent(new TriageClassificationModel_qo()));
			
		}
		
	}
	
}