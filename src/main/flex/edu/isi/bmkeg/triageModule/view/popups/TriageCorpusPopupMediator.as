package edu.isi.bmkeg.triageModule.view.popups
{

	import edu.isi.bmkeg.triage.events.*;
	import edu.isi.bmkeg.digitalLibrary.events.*;
	import edu.isi.bmkeg.triage.model.*;
	import edu.isi.bmkeg.triage.model.qo.*;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triageModule.events.*;
	import edu.isi.bmkeg.triageModule.model.*;
	import edu.isi.bmkeg.pagedList.*;
	import edu.isi.bmkeg.pagedList.model.*;
	
	import flash.events.Event;
	
	import mx.collections.ItemResponder;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.Alert;
	import mx.events.CollectionEvent;
	import mx.managers.PopUpManager;
	import mx.utils.StringUtil;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class TriageCorpusPopupMediator extends Mediator
	{
		
		[Inject]
		public var view:TriageCorpusPopup;
		
		[Inject]
		public var model:TriageModel;

		override public function onRegister():void {
			
			addViewListener(InsertTriageCorpusEvent.INSERT_TRIAGECORPUS, dispatch);
			addViewListener(UpdateTriageCorpusEvent.UPDATE_TRIAGECORPUS, dispatch);
			addViewListener(ClosePopupEvent.CLOSE_POPUP, closePopup);

		}
		
		private function closePopup(event:ClosePopupEvent):void {
			
			mediatorMap.removeMediatorByView( event.popup );
			PopUpManager.removePopUp( event.popup );
			
		}
		
	}

}