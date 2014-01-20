package edu.isi.bmkeg.triage.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class ReadCorpusCountsEvent extends Event 
	{
		
		public static const READ_CORPUS_COUNTS:String = "readCorpusCounts";
		
		public function ReadCorpusCountsEvent( bubbles:Boolean=false, 
												 cancelable:Boolean=false) {			
			super(READ_CORPUS_COUNTS, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new ReadCorpusCountsEvent(bubbles, cancelable);
		}
		
	}
	
}
