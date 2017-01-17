package core 
{

	import nape.geom.Vec2;
	import adobe.utils.CustomActions;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.*;
	import flash.net.*;
	public class Config 
	{
		
		public static const GRAVITY:Vec2 = new Vec2(0, 600);
		public static const WORLD_WIDTH:int = 900;
		public static const WORLD_HEIGHT:int = 500;
		public static const WORLD_CENTER_X:Number = WORLD_WIDTH * 0.5;
		public static const OBSTICLE_LIMIT:int = 150;
		public static var WORLD_SPEED:Number = -250;
		public static const WORLD_SPEED_INCREASE:Number= 0.03;
		public static const BACKGROUND_SPEED:int = -20;
		public static const MENU_SPEED:Number = -20;
		
		public static const PLAYER_X: Number = 450;
		public static const PLAYER_Y: Number = 240;
		
		public static const FONT_NAME:String = "flapper_font";
		public static const TEXT_COLOR:uint = 0xFFFF00
		public static const HEADER_TEXT_SIZE:int = 40;
		public static const INSTRUCTION_TEXT_SIZE:int = 22;
		public static const SCORE_TEXT_SIZE:int = 30;
		
		
		public static const BEST_SCORE_FILE:String = "best_score";
		
		
		public static var DO_DEBUG_DRAW:Boolean = false;
		
	}

}