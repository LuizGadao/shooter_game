package ShooterGame 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author L.C
	 */
	public class Game
	{
		public static var stage:Stage 	= null;
		public static var game:Game		= null;
		
		public static function createInstances(e:Stage):void
		{
			stage 	= e;
			game 	= new Game();
		}
		
		public var player:PlayerBase;
		public var level:Level;
		public var points:int;
		//
		
		public var txtPoints:TextField;
		public static const killEnemyPoints:int = 50;
		public static const diePoints:int = 150;
		
		public function Game() 
		{
			stage.addEventListener(Event.ENTER_FRAME, Update);
			
			Input.createInstance();
			
			level = new Level();
			player = new Player();			
			
			stage.addChild(player);
			
			//create txt
			var font1:Font = new Font1();
			var format:TextFormat = new TextFormat(font1.fontName, 18, 0xffffff);
			txtPoints = new TextField();
			txtPoints.x = 520;
			txtPoints.y = 10;
			txtPoints.defaultTextFormat = format;
			stage.addChild(txtPoints);
			
		}
		
		public function Update(e:Event):void
		{
			level.Update();
			player.Update();		
			
			if (points < 0)
				points = 0;
			
			txtPoints.text = points.toString();
		}
		
		public static function Remove(a:Array, i:int, obj:*):void
		{
			a.splice(i, 1);
			stage.removeChild(obj);	
		}
		
		public function getSixDigital():String
		{
			var s:String = points.toString();
			
			while ( s.length < 6)
				s = 0 + s;
				
			return s;
		}
		
	}

}