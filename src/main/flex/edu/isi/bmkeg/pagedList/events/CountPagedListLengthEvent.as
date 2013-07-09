package edu.isi.bmkeg.pagedList.events
{
	import edu.isi.bmkeg.pagedList.model.PagedListModel;
	
	import flash.events.Event;
	
	public class CountPagedListLengthEvent extends Event
	{
		public static const COUNT_PAGED_LIST_LENGTH:String = "CountPagedListLengthEvent";

		public function CountPagedListLengthEvent(bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(COUNT_PAGED_LIST_LENGTH, bubbles, cancelable);
		}

		override public function clone():Event
		{
			return new CountPagedListLengthEvent(bubbles, cancelable)
		}

	}
}