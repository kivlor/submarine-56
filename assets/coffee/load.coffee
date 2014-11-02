# create the load state
loadState =
	preload: ->
		# setup the progress bar
		progress = game.add.sprite game.world.centerX, game.world.centerY, 'progress'
		progress.anchor.setTo 0.5, 0.5
		game.load.setPreloadSprite progress

		# load the sprites
		game.load.image 'trans', '/images/trans.png'
		game.load.image 'ocean', '/images/ocean.png'
		game.load.image 'floor', '/images/floor.png'
		game.load.image 'sand', '/images/sand.png'
		game.load.image 'sky', '/images/sky.png'
		game.load.spritesheet 'surface', '/images/surface.png', 12, 4

		game.load.image 'torpedo', '/images/torpedo.png'
		game.load.spritesheet 'submarine', '/images/submarine.png', 118, 96

	create: ->
		# start the menu state
		game.state.start('menu');