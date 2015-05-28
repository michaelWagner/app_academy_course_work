(function () {
  var Asteroids = this.Asteroids = (this.Asteroids || {});

  Asteroids.Ship = function (game) {
    this.vel = [0, 0];
    this.radius = 25;
    this.color = 'red';
    this.game = game;
    this.center_w = this.game.DIM_X / 2;
    this.center_h = this.game.DIM_Y / 2;
    this.pos = [this.center_w, this.center_h];
  };

  Asteroids.Util.inherits(Asteroids.Ship, Asteroids.MovingObject);

  Asteroids.Ship.prototype.relocate = function() {
    this.pos = [this.center_w, this.center_h];
    this.vel = [0, 0];
  };

  Asteroids.Ship.prototype.power = function(impulse) {
    this.vel[0] += impulse[0];
    this.vel[1] += impulse[1];
  };

})();
