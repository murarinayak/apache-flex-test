package
{
	import com.murari.Main;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import starling.core.Starling;
	
	public class mCreativeCustomizer extends Sprite
	{
		private var _starling:Starling;
		
		public function mCreativeCustomizer()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
		}
		
		protected function _onAddedToStage(event:Event):void
		{
			trace ("Application has been added to stage");
			_starling = new Starling(Main, stage);
			_starling.start();
		}
	}
}