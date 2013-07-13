package ShooterGame 
{
	/**
	 * ...
	 * @author L.C
	 */
	public class GhostSquadromRed extends GhostSquadron
	{
		private var startPosY:int = 0;
		private var  wobble:int = GhostBase.Height * 2;
		private var angles:Array;
		
		public function GhostSquadromRed():void
		{
			var PiOver4:Number = Math.PI / 4;
			angles = new Array();
			
			startPosY = Level.minY + ((Level.maxY - GhostBase.Height) * Math.random());
			for (var i:uint = 0; i < 6; ++i)
			{
				var ghost:GhostRed = new GhostRed();
				ghost.x = Game.stage.stageWidth + (ghost.width + 20) * i;
				ghost.y = startPosY;
				
				angles.push( -PiOver4 * i);
				ghosts.push(ghost);
				Game.stage.addChild(ghost);
			}
		}
		
		override public function Update():void
		{
			var TwoPi:Number = Math.PI * 2;
			var ghost:GhostBase;			
			
			for ( var i:int = 0; i < ghosts.length; ++i)
			{
				ghost = ghosts[i];
				
				angles[i] += TwoPi / 96;
				if (angles[i] > TwoPi)
					angles[i] -= TwoPi;
					
				ghost.x -= GhostBase.speed / 2;
				ghost.y = startPosY + (Math.sin(angles[i]) * wobble);
			}
			
			for ( i = ghosts.length -1; i > -1; --i)
			{
				ghost = ghosts[i];				
				if (ghost.dead)
				{
					Game.Remove(ghosts, i, ghost);
					angles.splice(i, 1);					
				}
				else
					ghost.Update();
			}
			
			//super.Update
			
		}
		
	}

}