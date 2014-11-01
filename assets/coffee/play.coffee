# create the play state
playState =
	create: ->
		# setup input
		@.cursor = game.input.keyboard.createCursorKeys()
		@.space = game.input.keyboard.addKey Phaser.Keyboard.SPACEBAR
		
	update: ->