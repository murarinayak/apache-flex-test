package com.murari.service
{
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import feathers.controls.Alert;
	import feathers.data.ListCollection;
	
	import starling.events.EventDispatcher;

	public class M2NServiceManager
	{
		//private static const SERVICE_URL:String = "http://localhost:81/mcc/services/v1/";
		private static const SERVICE_URL:String = "http://172.22.1.217/carlsbergapp/Service.svc/";
		
		public static const SERVICE_TEMPLATE:String = GET_SERVICE_URL("get_all_templates");
		public static const SERVICE_THEME:String = "theme";
		
		private static function GET_SERVICE_URL(argServiceName:String):String { return SERVICE_URL + argServiceName; }
		
		/// ----------- CONVERTING THIS CLASS TO BE A STATIC EVENT DISPATCHER
		private static var _eventDispatcher:EventDispatcher;
		
		public static function addEventListener(argType:String, argListener:Function):void
		{
			if (_eventDispatcher == null)
				_eventDispatcher = new EventDispatcher();
			
			_eventDispatcher.addEventListener(argType, argListener);
		}
		
		public static function removeEventListener(argType:String, argListener:Function):void
		{
			if (_eventDispatcher == null)
				return;
			
			_eventDispatcher.removeEventListener(argType, argListener);
		}
		
		public static function dispatchEvent(event:starling.events.Event):void
		{
			if (_eventDispatcher == null)
				return;
			
			_eventDispatcher.dispatchEvent(event);
		}
		
		public static function dispatchEventWith(argType:String, argBubbles:Boolean = false, argData:Object = null):void
		{
			if (_eventDispatcher == null)
				return;
			
			_eventDispatcher.dispatchEventWith(argType, argBubbles, argData);
		}
		
		/** Handling the service calls.	*/
		private static var _servicePath:String;
		private static var _request:URLRequest;
		private static var _loader:URLLoader;
		
		public static function executeService(__servicePath:String, __object:Object = null):void
		{
			var __urlVariables:URLVariables = new URLVariables();
			__urlVariables.template_id = 1;//SERVICE_TEMPLATE;
			var __header:URLRequestHeader = new URLRequestHeader();
			__header.name = "authorization";
			__header.value = "dde9ae0028ffa09742613dc013a65154";
			
			_servicePath = __servicePath;
			_request = new URLRequest(__servicePath);
			_request.method = URLRequestMethod.POST;
			//_request.requestHeaders.push(__header);
			
			//_request.data = __urlVariables;
			_request.contentType = "application/json";
			
			//if (__object)			_request.data = JSON.stringify(__object);
			
			trace (_request.data);
			
			Alert.show("Process Start", "Connected", new ListCollection([{label: 'OK'}]));
			
			_loader = new URLLoader();
			_loader.addEventListener(IOErrorEvent.IO_ERROR, _ioErrorHandler);
			_loader.addEventListener(flash.events.Event.COMPLETE, _dataLoadedCompleteHandler);
			_loader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, _onStatus);
			//_loader.dataFormat = URLLoaderDataFormat.TEXT;
			_loader.load(_request);
			
			///_lastLoadedData = __servicePath;
		}
		
		protected static function _onStatus(event:HTTPStatusEvent):void
		{
			Alert.show("HTTP STATUS " + event.status, "Connected", new ListCollection([{label: 'OK'}]));
		}
		
		/**
		 * Data loaded from the Service.
		 * 
		 * @author Murari M
		 * @created 9th Dec'15
		 * @modified 9th Dec'15
		 */
		private static function _dataLoadedCompleteHandler(event:flash.events.Event):void
		{
			//M2NCommonFunctions.hideMessage();
			Alert.show(event.target.data.toString(), "Connected", new ListCollection([{label: 'OK'}]));
			var __jsonData:Object = JSON.parse(event.target.data);
			///trace (__jsonData);
			if (__jsonData.status == false)
			{
				//M2NActionsTracer.showErrorAlert(new M2NError("Data Fetching Error", _servicePath + ". \n" + __jsonData.message));
				return;
			}
			dispatchEventWith(starling.events.Event.COMPLETE, false, __jsonData);
		}
		
		private static function _ioErrorHandler(event:IOErrorEvent):void
		{
			//M2NCommonFunctions.hideMessage();
			
			switch(event.errorID)
			{
				case 2032:
					Alert.show(event.text + "\nCouldn't connect to server. Try again later.", "Connection Error", new ListCollection([{label: 'OK'}]));
					break;
				
				default:
					Alert.show(event.text + "\nThis error is something new. Please report to administrator with the error details.", "Error", new ListCollection([{label: 'OK'}]));
					break;
			}
			dispatchEventWith(starling.events.Event.IO_ERROR, false, event);
		}
	}
}