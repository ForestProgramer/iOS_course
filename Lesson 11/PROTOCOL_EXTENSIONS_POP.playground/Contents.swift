import UIKit
//1. Розширити клас Date методами:
//
//func isAfter(_ date: Date) -> Bool
//
//func isBefore(_ date: Date) -> Bool
//
//Методи додають можливість порівнювати 2 обєкти дат.
extension Date {
    func isAfter(_ date: Date) -> Bool{
        let result : Bool = self > date ? true : false
        return result
    }
    func isBefore(_ date: Date) -> Bool{
        let result : Bool = self < date ? true : false
        return result
    
    }
}
Date().isAfter(Date().addingTimeInterval(-123456789.0))// Feb 2, 1997, 10:26 AM

Date().isBefore(Date().addingTimeInterval(+123456))//Feb 6 , 2023, 6:41 AM
//2. Розширити клас String методом, який повертатиме скорочений варіант місяця в англ.мові:
//
//func monthsShort() -> String
//
//Приклад: “September” => “Sept”, “May” => “May”, “January” => “Jan”

extension String {
//оскільки є місяці які мають 3 і 4 букви на англійській мові то я добавив перевірку для того щоб вони не обрізались оскільки не бачу сенсу в June вирізати останню букву
    func monthsShort() -> String{
        if self.count > 4{
            return String(self.prefix(3))
        }else{
            return String(self)
        }
        
    }
}

let shortMonth = "November".monthsShort()
let shortMonth2 = "June".monthsShort()
//3. Створити 2 класи: UkrainianStudent, USStudent. USStudent містить властивості name, surname. UkrainianStudent містить name, surname, middleName.
//
//Створити протокол FullNameable, який описує властивість fullname.
//
//Обидва класи повинні пронаслідувати протокол і реалізувати властивість fullname, яка роздруковує через пробіл усі поля класу.
//
//Створити розширення до протоколу і описати у ньому метод whoAmI(), який роздруковує текст: “Я - студент / I am student”.
//
//Викликати в екземплярів класу: UkrainianStudent і USStudent метод whoAmI(), побачити, як працюють розширення до протоколу.

protocol FullNameable {
    var fullname : String {get}
}
extension FullNameable {
    func whoAmI() -> () {
        switch self {
        case is UkrainianStudent: print("Я - студент")
        case is USStudent : print("I am student")
        default:
            print("")
        }
    }
}

class UkrainianStudent : FullNameable {
    let name : String
    let surname : String
    let middleName : String
    var fullname: String
    init(name : String,surname : String, middleName : String) {
        self.name = name
        self.surname = surname
        self.middleName = middleName
        
        fullname = self.name + " " + self.surname + " " + self.middleName
    }
    
    
}


class USStudent : FullNameable {
    let name : String
    let surname : String
    
    let fullname: String
    
    init(name : String,surname : String) {
        self.name = name
        self.surname = surname
        
        fullname = self.name + " " + self.surname
    }
    
    
}



let student1 = USStudent(name: "Jeorge", surname: "Bush")
student1.fullname
student1.whoAmI()
let student2 = UkrainianStudent(name: "Оліярник", surname: "Максим", middleName: "Андрійович")
student2.fullname
student2.whoAmI()



//ПРИКЛАД РОБОТИ ПРОТОКОЛУ
//enum State : Toggleable{
//    case off , on
//
//    mutating func updateState(){
//        switch  self {
//        case .off: self = .on
//        case .on : self = .off
//        }
//    }
//}
//struct Lamp : Toggleable {
//    var state : String
//    mutating func updateState() {
//        state = state == "on" ? "off" : "on"
//    }
//
//
//}
//protocol Toggleable{
//    mutating func updateState()
//}

//ПРОТОКОЛ З ІЦІАЛІЗАТОРАМИ В КЛАССАХ І ФАЙНЛ КЛАССАХ

//protocol SomeProtocol{
//    init(someParametrs : Int)
//}
//
//class Some : SomeProtocol {
//    required init(someParametrs: Int) {
//        print("")
//    }
//}
//
//
//final class SomeClass2 : SomeProtocol {
//    init(someParametrs : Int) {
//
//    }
//}


//ПРОТОКОЛИ ЯК ТИПИ
//protocol HistoryPepresentable{
//
//}
//
//class Cat {
//    let name : String
//    let history : HistoryPepresentable
//
//    init(name : String, history : HistoryPepresentable) {
//        self.name = name
//        self.history = history
//    }
//}


//ДЕЛЕГУВАННЯ

//protocol ManagerDelegate : AnyObject {
//    func howMuchMoneyDidWeMake() -> String
//}
//
//class Manager {
//    weak var delegate : ManagerDelegate?
//    func getReport()->String {
//        return  delegate?.howMuchMoneyDidWeMake() ?? ""
//    }
//}
//
//class Assistant : ManagerDelegate{
//    let repairedCars = 20
//    let priceOfOne = 100
//
//    func howMuchMoneyDidWeMake() -> String {
//        return "Today we get $\(repairedCars * priceOfOne)"
//    }
//}
//
//
//let m = Manager()
//let a = Assistant()
//
//m.delegate = a
//m.getReport()

//EXTENSIONS


//protocol HistoryRepresenatable {
//    var history : String {get }
//}
//
//class Cat {
//    let name : String = ""
//
//}
//
//extension Cat : HistoryRepresenatable {
//    var history: String {
//        return "Here is my story."
//    }
//}

//extension String {
//    func removingNonNumericalChars() -> String{
//        return self.replacingOccurrences(of: "[^0-9]", with: "",options: .regularExpression)
//    }
//}
//
//
//"199 Red Blrd street, 47 apt".removingNonNumericalChars()
//Наслідування протоколів

//protocol TextRepresanteble {
//    var textDescription : String {get}
//}
//
//protocol PrettyTextRepresentable : TextRepresanteble {
//    var prettyTextualDescription : String{get}
//}
//class Document: PrettyTextRepresentable {
//    var prettyTextualDescription : String = "just plain text"
//    var textDescription: String = "Text with pretty formatting"
//}


//Composition Protocols
//protocol MyEncodable{
//    static func code (from String : String)->String
//}
//
//protocol MyDecodable {
//    static func decode (from code : String)->String
//}
//
//
//typealias MyCodable = MyEncodable & MyDecodable
//
//
//class MyBlackBox : MyCodable {
//    static func code(from string: String) -> String {
//        string.map(String.init).reversed().joined()
//    }
//
//    static func decode(from code: String) -> String {
//        code.map(String.init).reversed().joined()
//    }
//}
//
//
//let code = MyBlackBox.code(from: "Ivan")
//
//let original = MyBlackBox.decode(from: "navI")

//Associated types

//protocol Container : AnyObject{
//    associatedtype Item
//
//    func append(_ item: Item)
//    var count : Int {get}
//    subscript(i: Int)-> Item {get}
//}
//
//class IntContainer : Container{
//    private var array : [Int] = []
//
//
//    //Conforming to protocol
//    typealias Item = Int
//
//    func append(_ item: Int) {
//        array.append(item)
//    }
//    var count: Int{
//        array.count
//    }
//    subscript(i: Int)->Int{
//        array[i]
//    }
//}
//let intContainer = IntContainer()
//intContainer.append(9)
//intContainer.count
//intContainer[0]
