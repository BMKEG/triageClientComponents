package edu.isi.bmkeg.pagedList.model
{
	import edu.isi.bmkeg.pagedList.PagedList;
	import edu.isi.bmkeg.pagedList.events.*;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * The citations collection supporting this model is implemented using the PagedList class
	 * created by James Ward.
	 * This class implements an IList whose items are retrieved asynchronically from a remote
	 * service. When attempting to call the getItemAt() method and the requested item hasn't 
	 * been retrieved yet, the PagedList throws an ItemPendingError exception which includes
	 * a call responder for the caller to add a callback function to be called when the service
	 * completes the retrieve operation.
	 */
	public class PagedListModel extends Actor
	{
		
		public var pageSize:int = 200;
		
		public var tempOffset:int = -1;
		
		private var _pagedList:PagedList = null;
		
		private var _selectedIndex:int = -1;
				
		public function get selectedObject():Object
		{
			if (_selectedIndex == -1)
			{
				return null;
			}
			else
			{
				return _pagedList.getItemAt(_selectedIndex);
			}
		}

		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		public function set selectedIndex(v:int):void
		{
			if (v != _selectedIndex)
			{
				_selectedIndex = v;
				dispatch(new PagedListSelectionChangedEvent(selectedIndex));						
			}

		}
		
		public function initCitationsList():void
		{
			dispatch(new CountPagedListLengthEvent());
		}
		
		public function get pagedListLength():int
		{
			return _pagedList.length;
		}
			
		public function set pagedListLength(v:int):void
		{
			
			if( this.tempOffset >= 0 ) {
				
				var list:IList = _pagedList;
				_pagedList = new PagedList(v, pageSize);
				_pagedList.loadItemsFunction = dispatchPagedListRetrievePageEvent;
				this.storeObjectsAt(this.tempOffset, list.toArray(), false);
				this.tempOffset = -1;
				dispatch(new PagedListUpdatedEvent());
				
			} else {

				_pagedList = new PagedList(v, pageSize);
				_pagedList.loadItemsFunction = dispatchPagedListRetrievePageEvent;
				dispatch(new PagedListUpdatedEvent());
				
			}
			
		}
		
		
		public function get pagedList():IList
		{
			return _pagedList;
		}
		
		public function storeObjectsAt(offset:int, objects:Array, refresh:Boolean):void
		{
						
			if( _pagedList == null || refresh) {
				
				_pagedList = new PagedList(objects.length, pageSize);
				_pagedList.storeItemsAt(objects, 0); 
				this.tempOffset = offset;
				dispatch(new CountPagedListLengthEvent());
				dispatch(new PagedListUpdatedEvent());
				
			} else {
				
				_pagedList.storeItemsAt(objects, offset); 
				dispatch(new PagedListUpdatedEvent());
				
			}
			
		}

		private function dispatchPagedListRetrievePageEvent(list:PagedList, index:int, count:int):void {
			
			dispatch(new PagedListRetrievePageEvent(index, count) );
				
		}
		
		public function setLoadItemsFunction(loadItemFunction:Function):void {
			
			this._pagedList.loadItemsFunction = loadItemFunction;
		
		}
		
	}
}