(function () {
  var Asteroids = this.Asteroids = (this.Asteroids || {});
  // if (Asteroids === undefined) {
  //   window.Asteroids = {};
  // }

  Asteroids.MovingObject = function (pos, vel, radius, color, game) {
    this.pos = pos;
    this.vel = vel;
    this.radius = radius;
    this.color = color;
    this.game = game;
  };

  Asteroids.MovingObject.prototype.draw = function(ctx) {
    ctx.fillStyle = this.color;
    ctx.beginPath();
    ctx.arc(this.pos[0], this.pos[1], this.radius, 0 , Math.PI*2, true);
    // ctx.stroke();
    ctx.fill();
  };

  Asteroids.MovingObject.prototype.move = function() {
    this.pos[0] += this.vel[0];
    this.pos[1] += this.vel[1];
    this.pos = this.game.wrap(this);
  };

  Asteroids.MovingObject.prototype.isCollidedWith = function (otherObject){
    var xDist = this.pos[0] - otherObject.pos[0];
    var yDist = this.pos[1] - otherObject.pos[1];

    var distance = Math.sqrt(xDist * xDist + yDist * yDist);

    if (distance < (this.radius + otherObject.radius)) {
      this.collideWith(otherObject);
      return true;
    } else {
      return false;
    }
  };

  Asteroids.MovingObject.prototype.collideWith = function (otherObject) {
  };

})();
