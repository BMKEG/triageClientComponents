package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triageModule.model.TriageModel;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class ListTriageClassificationModelResultCommand extends Command
	{
		
		[Inject]
		public var event:ListTriageClassificationModelResultEvent;
		
		[Inject]
		public var model:TriageModel;
		
		override public function execute():void
		{

			var hash:Object = new Object();
			for each( var cLvi:LightViewInstance in model.classificationModels ) {
				hash[cLvi.vpdmfLabel] = cLvi;
			}

			//
			// This is a bit ugly. 
			// Matching the models to the corpora via the corpus names is REALLY fragile.
			// Need to drive this from list of corpora since models need to be trained to exist.
			// Can't be bothered to do anything more concrete at the moment.
			//
			for each( var mLvi:LightViewInstance in event.list) {
				var lookup:LightViewInstance = hash["[-] " + mLvi.vpdmfLabel];
				if( lookup != null ) {
					var s:String = lookup.vpdmfLabel;
					lookup.vpdmfLabel = "[+] " + s.substr(4);
				}
			}
			
		}
		
	}
	
}