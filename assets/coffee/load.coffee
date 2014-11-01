# create the load state
loadState =
	preload: ->
		# setup the progress bar
		progress = game.add.sprite game.world.centerX, game.world.centerY, 'progress'
		progress.anchor.setTo 0.5, 0.5
		game.load.setPreloadSprite progress

		# load the sprites
		game.load.image 'sprite', '/images/sprite.png'

	create: ->
		# start the menu state
		game.state.start('menu');