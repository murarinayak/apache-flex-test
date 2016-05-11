package com.murari
{
	import com.murari.screens.M2NScreenHome;
	import com.murari.screens.M2NScreenTemplates;
	import com.murari.theme.M2NApplicationTheme;
	
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.events.FeathersEventType;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Main extends Sprite
	{
		private var _screenNavigator:ScreenNavigator;
		
		
		public function Main()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
		}
		
		private function _onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			
			_initializeApplication();
		}
		
		private function _initializeApplication():void
		{
			new M2NApplicationTheme();
			
			_screenNavigator = new ScreenNavigator();
			_screenNavigator.addEventListener(FeathersEventType.TRANSITION_COMPLETE, _onScreenTransitionComplete);
			addChild(_screenNavigator);
			
			_addScreens();
		}
		
		private function _onScreenTransitionComplete(event:Event):void
		{
			var __activeScreen:* = _screenNavigator.activeScreen;
			__activeScreen.initializeView();
		}
		
		private function _addScreens():void
		{
			///_screenNavigator.addScreen(M2NScreenHome.SCREEN_NAME, new ScreenNavigatorItem(M2NScreenHome));
			_screenNavigator.addScreen(M2NScreenTemplates.SCREEN_NAME, new ScreenNavigatorItem(M2NScreenTemplates));
			
			_showScreen(M2NScreenTemplates.SCREEN_NAME);
		}
		
		private function _showScreen(argScreenName:String):void
		{
			_screenNavigator.showScreen(argScreenName);
		}
	}
}