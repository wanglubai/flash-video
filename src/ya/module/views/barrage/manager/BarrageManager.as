package ya.module.views.barrage.manager
{
	import ya.component.events.EventName;
	import ya.component.events.ParamEvent;
	import ya.component.events.YaDispatcher;
	import ya.manages.ConfigManager;
	import ya.manages.LayerManager;
	import ya.module.views.barrage.BarrageBaseItem;
	
	public class BarrageManager
	{
		private static var _instance:BarrageManager;
		public static function get instance():BarrageManager{
			if(_instance==null){
				_instance=new BarrageManager();
			}
			return _instance;
		}
		
		public function BarrageManager():void{
			YaDispatcher.instance.addEventListener(EventName.Barrage_Setting,eventFun);
		}
		private var _barrageStatus:String="0";
		private function eventFun(e:ParamEvent):void{
			_barrageStatus=e.param.toString();
		}
		private function setBarageStatus():void{
			if(_barrageStatus=="0"){
				_startIndex=0;
				_len=int(LayerManager.Layer_Stage.stageHeight/38);
			}else if(_barrageStatus=="1"){
				_len=int(LayerManager.Layer_Stage.stageHeight/38);
				_startIndex=_len-5;
			}else if(_barrageStatus=="2"){
				_startIndex=0;
				_len=5;
			}
		}
		
		private var _rightToArr:Array=[];
		private var _startIndex:int=0;
		private var _len:int=20;
		private var _h:int=24;
		private var _gapW:int=30;
		private var _gapH:int=12;
		public function addRight(item:BarrageBaseItem):Boolean{
			var itemTemp:BarrageBaseItem;
			var index:int;
			
			var tempIndexArr:Array=[];
			setBarageStatus();
			//_len=int(LayerManager.Layer_Stage.stageHeight/38);
			for(index=_startIndex;index<_len;index++){
				if(_rightToArr[index]==null){
					_rightToArr[index]=item;
					this.setY(item,index);
					return true;
				}else{
					itemTemp=_rightToArr[index];
					var timeTemp:Number=(itemTemp.width+itemTemp.x+_gapW)/itemTemp.vo.speed;
					var timeThis:Number=(item.x)/item.vo.speed;
					if(timeThis>timeTemp){
						if((itemTemp.width+itemTemp.x)>ConfigManager.W_video){
							tempIndexArr.push(index);
						}else{
							_rightToArr[index]=item;
							this.setY(item,index);
							return true;
						}
					}
				}
			}
			if(tempIndexArr.length>0){
				index=tempIndexArr[int(Math.random()*tempIndexArr.length)];
				_rightToArr[index]=item;
				this.setY(item,index);
				return true;
			}
			return false;
			var val:Number=9999999;
			var indexVal:int=0;
			for(index=0;index<_len;index++){
				itemTemp=_rightToArr[index];
				timeTemp=(itemTemp.width+itemTemp.x+_gapW)/itemTemp.vo.speed;
				if(val>timeTemp){
					val=timeTemp;
					indexVal=index;
				}
			}
			_rightToArr[indexVal]=item;
			this.setY(item,indexVal);
			return true;
		}
		public function removeRight(item:BarrageBaseItem):void{
			var index:int=_rightToArr.indexOf(item);
			if(index!=-1){
				_rightToArr[index]=null;
			}
		}
		public function setY(barrage:BarrageBaseItem,index:int):void{
			barrage.setY((_h+_gapH)*index);
		}
	}
}