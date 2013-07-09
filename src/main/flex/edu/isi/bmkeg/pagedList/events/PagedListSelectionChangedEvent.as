package edu.isi.bmkeg.pagedList.events
{
	import edu.isi.bmkeg.digitalLibrary.model.citations.ArticleCitation;
	
	import flash.events.Event;
	
	public class PagedListSelectionChangedEvent extends Event
	{
		public static const CHANGED:String = "PagedListSelectionChangedEvent";

		/**
		 * selected Article or null if none is selected
		 */
		public var selectedIndex:int;
		
		public function PagedListSelectionChangedEvent(selectedIndex:int, 
												 bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(CHANGED, bubbles, cancelable);
			this.selectedIndex = selectedIndex;
		}

		override public function clone():Event
		{
			return new PagedListSelectionChangedEvent(selectedIndex, bubbles, cancelable)
		}

	}
}