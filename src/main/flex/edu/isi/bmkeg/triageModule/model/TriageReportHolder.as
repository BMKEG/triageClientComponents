package edu.isi.bmkeg.triageModule.model
{
	import flash.display.Bitmap;
	
	import mx.collections.ArrayCollection;
	
	import spark.primitives.*;

	public class TriageReportHolder extends Object
	{

		[Bindable]
		public var image:Bitmap;

		[Bindable]
		public var pdfScale:Number;

		[Bindable]
		public var runningCount:int;
		
		[Bindable]
		public var page:int;

		[Bindable]
		public var extraRectangles:ArrayCollection = new ArrayCollection();
		
		[Bindable]
		public var fragmentInProgress:Path;
		
		[Bindable]
		public var fragmentsAdded:ArrayCollection = new ArrayCollection();
		
		public function TriageReportHolder(pdfScale:Number)
		{
			super();
			this.pdfScale = pdfScale;
		}
		
	}
	
}