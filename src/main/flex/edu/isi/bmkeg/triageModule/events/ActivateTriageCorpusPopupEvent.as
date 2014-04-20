package edu.isi.bmkeg.triageModule.events
{
	
	import edu.isi.bmkeg.triage.model.TriageCorpus;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class ActivateTriageCorpusPopupEvent extends Event 
	{
		
		public static const ACTIVATE_TRIAGE_CORPUS_POPUP:String = "activateTriageCorpusPopup";
		
		public var corpus:TriageCorpus;
		
		public function ActivateTriageCorpusPopupEvent(corpus:TriageCorpus = null)
		{
			this.corpus = corpus;
				
			super(ACTIVATE_TRIAGE_CORPUS_POPUP);
		}
		
		override public function clone() : Event
		{
			return new ActivateTriageCorpusPopupEvent(corpus);
		}
		
	}
	
}
