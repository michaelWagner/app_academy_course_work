(function() {
  if (typeof WhipSnake === "undefined") {
    window.WhipSnake = {};
  }

  var View = WhipSnake.View = function ($el) {
    this.$el = $el;
    this.board = new WhipSnake.Board();
    this.bindKeys();

    var that = this;
    setInterval(function () {
      that.step();
    }, 500);
  };

  View.prototype.bindKeys= function () {
    var that = this;

    this.$el.on('keydown', function handleKeyEvent(event) {
      switch (event.keyCode) {
        case 38:
          that.board.snake.turn("N");
          break;
        case 39:
          that.board.snake.turn("E");
          break;
        case 40:
          that.board.snake.turn("S");
          break;
        case 37:
          that.board.snake.turn("W");
          break;
      }
    });
  };

  View.prototype.step = function () {
    this.board.snake.move();
    this.$el.empty();
    console.log(this.board.render());
    this.$el.append($('<pre>').text(this.board.render()));

  };


})();
