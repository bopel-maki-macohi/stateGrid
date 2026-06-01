import flixel.util.FlxColor;
import flixel.FlxSprite;

class Tile extends FlxSprite
{
	public var state(default, null):Int = 0;

	public function setState(state:TileStates)
	{
		properties = {
			exists: true,
			movable: true,
		};

		switch (state)
		{
			case EMPTY:
				properties.exists = false;

			case SOLID:
				properties.movable = false;
		}

		this.state = state;
	}

	public var properties(default, null):TileProperties;

	override public function new()
	{
		super();

		makeGraphic(64, 64);
		setState(SOLID);
	}
}
