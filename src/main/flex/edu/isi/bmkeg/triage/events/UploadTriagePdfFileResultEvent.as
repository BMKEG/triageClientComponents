package edu.isi.bmkeg.triage.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	import edu.isi.bmkeg.digitalLibrary.model.citations.ArticleCitation;
	
	import mx.rpc.events.FaultEvent;
	
	public class UploadTriagePdfFileResultEvent extends Event 
	{
		
		public static const UPLOAD_TRIAGE_PDF_FILE_RESULT:String = "uploadTriagePdfFileResult";
		
		public var success:Boolean;
		
		public function UploadTriagePdfFileResultEvent(success:Boolean) {
			this.success = success;
			super(UPLOAD_TRIAGE_PDF_FILE_RESULT);
		}
		
		override public function clone() : Event
		{
			return new UploadTriagePdfFileResultEvent(success);
		}
		
	}
}
