gameSize = 4

# create the play state
playState =
	create: ->
		# setup input
		@.cursor = game.input.keyboard.createCursorKeys()
		@.space = game.input.keyboard.addKey Phaser.Keyboard.SPACEBAR

		game.world.setBounds 0, 0, game.world.width*gameSize, game.world.height*gameSize

		# create world
		@.createWalls()
		@.createOcean()
		
		@.createPlayer()
		@.createTorpedo()
		@.createSurface()

		# create camera
		game.camera.follow @.sub, @.camera.FOLLOW_LOCKON

	update: ->
		game.physics.arcade.collide @.sub, @.walls
		game.physics.arcade.collide @.sub, @.floor
		game.physics.arcade.collide @.sub, @.sky

		@.movePlayer()

	render: ->
		# game.debug.cameraInfo game.camera, 20, 20
		# game.debug.spriteCoords @.sub, 20, 400
	
	createWalls: ->
		# setup the wall group
		@.walls = game.add.group()
		@.walls.enableBody = yes

		# build all the walls!
		leftWall = game.add.tileSprite -1, 0, 1, game.world.height, 'trans', 0, @.walls
		rightWall = game.add.tileSprite game.world.width, 0, game.world.width+1, game.world.height, 'trans', 0, @.walls

		# let's make sure they don't move
		@.walls.setAll 'body.immovable', yes

	createOcean: ->
		# add the ocean.. of bubbles
		@.ocean = game.add.tileSprite 0, 96, game.world.width, game.world.height, 'ocean'
		game.physics.arcade.enable @.ocean
		@.ocean.body.immovable = yes

		# add the floor
		@.floor = game.add.tileSprite 0, game.world.height-16, game.world.width, game.world.height, 'floor'
		game.physics.arcade.enable @.floor
		@.floor.body.immovable = yes

		# add the sand above the floor
		@.sand = game.add.tileSprite 0, game.world.height-32, game.world.width, game.world.height, 'sand'
		game.physics.arcade.enable @.sand
		@.sand.body.immovable = yes

	createSurface: ->
		@.surface = game.add.tileSprite 0, 96, game.world.width, 4, 'surface', 0
		@.surface.animations.add 'waves', [0, 1], 1, yes
		@.surface.animations.play 'waves'

		@.sky = game.add.tileSprite 0, 0, game.world.width, 36, 'sky'
		game.physics.arcade.enable @.sky
		@.sky.body.immovable = yes

	createPlayer: ->
		@.sub = game.add.sprite game.world.centerX, 132, 'sub56'
		@.sub.anchor.setTo 0.5, 1
		@.sub.animations.add 'left', [0, 1, 2, 3], 24, yes
		@.sub.animations.add 'right', [4, 5, 6, 7], 24, yes

		@.sub.animations.play 'right'
		@.sub.direction = 'right'

		game.physics.arcade.enable @.sub
		@.sub.body.gravity.y = 50

	movePlayer: ->
		# handle basic movement
		if @.cursor.left.isDown
			@.sub.body.velocity.x = -150;
			@.sub.animations.play 'left'
			@.sub.direction = 'left'
		else if @.cursor.right.isDown
			@.sub.body.velocity.x = 150;
			@.sub.animations.play 'right'
			@.sub.direction = 'right'
		else
			@.sub.body.velocity.x = 0

		if @.cursor.up.isDown
			@.sub.body.velocity.y = -100;
		else if @.cursor.down.isDown
			@.sub.body.velocity.y = 100;
		else
			@.sub.body.velocity.y = 50;

		# handle fire
		@.space.onDown.addOnce @.fireTorpedo, @

	killPlayer: ->
		# back to the menu
		game.state.start 'menu'

	createTorpedo: ->
		@.torpedos = game.add.group()
		@.torpedos.enableBody = yes
		@.torpedos.createMultiple 3, 'torpedo'

	fireTorpedo: ->
		# create a new toredo
		if !torpedo = @.torpedos.getFirstDead() then return
		
		torpedo.anchor.setTo 0.5, 0.5
		torpedo.checkWorldBounds = yes
		torpedo.outOfBoundsKill = yes

		# left or right?
		if @.sub.direction is 'right'
			torpedo.angle = 0
			torpedo.reset @.sub.x+(@.sub.width/2), @.sub.y-16
			torpedo.body.velocity.x = 400
		else
			torpedo.angle = 180
			torpedo.reset @.sub.x-(@.sub.width/2), @.sub.y-16
			torpedo.body.velocity.x = -400