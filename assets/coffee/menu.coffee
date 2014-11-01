# create the menu state
menuState =
	create: ->
		# game.add.image 0, 0, 'background'

		instruct = game.add.text game.world.centerX, game.world.centerY, '0', {font: '18px Arial', fill: '#000000'}
		instruct.anchor.setTo 0.5, 0.5
		instruct.text = 'press space to start...'

		spacebar = game.input.keyboard.addKey Phaser.Keyboard.SPACEBAR
		spacebar.onDown.addOnce @.start, @

	start: ->
		game.state.start 'play'