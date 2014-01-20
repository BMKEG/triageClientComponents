package edu.isi.bmkeg.triage.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	import edu.isi.bmkeg.digitalLibrary.model.citations.ArticleCitation;
	import mx.collections.*;

	import mx.rpc.events.FaultEvent;
	
	public class TransferTriageInsToArticleCorporaResultEvent extends Event 
	{
		
		public static const TRANSFER_TRIAGE_INS_TO_ARTICLE_CORPORA_RESULT:String = 
			"transferTriageInsToArticleCorporaResult";
		
		public var success:Boolean;
		
		public function TransferTriageInsToArticleCorporaResultEvent(list:Boolean) {
			this.success = success;
			super(TRANSFER_TRIAGE_INS_TO_ARTICLE_CORPORA_RESULT);
		}
		
		override public function clone() : Event
		{
			return new TransferTriageInsToArticleCorporaResultEvent(success);
		}
		
	}
}
