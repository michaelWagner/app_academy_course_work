(function () {
  var Asteroids = this.Asteroids = (this.Asteroids || {});

  Asteroids.Ship = function (game){
    var w = document.getElementById('game-canvas').width/2;
    var h = document.getElementById('game-canvas').height/2;
    this.pos = [w,h];
    this.vel = [0,0];
    this.radius = 25;
    this.color = 'red';
    this.game = game;
  };

  Asteroids.Util.inherits(Asteroids.Ship, Asteroids.MovingObject);

  Asteroids.Ship.prototype.relocate = function(){
    this.pos = this.game.randomPos();
    this.vel = [0,0];
  };

  Asteroids.Ship.prototype.power = function(impulse){
    this.vel[0] += impulse[0];
    this.vel[1] += impulse[1];
  };

})();
