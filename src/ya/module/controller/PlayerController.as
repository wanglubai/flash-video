package ya.module.controller
{
	import flash.events.EventDispatcher;
	
	import ya.component.events.EventName;
	import ya.component.events.ParamEvent;
	import ya.component.events.YaDispatcher;
	import ya.manages.ErrorManager;
	import ya.module.model.player.PlayerModel;
	
	public class PlayerController extends EventDispatcher
	{
		private static var _instance:PlayerController;
		public static function get instance():PlayerController{
			if(_instance==null){
				_instance=new PlayerController();
			}
			return _instance;
		}
		
		private var _model:PlayerModel;
		public function PlayerController()
		{
			ErrorManager.singleError(_instance);
			_model=PlayerModel.instance;
		}
		
		public function initWebParamVo(thisParam:Object):void{
			_model.initWebParamVo(thisParam);
		}
		
		/**
		 * 播放视频有关数据 
		 * 接受到数据 开始异步初始化 视频模块 和 弹幕模块
		 * @param xml_
		 * 
		 */		
		public function initVideoVoByXml(xml_:XML):void{
			_model.initVideoVoByXml(xml_);
			YaDispatcher.instance.dispatchEvent(new ParamEvent(EventName.Video_Xml_Complete,_model.videoVo));
		}
		/**
		 * 主要为了获取socket数据 
		 * @param xml_
		 * 
		 */		
		public function initServerVoByXml(xml_:XML):void{
			_model.initServerVoByXml(xml_);
			YaDispatcher.instance.dispatchEvent(new ParamEvent(EventName.Server_Xml_Complete,_model.serverVo));
		}
	}
}