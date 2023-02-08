import UIKit
print("Завдання 1\n")
//1. The company you work for has just been awarded a contract to build a payment gateway. In order to help move things along, you have volunteered to create a function that will take a float and return the amount formatting in dollars and cents. 39.99 becomes $39.99 The rest of your team will make sure that the argument is sanitized before being passed to your function although you will need to account for adding trailing zeros if they are missing (though you won't have to worry about a dangling period).
//
//
//Example:
//3 needs to become $3.00 3.1 needs to become $3.10. Good luck! Your team knows they can count on you!

//Тут я використав звичайну функцію. В параметрі вказав типу варіативного параметру Double.

//Також можна було зробити функцію вищого порядку і засунути її в мап яка б перетворила масив чисел в стрінги з значком долару спереду і двома цифрами після комми

//ЗВИЧАЙНА ФУНКЦІЯ
func dollarFormating (_ amount : Double...)-> [String]{
    
    return amount.map { "$" + String(format: "%.2f", $0)}
}
print("\(dollarFormating(3,3.1,39.50))\n")

//ФУНКЦІЯ ВИЩОГО ПОРЯДКУ

//func dollarFormating2 ()-> (Double)->String{
//
//    { "$" + String(format: "%.2f", $0) }
//}
//let result = [3,3.1,39.50]
//print(result.map(dollarFormating2()))

print("Завдання 2\n")
//2. Given a two-dimensional array of integers, return the flattened version of the array with all the integers in the sorted (ascending) order.
//Example:
//Given [[3, 2, 1], [4, 6, 5], [], [9, 7, 8]], your function should return [1, 2, 3, 4, 5, 6, 7, 8, 9].

func converTwoToOneDimesionalArray (_ array : [[Int]])->[Int]{
    return array.flatMap {$0.sorted()}
}
print("\(converTwoToOneDimesionalArray([[3, 2, 1], [4, 6, 5], [], [9, 7, 8]]))\n")


//ЗАМІТКИ ДО УРОКУ :

//Імперативне програмування


//let numbers = [1,2,3,10,20,100,101,105,200]
//var newNumbers : [Int] = []
//for n in numbers {
//    if n % 2 == 0 {
//        newNumbers.append(n/2)
//    }
//}
//
//newNumbers

//Функціональне програмування
//
//let numbers = [1,2,3,10,20,100,101,105,200]
//let newNumbers = numbers.filter {$0 % 2 == 0 }.map {$0 / 2}
//
//newNumbers

//Рекурсивні функції

//func factorial(_ number: Int)->Int{
//    if number == 0{
//        return 1
//    }else{
//        return number * factorial(number-1)
//    }
//}
//
//func factorial2(_ number: Int)->Int{
//    return number == 0 ? 1 : number * factorial2(number-1)
//}

//Функції вищого порядку

//func divisiible (by numbers: Int...)->(Int)->Bool{
//    return { input -> Bool in
//        return numbers.reduce(true) { divisiible , number in
//            divisiible && input % 2 == 0
//
//        }
//    }
//}
//let items = [6,12,24,13,19,15]
//let result = items.filter(divisiible(by: 2,3,4))

// Функтор - це може бути будь-який тип, який описує те, як функція map застосовується до нього

//let val : String? = "Ivan"  // String?
////
////val.map{$0}
////val.map{type(of: $0)}  //String
//
//func printName(name : String){
//    print(name)
//}
//val.map {printName(name:$0)} // Ivan

//МОНАДА
//let a : String?? = "hello"
//print(a) //Optional(Optional("hello"))
//a?.flatMap{ print($0)} //Optional("hello")

//БОНУС

//func repeatedString(s: String , n : Int) -> Int{
//    Array(repeating: s, count: n).joined().prefix(n).filter { $0 == "a"}.count
//}
//
//repeatedString(s: "asdasd", n: 20) // 7

//HACKERRACNK (SOCKS)

//let arr = [1,2,1,2,1,3,2]
//let n = 7
//func sockMerchant(n: Int, ar: [Int]) -> Int{
//    var pairs = 0
//    ar.reduce(into: [Int]()) { (acc, el)  in
//        acc.append(el)
//        if (acc.filter{ $0 == el}.count % 2) == 0{
////            print(acc.filter{ $0 == el})
//            pairs += 1
//        }
//    }
//    return pairs
//}
//
//sockMerchant(n: n, ar: arr) // 2
