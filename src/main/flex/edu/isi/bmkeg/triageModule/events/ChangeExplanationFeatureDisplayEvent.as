package edu.isi.bmkeg.triageModule.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class ChangeExplanationFeatureDisplayEvent extends Event 
	{
		
		public static const CHANGE_EXPLANATION_FEATURE_DISPLAY:String = "changeExplanationFeatureDisplay";
		
		public var pgOrBlocks:String;
		
		public function ChangeExplanationFeatureDisplayEvent( pgOrBlocks:String,
				bubbles:Boolean=false, cancelable:Boolean=false )
		{
			this.pgOrBlocks = pgOrBlocks;
			super(CHANGE_EXPLANATION_FEATURE_DISPLAY, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new ChangeExplanationFeatureDisplayEvent(pgOrBlocks, bubbles, cancelable);
		}
		
	}
	
}
