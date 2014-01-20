package edu.isi.bmkeg.triage.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class RunClassifierPredictEvent extends Event 
	{
		
		public static const RUN_CLASSIFIER_PREDICT:String = "runClassifierPredict";
		
		public var targetCorpusName:String;
		public var triageCorpusName:String;
		
		public function RunClassifierPredictEvent(targetCorpusName:String,
												  triageCorpusName:String,
												  bubbles:Boolean=false, 
												 cancelable:Boolean=false) {
			this.targetCorpusName = targetCorpusName;
			this.triageCorpusName = triageCorpusName;
			
			super(RUN_CLASSIFIER_PREDICT, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new RunClassifierPredictEvent(
				targetCorpusName, triageCorpusName, 
				bubbles, cancelable);
		}
		
	}
	
}
