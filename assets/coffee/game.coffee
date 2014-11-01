# build the game
game = new Phaser.Game 256, 240, Phaser.AUTO, 'stage'

game.state.add 'boot', bootState
game.state.add 'load', loadState
game.state.add 'menu', menuState
game.state.add 'play', playState

game.state.start 'boot'