// Example file for standard js excerises

// Ejercicios de JavaScript
// Rodrigo Núñez Magallanes (nones)
// Alejandro Arouesty (pares)

// 2023-03-12

console.log(
   "\nEjercicios de JavaScript\nRodrigo Núñez Magallanes (nones)\nAlejandro Arouesty (pares)\n2023-03-12\n"
)
// 1. Escribe una función que encuentre el primer carácter de un cadena de texto que no se repite.
// Prueba tu función con: 'abacddbec'
function getFirstUniqueCharacter(string) {
   for (index in string) {
      const char = string[index]
      const restOfString = string.slice(string.indexOf(char) + 1)
      if (restOfString.includes(char)) {
         continue
      } else {
         return char
      }
   }
   return "Ningún crácter es único en la cadena."
}
console.log(
   "1. Encontrar el primer carácter de una cadena que no se repite:\n Cadena: 'abacddbec'\n"
)
console.log(
   `El primer carácter que no se repite es ${getFirstUniqueCharacter(
      "abacddbec"
   )}\n\n`
)
// 2. Escribe una función que implemente el algoritmo 'bubble-sort' para ordenar una lista de números.
function bblSort(arr) {
   for (let i = 0; i < arr.length; i++) {
      for (let j = 0; j < arr.length - i - 1; j++) {
         if (arr[j] > arr[j + 1]) {
            let temp = arr[j]
            arr[j] = arr[j + 1]
            arr[j + 1] = temp
         }
      }
   }

   console.log("Ejercicio 2: ")
   console.log(arr + "\n\n")
}
let arr = [2, 32, 100, 1, 4, 8, 7, 87]
bblSort(arr)
// 3. Escribe dos funciones: la primera que invierta un arreglo de números y regrese un nuevo arreglo con el resultado;
function newReversedArray(array) {
   const newArray = []
   for (let i = array.length - 1; i >= 0; i--) {
      newArray.push(array[i])
   }
   return newArray
}
console.log(
   "3a. Invertir el orden de un arreglo devolviendo uno nuevo: \n Arreglo inicial: [5,6,7]\n"
)
console.log(`Resultado: [${newReversedArray([5, 6, 7])}]\n\n`)
// 3. la segunda que modifique el mismo arreglo que se pasa como argumento. No se permite usar la función integrada 'reverse'.
function reverseArray(array) {
   let maxIndex = array.length - 1
   let index = 0
   while (maxIndex > index) {
      const leftValue = array[index]
      const rightValue = array[maxIndex]
      array[index] = rightValue
      array[maxIndex] = leftValue
      maxIndex--
      index++
   }
   return array
}
console.log(
   "3b. Invertir el orden de un arreglo modificando el que se pasa como argumento: \n Arreglo inicial: [5,6,7,5,6,10]\n"
)
console.log(`Resultado: [${newReversedArray([5, 6, 7, 5, 6, 10])}]\n\n`)
// 4. Escribe una función que reciba una cadena de texto y regrese una nueva con la primer letra de cada palabra en mayúscula.
function newString(str) {
   let words = str.split(" ")
   for (let i = 0; i < words.length; i++) {
      words[i] = words[i][0].toUpperCase() + words[i].substr(1)
   }
   return words.join(" ")
}
console.log("Ejercicio 4:")
console.log(newString("esto es una prueba") + "\n\n")
// 5.Escribe una función que calcule el máximo común divisor de dos números.
function getGreatestCommonDivisor(a, b) {
   const larger = a > b ? a : b
   const smaller = larger === a ? b : a
   let divisor = smaller
   while (larger % divisor !== 0 || smaller % divisor !== 0) {
      divisor = divisor - 1
   }
   return divisor
}
console.log(
   "5. Obtener el máximo común divisor de dos números: \n Número a: 21, Número b: 15\n"
)
console.log(`Máximo común divisor: ${getGreatestCommonDivisor(21, 15)}\n\n`)
// 6. Crea una función que cambie una cadena de texto a 'Hacker Speak'. Por ejemplo, para la cadena
// 'Javascript es divertido', su hacker speak es: 'J4v45c1pt 35 d1v3rt1d0'.
function changeLetters(str) {
   let alphabets = {
      a: "4",
      b: "8",
      e: "3",
      g: "6",
      i: "1",
      o: "0",
      p: "9",
      s: "5",
      t: "7",
      z: "2",
   }
   let newStr = ""
   for (let i = 0; i < str.length; i++) {
      if (alphabets[str[i].toLowerCase()]) {
         newStr += alphabets[str[i].toLowerCase()]
      } else {
         newStr += str[i]
      }
   }
   return newStr
}
console.log("Ejercicio 6")
console.log(changeLetters("Javascript es divertido") + "\n\n")
// 7. Escribe una función que reciba un número, y regrese una lista con todos sus factores.
// Por ejemplo: factoriza(12) -> [1, 2, 3, 4, 6, 12].
function factorize(number) {
   let acc = 2
   const factors = [1]
   while (acc <= number) {
      if (number % acc === 0) {
         factors.push(acc)
      }
      acc++
   }
   return factors
}
console.log("7. Obtener todos los factores de un número: \n Número: 28\n")
console.log(`Factores: [${factorize(28)}]\n\n`)
// 8. Escribe una función que quite los elementos duplicados de un arreglo y regrese una lista con los elementos que quedan.
// Por ejemplo: quitaDuplicados([1, 0, 1, 1, 0, 0]) -> [1, 0]
function quitaDuplicados(arr) {
   let sinDuplicados = []
   let objAux = {}
   for (let i = 0; i < arr.length; i++) {
      if (!(arr[i] in objAux)) {
         sinDuplicados.push(arr[i])
         objAux[arr[i]] = true
      }
   }
   return sinDuplicados
}
console.log("Ejercicio 8:")
console.log(quitaDuplicados([1, 0, 1, 0, 10, 10, 0, 1]) + "\n\n")
// 9. Escribe una función que reciba como parámetro una lista de cadenas de texto,
// y regrese la longitud de la cadena más corta.
function getShortestStringLength(strings) {
   let shortest = strings[0]
   for (index in strings) {
      const string = strings[index]
      if (string.length < shortest.length) {
         shortest = string
      }
   }
   return shortest.length
}
console.log(
   "9. Obtener la longitud de la cadena más corta de una lista de cadenas: \n Lista: ['vaya', 'que', 'no', 'puedo']\n"
)
console.log(
   `Longitud de la cadena más corta: ${getShortestStringLength([
      "vaya",
      "que",
      "no",
      "puedo",
   ])}\n\n`
)
// 10. Escribe una función que revise si una cadena de texto es un palíndromo o no.
function esPalindromo(str) {
   // Convertir la cadena a minúsculas y eliminar los espacios en blanco
   str = str.toLowerCase().replace(/\s/g, "")
   // Revertir la cadena y compararla con la original
   return str === str.split("").reverse().join("")
}

