import flixel.util.FlxColor;
import flixel.FlxSprite;
import TileStates;

class Tile extends FlxSprite
{
	public var state(default, null):TileState = 0;

	public function setState(state:TileState)
	{
		properties = {
			exists: true,
			movable: true,
		};

		this.state = state;

		switch (state)
		{
			case EMPTY:
				properties.exists = false;
				destroy();

			case SOLID:
				properties.movable = false;
		}
	}

	public var properties(default, null):TileProperties;

	override public function new()
	{
		super();

		makeGraphic(64, 64);
		setState(SOLID);
	}
}
