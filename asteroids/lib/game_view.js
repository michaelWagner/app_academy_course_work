(function () {
  var Asteroids = this.Asteroids = (this.Asteroids || {});


  Asteroids.GameView = function (game, ctx){
    this.game = game;
    this.ctx = ctx;
    this.bindKeyHandlers();
    // this.ctx = document.getElementById('game-canvas').getContext('2d');
  };

  Asteroids.GameView.prototype.start = function() {
    var that = this;
    setInterval(function () {
      that.game.step();
      that.game.draw(that.ctx);
    }, 20);
  };

  Asteroids.GameView.prototype.bindKeyHandlers = function() {
    var that = this;
    key('up',     function(){ that.game.ship.power([ 0,-1]); });
    key('down',   function(){ that.game.ship.power([ 0, 1]); });
    key('left',   function(){ that.game.ship.power([-1, 0]); });
    key('right',  function(){ that.game.ship.power([ 1, 0]); });
  }

})();
