(function () {
  if (typeof WhipSnake === "undefined") {
    window.WhipSnake = {};
  }

  var Snake = WhipSnake.Snake = function () {
    this.dir = "N";
    this.segments = [];
  };

  Snake.prototype.move = function () {
  };

  Snake.prototype.turn = function (newDir) {
    this.dir = newDir;
  };

  var Coord = WhipSnake.Coord = function (x, y) {
    this.x = x;
    this.y = y;
    this.val = '.';
  };

  Coord.prototype.plus = function (otherCoord) {
    this.x += otherCoord.x;
    this.y += otherCoord.y;
  };

  Coord.prototype.equals = function (otherCoord) {
    return (otherCoord.x === this.x && otherCoord.y === this.y);
  };

  Coord.prototype.isOpposite = function (otherCoord) {
    return (otherCoord.x === this.y && otherCoord.y === this.x);
  };

  var Board = WhipSnake.Board = function () {
    this.snake = new Snake();
    this.apples = [];
    this.gridSize = 20;

    this.grid = this.setupGrid();
  };

  Board.prototype.setupGrid = function () {
    var grid = [];

    for (var i = 0; i < this.gridSize; i++) {
      var row = [];
      for (var j = 0; j < this.gridSize; j++) {
        row.push(new Coord(i, j));
      }
      grid.push(row);
    }

    return grid;
  };

  Board.prototype.render = function () {
    var gridStr = ''

    for (var i = 0; i < this.grid.length; i++) {
      for (var j = 0; j < this.grid[i].length; j++) {
        if ($.inArray(this.grid[i][j], this.snake.segments) !== -1) {
          this.grid[i][j].val = 'S';
        }
        gridStr += this.grid[i][j].val;
      }
      gridStr += '\n';
    }
    return gridStr;
  };

})();
