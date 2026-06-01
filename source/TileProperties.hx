import flixel.util.FlxDirection;

typedef TileProperties =
{
	var exists:Bool;
	var movable:Bool;

	var pusher:Bool;
	var ?push:FlxDirection;

	var end:Bool;
}
