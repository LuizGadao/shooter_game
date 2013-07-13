package ShooterGame 
{
	import adobe.utils.CustomActions;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author L.C
	 */
	public class Level
	{
		//bg and squads
		private var squads:Array;
		private var bg1:MovieClip;
		private var bg2:MovieClip;
		
		private var boss:BossBase;
		
		//powerup members
		public var powerup:MovieClip;
		public var nextPowerup:int = 1;
		public var killedGhostsCount:int = 0;
		
		//level progression
		private var isBossUp:Boolean;
		private var waveTimeFloat:Number = 5000;
		private var squadTimer:Timer;
		private var waveTimer:Timer;
		private var squadTimerDone:Boolean = false;
		private var waveTimeDone:Boolean = false;
		private var waveCount:int = 0;
		private var squadId:int = 0;
		
		//level progression const
		private const waveTimeFloatDiff:Number = 1000;
		private const gameStartTime:Number = 3000;
		private const easySquadTime = 6000;
		private const hardSquadTime = 3000;
		
		//public static members
		public static const minX:int = 0;
		public static const maxX:int = 510;
		public static const minY:int = 10;
		public static const maxY:int = 400;
		
		public function Level():void
		{
			squads = new Array;
			bg1 = new BGImage();
			bg2 = new BGImage();
			bg2.x = bg2.width - 5;
			Game.stage.addChildAt(bg1, 0);
			Game.stage.addChildAt(bg2, 0);
			
			// boss
			boss = new Boss();
			boss.visible = false;
			boss.x = Game.stage.stageWidth - boss.width * 3 / 4;
			boss.y = Game.stage.stageHeight -  boss.height;
			Game.stage.addChild(boss);
			
			
			//progressionTimer
			waveTimer = new Timer(gameStartTime, 0);
			waveTimer.addEventListener(TimerEvent.TIMER, function(e:TimerEvent) {
				waveTimer.reset(); waveTimeDone = true;
			} );
			waveTimer.start();
			squadTimer = new Timer(easySquadTime, 0);
			squadTimer.addEventListener(TimerEvent.TIMER, function(e:TimerEvent) { 
				squadTimer.reset(); squadTimerDone = true;
			});
			
			//powerup
			powerup = new PowerUp();
			powerup.visible = false;
			Game.stage.addChild(powerup);
			
			//squads.push(new GhostSquadronPink());
			//squads.push(new GhostSquadronYellow());
			//squads.push(new GhostSquadromRed);
			//squads.push(new GhostSquadromBlue);
		}
		
		public function CkeckGhostCollision(obj:MovieClip):GhostBase
		{
			for each (var squad:GhostSquadron in squads)
			{
				var ghost:GhostBase = null;
				ghost = squad.CheckColision(obj);
				if (ghost != null)
					return ghost;					
			}			
			return null;
		}
		
		public function CheckBossBulletsCollision(obj:MovieClip):Boolean
		{
			for each (var bullet:BossBulletBase in boss.bullets)
			{
				if (bullet.hitTestObject(obj))
					return true;
			}
			
			return false;
		}
		
		public function CheckBossCompleteCollision(obj:MovieClip):Boolean
		{
			if ( !isBossUp || !(boss.visible) )
				return false;
				
			if (boss.hitTestObject(obj))
			{
				boss.life -= 1;
				return true;
			}
			
			return CheckBossBulletsCollision(obj);
		}
		
		public function GhostKilled(ghost:GhostBase):void
		{
			Game.game.points += Game.killEnemyPoints + Game.game.player.bonusMultiplayer;
			
			if ( !(powerup.visible) && 
				(Game.game.player.bonusMultiplayer < Game.game.player.maxBonusMultiplayer))
			{
				if (++killedGhostsCount >= nextPowerup)
				{					
					nextPowerup =  nextPowerup == 1?  2 : nextPowerup * nextPowerup;
					killedGhostsCount = 0;
					powerup.x = ghost.x + (GhostBase.Width * .5 - powerup.width);
					powerup.y = ghost.y + (GhostBase.Height * .5 - powerup.height);
					powerup.visible = true;
				}				
				
			}
		}
		
		public function Update():void
		{
			//level progression
			if ( ! isBossUp)
			{
				if (squadTimerDone)
				{
					squadTimerDone = false;
					CreateSquad();
					if (squadId == 4)
					{
						if (waveCount == 5)
						{
							isBossUp = true;
						}else
						{
							squadId = 0;
							waveTimer.delay = waveTimeFloat;
							waveTimeFloat -= waveTimeFloatDiff;
							waveTimer.start();
						}
					}
					else
					{
						squadTimer.delay = (waveCount < 3 ? easySquadTime : hardSquadTime);
						squadTimer.start();
					}
				}
				if (waveTimeDone)
				{
					waveTimeDone = false;
					waveCount++;
					squadTimer.delay = 100;					
					squadTimer.start();
					
					trace("incrementa level");
				}
			} else
			{				
				trace("squads", squads.length);
				if (squads.length == 10)
				{
					trace("INICIA CHEFE2");
					if ( !boss.starded)
					{
						boss.Start();
						trace("INICIA CHEFE1");
					}
					
					boss.Update();
				}
				
			}
			
			//update bg
			bg1.x -= 2;
			bg2.x -= 2;
			
			if (bg1.x < -(bg1.width-5))
				bg1.x = bg1.width - 5;
				
			if (bg2.x < -(bg2.width-5))
				bg2.x = bg2.width - 5;
				
			//update powerup
			if (powerup.visible)
			{
				powerup.x -= 2;
				
				if (powerup.x < 0 - powerup.width)
					powerup.visible = false;
			}
				
			//update squads
			for (var i:int = squads.length - 1; i > -1; i--)
			{
				var squad:GhostSquadron = squads[i];
				
				if (squad.dead)
					squads.splice(i, 1);
				else
					squad.Update();
			}
		}
		
		private function CreateSquad():void
		{
			var squad:GhostSquadron = null;
			
			switch(squadId)
			{
				case 0:
					squad = new GhostSquadronPink();
					break;
					
				case 1:
					squad = new GhostSquadromBlue();
					break;
					
				case 2:
					squad = new GhostSquadronYellow();
					break;
					
				case 3:
					squad = new GhostSquadromRed();
					break;
			}
			
			if (squad != null)
				squads.push(squad);
				
			squadId++;
		}
		
		
		
	}

}