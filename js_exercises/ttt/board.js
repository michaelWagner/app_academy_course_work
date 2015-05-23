require('./game.js');

var Board = function () {

  this.board = new Array(new Array(3), new Array(3), new Array(3));
  this.currentPlayer = 'x';

  this.wonGame = function () {

  };

  this.winner = function () {
    if (this.wonGame) {
      console.log(this.currentPlayer + " won!");
      return this.currentPlayer;
    }
  };

  this.empty = function(pos) {
    (typeof this.board[pos[0][pos[1]]]) === "undefined";
  };

  this.placeMark = function(pos, mark) {
    if (this.empty(pos)) {
      this.board[pos[0]][pos[1]] = mark;
      this.currentPlayer = this.currentPlayer === 'x' ? 'o' : 'x';
    }
  };
};


module.exports = Board;
