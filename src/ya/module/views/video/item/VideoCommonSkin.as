package ya.module.views.video.item
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import ya.component.YaButton;
	import ya.component.YaResName;
	import ya.component.YaScrollBar;
	import ya.component.events.EventName;
	import ya.component.events.ParamEvent;
	import ya.component.events.YaDispatcher;
	import ya.component.tips.YaBaseTips;
	import ya.component.tips.YaPersonTips;
	import ya.component.tips.YaTipsManager;
	import ya.component.tips.YaTxtTips;
	import ya.manages.LayerManager;
	import ya.manages.LogManager;
	import ya.manages.ResManager;
	import ya.manages.UrlManager;
	import ya.module.views.CarItem;
	import ya.module.views.barrage.manager.BarrageRenderManager;
	import ya.module.views.video.base.ViewBaseSkin;
	import ya.utils.YaFactory;
	import ya.utils.YaUtils;
	
	public class VideoCommonSkin extends ViewBaseSkin
	{
		public function VideoCommonSkin()
		{
			initStage();
			addStageEvent();
			super(UrlManager.instance.getResUrl(YaResName.VideoCommonSkin));
			LayerManager.Layer_UI.addChild(this);
		}
		
		private var _bg:Sprite;
		private var _playStateBtn:SimpleButton;
		private var _pauseStateBtn:SimpleButton;
		private var _musicHasBtn:SimpleButton;
		private var _musicNoBtn:SimpleButton;
		private var _btn1:YaButton;
		private var _yaTxt:TextField;
		private var _barBtn:YaScrollBar;
		private var _btn2:YaButton;
		private var _btn3:YaButton;
		override protected function initView():void{
			this.mouseEnabled=false;
			
			_bg=new Sprite();
			_bg.alpha=0.8;
			_bg.graphics.beginFill(0x666666);
			_bg.graphics.drawRect(0,0,_stage.stageWidth,40);
			_bg.graphics.endFill();
			this.addChild(_bg);
			
			_playStateBtn=ResManager.instance.getInstanceObj("VideoCommonSkin_Play_State_RES",YaResName.VideoCommonSkin);
			this.addChild(_playStateBtn);
			_playStateBtn.visible=true;
			
			var aa:YaTxtTips=new YaTxtTips();aa.setObj("开关");
			YaTipsManager.instance.register(_playStateBtn,aa);
			
			_pauseStateBtn=ResManager.instance.getInstanceObj("VideoCommonSkin_Pause_State_RES",YaResName.VideoCommonSkin);
			this.addChild(_pauseStateBtn);
			_pauseStateBtn.visible=false;
			
			_yaTxt=YaFactory.getTextFied({"filter":true,"size":20});
			this.addChild(_yaTxt);
			
			_tips=new YaTxtTips();
			YaTipsManager.instance.register(_yaTxt,_tips);
			
			_musicHasBtn=ResManager.instance.getInstanceObj("VideoCommonSkin_Has_Music_RES",YaResName.VideoCommonSkin);
			this.addChild(_musicHasBtn);
			_musicHasBtn.visible=true;
			
			YaTipsManager.instance.register(_musicHasBtn,new YaPersonTips());
			
			_musicNoBtn=ResManager.instance.getInstanceObj("VideoCommonSkin_No_Music_RES",YaResName.VideoCommonSkin);
			this.addChild(_musicNoBtn);
			_musicNoBtn.visible=false;
			
			_btn1=new YaButton();
			_btn1.setSkin('tool1_1.png','tool1_0.png','tool1_1.png');
			this.addChild(_btn1);
			
			var _btn1Tips:YaTxtTips=new YaTxtTips();
			_btn1Tips.setObj("组件查看");
			YaTipsManager.instance.register(_btn1,_btn1Tips);
			
			_btn2=new YaButton();
			_btn2.setSkin('tool0.png','tool1.png','tool0.png');
			this.addChild(_btn2);
			
			var _btn2Tips:YaTxtTips=new YaTxtTips();
			_btn2Tips.setObj("弹幕设置栏");
			YaTipsManager.instance.register(_btn2,_btn2Tips);
			
			_btn3=new YaButton();
			_btn3.setSkin('fullScreen0.png','fullScreen1.png','fullScreen0.png');
			this.addChild(_btn3);
			
			var _btn3Tips:YaTxtTips=new YaTxtTips();
			_btn3Tips.setObj("点击按钮全屏");
			YaTipsManager.instance.register(_btn3,_btn3Tips);
			
			_barBtn=new YaScrollBar(YaScrollBar.Type_Horizontal);
			var bg:Sprite=YaUtils.getSprite(110,4);
			_barBtn.setSkin(YaUtils.getSprite(10,10,0xffffff),bg,100);
			YaUtils.setCenterY(bg,_barBtn);
			_barBtn.setVal(0.1);
			_tempVolume=_barBtn.getVal();
			this.addChild(_barBtn);
			
			addEvent();
			resizeFresh();
		}
		override protected function addEvent():void{
			_playStateBtn.addEventListener(MouseEvent.CLICK,eventFun);
			_pauseStateBtn.addEventListener(MouseEvent.CLICK,eventFun);
			_musicHasBtn.addEventListener(MouseEvent.CLICK,eventFun);
			_musicNoBtn.addEventListener(MouseEvent.CLICK,eventFun);
			_barBtn.addEventListener(EventName.YaScrollBar_Val,eventFun);
			_btn1.addEventListener(MouseEvent.CLICK,eventFun);
			_btn2.addEventListener(MouseEvent.CLICK,eventFun);
			_btn3.addEventListener(MouseEvent.CLICK,eventFun);
			BarrageRenderManager.instance.add(updateFun);
		}
		
		override protected function removeEvent():void{
			_playStateBtn.removeEventListener(MouseEvent.CLICK,eventFun);
			_pauseStateBtn.removeEventListener(MouseEvent.CLICK,eventFun);
			_musicHasBtn.removeEventListener(MouseEvent.CLICK,eventFun);
			_musicNoBtn.removeEventListener(MouseEvent.CLICK,eventFun);
			_barBtn.removeEventListener(EventName.YaScrollBar_Val,eventFun);
			_btn1.removeEventListener(MouseEvent.CLICK,eventFun);
			
			BarrageRenderManager.instance.remove(updateFun);
		}
		
		override public function destroy():void
		{
			removeEvent();
			_bg=null;
			_playStateBtn=null;
			_pauseStateBtn=null;
			_musicHasBtn=null;
			_musicNoBtn=null;
			_yaTxt=null;
		}
		
		private function updateFun():void{
			this.playTime(YaUtils.secToTime(_video.getPlayTime));
		}
		
		override protected function resizeFresh():void{
			_bg.graphics.clear();
			_bg.graphics.beginFill(0x666666);
			_bg.graphics.drawRect(0,0,_stage.stageWidth,40);
			_bg.graphics.endFill();
			
			LogManager.log("Layer_Stage.width"+_stage.stageWidth+"__Layer_Stage.height"+_stage.stageHeight);
			_pauseStateBtn.x=_playStateBtn.x=10;
			_pauseStateBtn.y=_playStateBtn.y=_stage.stageHeight-25;
			
			_musicHasBtn.x=_musicNoBtn.x=140;
			_musicHasBtn.y=_musicNoBtn.y=_stage.stageHeight-25;
			
			_bg.y=_stage.stageHeight-_bg.height;
			
			_yaTxt.x=50;
			_yaTxt.y=_stage.stageHeight-30;
			
			_btn1.x=_stage.stageWidth-185-45;
			_btn1.y=_stage.stageHeight-32;
			
			_btn2.x=_stage.stageWidth-185;
			_btn2.y=_stage.stageHeight-32;
			
			
			_btn3.x=_stage.stageWidth-35;
			_btn3.y=_stage.stageHeight-30;
			
			_barBtn.x=164;
			_barBtn.y=_stage.stageHeight-22;
		}
		
		private var _tips:YaBaseTips;
		override public function playTime(str:String):void{
			_yaTxt.text=str;
			_tips.setObj(str);
		}
		
		private function eventFun(e:Event):void{
			if(e.currentTarget==_playStateBtn){
				_video.pasvPause();
				_playStateBtn.visible=!(_pauseStateBtn.visible=true);
			}else if(e.currentTarget==_pauseStateBtn){
				_video.pasvPlay();
				_playStateBtn.visible=!(_pauseStateBtn.visible=false);
			}else if(e.currentTarget==_musicHasBtn){
				_barBtn.setVal(0);
				_video.volume(0);
				_musicHasBtn.visible=!(_musicNoBtn.visible=true);
			}else if(e.currentTarget==_musicNoBtn){
				_video.volume(Math.max(0.1,_tempVolume));
				_barBtn.setVal(Math.max(0.1,_tempVolume));
				_musicHasBtn.visible=!(_musicNoBtn.visible=false);
			}else if(e.currentTarget==_btn1){
				YaDispatcher.instance.dispatchEvent(new ParamEvent(EventName.Open_Demo1));
			}else if(e.currentTarget==_barBtn){
				_tempVolume=Number(ParamEvent(e).param);
				_video.volume(Number(ParamEvent(e).param));
				_musicHasBtn.visible=!(_musicNoBtn.visible=_tempVolume==0?true:false);
			}else if(e.currentTarget==_btn2){
				i++;
				if(ing==false)startCar();
				
				YaDispatcher.instance.dispatchEvent(new ParamEvent(EventName.Open_Setting_View,{"x":e.currentTarget.stage.mouseX,"y":e.currentTarget.stage.mouseY}));
			}else if(e.currentTarget==_btn3){
				stageFun();
			}
		}
		private var i:int=0;
		private var ing:Boolean=false;
		private function startCar():void{
			if(i>0){
				ing=true;
				i--;
				var car:CarItem=new CarItem();
				car._overFun=startCar;
			}else{
				ing=false;
			}
		}
		
		private  function stageFun():void{
			if(_stage.displayState==StageDisplayState.FULL_SCREEN_INTERACTIVE){
				_stage.displayState=StageDisplayState.NORMAL;
				//				_stage.stageWidth=1280;
				//				_stage.stageHeight=768;
			}else if(_stage.displayState==StageDisplayState.NORMAL){
				_stage.displayState=StageDisplayState.FULL_SCREEN;
				//				_stage.stageWidth=1928;
				//				_stage.stageHeight=1084;
				//				fscommand("fullscreen","true");
			}else if(_stage.displayState==StageDisplayState.FULL_SCREEN){
				_stage.displayState=StageDisplayState.NORMAL;
			}
		}		
		
		private var _tempVolume:Number;
	}
}