package ya.component.tips
{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	public class YaTipsManager extends EventDispatcher
	{
		private var _targetDic:Dictionary=new Dictionary();
		
		private static var _instnace:YaTipsManager;
		public static function get instance():YaTipsManager{
			if(_instnace==null){
				_instnace=new YaTipsManager();
			}
			return _instnace;
		}
		
		public function YaTipsManager(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function register(target:DisplayObject,panel:YaBaseTips):void{
			if(_targetDic[target]){
				if(_targetDic[target]==panel){
					return;
				}else{
					var targetPanel:YaBaseTips=_targetDic[target];
					targetPanel.destroy();
				}
			}
			_targetDic[target]=panel;
			addEvent(target);
		}
		
		public function destroy(target:DisplayObject):void{
			if(_targetDic[target]){
				YaBaseTips(_targetDic[target]).destroy();
				_targetDic[target]=null;
				delete _targetDic[target];
			}
		}
		
		private function addEvent(target:DisplayObject):void{
			target.addEventListener(MouseEvent.MOUSE_OVER,eventFun);
			target.addEventListener(MouseEvent.MOUSE_OUT,eventFun);
			target.addEventListener(MouseEvent.MOUSE_MOVE,eventFun);
		}
		
		private function removeEvent(target:DisplayObject):void{
			target.removeEventListener(MouseEvent.MOUSE_OVER,eventFun);
			target.removeEventListener(MouseEvent.MOUSE_OUT,eventFun);
			target.removeEventListener(MouseEvent.MOUSE_MOVE,eventFun);
		}
		
		private function eventFun(e:MouseEvent):void{
			var target:DisplayObject=e.currentTarget as DisplayObject;
			var panel:YaBaseTips=_targetDic[target];
			if(e.type==MouseEvent.MOUSE_OVER){
				panel.show();
				panel.setPosition(target.stage.mouseX,target.stage.mouseY-panel.height-10);
			}else if(e.type==MouseEvent.MOUSE_OUT){
				panel.hide();
			}else if(e.type==MouseEvent.MOUSE_MOVE){
				panel.setPosition(target.stage.mouseX,target.stage.mouseY-panel.height-10);
			}
		}
		
		public function getPangelByTarget(target:DisplayObject):YaBaseTips{
			return _targetDic[target];
		}
	}
}