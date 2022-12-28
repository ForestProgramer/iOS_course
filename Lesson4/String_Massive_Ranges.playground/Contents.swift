import UIKit

var stringValue = "Hello. This is a homework task."
//1. Надрукувати кількість елементів в рядку.
print("Кількість елементів в рядку : \(stringValue.count)",terminator: ".")
//2. Роздрукувати весь текст великими літерами.
print("Весь текст великими літерами : \(stringValue.uppercased())",terminator: "")
//3. Надрукувати перший елемент рядка.
print("Перший елемент рядка : \(stringValue.first!)",terminator: "")
//4. Замінити “а” на “my” у такий спосіб, щоб зміни відбулися в оригінальному рядку, а не копії. Результат має бути: “Hello. This is my homework task.”
stringValue = stringValue.replacingOccurrences(of: " a ", with: " my ")
print("Замінити “а” на “my” : \(stringValue)",terminator: "")
//5. Видалити останнє слово в рядку двома способами:
//5a. Cтворити константу, яка буде результатом видалення останнього слова.
//Видалив крапку з оригіналу
stringValue.remove(at: stringValue.index(before: stringValue.endIndex))
stringValue
let indexWord  = stringValue.index(stringValue.endIndex, offsetBy: -4)
stringValue[indexWord]
let lastWord = stringValue.suffix(from: indexWord)
print("Видаленя останнього слова №1: \(lastWord)",terminator: "")
//або ще такий спосіб можна використати.
var stringValueArr = stringValue.components(separatedBy:" "  )
stringValueArr.last
//5б. Видалити останнє слово в оригінальному рядку.
print("Оригінал: \(stringValue)",terminator: "")
stringValue.removeSubrange(Range(uncheckedBounds: (indexWord,stringValue.endIndex)))
print("Після методу remove: \(stringValue)",terminator: "")
//6. Використати різні способи конкатенації і до даного рядка додати наступні тексти: ”I study Swift language”, “So far everything goes very smoothly.”, “I like it.”
let stringValue2 = "I study Swift language"
let stringValue3 = "So far everything goes very smoothly"
let stringValue4 = "I like it"
// Конкатенація через звичайий оператор додавання в окремій змінній
var concat1 =  stringValue + stringValue2 + stringValue3 + stringValue4
//Конкатенація через складений поператор
var stringValueConcat = ""
stringValueConcat += stringValue
stringValueConcat += stringValue2
stringValueConcat += stringValue3
stringValueConcat += stringValue4
//Конкатенація через метод append()
stringValueConcat.removeAll()
stringValueConcat.append(stringValue)
stringValueConcat.append(stringValue2)
stringValueConcat.append(stringValue3)
stringValueConcat.append(stringValue4)
//Конкатенація через метод joined()
[stringValue,stringValue2,stringValue3,stringValue4].joined(separator: ". ")

// MARK : Завдання № 2 (Массиви)

//1. Створіть масив fibArray, який буде складатися з перших 10 чисел Фібоначчі.
//Погуглив в неті за фібоначі числа і япочинав ряд не з 0 а з 1
var fibArray : [Int] = []
var fib1 = 1
var fib2 = 1
var fib_sum = 0
let n = 12
var i = 0
fibArray.append(fib1)
fibArray.append(fib2)
while i<n-2 {
    fib_sum = fib1+fib2
    fib1 = fib2
    fib2 = fib_sum
    i = i+1
    fibArray.append(fib2)
}
fibArray
//2. Створіть масив revArray, який буде містити елементи fabArray у зворотному порядку.
let revArray : [Int] = fibArray.reversed()
// 3. Додайте на 3 позицію 11 число Фібоначчі і на 5 позицію - 12 число Фібоначчі.
fibArray[2] = fibArray[10]
fibArray[5] = fibArray[11]
fibArray
//4. Видаліть перший і сьомий індекс масиву в оригінальному масиві.
let sevenIndex = fibArray.remove(at: 6)
let firstIndex = fibArray.remove(at: 0)
fibArray
//5. Посортуйте масив fibArray у порядку спадання.
let spad_Array : [Int] = fibArray.sorted().reversed()
//або найшов ще такий варіант
fibArray.sort(){$0 > $1}
fibArray
//6. Роздрукуйте найбільше і найменше значення масиву.
fibArray.min()
fibArray.max()
//5. Робота з множинами
//1. Створіть множину mySet1 із значеннями: “a”, “b”, “c”, “d”, “e”.
var mySet1 : Set<Character> = ["a", "b" , "c" , "d" , "e"]
//2. Створіть множину mySet2 із значеннями: “c”, “d”.
var mySet2 : Set<Character> = ["c" , "d"]
//3. Додайте у множину mySet2 значення: “z”.
mySet1.insert("z")
mySet1
//4. Роздрукуйте спільні значення для множин mySet1, mySet2
print("Cпільні значення для двох сетів\(mySet1.intersection(mySet2))",terminator: "")
//5. Роздрукувати результат виконання порівняння чи не має mySet2 спільних елементів із mySet1
let result : Bool = mySet1.intersection(mySet2).isEmpty ? true : false
print("Чи НЕ має mySet2 спільних значеннь з mySet1 : \(result)", terminator: "")
//6. Роздрукувати усі значення, що входять в обидві множини.
let allCharacters = mySet1.union(mySet2)
// MARK : 6. Робота з словником.
//1. Створіть словник nDict, де ключами будуть виступати числа від 0 до 10, а значеннями відповідні текстові представлення чисел. Приклад: [1: “one”, 2: “two”].
var nDcit : [Int : String] = [0 : "zero",
                              1 : "one",
                              2: "two",
                              3: "three",
                              4: "four",
                              5: "five",
                              6: "six",
                              7: "seven",
                              8: "eight",
                              9: "nine",
                              10: "ten",]
//2. Виведіть значення для ключа 3.
nDcit[3]
//3. Виведіть значення для ключа з індексом 4.
nDcit[4]
//4. Роздрукувати всі ключі.
nDcit.keys
//5. Додайте нову пару до словника: 11 - “Eleven”.
nDcit[11] = "eleven"
nDcit
//6. Створити константу numbers, яка буде масивом і записати у нього всі значення (values) зі словника nDict.
let numbers = Array(nDcit.values)

// MARK : 7. Робота з діапазоном.
//1. Створити діапазон (range) чисел від 10 до 20 (не включно).
let range = 10..<20
//2. Роздрукувати кількість елементів цього діапазону
range.count
//3. Перевірити (за допомогою оператора “~=”) чи входить 20 до цього діапазону.
let hasTwenty = range ~= 20
