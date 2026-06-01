package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import lime.utils.Assets;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import TileStates;
import flixel.math.FlxPoint;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.FlxState;

class PlayState extends FlxState
{
	var player:Tile;

	var tiles:FlxTypedSpriteGroup<Tile>;
	var tileGrid:Array<Array<TileState>> = [];

	var level:FlxOgmo3Loader;

	override public function create() @:privateAccess
	{
		level = new FlxOgmo3Loader('assets/levels/levels.ogmo', 'assets/levels/level1.json');

		final w = level.level.width / level.project.tilesets[0].tileWidth;
		final h = level.level.height / level.project.tilesets[0].tileHeight;

		// genTileGrid(FlxPoint.weak(w, h));
		tileGrid = level.level.layers[0].data2D;

		// trace(tileGrid);

		tiles = new FlxTypedSpriteGroup<Tile>();
		add(tiles);

		makeGrid(FlxPoint.weak(w, h));

		player = new Tile();
		player.setState(PLAYER);
		tiles.add(player);
		player.setPosition(tiles.x, tiles.y);

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
		var i = 0;

		while (iy < dimensions.y)
		{
			while (ix < dimensions.x)
			{
				var tile = new Tile();
				tile.setPosition(ix * 64, iy * 64);
				tile.ID = i;

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

				// TODO : support for moving left or up on spawn
				// if (tile.state == PLAYER)
				// player.setPosition(tile.x, tile.y);

				if (tile != null)
				{
					if (tile.exists && tile.properties?.exists && tile.state != PLAYER)
						tiles.add(tile);

					if (tile.exists && !tile.properties?.exists && tile.state != PLAYER)
						tile.destroy();
				}

				ix++;
				i++;
			}

			ix = 0;
			iy++;
		}
		tiles.screenCenter();
	}

	var playing:Bool = false;

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.R && playing)
			FlxG.switchState(() -> new PlayState());

		if (FlxG.keys.justPressed.ENTER)
		{
			playing = true;

			onPlay();
		}

		if (playing)
			onPlayUpdate();
	}

	var playerSpeed:Float = 32;

	function onPlay() @:privateAccess
	{
		for (tile in tiles)
			tile.properties.interactable = false;

		player.velocity.set();

		if (level.level.values.start_horizontal)
			player.velocity.x = playerSpeed;
		else
			player.velocity.y = playerSpeed;
	}

	function onPlayUpdate() @:privateAccess
	{
		for (tile in tiles)
		{
			if (!tile.properties.exists)
				continue;

			if (!player.overlaps(tile))
				continue;

			var px = Math.floor(player.x / 8);
			var py = Math.floor(player.y / 8);

			var tx = Math.floor(tile.x / 8);
			var ty = Math.floor(tile.y / 8);

			if (px != tx)
				continue;
			if (py != ty)
				continue;

			if (tile.properties.pusher)
			{
				switch (tile.properties.push)
				{
					case LEFT:
						player.velocity.set(-playerSpeed, 0);
					case DOWN:
						player.velocity.set(0, playerSpeed);
					case UP:
						player.velocity.set(0, -playerSpeed);
					case RIGHT:
						player.velocity.set(playerSpeed, 0);
				}
			}

			if (!tile.properties.movable || tile.properties.end)
				player.velocity.set(0, 0);
		}
	}
}
