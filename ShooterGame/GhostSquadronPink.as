package ShooterGame 
{
	/**
	 * ...
	 * @author L.C
	 */
	public class GhostSquadronPink extends GhostSquadron
	{
		
		public function GhostSquadronPink() 
		{
			var startPosY:Number = Level.minX + Level.maxY * Math.random();
			
			for (var i:uint = 0; i < 6; i++)
			{
				var ghost:GhostPink = new GhostPink();
				ghost.x = Game.stage.stageWidth + (ghost.width + 20) * i;
				ghost.y = startPosY;
				
				ghosts.push(ghost);
				Game.stage.addChild(ghost);				
			}			
		}
		
		public override function Update():void
		{
			for each(var ghost:GhostBase in ghosts)			
				ghost.x -= GhostBase.speed;
			
			super.Update();
		}
		
		
	}

}