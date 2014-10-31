package {
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.materials.TextureMaterial;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Vector3D;

	import text3d.BitmapFont;
	import text3d.RectangleBitmapTexture;
	import text3d.TextField;

	[SWF(backgroundColor="#000000", frameRate="60", quality="LOW")]
	public class Main extends Sprite {
		[Embed(source="assets/font0.png")]
		private static const fontImageCl:Class;

		[Embed(source="assets/font0.fnt", mimeType="application/octet-stream")]
		private static const fontCl:Class;

		private var _view:View3D;

		private var _animate:ObjectContainer3D;
		private var _text:TextField;

		public function Main() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			_view = new View3D();
			addChild(_view);

			_view.camera.z = -300;
			_view.camera.lookAt(new Vector3D());

			new CameraController(_view.camera, stage);

			var fontMaterial:TextureMaterial = new TextureMaterial(new RectangleBitmapTexture((new fontImageCl() as Bitmap).bitmapData), true, false, false);
			fontMaterial.alphaBlending = true;
			fontMaterial.bothSides = true;

			var bitmapFont:BitmapFont = new BitmapFont(fontMaterial, XML(new fontCl()));

			_animate = new ObjectContainer3D();
			_view.scene.addChild(_animate);

			_text = new TextField(200, 50, "Away Starling BitmapFont!", bitmapFont);
			_animate.addChild(_text);
			_text.rotationX = 90;
			_text.rotationY = 180;

			addEventListener(Event.ENTER_FRAME, _onEnterFrame);
			stage.addEventListener(Event.RESIZE, onResize);
			onResize();
		}

		private function _onEnterFrame(e:Event):void {
			_animate.rotationY += 1;
			_view.render();
		}

		private function onResize(event:Event = null):void {
			_view.width = stage.stageWidth;
			_view.height = stage.stageHeight;
		}
	}
}


import away3d.cameras.Camera3D;

import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;

class CameraController extends Sprite {
	private var camera:Camera3D;
	private var appStage:Stage;
	private var dist:Number = 5;
	private var isShift:Boolean;

	public function CameraController(camera:Camera3D, appStage:Stage) {
		this.camera = camera;
		this.appStage = appStage;
		init();
	}

	private function init():void {
		appStage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		appStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		appStage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	private function onEnterFrame(event:Event):void {
		var distance:Number = dist;
		if (isShift) {
			distance *= 3;
		}

		if (forward) {
			camera.moveForward(distance);
		}
		if (back) {
			camera.moveBackward(distance);
		}
		if (left) {
			camera.moveLeft(distance);
		}
		if (right) {
			camera.moveRight(distance);
		}
	}

	private var forward:Boolean = false;
	private var back:Boolean = false;
	private var left:Boolean = false;
	private var right:Boolean = false;

	private function onKeyDown(event:KeyboardEvent):void {
		if (event.keyCode == Keyboard.W) {
			forward = true;
		}
		if (event.keyCode == Keyboard.S) {
			back = true;
		}
		if (event.keyCode == Keyboard.A) {
			left = true;
		}
		if (event.keyCode == Keyboard.D) {
			right = true;
		}
		if (event.keyCode == Keyboard.SHIFT) {
			isShift = true;
		}
	}

	private function onKeyUp(event:KeyboardEvent):void {
		if (event.keyCode == Keyboard.W) {
			forward = false;
		}

		if (event.keyCode == Keyboard.S) {
			back = false;
		}

		if (event.keyCode == Keyboard.A) {
			left = false;
		}

		if (event.keyCode == Keyboard.D) {
			right = false;
		}
		if (event.keyCode == Keyboard.SHIFT) {
			isShift = false;
		}
	}

	private var lastX:Number;
	private var lastY:Number;
	private var lastRX:Number;
	private var lastRY:Number;
	private var lastRZ:Number;

	private function onMouseDown(event:MouseEvent):void {
		lastX = appStage.mouseX;
		lastY = appStage.mouseY;
		lastRX = camera.rotationX;
		lastRY = camera.rotationY;
		lastRZ = camera.rotationZ;
		appStage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		appStage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}

	private function onMouseMove(event:MouseEvent):void {
		camera.rotationX = lastRX + (appStage.mouseY - lastY) / 5;
		camera.rotationY = lastRY + (appStage.mouseX - lastX) / 5;
	}

	private function onMouseUp(event:MouseEvent):void {
		appStage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		appStage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}
}