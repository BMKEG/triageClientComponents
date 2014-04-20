package edu.isi.bmkeg.triageModule.view
{

	import edu.isi.bmkeg.digitalLibrary.events.*;
	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
	import edu.isi.bmkeg.digitalLibraryModule.events.*;
	import edu.isi.bmkeg.ftd.model.*;
	import edu.isi.bmkeg.ftd.model.qo.*;
	import edu.isi.bmkeg.ftd.rl.events.*;
	import edu.isi.bmkeg.pagedList.*;
	import edu.isi.bmkeg.pagedList.model.*;
	import edu.isi.bmkeg.terminology.model.Term;
	import edu.isi.bmkeg.terminology.model.qo.Term_qo;
	import edu.isi.bmkeg.terminology.rl.events.*;
	import edu.isi.bmkeg.triage.rl.events.*;
	import edu.isi.bmkeg.triageModule.events.*;
	import edu.isi.bmkeg.triageModule.model.*;
	import edu.isi.bmkeg.utils.dao.Utils;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Matrix;
	import flash.net.*;
	import flash.utils.ByteArray;
	
	import flashx.textLayout.conversion.TextConverter;
	
	import mx.collections.*;
	import mx.collections.ArrayCollection;
	import mx.collections.ItemResponder;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.Alert;
	import mx.controls.SWFLoader;
	import mx.core.IFactory;
	import mx.events.CollectionEvent;
	import mx.events.ResizeEvent;
	import mx.graphics.*;
	import mx.managers.PopUpManager;
	import mx.utils.StringUtil;
	
	import org.ffilmation.utils.rtree.*;
	import org.libspark.utils.ForcibleLoader;
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	import spark.primitives.*;
	
	public class ExplanationFeatureDisplayMediator extends Mediator
	{
		
		[Inject]
		public var view:ExplanationFeatureDisplay;
		
		[Inject]
		public var model:TriageModel;
		
		private var xml:XML;
				
		override public function onRegister():void {

			addViewListener(ResizeEvent.RESIZE, 
				eventDrivenRedraw);

			addViewListener(RemoveAnnotationEvent.REMOVE_ANNOTATION, 
				dispatch);
			
			addViewListener(ChangeExplanationFeatureDisplayEvent.CHANGE_EXPLANATION_FEATURE_DISPLAY, 
				manageChanges);

			addViewListener(RunRuleSetOnArticleCitationEvent.RUN_RULE_SET_ON_ARTICLE_CITATION, 
				runRules);

			addContextListener(
				FindTriagedArticleByIdResultEvent.FIND_TRIAGEDARTICLEBY_ID_RESULT, 
				buildDisplayFromFindByIdResult);

			addContextListener(
				RetrieveFTDRuleSetForArticleCitationResultEvent.RETRIEVE_FTDRULESET_FOR_ARTICLE_CITATION_RESULT, 
				updateRuleSet);

			addContextListener(
				GenerateRuleFileFromLapdfResultEvent.GENERATE_RULE_FILE_FROM_LAPDF_RESULT, 
				updateCsv);
			
			addContextListener(LoadSwfResultEvent.LOAD_SWF_RESULT, 
				swfFileLoadResult);
			
			addContextListener(LoadXmlResultEvent.LOAD_XML_RESULT, 
				xmlFileLoadResult);
			
			addContextListener(LoadHtmlResultEvent.LOAD_HTML_RESULT, 
				htmlFileLoadResult);

			if( model.currentCitation != null ) {
				this.buildBitmaps( model.currentCitation.vpdmfId );
			}

		}

		private function runRules(event:RunRuleSetOnArticleCitationEvent):void {
			if( model.currentCitation == null )
				return;
			
			event.articleId = model.currentCitation.vpdmfId;
			dispatch(event);
		}

		private function updateCsv(event:GenerateRuleFileFromLapdfResultEvent):void {
			view.csv = event.csv;
		}
		
		private function updateRuleSet(event:RetrieveFTDRuleSetForArticleCitationResultEvent):void {
			
			if( event.ruleSet == null ) {
				this.view.ruleSet = new FTDRuleSet();				
				this.view.ruleSet.fileName = "---general.drl---";				
			} else {
				this.view.ruleSet = event.ruleSet;
			}
		
		}
		
		private function manageChanges(event:ChangeExplanationFeatureDisplayEvent):void {
			
			if( model.currentCitation == null ) {
				return;
			}
			
			var acId:Number = Number(model.currentCitation.vpdmfId);
			
			var alpha:Number = -1.0;
			var state:int = -1;
			if( event.pgOrBlocks == "Pages" ) {
				for( var i:int = 0; i<view.bitmaps.length; i++) {
					var bh:ExplanationFeatureDisplayHolder = readExplanationFeatureDisplayHolder(i);		
					bh.alpha = 1.0;			
					bh.state = 1.0;
				}
				if( this.view.bitmaps.length == 0 ){
					this.buildBitmaps(acId);
				}
			}			
						
		}

		private function buildDisplayFromFindByIdResult(event:FindTriagedArticleByIdResultEvent):void {

			if( model.currentCitation == null ) {
				return;
			}
			
			var acId:Number = Number(model.currentCitation.vpdmfId);
			
			//this.view.featureButton.selected = true;
			this.view.currentState = "showPages";
						
			this.view.features = model.features;
			
			if( model.refreshFullText ) {
				this.view.bitmaps.removeAll();
				this.buildBitmaps(model.currentCitation.vpdmfId);
			}
			
		}
		
		private function buildBitmaps(vpdmfId:Number):void{
			
			//
			// First, get the swf file on the server for the images
			//
			this.dispatch( new LoadSwfEvent(vpdmfId) );
			
			//
			// Next, get the xml for the page boxes
			//
			this.dispatch( new LoadXmlEvent(vpdmfId) );
			
			//
			// Finally, get the html for the text of the document 
			// (this is the end product that we will annotate)
			//
			this.dispatch( new LoadHtmlEvent(vpdmfId) );
			
			view.bitmaps = new ArrayCollection();
			
		}

		private function readExplanationFeatureDisplayHolder(pMinusOne:int):ExplanationFeatureDisplayHolder {
			
			var fh:ExplanationFeatureDisplayHolder;
			
			if( view.bitmaps.length <= pMinusOne ) {
				fh = new ExplanationFeatureDisplayHolder(model.pdfScale);
				fh.page = pMinusOne + 1;
				view.bitmaps.addItem(fh);
			} else {
				fh = ExplanationFeatureDisplayHolder(view.bitmaps.getItemAt(pMinusOne));
			}
			
			return fh;
			
		}

		private function swfFileLoadResult(event:LoadSwfResultEvent):void {
			
			var clip:MovieClip = model.swf;
						
			var frames:int = clip.totalFrames;
			
			for(var i:int=1; i<=frames; i++){
				clip.gotoAndStop(i)
				var bitmapData:BitmapData = new BitmapData(
					clip.width*model.pdfScale, clip.height*model.pdfScale,
					true, 0x00FFFFFF);

				var mat:Matrix=new Matrix();
				mat.scale(model.pdfScale,model.pdfScale);

				bitmapData.draw(clip, mat);
				var o:ExplanationFeatureDisplayHolder = readExplanationFeatureDisplayHolder(i-1);			
				o.image = new Bitmap(bitmapData);
			}

			this.forceRedraw();				
			
		}
		
		private function xmlFileLoadResult(event:LoadXmlResultEvent):void {
			
			xml = XML(event.xml);
				
			//
			// Build the spatial index of the PDF content here. 
			//
			model.rTreeArray = new ArrayCollection();
			model.indexedWordsByPage = new ArrayCollection();
		
			var p:int = 0; 
			for each(var pageXml:XML in xml.pages[0].*) {

				var rTree:fRTree = new fRTree();
				model.rTreeArray.addItemAt(rTree,p);
				
				var words:ArrayCollection = new ArrayCollection();
				model.indexedWordsByPage.addItemAt(words,p);
		
				var fh:ExplanationFeatureDisplayHolder = readExplanationFeatureDisplayHolder(p);
				fh.extraRectangles = new ArrayCollection();
				
				var wc:int = 0;
				for each(var chunkXml:XML in pageXml.chunks[0].*) {	
					
					var chunkType:String = chunkXml.@type;
					
					for each(var wordXml:XML in chunkXml.words[0].*) {
						
						var xxx1:Number = wordXml.@x;
						var yyy1:Number = wordXml.@y;
						var zzz1:Number = 0;
						var xxx2:Number = xxx1 + Number(wordXml.@w);
						var yyy2:Number = yyy1 + Number(wordXml.@h);
						var zzz2:Number = 1;
						var w:String = new String(wordXml.@t[0]);
						
						var c:fCube = new fCube(xxx1, yyy1, zzz1, xxx2, yyy2, zzz2);
						rTree.addCube(c, wc);
						words.addItemAt(wordXml, wc);
						
						//trace(wc+ " - p: "+p+", x:"+x1+", y:"+y1+", w:"+w);
						
						wc++;
						
						if(model.tokensToHighlight[w] != null && 
								chunkType != "methods.body" && 
								chunkType != "references.body" ) {
							
							var ooo:Object = {"x1":xxx1, "y1":yyy1, "x2":xxx2, "y2":yyy2}; 
							fh.extraRectangles.addItem(ooo);
						}
						
					}
					
				}
				
				p++;
			
			}

			this.forceRedraw();				
		
		}
		
		private function htmlFileLoadResult(event:LoadHtmlResultEvent):void {
			
			var htmlString:String = model.pmcHtml;
			
			/*if( htmlString != null ) {
				view.lapdfTextControl.textFlow = TextConverter.importToFlow(
					htmlString, TextConverter.TEXT_FIELD_HTML_FORMAT);
			}*/
			
		}
		
		private function eventDrivenRedraw(event:Event):void {
			this.forceRedraw();
		}
		
		//
		// Force a redraw for the List control.
		// from: http://blog.9mmedia.com/?p=709
		//
		private function forceRedraw():void {
			var _itemRenderer:IFactory = this.view.pgList.itemRenderer;
			this.view.pgList.itemRenderer = null;
			this.view.pgList.itemRenderer = _itemRenderer;
		}
		
				
	}

}