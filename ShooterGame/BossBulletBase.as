package ShooterGame 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author L.C
	 */
	public class BossBulletBase extends MovieClip
	{
		
		public const speed:Number = 10.0;
		public var dead:Boolean;
		
		public function BossBulletBase() 
		{
			
		}
		
		public function Update():void
		{
			this.x -= speed;
			
			if (this.x < 0 - this.width)
				dead = true;
		}
		
		
		
	}

}