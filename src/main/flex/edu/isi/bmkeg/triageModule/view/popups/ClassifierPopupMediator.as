package edu.isi.bmkeg.triageModule.view.popups
{

	import edu.isi.bmkeg.digitalLibrary.events.ClosePopupEvent;
	import edu.isi.bmkeg.ftd.model.qo.FTDRuleSet_qo;
	import edu.isi.bmkeg.ftd.rl.events.*;
	import edu.isi.bmkeg.pagedList.*;
	import edu.isi.bmkeg.pagedList.model.*;
	import edu.isi.bmkeg.triage.events.*;
	import edu.isi.bmkeg.triageModule.model.*;
	import edu.isi.bmkeg.utils.serverUpdates.services.IServerUpdateService;
	import edu.isi.bmkeg.utils.ServiceUtils;
	import edu.isi.bmkeg.utils.updownload.*;
	import edu.isi.bmkeg.utils.uploadDirectoryControl.*;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.collections.ItemResponder;
	import mx.collections.errors.ItemPendingError;
	
	import mx.controls.Alert;
	
	import mx.events.CollectionEvent;
	
	import mx.managers.PopUpManager;

	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.messaging.Consumer;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.messages.AsyncMessage;
	
	import mx.utils.StringUtil;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ClassifierPopupMediator extends Mediator
	{
		
		[Inject]
		public var view:ClassifierPopup;
		
		[Inject]
		public var model:TriageModel;

		[Inject]
		public var service:IServerUpdateService;
		
		override public function onRegister():void {
			
			addViewListener(ClosePopupEvent.CLOSE_POPUP, closePopup);

			addContextListener(RunClassifierPredictResultEvent.RUN_CLASSIFIER_PREDICT_RESULT, 
				uploadComplete);

			addContextListener(TrainClassifierResultEvent.TRAIN_CLASSIFIER_RESULT, 
				uploadComplete);
			
			view.consumer.subscribe();	
		}

		private function uploadComplete(event:Event):void {
		
			this.closePopup(new ClosePopupEvent(view));
		
		}
		
		private function closePopup(event:ClosePopupEvent):void {
			
			view.consumer.unsubscribe();

			mediatorMap.removeMediatorByView( event.popup );
			
			PopUpManager.removePopUp( event.popup );
			
		}
		
	}

}