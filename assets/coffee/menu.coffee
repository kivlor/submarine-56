# create the menu state
menuState =
	create: ->
		ocean = game.add.tileSprite 0, 0, game.world.width, game.world.height, 'ocean'

		logo = game.add.sprite game.world.centerX, 56, 'logo'
		logo.anchor.setTo 0.5, 0

		instruct = game.add.text game.world.centerX, game.world.centerY+128, '0', {font: '18px Arial', fill: '#fcb800'}
		instruct.anchor.setTo 0.5, 0.5
		instruct.text = 'press space to start...'

		sub56 = game.add.sprite game.world.centerX, game.world.centerY+24, 'sub56'
		sub56.anchor.setTo 0.5, 0.5
		sub56.animations.add 'right', [4, 5, 6, 7], 24, yes
		sub56.animations.play 'right'

		tween = game.add.tween sub56
		tween.to {y: game.world.centerY+32}, 1000
		tween.to {y: game.world.centerY+24}, 1000
		tween.loop()
		tween.start()

		spacebar = game.input.keyboard.addKey Phaser.Keyboard.SPACEBAR
		spacebar.onDown.addOnce @.start, @

	start: ->
		game.state.start 'play'