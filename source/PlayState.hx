package;

import TileStates;
import flixel.math.FlxPoint;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.FlxState;

class PlayState extends FlxState
{
	var tiles:FlxTypedSpriteGroup<Tile>;
	var tileGrid:Map<Array<Int>, Int> = new Map();

	override public function create()
	{
		tileGrid.set([2, 2], EMPTY);

		trace(tileGrid);

		tiles = new FlxTypedSpriteGroup<Tile>();
		add(tiles);

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

				trace('${[ix, iy]} : ${tileGrid.get([ix,iy])}');

				if (onTileMade != null)
					onTileMade(tile);

				if (tile != null)
				{
					if (tile.exists && tile.properties?.exists)
						tiles.add(tile);

					if (tile.exists && !tile.properties?.exists)
						tile.destroy();
				}

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
