package ya.component
{
	import flash.events.EventDispatcher;
	
	import ya.interfaces.IDestroy;
	import ya.interfaces.ISelecte;

	public class YaGroup extends EventDispatcher implements IDestroy
	{
		private var _arr:Array=[];
		private var _cur:ISelecte;
		private var _changeCall:Function;
		public function set changeCall(fun:Function):void{
			_changeCall=fun;
		}
		
		public function add(...args):void{
			var iSelecte:ISelecte;
			for each(iSelecte in args){
				if(_arr.indexOf(iSelecte)==-1){
					_arr.push(iSelecte);
					iSelecte.register(this);
				}
			}
		}
		
		public function remove(...args):void{
			var index:int=-1;
			for each(var iSelecte:ISelecte in args){
				index=_arr.indexOf(iSelecte);
				if(index!=-1){
					_arr.splice(index,1);
					if(_cur==iSelecte){
						_cur=null;
					}
				}
			}
		}
		
		public function setSelectedByIndex(index:int):void{
			_arr[index]&&setSelected(_arr[index]);
		}
		
		public function setSelected(iSelecte:ISelecte):void{
			if(_cur){
				if(_cur==iSelecte){
					return;
				}else{
					_cur.setSelectedState(0);
				}
			}
			_cur=iSelecte;
			_cur.setSelectedState(1);
			
			if(_changeCall!=null){
				_changeCall();
			}
		}
		
		public function getSelected():ISelecte{
			return _cur;
		}
		
		public function destroy():void{
			var iSelecte:ISelecte;
			while(_arr.length>0){
				iSelecte=_arr.pop();
				iSelecte.destroy();
			}
			_arr=null;
			_changeCall=null;
		}
	}
}