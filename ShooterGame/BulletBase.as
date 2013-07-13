package ShooterGame 
{
	import ShooterGame.*;
	
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author L.C
	 */
	public class BulletBase extends MovieClip
	{
		public var dead:Boolean;		
		
		public function BulletBase():void
		{
			
		}
		
		public function Update():void
		{
			//update position
			this.x += 20;			
			if (this.x > Game.stage.stageWidth)
				dead = false;
				
				
			//check colision
			var ghost:GhostBase = Game.game.level.CkeckGhostCollision(this);
			if (ghost != null)
			{
				dead = true;
				Game.game.level.GhostKilled(ghost);
			}
			
			//check boss colision
			if (Game.game.level.CheckBossCompleteCollision(this) )
				this.dead = true;
			
				
			
		}
		
		
	}

}