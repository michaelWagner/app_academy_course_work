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
    if (this.stacks[1].length === 3 | this.stacks[2] === 3) {
      return true;
    }
    return false;
  },
  isValidMove : function(startTowerIdx, endTowerIdx) {
    var startTower = this.stacks[startTowerIdx];
    var endTower = this.stacks[endTowerIdx];
    var lastPosOfStart = startTower[startTower.length - 1];
    var lastPosOfEnd = endTower[endTower.length - 1];

    return startTower[lastPosOfStart] < endTower[lastPosOfEnd];
  },
  move : function(startTowerIdx, endTowerIdx) {
    var startTower = this.stacks[startTowerIdx];
    var endTower = this.stacks[endTowerIdx];

    if (this.isValidMove(startTowerIdx, endTowerIdx)) {
      endTower.push(startTower.pop());
    }
  },
  print : function() {
    console.log(JSON.stringify(this.stacks));
  },
  promptMove : function(callback) {
    this.print();
    reader.question("Where do you want to move from and to?", function(answerArray) {
      console.log(answerArray);
      var moveTo = answerArray[1];
      var moveFrom = answerArray[0];
      callback(moveTo, moveFrom);
    });
  },
  run : function(completionCallback) {
    this.promptMove(function(moveTo, moveFrom) {
      if (this.isValidMove(moveTo, moveFrom)) {
        this.move(moveTo, moveFrom);
      } else if (!this.isWon) {
        console.log("Bad move!");
        this.run(completionCallback);
      } else {
        console.log("You won!!");
        completionCallback();
      }
    });
  }
};


var hGame = new HanoiGame();

hGame.run(reader.close());
