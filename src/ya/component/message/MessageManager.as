package ya.component.message
{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import ya.utils.YaUtils;
	
	public class MessageManager extends EventDispatcher
	{
		private static var _instance:MessageManager;
		public static function get instance():MessageManager{
			if(_instance==null){
				_instance=new MessageManager();
			}
			return _instance;
		}
		
		public function MessageManager(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function push(item:MessageItem):void{
			_arr.indexOf(item)==-1?_arr.push(item):null;
		}
		
		public function show(str:String,x_:int,y_:int):void{
			getItem().setObj(str).start(x_,y_);
		}
		
		public function showSp(str:String,sp:DisplayObject):void{
			var item:MessageItem=getItem().setObj(str);
			YaUtils.setCenterX(item,sp);
			item.start(item.x+sp.x,sp.y-item.height);
		}
		
		public function getItem():MessageItem{
			if(_arr.length>0){
				return _arr.pop();
			}else{
				return new MessageItem();
			}
		}
		private var _arr:Array=[];
	}
}