package core 
{
	import flash.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	public class Assets 
	{
		
		[Embed(source = "../../bin/assets/Chunkfive.otf",
			fontName = "ChunkFive",
			mimeType = "application/x-font",
			unicodeRange = "U+000a, U+0020-U+0023, U+0025-U+003f, U+0041-U+005a, U+005f-U+007a, U+007c, U+00a4, U+00a8, U+00b4, U+00bd, U+00c4-U+00c5, U+00d6, U+00e4-U+00e5, U+00f6", //Vilka bikstäver som ska vara med
			advancedAntiAliasing = "true",
			embedAsCFF="false")]
		public static var ChunkFiveClass:Class;
		
		[Embed(source = "../../bin/assets/atlas.png")]
		private static var Atlas:Class;
		public static var ta:TextureAtlas;
		
		[Embed(source = "../../bin/assets/atlas.xml", mimeType="application/octet-stream")]
		private static var AtlasXML:Class;
		
		[Embed(source = "../../bin/assets/Flapperfont/font.png")]
		private static var Font:Class;
		
		[Embed(source = "../../bin/assets/Flapperfont/font.fnt", mimeType = "application/octet-stream")]
		private static var FontXML:Class;
		
		
		public static function init():void {
			ta = new TextureAtlas(Texture.fromBitmap(new Atlas()), XML(new AtlasXML));
			var fontTexture:Texture = Texture.fromEmbeddedAsset(Font);
			var fontBitMap:BitmapFont = new BitmapFont(fontTexture, XML(new FontXML));
			TextField.registerCompositor(fontBitMap, "flapper_font");
			
		}
		
	}

}