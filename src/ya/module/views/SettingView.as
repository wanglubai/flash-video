package ya.module.views
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	import ya.component.YaCacheSprite;
	import ya.component.YaResName;
	import ya.component.YaScrollBar;
	import ya.component.events.EventName;
	import ya.component.events.ParamEvent;
	import ya.component.events.YaDispatcher;
	import ya.component.tips.YaTipsManager;
	import ya.component.tips.YaTxtTips;
	import ya.manages.LayerManager;
	import ya.manages.ResManager;
	import ya.manages.UrlManager;
	import ya.utils.YaUtils;
	
	public class SettingView extends YaCacheSprite
	{
		public function SettingView(url:String=null)
		{
			initStage();
			super(UrlManager.instance.getResUrl(YaResName.BulletRes));
		}
		
		private var _btn1:MovieClip;
		private var _btn2:MovieClip;
		private var _btn3:MovieClip;
		private var _yaScrollBar:YaScrollBar;
		private var _alhpaTxt:YaTxtTips;
		override protected function initView():void{
			this.graphics.beginFill(0x000000);
			this.graphics.drawRect(0,0,200,200);
			this.graphics.endFill();
			
			_btn1=ResManager.instance.getInstanceObj("Bullet_Full_Res",YaResName.BulletRes);
			_btn1.x=20;
			_btn1.buttonMode=true;
			this.addChild(_btn1);
			_btn1.filters=[new GlowFilter(0xff0000,1,2,2,10)];
			YaTipsManager.instance.register(_btn1,new YaTxtTips("全屏弹幕"));
			
			_btn2=ResManager.instance.getInstanceObj("Bullet_Down_Res",YaResName.BulletRes);
			_btn2.x=_btn1.x+60;
			_btn2.buttonMode=true;
			this.addChild(_btn2);
			YaTipsManager.instance.register(_btn2,new YaTxtTips("底端弹幕"));
			
			_btn3=ResManager.instance.getInstanceObj("Bullet_Top_Res",YaResName.BulletRes);
			_btn3.x=_btn2.x+60;
			_btn3.buttonMode=true;
			this.addChild(_btn3);
			YaTipsManager.instance.register(_btn3,new YaTxtTips("顶端弹幕"));
			
			_yaScrollBar=new YaScrollBar(YaScrollBar.Type_Horizontal);
			_yaScrollBar.setSkin(YaUtils.getSprite(10,10,0xffffff),YaUtils.getSprite(110,10),100);
			_yaScrollBar.setVal(1);
			this.addChild(_yaScrollBar);
			
			_alhpaTxt=new YaTxtTips();
			_alhpaTxt.setObj(_yaScrollBar.getVal());
			YaTipsManager.instance.register(_yaScrollBar.barBtn,_alhpaTxt);
			
			addEvent();
			updatePosition();
		}
		
		override protected function addEvent():void{
			_btn1.addEventListener(MouseEvent.MOUSE_DOWN,eventFun);
			_btn2.addEventListener(MouseEvent.MOUSE_DOWN,eventFun);
			_btn3.addEventListener(MouseEvent.MOUSE_DOWN,eventFun);
			this.addEventListener(MouseEvent.MOUSE_OVER,eventFun);
			this.addEventListener(MouseEvent.ROLL_OUT,eventFun);
			_yaScrollBar.addEventListener(EventName.YaScrollBar_Val,eventFun);
		}
		
		private function eventFun(e:Event):void{
			if(e.currentTarget==_btn1){
				YaDispatcher.instance.dispatchEvent(new ParamEvent(EventName.Barrage_Setting,"0"));
				_btn1.filters=[new GlowFilter(0xff0000,1,2,2,10)];_btn2.filters=[];_btn3.filters=[];
			}else if(e.currentTarget==_btn2){
				YaDispatcher.instance.dispatchEvent(new ParamEvent(EventName.Barrage_Setting,"1"));
				_btn2.filters=[new GlowFilter(0xff0000,1,2,2,10)];_btn1.filters=[];_btn3.filters=[];
			}else if(e.currentTarget==_btn3){
				_btn3.filters=[new GlowFilter(0xff0000,1,2,2,10)];_btn2.filters=[];_btn1.filters=[];
				YaDispatcher.instance.dispatchEvent(new ParamEvent(EventName.Barrage_Setting,"2"));
			}else if(e.currentTarget==_stage){
				if(this.parent){
					this.parent.removeChild(this);
				}
			}else if(e.currentTarget==_yaScrollBar){
				LayerManager.Layer_Barrage.alpha=Number(ParamEvent(e).param);
				_alhpaTxt.setObj(_yaScrollBar.getVal());
			}else if(e.currentTarget==this){
				if(e.type==MouseEvent.ROLL_OUT){
					if(this.parent){
						this.parent.removeChild(this);
					}
				}else if(e.type==MouseEvent.MOUSE_OVER){
					_stage.removeEventListener(MouseEvent.MOUSE_DOWN,eventFun);
				}
			}
		}
		
		override protected function updatePosition():void{
			LayerManager.Layer_UI.addChild(this);
			this.x=_x-this.width/2;
			this.y=_y-this.height-30;

			_yaScrollBar.x=40;
			_yaScrollBar.y=50;
			
			_btn1.y=_btn2.y=_btn3.y=140;
		}
		
		private var _x:int;
		private var _y:int;
		public function open(x_:int,y_:int):void{
			_stage.addEventListener(MouseEvent.MOUSE_DOWN,eventFun);
			
			_x=x_;
			_y=y_;
			LayerManager.Layer_UI.addChild(this);
		}
	}
}