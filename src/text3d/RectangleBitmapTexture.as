package text3d {
	import away3d.textures.Texture2DBase;

	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.textures.RectangleTexture;
	import flash.display3D.textures.TextureBase;

	public class RectangleBitmapTexture extends Texture2DBase {
		private var _bitmapData:BitmapData;

		public function RectangleBitmapTexture(bitmapData:BitmapData) {
			this.bitmapData = bitmapData;
		}

		public function get bitmapData():BitmapData {
			return _bitmapData;
		}

		public function set bitmapData(value:BitmapData):void {
			if (value == _bitmapData)
				return;

			invalidateContent();
			setSize(value.width, value.height);

			_bitmapData = value;

		}

		override protected function uploadContent(texture:TextureBase):void {
			RectangleTexture(texture).uploadFromBitmapData(_bitmapData);
		}

		override protected function createTexture(context:Context3D):TextureBase {
			return context.createRectangleTexture(_width, _height, Context3DTextureFormat.BGRA_PACKED, false);
		}
	}
}
