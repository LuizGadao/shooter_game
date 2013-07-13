package ShooterGame 
{
	/**
	 * ...
	 * @author L.C
	 */
	public class GhostSquadronYellow extends GhostSquadron
	{
		
		public function GhostSquadronYellow() 
		{
			var startPositionY:Number = Level.minX + Level.maxX * Math.random();
			
			for (var i:uint = 0; i < 6; i++)
			{				
				var ghost:GhostBase = new GhostYellow();
				ghost.x = Game.stage.stageWidth + (ghost.width + 20) * i;
				ghost.y = startPositionY / GhostBase.Height * i / 2;
				
				ghosts.push(ghost);
				Game.stage.addChild(ghost);
			}
		}
		
		public override function Update():void
		{
			var x:Number = -.7 * GhostBase.speed;
			var y:Number = -.3 * GhostBase.speed;
			
			for each (var ghost:GhostBase in ghosts)
			{
				ghost.x += x;
				ghost.y += y;
			}
			
			super.Update();
		}
		
	}

}