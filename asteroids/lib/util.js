(function () {
  var Asteroids = this.Asteroids = (this.Asteroids || {});
  // if (Asteroids === undefined) {
  //   window.Asteroids = {};
  // }
  Asteroids.Util = {};

  Asteroids.Util.inherits = function (ChildClass, ParentClass) {
    function Surrogate() {};
    Surrogate.prototype = ParentClass.prototype;
    ChildClass.prototype = new Surrogate();
  };

  Asteroids.Util.randomVec = function (length) {
    var negLength = -1 * length
    var vel = [];
    vel[0] = getRandomArbitrary(length, negLength);
    vel[1] = getRandomArbitrary(length, negLength);
    return vel;
  };

  function getRandomArbitrary(min, max) {
    return Math.floor(Math.random() * (max - min) + min);
  };

})();
