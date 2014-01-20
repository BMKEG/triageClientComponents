package edu.isi.bmkeg.triage.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	import edu.isi.bmkeg.digitalLibrary.model.citations.ArticleCitation;
	
	import mx.rpc.events.FaultEvent;
	
	public class RunClassifierPredictResultEvent extends Event 
	{
		
		public static const RUN_CLASSIFIER_PREDICT_RESULT:String = "runClassifierPredictResult";
		
		public var success:Boolean;
		
		public function RunClassifierPredictResultEvent(success:Boolean) {
			this.success = success;
			super(RUN_CLASSIFIER_PREDICT_RESULT);
		}
		
		override public function clone() : Event
		{
			return new RunClassifierPredictResultEvent(success);
		}
		
	}
}
