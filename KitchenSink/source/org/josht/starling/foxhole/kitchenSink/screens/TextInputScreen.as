package org.josht.starling.foxhole.kitchenSink.screens
{
	import org.josht.starling.foxhole.controls.Screen;
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.josht.starling.foxhole.controls.TextInput;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;

	public class TextInputScreen extends Screen
	{
		public function TextInputScreen()
		{
		}

		private var _header:ScreenHeader;
		private var _backButton:Button;
		private var _input:TextInput;

		private var _onBack:Signal = new Signal(TextInputScreen);

		public function get onBack():ISignal
		{
			return this._onBack;
		}

		override protected function initialize():void
		{
			this._input = new TextInput();
			this.addChild(this._input);

			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(backButton_onRelease);

			this._header = new ScreenHeader();
			this._header.title = "Text Input";
			this.addChild(this._header);
			this._header.leftItems = new <DisplayObject>
			[
				this._backButton
			];

			// handles the back hardware key on android
			this.backButtonHandler = this.onBackButton;
		}

		override protected function draw():void
		{
			const margin:Number = this.originalHeight * 0.04 * this.dpiScale;
			const spacingX:Number = this.originalHeight * 0.02 * this.dpiScale;
			const spacingY:Number = this.originalHeight * 0.02 * this.dpiScale;

			this._header.width = this.actualWidth;
			this._header.validate();

			this._input.validate();
			this._input.x = (this.actualWidth - this._input.width) / 2;
			this._input.y = (this.actualHeight - this._input.height) / 2;
		}

		private function onBackButton():void
		{
			this._onBack.dispatch(this);
		}

		private function backButton_onRelease(button:Button):void
		{
			this.onBackButton();
		}
	}
}
