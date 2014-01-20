package edu.isi.bmkeg.triage.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class TransferTriageInsToArticleCorporaEvent extends Event 
	{
		
		public static const TRANSFER_TRIAGE_INS_TO_ARTICLE_CORPORA:String = "transferTriageInsToArticleCorpora";
		
		public function TransferTriageInsToArticleCorporaEvent( bubbles:Boolean=false, 
												 cancelable:Boolean=false) {			
			super(TRANSFER_TRIAGE_INS_TO_ARTICLE_CORPORA, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new TransferTriageInsToArticleCorporaEvent(bubbles, cancelable);
		}
		
	}
	
}
