// =================================================================================================
//
//	Starling Framework
//	Copyright 2011-2014 Gamua. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package text3d
{
	import flash.utils.Dictionary;
    

    /** A BitmapChar contains the information about one char of a bitmap font.  
     *  <em>You don't have to use this class directly in most cases. 
     *  The TextField class contains methods that handle bitmap fonts for you.</em>    
     */ 
    public class BitmapChar
    {
        private var mCharID:int;
        private var mXOffset:Number;
        private var mYOffset:Number;
        private var mXAdvance:Number;
        private var mKernings:Dictionary;

		private var mX:Number;
		private var mY:Number;
		private var mWidth:Number;
		private var mHeight:Number;

        /** Creates a char with a texture and its properties. */
        public function BitmapChar(id:int, x:Number, y:Number, width:Number, height:Number,
                                   xOffset:Number, yOffset:Number, xAdvance:Number)
        {
            mCharID = id;
            mXOffset = xOffset;
            mYOffset = yOffset;
            mXAdvance = xAdvance;
            mKernings = null;
			mX = x;
			mY = y;
			mWidth = width;
			mHeight = height;
        }
        
        /** Adds kerning information relative to a specific other character ID. */
        public function addKerning(charID:int, amount:Number):void
        {
            if (mKernings == null)
                mKernings = new Dictionary();
            
            mKernings[charID] = amount;
        }
        
        /** Retrieve kerning information relative to the given character ID. */
        public function getKerning(charID:int):Number
        {
            if (mKernings == null || mKernings[charID] == undefined) return 0.0;
            else return mKernings[charID];
        }

        
        /** The unicode ID of the char. */
        public function get charID():int { return mCharID; }
        
        /** The number of points to move the char in x direction on character arrangement. */
        public function get xOffset():Number { return mXOffset; }
        
        /** The number of points to move the char in y direction on character arrangement. */
        public function get yOffset():Number { return mYOffset; }
        
        /** The number of points the cursor has to be moved to the right for the next char. */
        public function get xAdvance():Number { return mXAdvance; }
        
        /** The width of the character in points. */
        public function get width():Number { return mWidth; }
        
        /** The height of the character in points. */
        public function get height():Number { return mHeight; }

		public function get x():Number { return mX; }

        public function get y():Number { return mY; }
    }
}