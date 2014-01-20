package edu.isi.bmkeg.triageModule.events
{
	
	import flash.events.Event;
	import edu.isi.bmkeg.triage.model.*;
	
	public class ActivateClassifierPopupEvent extends Event
	{
		public static const ACTIVATE_CLASSIFIER_POPUP:String = "activateClassifierPopup";
		
		public function ActivateClassifierPopupEvent(bubbles:Boolean=false, 
												 cancelable:Boolean=false)
		{
			super(ACTIVATE_CLASSIFIER_POPUP, bubbles, cancelable);
		}

		override public function clone():Event
		{
			return new ActivateClassifierPopupEvent(bubbles, 
				cancelable)
		}

	}
}