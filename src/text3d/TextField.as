package text3d {
	import away3d.core.base.CompactSubGeometry;
	import away3d.core.base.Geometry;
	import away3d.entities.Mesh;

	import flash.display.DisplayObjectContainer;
	import flash.text.TextFieldAutoSize;

	public class TextField extends Mesh {
		private var vertexData:Vector.<Number> = new Vector.<Number>();
		private var indexData:Vector.<uint> = new Vector.<uint>();
		private var mText:String = "";
		private var mBitmapFont:BitmapFont;
		private var mFontSize:Number;
		private var mColor:uint;
		private var mHAlign:String;
		private var mVAlign:String;
		private var mBold:Boolean;
		private var mItalic:Boolean;
		private var mUnderline:Boolean;
		private var mAutoScale:Boolean;
		private var mAutoSize:String;
		private var mKerning:Boolean;
		private var mBorder:DisplayObjectContainer;
		private var mWidth:Number;
		private var mHeight:Number;

		private var _subGeometry:CompactSubGeometry;

		public function TextField(width:Number, height:Number, text:String, bitmapFont:BitmapFont, fontSize:Number = 12, color:uint = 0x0, bold:Boolean = false) {
			super(new Geometry(), bitmapFont.fontMaterial);

			mText = text;
			mBitmapFont = bitmapFont;

			mWidth = width;
			mHeight = height;
			mFontSize = fontSize;
			mColor = color;
			mHAlign = HAlign.CENTER;
			mVAlign = VAlign.CENTER;
			mBorder = null;
			mKerning = true;
			mBold = bold;
			mAutoSize = TextFieldAutoSize.NONE;
			_subGeometry = new CompactSubGeometry();
			_subGeometry.autoDeriveVertexNormals = true;
			_subGeometry.autoDeriveVertexTangents = true;
			geometry.addSubGeometry(_subGeometry);

			material = bitmapFont.fontMaterial;
			updateText();
		}

		private function updateText():void {
			mBitmapFont.fillBatched(vertexData, indexData, mWidth, mHeight, mText, mFontSize, mHAlign, mVAlign, mAutoScale, mKerning);

			_subGeometry.updateData(vertexData);
			_subGeometry.updateIndexData(indexData);
		}


		/** Indicates whether the text is bold. @default false */
		public function get bold():Boolean {
			return mBold;
		}

		public function set bold(value:Boolean):void {
			if (mBold != value) {
				mBold = value;
				updateText();
			}
		}

		/** Indicates whether the text is italicized. @default false */
		public function get italic():Boolean {
			return mItalic;
		}

		public function set italic(value:Boolean):void {
			if (mItalic != value) {
				mItalic = value;
				updateText();
			}
		}

		/** Indicates whether the text is underlined. @default false */
		public function get underline():Boolean {
			return mUnderline;
		}

		public function set underline(value:Boolean):void {
			if (mUnderline != value) {
				mUnderline = value;
				updateText();
			}
		}

		/** Indicates whether kerning is enabled. @default true */
		public function get kerning():Boolean {
			return mKerning;
		}

		public function set kerning(value:Boolean):void {
			if (mKerning != value) {
				mKerning = value;
				updateText();
			}
		}

		/** Indicates whether the font size is scaled down so that the complete text fits
		 *  into the text field. @default false */
		public function get autoScale():Boolean {
			return mAutoScale;
		}

		public function set autoScale(value:Boolean):void {
			if (mAutoScale != value) {
				mAutoScale = value;
				updateText();
			}
		}

		/** Specifies the type of auto-sizing the TextField will do.
		 *  Note that any auto-sizing will make auto-scaling useless. Furthermore, it has
		 *  implications on alignment: horizontally auto-sized text will always be left-,
		 *  vertically auto-sized text will always be top-aligned. @default "none" */
		public function get autoSize():String {
			return mAutoSize;
		}

		public function set autoSize(value:String):void {
			if (mAutoSize != value) {
				mAutoSize = value;
				updateText();
			}
		}
	}
}
