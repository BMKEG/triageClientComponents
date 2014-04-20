package edu.isi.bmkeg.triage.events
{
	
	import flash.events.Event;
	
	public class SwitchInOutResultEvent extends Event
	{
		public static const SWITCH:String = "SwitchInOutResultEvent";

		public function SwitchInOutResultEvent(bubbles:Boolean=false, 
										 cancelable:Boolean=false)
		{
			super(SWITCH, bubbles, cancelable);
		}

		override public function clone():Event {
			return new SwitchInOutResultEvent(bubbles, cancelable)
		}

	}
}