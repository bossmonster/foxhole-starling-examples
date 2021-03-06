package org.josht.starling.foxhole.kitchenSink.screens
{
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.ProgressBar;
	import org.josht.starling.foxhole.controls.Screen;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.josht.starling.motion.GTween;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;

	public class ProgressBarScreen extends Screen
	{
		public function ProgressBarScreen()
		{
		}

		private var _header:ScreenHeader;
		private var _backButton:Button;
		private var _progress:ProgressBar;

		private var _progressTween:GTween;

		private var _onBack:Signal = new Signal(ProgressBarScreen);

		public function get onBack():ISignal
		{
			return this._onBack;
		}

		override protected function initialize():void
		{
			this._progress = new ProgressBar();
			this._progress.minimum = 0;
			this._progress.maximum = 1;
			this._progress.value = 0;
			this.addChild(this._progress);

			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(backButton_onRelease);

			this._header = new ScreenHeader();
			this._header.title = "Progress Bar";
			this.addChild(this._header);
			this._header.leftItems = new <DisplayObject>
			[
				this._backButton
			];

			// handles the back hardware key on android
			this.backButtonHandler = this.onBackButton;

			this._progressTween = new GTween(this._progress, 5,
			{
				value: 1
			},
			{
				repeatCount: int.MAX_VALUE
			});
		}

		override protected function draw():void
		{
			const margin:Number = this.originalHeight * 0.04 * this.dpiScale;
			const spacingX:Number = this.originalHeight * 0.02 * this.dpiScale;
			const spacingY:Number = this.originalHeight * 0.02 * this.dpiScale;

			this._header.width = this.actualWidth;
			this._header.validate();

			this._progress.validate();
			this._progress.x = (this.actualWidth - this._progress.width) / 2;
			this._progress.y = (this.actualHeight - this._progress.height) / 2;
		}

		private function onBackButton():void
		{
			this._progressTween.paused = true;
			this._progressTween = null;
			this._onBack.dispatch(this);
		}

		private function backButton_onRelease(button:Button):void
		{
			this.onBackButton();
		}
	}
}
