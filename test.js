// Javascript syntax highlighter test file

// This is the test file for the syntax highlighter
// The syntax highlighting pattern is inspired by
// vscode's theme "andromeda"

// This highlighter does not support multiline strings or comments yet

const test = "Hello world for test.js"
const amTesting = true
const testNumber = 123.52
let anotherNumber = 0

// comments should ignore "strings"
if (amTesting) {
   console.log(test)
   console.log(testNumber) // comments should ignore (456) numbers or any token
}

const list = [1, 2, 3, 4, 5]

for (let i = 0; i < list.length; i++) {
   console.log(list[i])
}

const obj = {
   name: "test", // it even highlights the object properties!
   age: 123,
   isTesting: true,
   anotherObj: {
      name: "test2",
      age: 456,
      isTesting: !amTesting,
   },
}

// highlights logical operators
if (obj.test === "test") {
   console.log("I am ever here")
}

console.log(obj.name)
// nested properties are more challenging beacuse of the dot notation
console.log(obj.anotherObj.name)
