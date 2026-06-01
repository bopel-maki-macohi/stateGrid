typedef TileState = TileStates;

enum abstract TileStates(Int) from Int to Int
{
	var EMPTY = -1;
	var SOLID = 0;

	var PUSH_LEFT = 1;
	var PUSH_DOWN = 2;
	var PUSH_UP = 3;
	var PUSH_RIGHT = 4;
	
	var FINISH = 5;

	public inline function new(int:Int)
		this = int;

	public static inline function fromInt(int:Int):TileState
		return new TileState(int);

	public function toInt():Int
		return this;
}
