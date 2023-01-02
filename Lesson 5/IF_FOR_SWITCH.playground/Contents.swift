import UIKit

// MARK : 1. Створити масив String names із 10 елементів, де кожен елемент ім'я вашого знайомого. Роздрукувати кількість знайомих, в яких ім'я починається з літери “А” або “П”. Вивести найдовше і найкоротше ім'я. Створити новий масив namesWithIndex, який би додавав до кожного з імен через дефіс його порядковий номер, починаючи з 1 (Приклад: “Aндрій-1”, “Петро-2”...). Підказка: скористайтесь методом enumerated().

//Створити масив String names із 10 елементів, де кожен елемент ім'я вашого знайомого. Роздрукувати кількість знайомих, в яких ім'я починається з літери “А” або “П”.
let arrayStringNames : [String] = ["Ігор","Ростік","Микола","Артур","Денис","Віталік","Андрій","Назар","Тарас","Роман"]

print("Кількість відфільтрованих значень : \(arrayStringNames.filter{ $0.first == "А" || $0.first == "П"}.count)")
//Вивести найдовше і найкоротше ім'я.
var maxLenghtName = arrayStringNames[0].count
var minLenghtName = arrayStringNames[0].count
var indMax = 0
var indMin = 0
for (indx,el) in arrayStringNames.enumerated(){
    if (el.count > maxLenghtName){
        maxLenghtName = el.count
        indMax = indx
    }
    else if(el.count < minLenghtName){
        minLenghtName = el.count
        indMin = indx
    }
}
print("Найменше ім'я - \(arrayStringNames[indMin]) : \(minLenghtName) букв" ,terminator: " .")
print("Найбільше ім'я - \(arrayStringNames[indMax]) : \(maxLenghtName) букви", terminator: " .\n")

//Створити новий масив namesWithIndex, який би додавав до кожного з імен через дефіс його порядковий номер, починаючи з 1 (Приклад: “Aндрій-1”, “Петро-2”...). Підказка: скористайтесь методом enumerated().
var namesWithIndex : [String] = []

for (index,el) in arrayStringNames.enumerated(){
    namesWithIndex.append(el+"-"+String(index))
}
namesWithIndex.forEach{ el in print("\(el)\n")}

//MARK : 2. Створити масив Int з числами: 10, 22, 50, 99, 101, -6, 12, 100, 1001, 12, 15, -10, 0, -101, 15. За допомогою циклу пройтися по всіх елементах масиву і вибрати числа, які знаходяться в діапазонах: 1..<100, 101..<1000 і -100..<0 (використати switch). Після чого ці масиви об'єднати (зробити конкатенацію) в 1 масив.

//2. Створити масив Int з числами: 10, 22, 50, 99, 101, -6, 12, 100, 1001, 12, 15, -10, 0, -101, 15.
let listOfNumbers = [10 , 22, 50, 99, 101, -6, 12, 100, 1001, 12, 15, -10, 0, -101, 15]
//За допомогою циклу пройтися по всіх елементах масиву і вибрати числа, які знаходяться в діапазонах: 1..<100, 101..<1000 і -100..<0 (використати switch).
var oneToHunderd : [Int] = []
var hundredOneToThousand : [Int] = []
var minusHundredToNull : [Int] = []
var extraNumbers : [Int] = []
var rightMassive : [Int] = []

for el in listOfNumbers {
    switch el {
    case 1..<100:
        oneToHunderd.append(el)
    case 101..<1000:
        hundredOneToThousand.append(el)
    case -100..<0:
        minusHundredToNull.append(el)
    default:
        extraNumbers.append(el)
    }
}
//Після чого ці масиви об'єднати (зробити конкатенацію) в 1 масив.
rightMassive = oneToHunderd + hundredOneToThousand + minusHundredToNull
print("Значенння які не підйшли ні до одної умови \(extraNumbers)")

//ПЕРЕВІРКА ЗАВДАНЬ З МЕТОДИЧКИ ЯКІ БУЛИ В ЛЕКЦІЇ

// MARK : Pattern Matching
//let somePoint = (2,3)
//switch somePoint {
//case (0,0):
//    print("Точка 0,0 лежить в початку координат")
//case (_,0):
//    print("Точка \(somePoint.0),0 лежить на осі x-ів")
//case (0,_):
//    print("Точка 0,\(somePoint.1) лежить на осі y-ів")
//case (-2...2,-2...2):
//    print("Точка \(somePoint.0),\(somePoint.1) лежить всередині квадрату")
//default:
//    print("Точка \(somePoint.0),\(somePoint.1) лежить за межами квадрату")
//}


//MARK : Value Bindings
//let somePoint = (2,3)
//switch somePoint {
//case (0,0):
//    print("Точка 0,0 лежить в початку координат")
//case (_,0):
//    print("Точка \(somePoint.0),0 лежить на осі x-ів")
//case (0,_):
//    print("Точка 0,\(somePoint.1) лежить на осі y-ів")
//case (let x , let y):
//    if (-2...2)~=x && (-2...2)~=y{
//        print("Точка \(somePoint.0),\(somePoint.1) лежить всередині квадрату")
//
//    }
//    else{
//        print("Точка \(x),\(y) лежить за межами квадрату")
//    }
//
//}

//MARK : Operator Where

//let somePoint = (2,3)
//switch somePoint {
//case (0,0):
//    print("Точка 0,0 лежить в початку координат")
//case (_,0):
//    print("Точка \(somePoint.0),0 лежить на осі x-ів")
//case (0,_):
//    print("Точка 0,\(somePoint.1) лежить на осі y-ів")
//case (let x , let y) where(-2...2)~=x && (-2...2)~=y:
//        print("Точка \(somePoint.0),\(somePoint.1) лежить всередині квадрату")
//default:
//    print("Точка \(somePoint.0),\(somePoint.1) лежить за межами квадрату")
//
//}

//MARK : Fallthrough operator

//let intergerToDescribe = 5
//var description = "Число \(intergerToDescribe) є"
//switch intergerToDescribe {
//case 2,3,5,7,11,13,17,19:
//    description += " простим числом"
//    fallthrough
//default:
//    description += " і також цілим"
//}


//MARK : Guard

//func greet(name:String?){
//    guard let name = name else {return}
//    print("Вітаємо,\(name)")
//}
//
//greet(name: "Дєд")
//greet(name: nil)


//MARK : Trow
//
//func login(password:String)throws->Bool{
//    if password == "1111"{
//        return true
//    }else{
//        throw NSError(domain: "wrong password", code: 0, userInfo: nil)
//    }
//}
//try login(password: "1111")
//try login(password: "2222")
