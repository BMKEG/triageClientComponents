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
	import mx.utils.StringUtil;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class UploadPdfsPopupMediator extends Mediator
	{
		
		[Inject]
		public var view:UploadPdfsPopup;
		
		[Inject]
		public var model:TriageModel;

		[Inject]
		public var service:IServerUpdateService;
		
		override public function onRegister():void {
			
			addViewListener(ClosePopupEvent.CLOSE_POPUP, closePopup);

			addViewListener(UploadCompleteEvent.UPLOAD_COMPLETE, 
				uploadCodesHandler);
			
			addViewListener(UploadToBrowserCompleteEvent.UPLOAD_TO_BROWSER_COMPLETE, 
				uploadPdfsToDatabase);

			addViewListener(AllFileUploadsCompleteEvent.ALL_FILE_UPLOADS_COMPLETE, 
				uploadComplete);

			addContextListener(ListFTDRuleSetResultEvent.LIST_FTDRULESET_RESULT, 
				listRulesHandler);
			
			addContextListener(UploadTriagePdfFileResultEvent.UPLOAD_TRIAGE_PDF_FILE_RESULT, 
				startNextFileHandler);

			this.dispatch(new ListFTDRuleSetEvent(new FTDRuleSet_qo()));

		}

		private function uploadComplete(event:AllFileUploadsCompleteEvent):void {
		
			this.closePopup(new ClosePopupEvent(view));
		
		}
		
		private function closePopup(event:ClosePopupEvent):void {
			
			if( view.consumer != null ) 
				view.consumer.unsubscribe();

			mediatorMap.removeMediatorByView( event.popup );
			
			PopUpManager.removePopUp( event.popup );
			
		}

		private function listRulesHandler(event:ListFTDRuleSetResultEvent):void {

			view.ruleFiles = model.rulesets;			
		
		}

		
		private function uploadCodesHandler(event:UploadCompleteEvent):void {
						
			view.codeFile = event.file;			
			
		}
		
		private function uploadPdfsToDatabase(event:UploadToBrowserCompleteEvent):void {

			var ruleSetLvi:LightViewInstance = 
				LightViewInstance(view.ruleFileControl.selectedItem);
			var ruleSetId:Number = -1;
			if(ruleSetLvi != null) {
				ruleSetId = ruleSetLvi.vpdmfId;
			}
			
			var codeFileData:ByteArray = null;
			if( view.codeFile != null )
				codeFileData = view.codeFile.data;

			var upEvent:UploadTriagePdfFileEvent = new UploadTriagePdfFileEvent(
				event.file.data,
				event.file.name,
				view.tc.name,
				ruleSetId,
				codeFileData
				);
				
			this.dispatch(upEvent);			
			
		}
		
		private function startNextFileHandler(event:UploadTriagePdfFileResultEvent):void {
			
			view.count++;
			view.progressBar.setProgress(view.count, view.max);
			view.pdfUploadButton.startLoadingNextFile();
			
		}
		
	}

}