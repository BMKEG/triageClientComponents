package edu.isi.bmkeg.triage.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class UploadTriagePdfFileEvent extends Event 
	{
		
		public static const UPLOAD_TRIAGE_PDF_FILE:String = "uploadTriagePdfFile";
		
		public var data:ByteArray;
		public var fileName:String;
		public var corpusName:String;
		public var ruleSetId:Number;
		public var code:ByteArray;
		
		public function UploadTriagePdfFileEvent(data:ByteArray, 
												 fileName:String, 
												 corpusName:String,
												 ruleSetId:Number,
												 code:ByteArray = null,
												 bubbles:Boolean=false, 
												 cancelable:Boolean=false) {
			this.data = data;
			this.fileName = fileName;
			this.corpusName = corpusName;
			this.ruleSetId = ruleSetId;
			this.code = code;
			
			super(UPLOAD_TRIAGE_PDF_FILE, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new UploadTriagePdfFileEvent(data, 
				fileName, corpusName, ruleSetId, 
				code, bubbles, cancelable);
		}
		
	}
	
}
