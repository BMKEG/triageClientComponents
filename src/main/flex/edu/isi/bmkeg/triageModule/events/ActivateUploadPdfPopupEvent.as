package edu.isi.bmkeg.triageModule.events
{
	
	import flash.events.Event;
	
	import edu.isi.bmkeg.triage.model.*;
	
	public class ActivateUploadPdfPopupEvent extends Event
	{
		public static const ACTIVATE_PDF_UPLOAD_POPUP:String = "activatePdfUploadPopup";

		public var triageCorpus:TriageCorpus;
		
		public function ActivateUploadPdfPopupEvent(triageCorpus:TriageCorpus,
													bubbles:Boolean=false, 
												 cancelable:Boolean=false)
		{
			super(ACTIVATE_PDF_UPLOAD_POPUP, bubbles, cancelable);
			this.triageCorpus = triageCorpus; 
		}

		override public function clone():Event
		{
			return new ActivateUploadPdfPopupEvent(triageCorpus, 
				bubbles, 
				cancelable)
		}

	}
}