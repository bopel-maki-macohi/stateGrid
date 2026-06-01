package;

import flixel.math.FlxPoint;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.FlxState;

class PlayState extends FlxState
{
	var tiles:FlxTypedSpriteGroup<Tile>;

	override public function create()
	{
		tiles = new FlxTypedSpriteGroup<Tile>();
		add(tiles);

		/**
		makeGrid(FlxPoint.weak(20, 12), null, function(tile:Tile)
		{
			tile.alpha = 0.25;
			tile.scale.set(0.5, 0.5);

			final ix = Math.floor(tile.x / 64);
			final iy = Math.floor(tile.y / 64);

			if (ix > 1 && ix < 17)
				if (iy > 1 && iy < 10)
					tile.destroy();
		});
		 */

		makeGrid(FlxPoint.weak(16, 8), FlxPoint.weak(2, 2));

		super.create();
	}

	function makeGrid(dimensions:FlxPoint, ?offset:FlxPoint, ?onTileMade:Tile->Void)
	{
		var ix = 0;
		var iy = 0;

		while (iy < dimensions.y)
		{
			while (ix < dimensions.x)
			{
				var tile = new Tile();
				tile.setPosition((ix + ((offset != null) ? offset.x : 0)) * 64, (iy + ((offset != null) ? offset.y : 0)) * 64);

				if (onTileMade != null)
					onTileMade(tile);

				if (tile != null && tile.exists)
					tiles.add(tile);

				ix++;
			}

			ix = 0;
			iy++;
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
