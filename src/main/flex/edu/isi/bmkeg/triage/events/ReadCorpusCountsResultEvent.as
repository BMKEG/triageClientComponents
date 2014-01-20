package edu.isi.bmkeg.triage.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	import edu.isi.bmkeg.digitalLibrary.model.citations.ArticleCitation;
	import mx.collections.*;

	import mx.rpc.events.FaultEvent;
	
	public class ReadCorpusCountsResultEvent extends Event 
	{
		
		public static const READ_CORPUS_COUNTS_RESULT:String = "readCorpusCountsResult";
		
		public var list:ArrayCollection;
		
		public function ReadCorpusCountsResultEvent(list:ArrayCollection) {
			this.list = list;
			super(READ_CORPUS_COUNTS_RESULT);
		}
		
		override public function clone() : Event
		{
			return new ReadCorpusCountsResultEvent(list);
		}
		
	}
}
