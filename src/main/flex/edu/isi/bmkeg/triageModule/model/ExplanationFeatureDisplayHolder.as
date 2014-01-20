package edu.isi.bmkeg.triageModule.model
{
	import flash.display.Bitmap;
	
	import mx.collections.ArrayCollection;
	
	import spark.primitives.*;

	public class ExplanationFeatureDisplayHolder extends Object
	{

		[Bindable]
		public var image:Bitmap;

		[Bindable]
		public var alpha:Number = 1.0;

		[Bindable]
		public var state:int = 0;

		[Bindable]
		public var pdfScale:Number;

		[Bindable]
		public var page:int;

		[Bindable]
		public var extraRectangles:ArrayCollection = new ArrayCollection();
				
		public function ExplanationFeatureDisplayHolder(pdfScale:Number)
		{
			super();
			this.pdfScale = pdfScale;
		}
		
	}
	
}