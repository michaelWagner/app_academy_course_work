var readline = require('readline');

var reader = readline.createInterface({

  input: process.stdin,
  output: process.stdout
});



var HanoiGame = function() {
  this.stacks = [[3, 2, 1], [], []];
};

HanoiGame.prototype = {
  isWon : function() {
    if (this.stacks[1].length === 3 || this.stacks[2].length === 3) {
      console.log(this.stacks);
      return true;
    }
    return false;
  },
  isValidMove : function(startTowerIdx, endTowerIdx) {
    var startTower = this.stacks[startTowerIdx];
    var endTower = this.stacks[endTowerIdx];
    var lastPosOfStart = startTower.length - 1;
    var lastPosOfEnd = endTower.length - 1;

    if (endTower.length > 0) {
      return startTower[lastPosOfStart] < endTower[lastPosOfEnd];
    }
    return true;
  },
  move : function(startTowerIdx, endTowerIdx) {
    var startTower = this.stacks[startTowerIdx];
    var endTower = this.stacks[endTowerIdx];

    endTower.push(startTower.pop());
  },
  print : function() {
    console.log(JSON.stringify(this.stacks));
  },
  promptMove : function(callback, completionCallback) {
    this.print();
    var that = this;
    reader.question("Where do you want to move from and to?", function(answerArray) {
      var array = answerArray.split(",");
      console.log(array);
      var moveTo = parseInt(array[1]);
      var moveFrom = parseInt(array[0]);

      if (that.isValidMove(moveFrom, moveTo)) {
        callback(moveFrom, moveTo);
      } else {
        console.log("invalid move");
      }
      that.run(completionCallback);
    });
  },
  run : function(completionCallback) {
    if (this.isWon()) {
      completionCallback();
    } else {
      this.promptMove(this.move.bind(this), completionCallback);
    }
  }
};

function endCallback () {
  reader.close();
  console.log("you win");
}

var hGame = new HanoiGame();

hGame.run(endCallback);
