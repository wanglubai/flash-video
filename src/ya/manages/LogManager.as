package ya.manages
{
	import com.junkbyte.console.Cc;
	
	import flash.display.Stage;
	
	/**
	 * 日志管理器 
	 * @author wangshuang
	 * 
	 */
	public class LogManager
	{
		public static function log(...args):void{
			Cc.log(args);
		}
		
		public static function debug(...args):void{
			Cc.debug(args);
		}
		
		public static function error(...args):void{
			Cc.error(args);
		}
		
		public static function throwError(...args):void{
			
		}
		
		
		public static function register(stage:Stage):void{
			Cc.startOnStage(stage);
		}
	}
}