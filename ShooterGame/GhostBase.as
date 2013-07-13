package ShooterGame 
{
	import flash.display.MovieClip;
	
	import ShooterGame.*;
	
	/**
	 * ...
	 * @author L.C
	 */
	public class GhostBase extends MovieClip
	{
		public static const Width:uint 	= 31;
		public static const Height:uint = 39;
		public static const speed:uint 	= 8;
		public var dead:Boolean			= false;
		
		public function GhostBase() 
		{
			
		}
		
		public function Update():void
		{
			if (this.x < -(this.width))
				this.x = Game.stage.stageWidth;
			if (this.y < -(this.height))
				this.y = Game.stage.stageHeight;
			if (this.y > Game.stage.stageHeight)
				this.y = 0;
		}
		
		
	}

}