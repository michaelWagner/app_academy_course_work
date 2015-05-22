var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers(sum, numsLeft, completionCallback) {
  if (numsLeft === 0) {
    completionCallback(sum);
  } else {
    reader.question("Enter a number: ", function(num) {
      num = parseInt(num);
      sum += num;
      console.log(sum);
      addNumbers(sum, numsLeft - 1, completionCallback);
    });
  }
}


addNumbers(0, 3, function (sum) {
  console.log("Total Sum: " + sum);
});
