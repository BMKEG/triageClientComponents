package edu.isi.bmkeg.triageModule.controller
{	
	import edu.isi.bmkeg.digitalLibrary.events.*;
	import edu.isi.bmkeg.triageModule.model.TriageModel;
	import edu.isi.bmkeg.pagedList.model.*;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.display.*;
	import flash.events.Event;
	import flash.system.LoaderContext;
	
	import mx.collections.ArrayCollection;
	import mx.controls.SWFLoader;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoadSwfResultCommand extends Command
	{
		
		[Inject]
		public var event:LoadSwfResultEvent;
		
		[Inject]
		public var model:TriageModel;

		override public function execute():void
		{
			model.swf = event.swf;
		}
		
	}
	
}