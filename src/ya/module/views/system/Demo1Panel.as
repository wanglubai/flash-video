package ya.module.views.system
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setInterval;
	
	import ya.component.YaButton;
	import ya.component.YaCacheSprite;
	import ya.component.YaCheckbox;
	import ya.component.YaGroup;
	import ya.component.YaImageProxy;
	import ya.component.YaResName;
	import ya.component.YaScrollBar;
	import ya.component.YaScrollContent;
	import ya.component.events.EventName;
	import ya.component.events.ParamEvent;
	import ya.component.message.MessageManager;
	import ya.component.poplist.DemoSelectedView;
	import ya.component.tips.YaTipsManager;
	import ya.component.tips.YaTxtTips;
	import ya.manages.LayerManager;
	import ya.manages.ResManager;
	import ya.manages.UrlManager;
	import ya.module.views.system.person.PersonItem;
	import ya.utils.YaUtils;
	
	public class Demo1Panel extends YaCacheSprite
	{
		public function Demo1Panel(url:String=null)
		{
			super(UrlManager.instance.getResUrl(YaResName.Demo1Panel));
			initStage();
			setInitiativeWH(_stage.stageWidth,_stage.stageHeight);
			setInterval(add,1000);
		}
		
		private var _closeBtn:YaButton;
		private var _btn:YaButton;
		private var _btn1:YaButton;
		private var _btn2:YaButton;
		private var _bg:Sprite;
		override protected function resManagerCall():void{
			_bg=YaUtils.getSprite(_stage.stageWidth,_stage.stageHeight,0x999999);
			this.addChild(_bg);
			
			var yasc:YaScrollContent=new YaScrollContent(300,300);
			yasc.x=220;
			yasc.y=20;
			this.addChild(yasc);
			
			var mc:MovieClip=ResManager.instance.getInstanceObj("Demo1Panel_Res",YaResName.Demo1Panel) as MovieClip;
			mc.x=380;
			yasc.push(ResManager.instance.getInstanceObj("Demo1Panel_Res",YaResName.Demo1Panel) as MovieClip);
			yasc.push(mc);
			
			_btn=new YaButton();
			_btn.setSkin('0.png','1.png','2.png');
			_btn.x=320;
			_btn.y=450;
			this.addChild(_btn);
			YaTipsManager.instance.register(_btn,new YaTxtTips().setObj("这里是按钮测试"));	
			_btn.addEventListener(MouseEvent.CLICK,eventFun);
			
			_btn1=new YaButton();
			_btn1.setSkin('0.png','1.png','2.png');
			_btn1.x=320;
			_btn1.y=450;
			this.addChild(_btn1);
			_btn1.addEventListener(MouseEvent.CLICK,eventFun);
			
			var check:YaCheckbox=new YaCheckbox();
			check.setSkin('checkbox0.png','checkbox1.png');
			check.x=30;
			check.y=100;
			this.addChild(check);
			YaTipsManager.instance.register(check,new YaTxtTips().setObj("这里是复选框测试"));	
			
			check=new YaCheckbox();
			check.setSkin('checkbox0.png','checkbox1.png');
			check.x=70;
			check.y=100;
			this.addChild(check);
			
			_closeBtn=new YaButton();
			_closeBtn.setSkin('close0.png','close1.png');
			this.addChild(_closeBtn);
			
			var gap:YaGroup=new YaGroup();
			
			for(var i:int=0;i<4;i++){
				var ch:YaCheckbox=new YaCheckbox();
				ch.setSkin('radio0.png','radio1.png');
				ch.x=30;
				ch.y=20*i+150;
				gap.add(ch);
				this.addChild(ch);
			}
			
			var yaScrollBar0:YaScrollBar=new YaScrollBar(YaScrollBar.Type_Vertical);
			yaScrollBar0.setSkin(YaUtils.getSprite(10,10,0xffffff),YaUtils.getSprite(10,110),100);
			yaScrollBar0.y=380;
			yaScrollBar0.x=20;
			this.addChild(yaScrollBar0);
			yaScrollBar0.addEventListener(EventName.YaScrollBar_Val,function valFun(e:ParamEvent):void{
				yasc.setProgressVal=Number(e.param);
				yaScrollBar1.setVal(Number(e.param));
			})
			
			var yaScrollBar1:YaScrollBar=new YaScrollBar(YaScrollBar.Type_Horizontal);
			var im:YaImageProxy=new YaImageProxy(UrlManager.instance.getBtnResUrl("bar1.png"));
			var bg:Sprite=YaUtils.getSprite(102,10);
			bg.x=4;
			bg.y=10;
			yaScrollBar1.setSkin(im,bg,100);
			yaScrollBar1.x=yaScrollBar0.x+yaScrollBar0.width+30;
			yaScrollBar1.y=yaScrollBar0.y;
			this.addChild(yaScrollBar1);
			yaScrollBar1.addEventListener(EventName.YaScrollBar_Val,function valFun(e:ParamEvent):void{
				yasc.setProgressVal=Number(e.param);
				yaScrollBar0.setVal(Number(e.param));
				tips.setObj(Number(e.param));
			})
			var tips:YaTxtTips=new YaTxtTips();
			tips.setObj(yaScrollBar1.getVal());
			YaTipsManager.instance.register(yaScrollBar1.barBtn,tips);	
			
			yasc.progressChangeCallFun(function():void{
				yaScrollBar0.setVal(yasc.getProgressVal);
				yaScrollBar1.setVal(yasc.getProgressVal);
			})
			
			var poplist:DemoSelectedView=new DemoSelectedView();
			poplist.x=532;
			poplist.y=75;
			this.addChild(poplist);
			
			addEvent();
			updatePosition();
		}
		private function add():void{
			new PersonItem(this)
		}
		
		override protected function addEvent():void{
			_closeBtn.addEventListener(MouseEvent.CLICK,eventFun);
		}
		override protected function removeEvent():void{
			
		}
		private function eventFun(e:Event):void{
			if(e.currentTarget==_closeBtn){
				close();
			}else if(e.currentTarget==_btn){
				MessageManager.instance.showSp("黄昏靠岸 码头格外悲伤",_btn);
			}else if(e.currentTarget==_btn1){
				MessageManager.instance.showSp("黄昏靠岸 码头格外悲伤",_btn);
			}
		}
		
		public function open():void{
			if(this.parent){
				close();
				return;
			}
			LayerManager.Layer_UI.addChild(this);
		}
		
		override protected function updatePosition():void{
			this.x=(_stage.stageWidth-this.width)/2;
			this.y=(_stage.stageHeight-this.height)/2;
			
			_closeBtn.x=this.width-30;
			YaUtils.setGraphics(_bg,_stage.stageWidth,_stage.stageHeight,0x999999);
		}
		
		public function close():void{
			LayerManager.Layer_UI.removeChild(this);
		}
	}
}