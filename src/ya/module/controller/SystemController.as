package ya.module.controller
{
	import flash.events.Event;
	
	import ya.component.events.EventName;
	import ya.component.events.ParamEvent;
	import ya.component.events.YaDispatcher;
	import ya.manages.ErrorManager;
	import ya.module.views.SettingView;
	import ya.module.views.system.Demo1Panel;

	public class SystemController extends BaseController
	{
		private static var _instance:SystemController;
		public static function get instance():SystemController{
			if(_instance==null){
				_instance=new SystemController();
			}
			return _instance;
		}
		public function SystemController(){
			ErrorManager.singleError(_instance);
		}
		
		override public function addEvent():void{
			YaDispatcher.instance.addEventListener(EventName.Open_Demo1,openDemo1Fun);
			
			YaDispatcher.instance.addEventListener(EventName.Open_Setting_View,openSettingFun);
		}
		
		private var _setting:SettingView;
		private function openSettingFun(e:ParamEvent):void{
			if(_setting==null){
				_setting=new SettingView();
			}
			_setting.open(e.param["x"],e.param['y']);
		}
		
		private var _demo1:Demo1Panel;
		private function openDemo1Fun(e:ParamEvent):void{
			if(_demo1==null){
				_demo1=new Demo1Panel();
			}
			_demo1.open();
		}
	}
}