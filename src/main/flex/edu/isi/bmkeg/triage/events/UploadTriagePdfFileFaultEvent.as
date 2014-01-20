package edu.isi.bmkeg.triage.events
{
	
	import flash.events.Event;
	
	import mx.rpc.events.FaultEvent;
	
	public class UploadTriagePdfFileFaultEvent extends Event 
	{
		
		public static const UPLOAD_TRIAGE_PDF_FILE_FAULT:String = "uploadTriagePdfFileFault";
		
		public var event:FaultEvent;
		
		public function UploadTriagePdfFileFaultEvent(event:FaultEvent)
		{
			this.event = event;
			super(UPLOAD_TRIAGE_PDF_FILE_FAULT);
		}
		
		override public function clone() : Event
		{
			return new UploadTriagePdfFileFaultEvent(event);
		}
		
	}
}
