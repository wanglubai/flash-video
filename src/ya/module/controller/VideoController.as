package ya.module.controller
{
	import flash.media.Video;
	
	import ya.component.events.EventName;
	import ya.component.events.ParamEvent;
	import ya.component.events.YaDispatcher;
	import ya.manages.ErrorManager;
	import ya.module.model.player.vo.VideoVo;
	import ya.module.views.video.VideoLiveView;
	
	public class VideoController extends BaseController
	{
		private static var _instance:VideoController;
		public static function get instance():VideoController{
			if(_instance==null){
				_instance=new VideoController();
			}
			return _instance;
		}
		
		public function VideoController()
		{
			ErrorManager.singleError(_instance);
		}
		
		override public function addEvent():void{
			YaDispatcher.instance.addEventListener(EventName.Video_Xml_Complete,Video_Xml_Complete_Fun);
		}
		
		private var _video:VideoLiveView;
		private function Video_Xml_Complete_Fun(e:ParamEvent):void{
			var vo:VideoVo=e.param as VideoVo;
			
			// 会根据类型 初始化不同类型的播放器
			if(vo.type==VideoVo.LIVE){
				if(_video==null){
					_video=new VideoLiveView();
				}
				_video.setVideoVo(vo);
				_video.initParant();
			}
		}
		
		public function test():void{
			if(_video==null){
				_video=new VideoLiveView();
			}
			var vo:VideoVo=new VideoVo();
			vo.linesAr[0]="http://lxdqncdn.miaopai.com/stream/xpRDVM0dDMqAf0WDt3Sz2Hb9xILphH1g_0_1494983817.mp4?ssig=9cc70c0d44e1efef1c034767814a5711&time_stamp=1495190004898"
			_video.setVideoVo(vo);
			_video.initParant();
		}
	}
}