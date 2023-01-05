import UIKit
import Foundation

//1. Створити enum з можливими рухами: вперед, назад, вправо, вліво. Створити масив елементів enum-а з наступною послідовністю рухів робота: вперед, вперед, вправо, вперед, вліво, назад. Написати цикл і пройтися по всіх елементах enum-a і роздрукувати rawValue значень enum-a. Підказка: щоб роздрукувати rawValue, enum повинен наслідуватися від типу String.

print("Завдання 1\n")

enum Movement : String {
    case вперед
    case назад
    case вправо
    case вліво
            
}
//["вперед","вперед","вправо","вперед","вліво","назад"]

let enum_A : [Movement] = [.вперед,.вперед,.вправо,.вперед,.вліво,.назад]

for move in enum_A {
    switch move {
    case .вперед:
        print("\(move.rawValue)"+"👆")
    case .назад:
        print("\(move.rawValue)"+"👇")
    case .вправо:
        print("\(move.rawValue)"+"👉")
    case .вліво:
        print("\(move.rawValue)"+"👈")
    
    }
}
print("\n")

//2. Розв'язати задачі на англійській мові:

//2а). Your function takes two arguments: current father's age (years) current age of his son (years). Сalculate how many years ago the father was twice as old as his son (or in how many years he will be twice as old).

print("Завдання 2a\n")

// Cтворив тип ExampleError виду enum + associated values для того щоб виводити помилки при перевірці значень в функції
enum ExampleError: Error {
    case invalid(contecst : String)
    case uncorrect(contecst : String)
}


func twiceOlder (sonsOld : Int, fathersOld : Int)throws{
    if sonsOld>fathersOld{
        throw ExampleError.invalid(contecst: "Argument sonsOld cant be bigger that value fathersOld ")
    }else if sonsOld == fathersOld{
        throw ExampleError.uncorrect(contecst: "Arguments cant be equal in this function")
    }
    print("Батьку : \(fathersOld) років , сину : \(sonsOld)")
    if fathersOld/2 >= sonsOld{
        print("Батько буде старший вдвічі за сина через \(abs(fathersOld-sonsOld*2)) років\n")
    }else{
        print("Батько був старший вдвічі за сина \(abs(fathersOld-sonsOld*2)) років тому\n")
        }
}

try twiceOlder(sonsOld: 20, fathersOld: 50)
try twiceOlder(sonsOld: 12, fathersOld: 44)
try twiceOlder(sonsOld: 17, fathersOld: 38)
try twiceOlder(sonsOld: 43, fathersOld: 60)
try twiceOlder(sonsOld: 37, fathersOld: 82)
try twiceOlder(sonsOld: 73, fathersOld: 91)
//перевірив чи спрацьовують помилки
//try twiceOlder(sonsOld: 73, fathersOld: 50)
//try twiceOlder(sonsOld: 73, fathersOld: 73)


//(Написати функцію і виконати її з різними значеннями. Пересвідчитися, що кількість років визначається правильно).


//2b). Create a function that converts US dollars (USD) to Гривні (UAH). The input is the amount of USD as an integer, and the output should be a string that states the amount of UAH followed by 'UAH' .

//For Example: usduah(1) => 26.80 UAH

//The conversion rate you should use is 26.8 UAH for every 1 USD. All numbers should be represented as a string with 2 decimal places. (e.g. "21.00" NOT "21.0" or "21").

print("Завдання 2b\n")
func convertUsdToUah(amount : Int)->String{
    let exchangeUahRate : Double = 26.8
    let usdInUah : Double = Double(amount) * exchangeUahRate
    return "usduah(\(amount)💰) => \(String(format: "%.2f", usdInUah)) UAH🇺🇦"
        //
}

convertUsdToUah(amount: 1000)


//2c). Given a two-dimensional array of integers, return the flattened version of the array with all the integers in the sorted (ascending) order. Example: Given [[3, 2, 1], [4, 6, 5], [], [9, 7, 8]], your function should return [1, 2, 3, 4, 5, 6, 7, 8, 9].
print("Завдання 2с\n")
func twoIntoOneDimensional(array : [[Int]]) -> [Int]{
    var newArray : [Int] = []
    for i in array{
        for j in i{
            newArray.append(j)
        }
    }
    //використав кложуру замість аргументів
    return newArray.sorted { $0 < $1}
        
}

twoIntoOneDimensional(array: [[3, 2, 1], [4, 6, 5], [], [9, 7, 8]])
