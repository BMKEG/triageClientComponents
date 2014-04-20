package edu.isi.bmkeg.triage.services.serverInteraction
{

	import mx.rpc.AbstractOperation;

	public interface IExtendedTriageServer {

		// ~~~~~~~~~~~~~~~
		//  functions
		// ~~~~~~~~~~~~~~~
		function get addPmidEncodedPdfToTriageCorpus():AbstractOperation;

		function get trainClassifier():AbstractOperation;
		
		function get runClassifier():AbstractOperation;

		function get readAllCorpusCounts():AbstractOperation;
		
		function get transferTriageInsToArticleCorpora():AbstractOperation;

		function get switchInOutCodes():AbstractOperation;
		
	}

}