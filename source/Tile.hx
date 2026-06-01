import flixel.FlxG;
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
			interactable: true,
		};

		this.state = state;

		animation.add('anim', [state]);
		animation.play('anim');

		switch (state)
		{
			case EMPTY:
				properties.exists = false;
				properties.interactable = false;
				visible = false;

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
				properties.interactable = false;
		}
	}

	public var properties(default, null):TileProperties;

	override public function new()
	{
		super();

		loadGraphic('assets/tileset.png', true, 64, 64);
		setState(SOLID);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.overlaps(this) && FlxG.mouse.justPressed && properties.interactable)
		{
			state++;

			if (state == FINISH || (state.toInt() > FINISH.toInt()) || (state.toInt() < SOLID.toInt()))
				state = SOLID;

			setState(state);
		}
	}
}
