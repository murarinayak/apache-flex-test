package com.murari.screens
{
	import com.murari.interfaces.IM2NScreen;
	
	import feathers.controls.Button;
	import feathers.controls.Screen;
	
	import starling.events.Event;
	
	public class M2NScreenTemplates extends Screen implements IM2NScreen
	{
		public static const SCREEN_NAME:String = "templates-screen";
		
		private var _buttonProceed:Button;
		
		
		public function M2NScreenTemplates()
		{
			super();
		}
		
		public function initializeView():void
		{
			_createContainers();
			_loadData();
		}
		
		private function _createContainers():void
		{
			_buttonProceed = new Button();
			_buttonProceed.label = "PROCEED";
			_buttonProceed.addEventListener(Event.TRIGGERED, _onButtonTriggered);
			addChild(_buttonProceed);
		}
		
		private function _loadData():void
		{
			
		}
		
		private function _onButtonTriggered(event:Event):void
		{
			trace ("Button Triggered");
		}
	}
}