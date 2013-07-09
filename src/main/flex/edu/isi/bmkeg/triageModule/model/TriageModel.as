package edu.isi.bmkeg.triageModule.model
{
	
	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.triage.model.*;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.utils.UIDUtil;

	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	import org.robotlegs.mvcs.Actor;

	[Bindable]
	public class TriageModel extends Actor
	{
		public var listPageSize:int = 200;
		
		public var corpora:ArrayCollection = new ArrayCollection();
		
		public var triageCorpora:ArrayCollection = new ArrayCollection();
		
		public var targetCorpus:Corpus;		

		public var triageCorpus:Corpus;		
				
		public var queryTriagedDocument:TriageScore;

		public var currentScore:TriageScore;

		public var currentInOutCode:int;
		
	}

}