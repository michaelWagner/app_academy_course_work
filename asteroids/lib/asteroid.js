(function () {
  var Asteroids = this.Asteroids = (this.Asteroids || {});

  Asteroids.Asteroid = function (pos, game){
    this.color = 'grey';
    this.radius = 50;
    this.vel = Asteroids.Util.randomVec(5);
    this.pos = pos;
    this.game = game;
  };

  Asteroids.Util.inherits(Asteroids.Asteroid, Asteroids.MovingObject);

  Asteroids.Asteroid.prototype.collideWith = function (otherObject) {
    console.log(typeof otherObject);

    if (otherObject instanceof Asteroids.Ship) {
      otherObject.relocate();
    }
    // this.game.remove(otherObject);
    // this.game.remove(this);
  };
})();
