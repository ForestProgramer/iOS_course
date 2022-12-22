import Foundation
//використовував тюпелси для виводу операцій взяв також стрінгове значення для 5-го оператора для того шоб використати опціонали
//

let operand1 : Int = 10
let operand2 : Double = 2.9
let operand3 : Float = 5.76
let operand4 : UInt8 = 2
let operand5 : String = "-10"

// MARK : +
print("Операція додавання над різнимим типа")

let addition1 = (result: Double(operand1)+operand2,description : "Додавання int до double")
let addition2 = (result: Float(operand2)+operand3,description : "Додавання double до float")
let addition3 = (result: UInt8(operand3)+operand4,description : "Додавання float до UInt8")
let addition4 = (result: Int16(operand4)+Int16(operand5)!,description : "Додавання Uint8 до Int16")
let addition5 = (result: Int(operand5)!+operand1,description : "Додавання Int16 до int")
// MARK : -
print("Операція віднімання над різнимим типа")

let subsraction1 = (result: Double(operand1)-operand2,description : "Віднімання int від double")
let subsraction2 = (result: Float(operand2)-operand3,description : "Віднімання double від float")
let subsraction3 = (result: UInt8(operand3)-operand4,description : "Віднімання float від UInt8")
let subsraction4 = (result: Int16(operand4)-Int16(operand5)!,description : "Віднімання Uint8 від Int16")
let subsraction5 = (result: Int(operand5)!-operand1,description : "Віднімання Int16 від int")
// MARK : *
print("Операція множення над різнимим типа")

let multiply1 = (result: Double(operand1)*operand2,description : "Множення int до double")
let multiply2 = (result: Float(operand2)*operand3,description : "Множення double до float")
let multiply3 = (result: UInt8(operand3)*operand4,description : "Множення float до UInt8")
let multiply4 = (result: Int16(operand4)*Int16(operand5)!,description : "Множення Uint8 до Int16")
let multiply5 = (result: Int(operand5)!*operand1,description : "Множення Int16 до int")
// MARK : /
print("Операція ділення над різнимим типа")

let division1 = (result: Double(operand1)/operand2,description : "Ділення int до double")
let division2 = (result: Float(operand2)/operand3,description : "Ділення double до float")
let division3 = (result: UInt8(operand3)/operand4,description : "Ділення float до UInt8")
let division4 = (result: Int16(operand4)/Int16(operand5)!,description : "Ділення Uint8 до Int16")
let division5 = (result: Int(operand5)!/operand1,description : "Ділення Int16 до int")
// MARK : %
print("Цілочисельна остача при діленні над цілими видами значеннь")

let ostacha1 = (result: (operand1)%Int(operand2),description : "Остача int до double")
let ostacha2 = (result: Int(operand2)%Int(operand3),description : "Остача double до float")
let ostacha3 = (result: UInt8(operand3)%operand4,description : "Остача float до UInt8")
let ostacha4 = (result: Int16(operand4)%Int16(operand5)!,description : "Остача Uint8 до Int16")
let ostacha5 = (result: Int(operand5)!%operand1,description : "Остача Int16 до int")

print("Виконаня різних математичних функцій")


print("Функція яка шукає мін значення між двома", min(UInt8(operand1), operand4),separator: ", ", terminator: "!")
// MARK : тут вже впадло було кожному то розписувати)
max(Double(operand1), operand2)
round(operand3)
ceil(operand2)
floor(operand3)
trunc(operand2)
abs(Int(operand5)!)
Double(operand1).sign
operand1.signum()
sin(operand2)
cos(operand2)
tan(operand2)
acos(Double(operand1))
atan(operand2)
pow(operand2, 2)
sqrt(operand2)
exp(Double(operand1))
log(operand2)
log10(Double(operand1))
