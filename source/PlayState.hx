package;

import TileStates;
import flixel.math.FlxPoint;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.FlxState;

class PlayState extends FlxState
{
	var tiles:FlxTypedSpriteGroup<Tile>;
	var tileGrid:Array<Array<TileState>> = [];

	override public function create()
	{
		genTileGrid(FlxPoint.weak(16, 8));
		setTile(FlxPoint.weak(), EMPTY);

		trace(tileGrid);

		tiles = new FlxTypedSpriteGroup<Tile>();
		add(tiles);

		makeGrid(FlxPoint.weak(16, 8), FlxPoint.weak(2, 2));

		super.create();
	}

	function setTile(position:FlxPoint, newtile:TileState)
	{
		tileGrid[Std.int(position.y)][Std.int(position.x)] = newtile;
	}

	function genTileGrid(dimensions:FlxPoint)
	{
		var ix = 0;
		var iy = 0;
		var fuckYouHaxe = [];

		while (iy < dimensions.y)
		{
			while (ix < dimensions.x)
			{
				fuckYouHaxe.push(SOLID);

				ix++;
			}

			tileGrid.push(fuckYouHaxe);
			fuckYouHaxe = [];

			ix = 0;
			iy++;
		}
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

				tile.setState(tileGrid[iy][ix] ?? SOLID);

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
