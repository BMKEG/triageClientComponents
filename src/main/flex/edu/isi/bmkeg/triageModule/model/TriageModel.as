package edu.isi.bmkeg.triageModule.model
{
	
	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.ftd.model.FTD;
	import edu.isi.bmkeg.triage.model.*;
	import edu.isi.bmkeg.triage.model.qo.TriageScore_qo;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.utils.Dictionary;
	import flash.display.*;
	
	import mx.collections.ArrayCollection;
	import mx.utils.UIDUtil;
	
	import org.robotlegs.mvcs.Actor;

	[Bindable]
	public class TriageModel extends Actor
	{
		public var listPageSize:int = 200;
		
		public var message:String = "";
		
		public var corpora:ArrayCollection = new ArrayCollection();
		
		public var triageCorpora:ArrayCollection = new ArrayCollection();
		
		public var targetCorpus:Corpus;		

		public var triageCorpus:Corpus;		
				
		public var queryTriagedDocument:TriageScore_qo;
		public var queryCorpusCount:int;

		public var queryLiteratureCitation:LiteratureCitation_qo;

		public var currentCitation:ArticleCitation;
		
		public var refreshFullText:Boolean = false;

		public var currentScores:ArrayCollection = new ArrayCollection();
		
		public var classificationModels:ArrayCollection = new ArrayCollection();

		public var rulesets:ArrayCollection = new ArrayCollection();

		public var swf:MovieClip;
		
		// An array of adapted org.ffilmation.utils.rtree.fRTree objects 
		public var rTreeArray:ArrayCollection = new ArrayCollection();
		
		// An array of arrays of words, indexed by page, then by rtree index
		public var indexedWordsByPage:ArrayCollection = new ArrayCollection();
		
		// The fragmenter renders each page as a bitmap. This is the scaling factor 
		// used to mitigate pixelation so that the pages look OK in the interface.
		public var pdfScale:Number = 2.0;
		
		// The text of the current PDF file expressed as a PMC file.
		public var pmcHtml:String;
		
		public var tokensToHighlight:Object = new Object();

		public var features:ArrayCollection= new ArrayCollection();
		
		public function TriageModel() {			
			tokensToHighlight["mouse"] = 1;
			tokensToHighlight["mice"] = 1;
			tokensToHighlight["murine"] = 1;
			tokensToHighlight["Mouse"] = 1;
			tokensToHighlight["Mice"] = 1;
			tokensToHighlight["Murine"] = 1;
		}
		
	}

}