package ya.component
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	import ya.interfaces.IDestroy;
	import ya.manages.LayerManager;
	import ya.manages.LogManager;
	
	public class YaSprite extends Sprite implements IDestroy
	{
		protected var _stage:Stage=null;
		protected var _registerStage:Boolean=false;
		public function YaSprite()
		{
		}
		
		protected function initStage():void{
			_stage=LayerManager.Layer_Stage;
		}
		
		protected function initView():void{
			
		}
		protected function addEvent():void{
			
		}
		protected function removeEvent():void{
			
		}
		
		protected function addStageEvent():void{
			_stage&&_stage.addEventListener(Event.RESIZE,updateResizeFun);
		}
		protected function removeStageEvent():void{
			_stage&&_registerStage&&_stage.removeEventListener(Event.RESIZE,updateResizeFun);
		}
		private function updateResizeFun(e:Event):void{
			resizeFresh();
			LogManager.log(_stage.stageWidth+"_"+_stage.stageHeight);
		}
		
		protected function updatePosition():void{
		}
		
		protected function resizeFresh():void{
			
		}
		
		public function destroy():void
		{
			_stage=null;
		}
		
		protected var _initiativeW:Number=0;
		protected var _initiativeH:Number=0;
		public function setInitiativeWH(w:Number=0,h:Number=0):void{
			this._initiativeW=w;
			this._initiativeH=h;
		}
		override public function get width():Number{
			if(_initiativeW==0){
				return super.width;
			}
			return _initiativeW;
		}
		override public function get height():Number{
			if(_initiativeH==0){
				return super.height;
			}
			return _initiativeH;
		}
	}
}