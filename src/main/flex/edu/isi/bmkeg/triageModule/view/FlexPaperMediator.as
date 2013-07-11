package edu.isi.bmkeg.triageModule.view
{
	
	import com.devaldi.controls.flexpaper.FlexPaperViewer;
	import com.devaldi.events.DocumentLoadedEvent;
	import com.devaldi.streaming.SwfDocument;
	
	
	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.ftd.model.*;
	import edu.isi.bmkeg.ftd.rl.events.*;
	import edu.isi.bmkeg.triage.events.*;
	import edu.isi.bmkeg.triage.model.TriageScore;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triage.rl.services.ITriageService;
	import edu.isi.bmkeg.triageModule.events.*;
	import edu.isi.bmkeg.triageModule.model.TriageModel;
	import edu.isi.bmkeg.utils.dao.Utils;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.utils.ByteArray;
	import flash.events.ErrorEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class FlexPaperMediator extends Mediator
	{
		[Inject]
		public var view:FlexPaperViewer;
		
		[Inject]
		public var triageModel:TriageModel;
		
		override public function onRegister():void {
			
			addContextListener(FindTriageScoreByIdResultEvent.FIND_TRIAGESCOREBY_ID_RESULT, 
				findTriageScoreByIdResultHandler);

			addContextListener(ListTriageScoreListPagedEvent.LIST_TRIAGESCORELIST_PAGED, 
				ListTriageScoreListPagedHandler);
			
			addViewListener(DocumentLoadedEvent.DOCUMENT_LOADED, documentLoadedHandler);
			
			addViewListener(ErrorEvent.ERROR, errorHandler);
			
			if( triageModel.currentScore != null )
				dispatch(new FindTriageScoreByIdEvent(triageModel.currentScore.vpdmfId));
					
		}

		private function findTriageScoreByIdResultHandler(event:FindTriageScoreByIdResultEvent):void {
			
			var url:String = "/" + Utils.getWebAppContext();
			
			var cit:LiteratureCitation = event.object.citation as LiteratureCitation;
			
			url = url + "/rest/load?swfFile=" + cit.vpdmfId + ".swf";
			
			try {
				
				this.view.loadSwf(url);
				
			} catch(e:Error){
				
				trace("Error loading SWF file: " + e);
				
			}
			
		}
		
		private function ListTriageScoreListPagedHandler(event:ListTriageScoreListPagedEvent):void {
			
			var url:String = "/" + Utils.getWebAppContext();
						
			url = url + "/rest/load?swfFile=00000.swf";
						
			this.view.loadSwf(url);
						
		}
		
		public function documentLoadedHandler(event:DocumentLoadedEvent):void {
			
			
			trace("Document Loaded");
				
		}

		public function errorHandler(event:DocumentLoadedEvent):void {
			
			trace("Error");
			
		}

				
	}
	
}