package ShooterGame 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author L.C
	 */
	public class BossBase extends MovieClip
	{
		private const w:int = 259;
		private const h:int = 280;
		
		private var angle:Number = 0.0;
		private var shootTimer:Timer;
		public var life:int = 100;
		public var bullets:Array;
		public var starded:Boolean;
		
		public function BossBase() 
		{
			bullets = [];
			shootTimer = new Timer(1400.0);
			shootTimer.addEventListener(TimerEvent.TIMER, doShoot);
			shootTimer.reset();
		}
		
		public function Start():void
		{
			visible = true;
			starded = true;
			shootTimer.start();
		}
		
		public function Update():void
		{
			var i:int;
			var TwoPi:Number = Math.PI * 2;
			
			for (i = bullets.length -1; i > -1; --i)
			{
				var bullet:BossBulletBase = bullets[i];
				if (bullet.dead)
					Game.Remove(bullets, i, bullet);
				else
					bullet.Update();
			}
			
			if (life > 0)
			{
				angle += TwoPi / 256;
				if (angle >= TwoPi)
					angle -= TwoPi;
				var sin:Number = Math.sin(angle);
				this.y = ((Game.stage.stageHeight - this.height) / 2 - 25) +
							(Game.stage.stageHeight - this.height + 100) / 2 * sin;
			}
			
		}
		
		private function doShoot(e:TimerEvent):void
		{
			var bullet:BossBulletBase;
			
			for (var i:int = -1;  i < 2; i++)
			{
				bullet = new BossBulletBase();
				bullets.push(bullet);
				bullet.x = this.x + this.width / 2;
				bullet.y = this.y + this.height / 2 + (bullet.height + 20) * i;
				
				Game.stage.addChildAt(bullet, Game.stage.getChildIndex(this));
			}
			
		}
		
	}

}