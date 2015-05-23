require('./board.js');
var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var Game = function() {
  this.board = new Board;
  this.currentPlayer = board.currentPlayer;

  this.play = function() {
    reader.question("where would you like to move from and to? ", function(answer) {
      moveFrom = answer[0];
      moveTo = answer[1];

      this.board.placeMark(moveTo, this.currentPlayer);

    })
  };
};

module.exports = Game;
