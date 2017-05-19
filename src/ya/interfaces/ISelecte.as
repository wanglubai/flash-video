package ya.interfaces
{
	import ya.component.YaGroup;

	public interface ISelecte extends IDestroy
	{
		function setSelectedState(val:int):void;
		function getSelectedState():int;
		function register(ya:YaGroup):void;
		function getKey():Object;
	}
}