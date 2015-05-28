(function () {
  var Asteroids = this.Asteroids = (this.Asteroids || {});

  // if (Asteroids === undefined) {
  //   window.Asteroids = {};
  // }

  Asteroids.Game = function() {
    // probably get these values from the html canvas tag.
    this.DIM_X = document.getElementById("game-canvas").width;
    this.DIM_Y = document.getElementById("game-canvas").height;
    // this.DIM_X = 1400;
    // this.DIM_Y = 900;
    this.NUM_ASTEROIDS = 10;
    this.asteroids = [];
    this.addAsteroids();
    this.ship = new Asteroids.Ship (this);
  };

  Asteroids.Game.prototype.addAsteroids = function() {
    for (var i = 0; i < this.NUM_ASTEROIDS; i++ ) {
      this.asteroids.push(new Asteroids.Asteroid(this.randomPos(), this));
    }
  };

  Asteroids.Game.prototype.randomPos = function() {
    var pos = [];
    pos[0] = Math.floor((Math.random() * this.DIM_X) + 1);
    pos[1] = Math.floor((Math.random() * this.DIM_Y) + 1);
    return pos;
  };

  Asteroids.Game.prototype.moveObjects = function() {
    for (var i = 0; i < this.allObjects().length; i++) {
      this.allObjects()[i].move();
    }
  };

  Asteroids.Game.prototype.draw = function(ctx) {
    ctx.clearRect(0, 0, this.DIM_X, this.DIM_Y);
    for (var i = 0; i < this.allObjects().length; i++){
      this.allObjects()[i].draw(ctx);
    }
  };

  Asteroids.Game.prototype.wrap = function(movingObj) {
    var newPos = movingObj.pos;
    if (movingObj.pos[0] < (0 - movingObj.radius) ) {
      newPos[0] = movingObj.pos[0] + (this.DIM_X + movingObj.radius);
    }
    if (movingObj.pos[0] > (this.DIM_X + movingObj.radius)) {
      newPos[0] = movingObj.pos[0] - (this.DIM_X + movingObj.radius);
    }
    if (movingObj.pos[1] < (0 - movingObj.radius)) {
      newPos[1] = movingObj.pos[1] + (this.DIM_Y + movingObj.radius);
    }
    if (movingObj.pos[1] > (this.DIM_Y + movingObj.radius)) {
      newPos[1] = movingObj.pos[1] - (this.DIM_Y + movingObj.radius);
    }

    return newPos;
  };

  Asteroids.Game.prototype.checkCollisions = function() {
    for (var i = 0; i < this.allObjects().length; i++) {
      for (var j = i + 1; j < this.allObjects().length; j++) {
        if (this.allObjects()[i].isCollidedWith(this.allObjects()[j]) === true) {
          // console.log("COLLISION");
        }
      }
    }
  };

  Asteroids.Game.prototype.step = function() {
    var ctx = document.getElementById('game-canvas').getContext('2d');
    this.moveObjects();
    this.checkCollisions();
  };

  Asteroids.Game.prototype.remove = function(asteroid) {
    var idx = this.allObjects().indexOf((asteroid));
    this.allObjects().splice(idx, 1);
  };

  Asteroids.Game.prototype.allObjects = function() {
    return this.asteroids.concat(this.ship);
  };
})();
