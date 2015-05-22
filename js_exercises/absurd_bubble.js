var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


function askIfGreaterThan(el1, el2, callback) {
  reader.question("Is " + el1 + " greater than " + el2 + "?: ", function(answer) {
    if (answer === "yes") {
      callback(true);
    } else {
      callback(false);
    }
  });
}

function innerBubbleSortLoop (arr, i, madeAnySwaps, outerBubbleSortLoop) {
  // Do an "async loop":
  // 1. If (i == arr.length - 1), call outerBubbleSortLoop, letting it
  //    know whether any swap was made.
  // 2. Else, use `askIfGreaterThan` to compare `arr[i]` and `arr[i +
  //    1]`. Swap if necessary. Call `innerBubbleSortLoop` again to
  //    continue the inner loop. You'll want to increment i for the
  //    next call, and possibly switch madeAnySwaps if you did swap.
  if (i === arr.length - 1) {
    outerBubbleSortLoop(madeAnySwaps);
  } else {
    askIfGreaterThan(arr[i], arr[i+1], function(answer) {
      madeAnySwaps = answer;
      if (madeAnySwaps) {
        var temp = arr[i];
        arr[i] = arr[i+1];
        arr[i+1] = temp;
      }
      innerBubbleSortLoop(arr, i+1, madeAnySwaps, outerBubbleSortLoop);
    });
  }
}

function absurdBubbleSort (arr, sortCompletionCallback) {
  function outerBubbleSortLoop (madeAnySwaps) {
    // Begin an inner loop if `madeAnySwaps` is true, else call
    // `sortCompletionCallback`.
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, madeAnySwaps, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }

  }
  // Kick the first outer loop off, starting `madeAnySwaps` as true.
  outerBubbleSortLoop(true);
}

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  console.log(arr);
  reader.close();
});

//
// function absurdBubbleSort (arr, sortCompletionCallback) {
//   function askIfGreaterThan(el1, el2, callback) {
//     reader.question("Is " + el1 + " greater than " + el2 + "?: ", function(answer) {
//       if (answer === "yes") {
//         callback(true);
//       } else {
//         callback(false);
//       }
//     });
//   }
//
//   function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
//     askIfGreaterThan(arr[i], arr[i+1], function (isGreaterThan) {
//       if (isGreaterThan) {
//         var temp = arr[i];
//         arr[i] = arr[i+1];
//         arr[i+1] = temp;
//         madeAnySwaps = true;
//       }
//       innerBubbleSortLoop(arr, i + 1, madeAnySwaps, function() {
//         if (i === (arr.length - 1)) {
//           outerBubbleSortLoop(madeAnySwaps);
//         }
//       });
//     });
//   }
// }

// var callback = function (array) {console.log("works with " + array);};
//
// absurdBubbleSort([1,2,3], callback);
