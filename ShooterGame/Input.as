package ShooterGame 
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author L.C
	 */
	public class Input
	{
		public static var input:Input = null;
		
		public static function createInstance():void
		{
			input = new Input();
		}
		
		public var keyLeft:Boolean 	= false;
		public var keyRight:Boolean = false;
		public var keyUp:Boolean 	= false;
		public var keyDown:Boolean 	= false;
		public var keyAlt:Boolean 	= false;		
		
		public function Input() 
		{
			Game.stage.addEventListener(KeyboardEvent.KEY_UP, 	onKeyUp);
			Game.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case 37:
						keyLeft = false;
						break;						
				case 38:
						keyUp = false;
						break;						
				case 39:
						keyRight = false;
						break;				
				case 40:
						keyDown = false;
						break;						
				case 32:
						keyAlt = false;
						break;
			}
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case 37:
						keyLeft = true;
						break;						
				case 38:
						keyUp = true;
						break;						
				case 39:
						keyRight = true;
						break;				
				case 40:
						keyDown = true;
						break;						
				case 32:
						keyAlt = true;
						break;
			}
		}
		
	}

}