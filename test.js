const test = "Hello world for test.js"
const amTesting = true
const testNumber = 123.52 // another test comment "right"
let anotherNumber = 0

// test comment
if (amTesting) {
   console.log(test)
   console.log(testNumber) // test comment for number 45
}

const list = [1, 2, 3, 4, 5]

for (let i = 0; i < list.length; i++) {
   console.log(list[i])
}

const obj = {
   name: "test",
   age: 123,
   isTesting: true,
   anotherObj: {
      name: "test2",
      age: 456,
      isTesting: !amTesting,
   },
}
