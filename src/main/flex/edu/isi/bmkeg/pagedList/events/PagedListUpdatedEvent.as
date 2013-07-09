package edu.isi.bmkeg.pagedList.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class PagedListUpdatedEvent extends Event
	{
		public static const UPDATED:String = "InfiniteListUpdatedEvent";
		
		public function PagedListUpdatedEvent(bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(UPDATED, bubbles, cancelable);
		}

		override public function clone():Event
		{
			return new PagedListUpdatedEvent(bubbles, cancelable)
		}

	}
}