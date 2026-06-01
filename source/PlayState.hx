package;

import lime.utils.Assets;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import TileStates;
import flixel.math.FlxPoint;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.FlxState;

class PlayState extends FlxState
{
	var tiles:FlxTypedSpriteGroup<Tile>;
	var tileGrid:Array<Array<TileState>> = [];

	override public function create() @:privateAccess
	{
		var levelLoader = new FlxOgmo3Loader('assets/levels/levels.ogmo', 'assets/levels/level1.json');

		final w = levelLoader.level.width / levelLoader.project.tilesets[0].tileWidth;
		final h = levelLoader.level.height / levelLoader.project.tilesets[0].tileHeight;

		// genTileGrid(FlxPoint.weak(w, h));
		tileGrid = levelLoader.level.layers[0].data2D;

		// trace(tileGrid);

		tiles = new FlxTypedSpriteGroup<Tile>();
		add(tiles);

		makeGrid(FlxPoint.weak(w, h));

		super.create();
	}

	function setTile(position:FlxPoint, newtile:TileState)
	{
		tileGrid[Std.int(position.y)][Std.int(position.x)] = newtile;
	}

	function genTileGrid(dimensions:FlxPoint)
	{
		trace('Making Tile Grid of Dimensions: ${dimensions}');

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

	function makeGrid(dimensions:FlxPoint, ?onTileMade:Tile->Void)
	{
		for (tile in tiles)
		{
			tiles.remove(tile);
			tile.destroy();
		}

		tiles.clear();

		trace('Making Grid of Dimensions: ${dimensions}');

		var ix = 0;
		var iy = 0;

		while (iy < dimensions.y)
		{
			while (ix < dimensions.x)
			{
				var tile = new Tile();
				tile.setPosition(ix * 64, iy * 64);

				try
				{
					tile.setState(tileGrid[iy][ix] ?? SOLID);
				}
				catch (e)
				{
					tile.setState(SOLID);
				}

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
		tiles.screenCenter();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
