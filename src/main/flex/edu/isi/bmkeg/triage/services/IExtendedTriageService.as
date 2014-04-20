package edu.isi.bmkeg.triage.services
{

	import edu.isi.bmkeg.ftd.model.*;
	
	import mx.collections.ArrayCollection;

	import flash.utils.ByteArray;

	public interface IExtendedTriageService {

		// ~~~~~~~~~~~~~~~
		//  functions
		// ~~~~~~~~~~~~~~~
		
		function addPmidEncodedPdfToTriageCorpus(pdfFileData:Object,
										   fileName:String, 
										   corpusName:String,
										   ruleSetId:Number=-1,
										   code:ByteArray=null):void;	
	
		function trainClassifier(targetCorpus:String):void;

		function runClassifier(targetCorpus:String, triageCorpus:String):void;

		function readAllCorpusCounts():void;
		
		function transferTriageInsToArticleCorpora():void;
		
		function switchInOutCodes(scoreId:Number, code:String):void;

	}

}
