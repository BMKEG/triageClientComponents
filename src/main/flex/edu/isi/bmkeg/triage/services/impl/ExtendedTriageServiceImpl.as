package edu.isi.bmkeg.triage.services.impl
{

	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.ftd.model.*;
	import edu.isi.bmkeg.triage.events.*;
	import edu.isi.bmkeg.triage.services.*;
	import edu.isi.bmkeg.triage.services.serverInteraction.*;
	import edu.isi.bmkeg.utils.dao.*;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.rpc.AbstractService;
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import flash.utils.ByteArray;

	import org.robotlegs.mvcs.Actor;

	public class ExtendedTriageServiceImpl extends Actor implements IExtendedTriageService {

		private var _server:IExtendedTriageServer;

		[Inject]
		public function get server():IExtendedTriageServer

		{
			return _server;
		}

		public function set server(s:IExtendedTriageServer):void
		{
			_server = s;
			initServer();
		}

		private function initServer():void
		{
			if (_server is AbstractService)
			{
				AbstractService(_server).addEventListener(FaultEvent.FAULT,faultHandler);
			}
		}

		private function asyncResponderFailHandler(fail:Object, token:Object):void
		{
			faultHandler(fail as FaultEvent);
		}

		private function faultHandler(event:FaultEvent):void
		{
			dispatch(event);
		}

		// ~~~~~~~~~
		// functions
		// ~~~~~~~~~

		public function addPmidEncodedPdfToTriageCorpus(pdfFileData:Object, 
														fileName:String, 
														corpusName:String, 
														ruleSetId:Number=-1,
														code:ByteArray=null):void {
			
			server.addPmidEncodedPdfToTriageCorpus.cancel();
			server.addPmidEncodedPdfToTriageCorpus.addEventListener(ResultEvent.RESULT, addPmidEncodedPdfToTriageCorpusResultHandler);
			server.addPmidEncodedPdfToTriageCorpus.addEventListener(FaultEvent.FAULT, faultHandler);
			server.addPmidEncodedPdfToTriageCorpus.send(pdfFileData, fileName, corpusName, ruleSetId, code);
		
		}
		
		private function addPmidEncodedPdfToTriageCorpusResultHandler(event:ResultEvent):void {
			
			var success:Boolean = Boolean(event.result);
			dispatch(new UploadTriagePdfFileResultEvent(success));
		
		}
		
		//~~~~~~~~~~~~~~~~~~~
		
		public function trainClassifier(targetCorpus:String):void {
			
			server.trainClassifier.cancel();
			server.trainClassifier.addEventListener(ResultEvent.RESULT, trainClassifierResultHandler);
			server.trainClassifier.addEventListener(FaultEvent.FAULT, faultHandler);
			server.trainClassifier.send(targetCorpus);
			
		}
		
		private function trainClassifierResultHandler(event:ResultEvent):void {
			
			var success:Boolean = Boolean(event.result);
			dispatch(new TrainClassifierResultEvent(success));
			
		}

		//~~~~~~~~~~~~~~~~~~~
		
		public function runClassifier(targetCorpus:String, triageCorpus:String):void {
			
			server.runClassifier.cancel();
			server.runClassifier.addEventListener(ResultEvent.RESULT, runClassifierResultHandler);
			server.runClassifier.addEventListener(FaultEvent.FAULT, faultHandler);
			server.runClassifier.send(targetCorpus, triageCorpus);
			
		}
		
		private function runClassifierResultHandler(event:ResultEvent):void {
			
			var success:Boolean = Boolean(event.result);
			dispatch(new RunClassifierPredictResultEvent(success));
			
		}
		
		//~~~~~~~~~~~~~~~~~~~
		
		public function readAllCorpusCounts():void {
			
			server.readAllCorpusCounts.cancel();
			server.readAllCorpusCounts.addEventListener(ResultEvent.RESULT, readAllCorpusCountsResultHandler);
			server.readAllCorpusCounts.addEventListener(FaultEvent.FAULT, faultHandler);
			server.readAllCorpusCounts.send();
			
		}
		
		private function readAllCorpusCountsResultHandler(event:ResultEvent):void {
			
			var success:ArrayCollection = ArrayCollection(event.result);
			dispatch(new ReadCorpusCountsResultEvent(success));
			
		}
		
		//~~~~~~~~~~~~~~~~~~~
		
		public function transferTriageInsToArticleCorpora():void {
			
			server.transferTriageInsToArticleCorpora.cancel();
			server.transferTriageInsToArticleCorpora.addEventListener(ResultEvent.RESULT, transferTriageInsToArticleCorporaResultHandler);
			server.transferTriageInsToArticleCorpora.addEventListener(FaultEvent.FAULT, faultHandler);
			server.transferTriageInsToArticleCorpora.send();
			
		}
		
		private function transferTriageInsToArticleCorporaResultHandler(event:ResultEvent):void {
			
			var success:Boolean = Boolean(event.result);
			dispatch(new TransferTriageInsToArticleCorporaResultEvent(success));
			
		}
		
	}

}
