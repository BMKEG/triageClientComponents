package edu.isi.bmkeg.triage.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class TrainClassifierEvent extends Event 
	{
		
		public static const TRAIN_CLASSIFIER:String = "trainClassifier";
		
		public var corpusName:String;
		
		public function TrainClassifierEvent(corpusName:String,
												 bubbles:Boolean=false, 
												 cancelable:Boolean=false) {
			this.corpusName = corpusName;
			
			super(TRAIN_CLASSIFIER, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new TrainClassifierEvent(corpusName, bubbles, cancelable);
		}
		
	}
	
}
