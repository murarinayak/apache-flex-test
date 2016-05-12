package com.murari.screens
{
	import com.murari.interfaces.IM2NScreen;
	import com.murari.service.M2NServiceManager;
	
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
			M2NServiceManager.addEventListener(Event.COMPLETE, _onServiceExecutionComplete);
			M2NServiceManager.addEventListener(Event.IO_ERROR, _onError);
			M2NServiceManager.executeService(M2NServiceManager.SERVICE_TEMPLATE);//, new Object());
		}
		
		private function _onServiceExecutionComplete(event:Event = null):void
		{
			/// Remove the listener
			M2NServiceManager.removeEventListener(Event.COMPLETE, _onServiceExecutionComplete);
			M2NServiceManager.removeEventListener(Event.IO_ERROR, _onError);
			
			trace (event.data);
		}
		
		private function _onError(error:Event):void
		{
			/// Remove the listener
			M2NServiceManager.removeEventListener(Event.COMPLETE, _onServiceExecutionComplete);
			M2NServiceManager.removeEventListener(Event.IO_ERROR, _onError);
			
			//M2NActionsTracer.showErrorAlert(new M2NError("Failure", error.data.toString()));
			//M2NCommonFunctions.hideMessage();
			
			trace(error.data);
		}
		
		private function _onButtonTriggered(event:Event):void
		{
			trace ("Button Triggered");
			_loadData();
		}
	}
}