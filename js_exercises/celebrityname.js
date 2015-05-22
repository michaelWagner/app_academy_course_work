function celebrityName (firstName) {
    var nameIntro = "This celebrity is ";
    // this inner function has access to the outer function's variables, including the parameter​
   function lastName (theLastName) {
        return nameIntro + firstName + " " + theLastName;
    }
    return lastName;
}

var mjName = celebrityName("Michael");

console.log(mjName);
console.log(mjName("Jackson"));
console.log(mjName("Watts"));
