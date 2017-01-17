package specialEffects 
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.media.SoundTransform;
	import core.Config;
	
	/**
	 * ...
	 * @author Kristoffer Karlsson
	 * 
	 * This class manages sounds.
	 */
	public class SimpleSound extends Sound 
	{
		private var _soundChannel:SoundChannel;
		private var _pausPosition:Number = 0;
		private var _trans:SoundTransform;
		public var _isPlaying:Boolean = false;
		
		public function SimpleSound(stream:URLRequest=null, context:SoundLoaderContext=null) 
		{
			super(stream, context);
			
		}
		
		public function playMusic():void {
			//Plays the backgroundmusic.
			_soundChannel = super.play();
			setVolume(1);
			_isPlaying = true;
			_soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		
		public function onSoundComplete(e:Event):void {
			_soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			_soundChannel = super.play();
			_soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			
		}
		
		public function playSFX():void {
			//Plays special effects
			_soundChannel = super.play();
			setVolume(1);
		}
		
		public function pausMusic():void {
			//Pauses music
			_isPlaying = false;
			_pausPosition = _soundChannel.position;
			_soundChannel.stop();
			_soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		
		public function resumeMusic():void {
			//Resumes paused music
			_isPlaying = true;
			_soundChannel = super.play(_pausPosition);
			setVolume(1);
			_soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			
		}
		
		public function stopMusic():void {
			_soundChannel.stop();
			_isPlaying = false;
		}
		
		public function setVolume(volume:Number):void {
			_trans = new SoundTransform(volume, 0);
			_soundChannel.soundTransform = _trans;
		}
		
		public function destroyMusic():void {
			_soundChannel.stop()
			_soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			_soundChannel = null;
		}
	}

}