package com.murari.screens
{
	import com.murari.interfaces.IM2NScreen;
	
	import feathers.controls.Button;
	import feathers.controls.Screen;
	
	import starling.events.Event;
	
	public class M2NScreenHome extends Screen implements IM2NScreen
	{
		public static const SCREEN_NAME:String = "home-screen";
		
		private var _buttonProceed:Button;
		
		
		public function M2NScreenHome()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
		}
		
		public function initializeView():void
		{
			_createContainers();
		}
		
		private function _createContainers():void
		{
			_buttonProceed = new Button();
			_buttonProceed.label = "PROCEED";
			_buttonProceed.addEventListener(Event.TRIGGERED, _onButtonTriggered);
			addChild(_buttonProceed);
		}
		
		private function _onButtonTriggered(event:Event):void
		{
			trace ("Button Triggered");
		}
		
		override protected function draw():void
		{
			super.draw();
			
			layoutChildren();
		}
		
		private function layoutChildren():void
		{
			if (_buttonProceed)
			{
				_buttonProceed.width = 1000;
				_buttonProceed.height = 400;
				_buttonProceed.x = this.width * 0.5;
			}
		}
	}
}