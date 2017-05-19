package ya.component.poplist
{
	import com.greensock.TweenMax;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ya.component.YaCacheSprite;
	import ya.component.YaGroup;
	import ya.component.YaScrollContent;
	import ya.manages.LogManager;
	
	public class DemoSelectedView extends YaCacheSprite
	{
		private var _head:DemoSelectedItem;
		private var _group:YaGroup;
		private var _content:YaScrollContent;
		public function DemoSelectedView(url:String=null)
		{
			initStage();
			super(url);
			_head=new DemoSelectedItem();
			_head.setSkin('poplist.jpg','poplist1.jpg','poplist.jpg');
			
			_group=new YaGroup();
			
			_content=new YaScrollContent(191,282);
			_content.y=50;
			_content.setVertical();
			
			var item:DemoSelectedItem;
			for(var i:int=0;i<10;i++){
				item=new DemoSelectedItem();
				item.setSkin('poplist.jpg','poplist1.jpg','poplist.jpg');
				item.y=i*40;
				item.setText("这里是列表"+i);
				_content.push(item);
				_group.add(item);
				
				item.addEventListener(MouseEvent.CLICK, btnClickHandler);
			}
			_group.setSelectedByIndex(i);
			_group.changeCall=function():void{
				_head.setText(_group.getSelected().getKey().toString());
			}
			this.addChild(_head);	
			_head.addEventListener(MouseEvent.MOUSE_UP,eventFun);
			_content.addEventListener(Event.ADDED_TO_STAGE,eventFun);
			//_content.addEventListener(MouseEvent.MOUSE_OUT,eventFun);
			this.addEventListener(Event.ADDED_TO_STAGE,stageFun);
		}
		private function stageFun(e:Event):void{
			this.stage.addEventListener(MouseEvent.MOUSE_DOWN,eventFun);
			if(this.stage==_stage){
				LogManager.log("好牛逼的样子啊");
			}
		}
		private function btnClickHandler(e:Event):void{
			_content.parent&&_content.parent.removeChild(_content);
		}
		private function eventFun(e:Event):void{
			if(e.currentTarget==_head){
				if(_content.parent){
					_content.parent.removeChild(_content);
				}else{
					this.addChild(_content);
					_content.y=20;
					TweenMax.to(_content,.1,{y:40});
				}
			}else if(e.currentTarget==_stage){
				if(_content.parent){
					_content.parent.removeChild(_content);
				}
			}else if(e.currentTarget==_content){
			//	_stage.addEventListener(MouseEvent.MOUSE_UP,eventFun);
			}
		}
	}
}