console.log("Ejercicio 10:")
console.log(esPalindromo("anita lava la tina") + "\n\n")

// 11. Escribe una función que tome una lista de cadena de textos y devuelva una nueva
// lista con todas las cadenas en orden alfabético.
function getAlphabetizedStrings(strings) {
   const orderedStrings = []
   for (index in strings) {
      const string = strings[index]
      orderedStrings.push(string.split("").sort().join(""))
   }
   return orderedStrings
}
console.log(
   "11. Devolver una lista con las cadenas de texto en orden alfabético: \n Lista: ['vaya', 'que', 'no', 'puedo']\n"
)
console.log(
   `Resultado: [${getAlphabetizedStrings(["vaya", "que", "no", "puedo"])}]\n\n`
)
// 12. Escribe una función que tome una lista de números y devuelva la mediana y la moda.
function mediana_y_moda(lista) {
   const n = lista.length
   lista.sort((a, b) => a - b)

   // Calculando la mediana
   let mediana
   if (n % 2 === 0) {
      mediana = (lista[n / 2 - 1] + lista[n / 2]) / 2
   } else {
      mediana = lista[(n - 1) / 2]
   }

   // Calculando la moda
   const counter = {}
   let moda
   let maxFrecuencia = 0
   lista.forEach(num => {
      if (counter[num]) {
         counter[num]++
      } else {
         counter[num] = 1
      }

      if (counter[num] > maxFrecuencia) {
         maxFrecuencia = counter[num]
         moda = num
      }
   })

   return {mediana, moda}
}

console.log("Ejercicio 12:")
console.log(mediana_y_moda([10, 20, 30, 40, 50]) + "\n\n")

// 13. Escribe una función que tome una lista de cadenas de texto y devuelva la cadena más frecuente.
function getMostFrequentString(strings) {
   let mostFrequent = strings[0]
   let mostFrequentCount = 0
   for (index in strings) {
      const string = strings[index]
      let count = 0
      for (index in strings) {
         if (strings[index] === string) {
            count++
         }
      }
      if (count > mostFrequentCount) {
         mostFrequent = string
         mostFrequentCount = count
      }
   }
   return mostFrequent
}
console.log(
   "13. Encontrar la cadena con mayor cantidad de ocurrencias en un arreglo: \n Lista: ['vaya', 'que', 'no', 'vaya','que', 'puedo', 'vaya', 'no', 'que', 'que']\n"
)
console.log(
   `Resultado: ${getMostFrequentString([
      "vaya",
      "que",
      "no",
      "vaya",
      "que",
      "puedo",
      "vaya",
      "no",
      "que",
      "que",
   ])}\n\n`
)
// 14. Escribe una función que tome un número y devuelva verdadero si es una potencia de dos, falso de lo contrario.
function esPotenciaDeDos(num) {
   if (num < 1) {
      return false
   }
   while (num > 1) {
      if (num % 2 !== 0) {
         return false
      }
      num = num / 2
   }
   return true
}

console.log("Ejercicio 14:")
console.log(esPotenciaDeDos(16) + "\n\n")

// 15. Escribe una función que tome una lista de números y devuelva
// una nueva lista con todos los números en orden descendente.
function getDescendingArray(numbers) {
   const newArray = []
   while (numbers.length > 0) {
      let greatest = numbers[0]
      for (index in numbers) {
         const number = numbers[index]
         if (number > greatest) {
            greatest = number
         }
      }
      newArray.push(greatest)
      numbers.splice(numbers.indexOf(greatest), 1)
   }
   return newArray
}
console.log(
   "15. Devolver los números de una lista en orden descendiente: \n Arreglo inicial: [5,6,7,5,6,10]\n"
)
console.log(`Resultado: ${getDescendingArray([5, 6, 7, 5, 6, 10])}\n\n`)
