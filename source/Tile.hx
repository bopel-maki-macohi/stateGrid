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
			pusher: false,
			end: false,
		};

		this.state = state;

		switch (state)
		{
			case EMPTY:
				properties.exists = false;
				destroy();

			case SOLID:
				properties.movable = false;

			case PUSH_LEFT:
				properties.pusher = true;
				properties.push = LEFT;

			case PUSH_DOWN:
				properties.pusher = true;
				properties.push = DOWN;

			case PUSH_UP:
				properties.pusher = true;
				properties.push = UP;

			case PUSH_RIGHT:
				properties.pusher = true;
				properties.push = RIGHT;

			case FINISH:
				properties.end = true;
		}
	}

	public var properties(default, null):TileProperties;

	override public function new()
	{
		super();

		// loadGraphic('assets/tileset.png', true, 64, 64);
		makeGraphic(64, 64, FlxColor.WHITE);
		setState(SOLID);
	}
}
