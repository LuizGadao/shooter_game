package ShooterGame 
{
	/**
	 * ...
	 * @author L.C
	 */
	public class GhostSquadromBlue extends GhostSquadron
	{
		
		private var angles:Array;
		private var circles:Array;
		private var reseted:Array;
		
		private var startPosX:Number;
		private var seed:Number;
		private var centerPosX:Number;
		private var centerPosY:Number;
		
		public function GhostSquadromBlue() 
		{
			angles = new Array();
			circles = new Array();
			reseted = new Array();
			
			seed = 1 + Math.random() * 5;
			startPosX = (Game.stage.stageWidth / 2) + (GhostBase.Width * seed);
			
			centerPosX = startPosX - (GhostBase.Width * (7 - seed));
			centerPosY = (Game.stage.stageHeight / 2) - (GhostBase.Width / 2);
			
			for (var i:int = 0; i < 6; ++i)
			{
				var ghost:GhostBlue = new GhostBlue();
				ghost.x = startPosX;
				ghost.y = 0 - (GhostBase.Height + 30) * (i + 1);
				
				ghosts.push(ghost);
				Game.stage.addChild(ghost);
				
				angles.push(0.0);
				circles.push(false);
				reseted.push(false);
			}
		}
		
		override public function Update():void
		{
			var ghost:GhostBase = null;
			var i:int;
			var TwoPi:Number = Math.PI * 2;
			
			for (i = 0; i < ghosts.length; ++i)
			{
				ghost = ghosts[i];
				if (circles[i])
				{
					angles[i] += TwoPi / 140;
					if (angles[i] > TwoPi)
					{
						angles[i] = 0.0;
						circles[i] = false;
						ghost.x = startPosX;
					}
					else
					{
						var radiu:Number = GhostBase.Width * (7 - seed);
						var posX:Number = (Math.cos(angles[i]) * radiu);
						var posY:Number = (Math.sin(angles[i]) * radiu);
						
						ghost.x = posX + centerPosX;
						ghost.y = posY + centerPosY;						
					}
				}
				else
				{
					ghost.y += GhostBase.speed;
					if (reseted[i] && ghost.y >= centerPosY)
					{
						reseted[i] = false;
						circles[i] = true;
					}
					else
					{
						if (ghost.y >= Game.stage.stageHeight)
						{
							ghost.y = 0 - GhostBase.Height;
							reseted[i] = true;
						}
					}
				}
			}
			
			for ( i = ghosts.length  - 1; i > -1; --i)
			{
				ghost = ghosts[i];
				
				if (ghost.dead)
				{
					Game.Remove(ghosts, i, ghost);
					angles.splice(i, 1);
					circles.splice(i, 1);
					reseted.splice(i, 1);
				}
			}
		}
		
	}

}