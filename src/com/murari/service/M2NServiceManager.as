package com.murari.service
{
	public class M2NServiceManager
	{
		private static const SERVICE_URL:String = "http://localhost:81/mcc/services/v1/";
		
		public static const SERVICE_TEMPLATE:String = "template";
		public static const SERVICE_THEME:String = "theme";
		
		private static function GET_SERVICE_URL(argServiceName:String):String { return SERVICE_URL + argServiceName; } 
	}
}