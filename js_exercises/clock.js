function Clock () {

}

Clock.TICK = 5000;

Clock.prototype.run = function () {
  that = this;
  that.currentTime = new Date();
  setInterval(function () {
    that.printTime();
    that._tick();
  }, Clock.TICK);
};

Clock.prototype.printTime = function () {
  console.log("" + that.currentTime.getHours() + ":" +
              that.currentTime.getMinutes() + ":" + that.currentTime.getSeconds());
};

Clock.prototype._tick = function () {
  that.currentTime.setMilliseconds(Clock.TICK);
};

// var clock = new Clock();
// clock.run();
