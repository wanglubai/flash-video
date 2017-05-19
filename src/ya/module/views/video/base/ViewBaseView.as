package ya.module.views.video.base
{
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetStream;
	
	import ya.component.YaCacheSprite;
	import ya.component.YaSprite;
	import ya.component.events.EventName;
	import ya.component.events.ParamEvent;
	import ya.component.events.YaDispatcher;
	import ya.utils.YaUtils;
	
	public class ViewBaseView extends YaCacheSprite
	{
		protected var _skin:ViewBaseSkin;
		protected var _stream:NetStream;
		protected var _video:Video;
		protected var _videoContent:YaSprite;
		protected var _soundTransform:SoundTransform;
		
		public function get getPlayTime():int{
			if(_stream){
				return _stream.time;
			}else{
				return 0;
			}
		}
		
		public function ViewBaseView(url:String=null)
		{
			super(url);
		}
		
		override protected function resizeFresh():void{
			var percentage:Number=Math.min(_stage.stageWidth/_video.videoWidth,_stage.stageHeight/_video.videoHeight);
			_video.width=_video.videoWidth*percentage;
			_video.height=_video.videoHeight*percentage;
			YaUtils.setCenterByDisplayObject(_video);
			YaUtils.setCenterByDisplayObject(this);
		}
		
		public function register(skin:ViewBaseSkin):void{
			if(_skin!=null&&_skin==skin){
				_skin.destroy();
			}
			_skin=skin;
			_skin.register(this);
		}
		
		public function callPropertyFun(funName:String):void{
			if(this.hasOwnProperty("funName")){
				this[funName]();
			}
		}
		
		public function play():void{
			
		}
		public function seek():void{
			
		}
		public function pause():void{
			
		}
		public function stop():void{
			
		}
		public function volume(level:Number):void{
			streamVolume(level);
		}
		public function param(param:Object):void{
			_skin.pasvParam(param);
		}
		
		public function pasvPlay():void{
			_stream.resume();
			YaDispatcher.instance.dispatchEvent(new ParamEvent(EventName.Video_Play_State,true));
		}
		public function pasvSeek(val:Number):void{
			_stream.seek(val);
		}
		public function pasvPause():void{
			_stream.pause();
			YaDispatcher.instance.dispatchEvent(new ParamEvent(EventName.Video_Play_State,false));
		}
		public function pasvVolume(level:Number):void{
			streamVolume(level);
		}
		
		protected function streamVolume(level:Number):void{
			_soundTransform.volume = level;
			if (_stream) {
				_stream.soundTransform = _soundTransform;
			}
		}
		public function pasvStop():void{
		}
		
		public function pasvParam(param:Object):void{
		}
		
		override public function destroy():void
		{
			
		}
	}
}