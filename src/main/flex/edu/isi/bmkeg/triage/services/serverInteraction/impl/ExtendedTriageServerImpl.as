package edu.isi.bmkeg.triage.services.serverInteraction.impl
{

	import edu.isi.bmkeg.triage.services.serverInteraction.*;

	import mx.collections.ArrayCollection;
	import mx.rpc.AbstractOperation;
	import mx.rpc.AbstractService;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.rpc.AbstractOperation;

	import edu.isi.bmkeg.utils.dao.Utils;
	import edu.isi.bmkeg.triage.services.serverInteraction.IExtendedTriageServer;

	public class ExtendedTriageServerImpl 
			extends RemoteObject 
			implements IExtendedTriageServer
	{

		private static const SERVICES_DEST:String = "extendedTriageServiceImpl";

		public function ExtendedTriageServerImpl()
		{
			destination = SERVICES_DEST;
			endpoint = Utils.getRemotingEndpoint();
			showBusyCursor = true;
		}
		
		// ~~~~~~~~~~~~~~~
		// functions
		// ~~~~~~~~~~~~~~~
		public function get addPmidEncodedPdfToTriageCorpus():AbstractOperation
		{
			return getOperation("addPmidEncodedPdfToTriageCorpus");
		}

		public function get trainClassifier():AbstractOperation
		{
			return getOperation("trainClassifier");
		}
		
		public function get runClassifier():AbstractOperation
		{
			return getOperation("runClassifier");
		}

		public function get readAllCorpusCounts():AbstractOperation
		{
			return getOperation("readAllCorpusCounts");
		}
		
		public function get transferTriageInsToArticleCorpora():AbstractOperation
		{
			return getOperation("transferTriageInsToArticleCorpora");
		}
		
	}

}