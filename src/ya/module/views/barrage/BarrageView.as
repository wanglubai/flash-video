package ya.module.views.barrage
{
	import flash.display.Sprite;
	import flash.utils.setInterval;
	
	import ya.interfaces.IDestroy;
	import ya.manages.LayerManager;
	import ya.module.model.barrage.vo.BarrageVo;
	import ya.module.views.barrage.manager.BarrageManager;
	import ya.module.views.barrage.manager.BarrageRenderManager;
	import ya.module.views.system.heart.HeartItem;
	
	public class BarrageView extends Sprite implements IDestroy
	{
		public function BarrageView()
		{
			super();
			//模拟 服务器弹幕 本来该controller层 刷新数据
			
			//			var val:int=setTimeout(function():void{
			//				FrameRenderManager.instance.add(addFun);
			//			},2000)
			
			setInterval(heart,400);
			setInterval(addFun,50);
		}
		
		public function initParent():void{
			LayerManager.Layer_Barrage.addChild(this);
		}
		
		private function heart():void{
			if(BarrageRenderManager.instance.isRun)
				new HeartItem().start();
			//new PersonItem();
		}
		
		private function addFun():void{
			
			//该先判断空间 再初始化 临时这样写
			var item:BarrageRightTxtItem=BarrageFactory.instance.txtBarrageItem;
			item.setVo(new BarrageVo());
			if(BarrageManager.instance.addRight(item)){
				this.addChild(item)&&item.start();
			}else{
				item.reset();
			}
		}
		
		public function addBarrageVo(vo:BarrageVo):void{
		}
		
		public function destroy():void
		{
		}
	}
}