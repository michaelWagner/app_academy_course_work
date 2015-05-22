Function.prototype.myBind = function(context) {
  var fn = this;
  return function() {
    fn.call(context);
  };

};


var obj = {
  name: "Earl Watts"
};

var greet = function(msg1, msg2) {
  console.log(msg1 + ": " + this.name);
  console.log(msg2 + ": " + this.name);
}

var name = obj.name;
console.log(greet.call(obj, "hello", "goodbye"));
// console.log(mod.getX()); // 81
//
// var getX = mod.getX;
// console.log("not bound ", getX()); // 9, because in this case, "this" refers to the global object
//
// // Create a new function with 'this' bound to mod
// var boundGetX = getX.myBind(mod);
// console.log("bound ", boundGetX()); // 81
