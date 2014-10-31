Starling BitmapFont port to Away3D
==========================
All characters are batched in one drawcall. You can use any material and effects for the font rendering.

Usage Example:
```ActionScript
var fontMaterial:TextureMaterial = new TextureMaterial(new RectangleBitmapTexture((new fontImageCl() as Bitmap).bitmapData), true, false, false);
fontMaterial.alphaBlending = true;
var bitmapFont:BitmapFont = new BitmapFont(fontMaterial, XML(new fontCl()));
var text:TextField = new TextField(200, 50, "Away Starling BitmapFont!", bitmapFont);
scene.addChild(text);
```