package ShooterGame 
{	
	import fl.motion.MotionEvent;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author L.C
	 */
	public class PlayerBase extends MovieClip
	{
		
		//constantes
		private const speed:uint 			= 6;
		private const timerShooting:Number 	= 300;
		
		//score
		public var bonusMultiplayer:uint 	= 1;
		public var maxBonusMultiplayer:uint = 5;
		
		//state
		public var state:uint 					= STATE_ALIVE;
		public static const STATE_ALIVE:uint 	= 0;
		public static const STATE_SPECIAL:uint 	= 1;
		public static const STATE_DEAD:uint 	= 2;
		
		private var bullets:Array;
		private var shootTimer:Timer
		private var blinkTimer:Timer;
		private var deadTimer:Timer;
		
		public function PlayerBase():void
		{
			bullets = new Array();
			
			shootTimer = new Timer(timerShooting);
			shootTimer.reset();
			shootTimer.addEventListener(TimerEvent.TIMER,
				function(e:TimerEvent):void { shootTimer.reset(); }
			);
			
			//blink timer setup
			blinkTimer = new Timer(200);
			blinkTimer.reset();
			blinkTimer.addEventListener(TimerEvent.TIMER,
				function(e:TimerEvent):void { visible = !visible; }
			);
			
			//dead timer setup
			deadTimer = new Timer(6000);
			deadTimer.reset();
			deadTimer.addEventListener(TimerEvent.TIMER,
				function(e:TimerEvent):void {
					trace("state dead");
					state = STATE_ALIVE;
					visible = true;
					blinkTimer.reset();
					deadTimer.reset();
				}
			);
		
		}
		
		public function Update():void
		{
			//dead special case
			if (state == STATE_DEAD)
			{				
				state = STATE_SPECIAL;
				blinkTimer.start();
				deadTimer.start();
				bonusMultiplayer = 1;
				Game.game.level.nextPowerup = 1;
				Game.game.level.killedGhostsCount = 0;
			}
			
			var mx:int;
			var my:int;
			
			if (Input.input.keyLeft)
				mx = -1;
			if (Input.input.keyRight)
				mx = 1;
			if (Input.input.keyUp)
				my = -1;
			if (Input.input.keyDown)
				my = 1;
				
			mx *= speed;
			my *= speed;			
			this.x += mx;
			this.y += my;
			
			if (this.x <= 0)
				this.x = 0;
			if (this.x >= Game.stage.stageWidth - this.width)
				this.x = Game.stage.stageWidth - this.width;
			if (this.y <= -10)
				this.y = -10;
			if (this.y >= Game.stage.stageHeight - this.height)
				this.y = Game.stage.stageHeight - this.height;
			
			//bullet base 	
			var bullet:BulletBase;			
			for (var i:int = bullets.length -1; i > -1; i--)
			{
				bullet = bullets[i];
				if (bullet.dead)
					Game.Remove(bullets, i, bullet);
				else
					bullet.Update();
			}
			
			if (state == STATE_ALIVE)
			{
				//player colision
				if (Game.game.level.CkeckGhostCollision(this) != null)
				{
					state 		 = STATE_DEAD;
					this.x 		 = 20;
					this.visible = false;
					trace(state);
				}	
				
				//powerup colision
				if (Game.game.level.powerup.visible &&
					Game.game.level.powerup.hitTestObject(this))
				{
					if (bonusMultiplayer < maxBonusMultiplayer)					
						++bonusMultiplayer;
						
					Game.game.level.powerup.visible = false;	
				}
				
				//smothing logic
				if (!shootTimer.running && Input.input.keyAlt)
				{				
					bullet = new Bullet();
					bullet.x = this.x + this.width;
					bullet.y = this.y + (this.height * .5) + 13;
					
					bullets.push(bullet);
					Game.stage.addChild(bullet);
					shootTimer.delay = timerShooting / bonusMultiplayer;
					shootTimer.start();
				}
			}
		}
	}

}