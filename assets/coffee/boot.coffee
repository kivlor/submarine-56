# create the boot state
bootState =
	preload: ->
		# load the progress sprite
		game.load.image 'progress', '/images/progress.png'

	create: ->
		# set the stage
		game.stage.backgroundColor = '#a4e8fc'
		game.physics.startSystem Phaser.Physics.ARCADE

		# start the load state
		game.state.start('load');