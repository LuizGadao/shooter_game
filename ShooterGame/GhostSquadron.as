package ShooterGame 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author L.C
	 */
	public class GhostSquadron
	{
		protected var ghosts:Array;
		public var dead:Boolean = false;
		
		public function GhostSquadron() 
		{
			ghosts = new Array();
		}
		
		public function CheckColision(obj:MovieClip):GhostBase
		{
			for (var i:uint = 0; i < ghosts.length; i++)
			{
				var ghost:GhostBase = ghosts[i];
				
				if (ghost.hitTestObject(obj))
				{
					ghost.dead = true;
					return ghost;
				}
			}
			
			return null;
		}
		
		public function Update():void
		{
			for (var i:int = ghosts.length-1; i > -1; i--)
			{
				var ghost:GhostBase;
				ghost = ghosts[i];
				
				if (ghost.dead)
					Game.Remove(ghosts, i, ghost);
				else
					ghost.Update();
			}
			
			if (ghosts.length == 0)
				dead = true;
		}
		
	}

}