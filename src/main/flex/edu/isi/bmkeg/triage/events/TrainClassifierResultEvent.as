package edu.isi.bmkeg.triage.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	import edu.isi.bmkeg.digitalLibrary.model.citations.ArticleCitation;
	
	import mx.rpc.events.FaultEvent;
	
	public class TrainClassifierResultEvent extends Event 
	{
		
		public static const TRAIN_CLASSIFIER_RESULT:String = "trainClassifierResult";
		
		public var success:Boolean;
		
		public function TrainClassifierResultEvent(success:Boolean) {
			this.success = success;
			super(TRAIN_CLASSIFIER_RESULT);
		}
		
		override public function clone() : Event
		{
			return new TrainClassifierResultEvent(success);
		}
		
	}
}
