package;

import TileStates;
import flixel.math.FlxPoint;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.FlxState;

class PlayState extends FlxState
{
	var tiles:FlxTypedSpriteGroup<Tile>;
	var tileGrid:Map<Array<Int>, TileState> = [];

	override public function create()
	{
		tileGrid.set([0,0], EMPTY);
		tileGrid.set([0,1], EMPTY);
		tileGrid.set([1,1], EMPTY);
		tileGrid.set([2,1], EMPTY);
		tileGrid.set([2,0], EMPTY);
		tileGrid.set([3,0], EMPTY);
		tileGrid.set([3,0], EMPTY);
		tileGrid.set([4,0], EMPTY);

		tiles = new FlxTypedSpriteGroup<Tile>();
		add(tiles);

		makeGrid(FlxPoint.weak(16, 8), FlxPoint.weak(2, 2), function(tile)
		{
			var ix = Math.floor(tile.x / 64);
			var iy = Math.floor(tile.y / 64);

			for (position => state in tileGrid)
			{
				if (position == [ix, iy])
					tile.setState(state);
			}
		});

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

				if (tile != null && tile.exists && tile.properties.exists)
					tiles.add(tile);

				if (tile.exists && !tile.properties.exists)
					tile.destroy();

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
