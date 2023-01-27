import UIKit
import Foundation

//створив базовий класс

public class Transport {
// в ньому додав статичнв властивості хоч по завданню їх і не треба було
    
//масив кортежів для збереження інформації про наші транспорти
    fileprivate static var arrayOfTime : [(hours : Int,minutes : Int , transportType : String)] = []
//і масив місткості кожного транспорту з якого хгодом вирахуємо загальну кількість
    fileprivate static var arrayOfCapacity : [Double] = []
// і геттер для виведення масиву
    public func showArray ()->() {
        return print(Transport.arrayOfTime)
    }
}

//створив саб-класи Avia UnderGround Ground Water в них є поля тип, місткість і середня швидкість і метод transportTo які ми реалізуєм в саб-саб-класах
class Avia : Transport {
    var type : String
    var capacity : Double
    var avarage_Speed : Double
//оверайднуто ініціалізатор батьківського класу для задання значень полям і перевизначення їх значень в саб-саб-классах щоб не виникало помилки по stored property
    override init() {
        type = ""
        capacity = 0
        avarage_Speed = 0
        super.init()
    }

    func transportTo () ->(){
        return print("")
    }
}

class UnderGround : Transport {
    var type : String
    var capacity : Double
    var avarage_Speed : Double
    override init() {
        type = ""
        capacity = 0
        avarage_Speed = 0
        super.init()
    }
    
    func transportTo () ->(){
        return print("")
    }

}

class Ground : Transport {
    var type : String
    var capacity : Double
    var avarage_Speed : Double
    override init() {
        type = ""
        capacity = 0
        avarage_Speed = 0
        super.init()
    }
    
    func transportTo () ->(){
        return print("")
    }
    
}

class Water : Transport {
    var type : String
    var capacity : Double
    var avarage_Speed : Double
    override init() {
        type = ""
        capacity = 0
        avarage_Speed = 0
        super.init()
    }
    
    func transportTo () ->(){
        return print("")
    }

}
//далі йдуть наші саб-саб-класи і реалізації подій і методів з наших сабкласів
class Plane : Avia {

    override init() {
        super.init()
        type = "літак"
        capacity = 452
        avarage_Speed = 902
    }
    override func transportTo()->() {
        let timeToTransport : Double = (500 / avarage_Speed)*2
        let counter : Int = Int(ceil(1000/capacity))
        let minutes : Int = Int(timeToTransport * Double(counter)*60) % 60
        let hour : Int = Int(floor(timeToTransport * Double(counter)))
        Transport.arrayOfCapacity.append(capacity)
        Transport.arrayOfTime.append((hours : hour , minutes : minutes, transportType : type ))
        return print("\(type) перевезе 1000 людей за \(hour) годин \(minutes) хвилин на відстань 500 км\n")
    }
}

class Helicopter : Avia {
    
    override init() {
        super.init()
        type = "гелікоптер"
        capacity = 4
        avarage_Speed = 200
    }
    override func transportTo()->() {
        let timeToTransport : Double = (500 / avarage_Speed)*2
        let counter : Int = Int(ceil(1000/capacity))
        let minutes : Int = Int(timeToTransport * Double(counter)*60) % 60
        let hour : Int = Int(floor(timeToTransport * Double(counter)))
        Transport.arrayOfCapacity.append(capacity)
        Transport.arrayOfTime.append((hours : hour , minutes : minutes, transportType : type))
        return print("\(type) перевезе 1000 людей за \(hour) годин \(minutes) хвилин на відстань 500 км\n")
    }
}


class Car : Ground {

    override init() {
        super.init()
        type = "автомобіль"
        capacity = 5
        avarage_Speed = 200
    }
    override func transportTo()->() {
        let timeToTransport : Double = (500 / avarage_Speed)*2
        let counter : Int = Int(ceil(1000/capacity))
        let minutes : Int = Int(timeToTransport * Double(counter)*60) % 60
        let hour : Int = Int(floor(timeToTransport * Double(counter)))
        Transport.arrayOfCapacity.append(capacity)
        Transport.arrayOfTime.append((hours : hour , minutes : minutes, transportType : type))
        return  print("\(type) перевезе 1000 людей за \(hour) годин \(minutes) хвилин на відстань 500 км\n")
    }
}

class Bus : Ground {

    override init() {
        super.init()
        type = "автобус"
        capacity = 30
        avarage_Speed = 150
    }
    override func transportTo()->() {
        let timeToTransport : Double = (500 / avarage_Speed) * 2
        let counter : Int = Int(ceil(1000/capacity))
        let minutes : Int = Int(timeToTransport * Double(counter)*60) % 60
        let hour : Int = Int(floor(timeToTransport * Double(counter)))
        Transport.arrayOfCapacity.append(capacity)
        Transport.arrayOfTime.append((hours : hour , minutes : minutes, transportType : type))
        return print("\(type) перевезе 1000 людей за \(hour) годин \(minutes) хвилин на відстань 500 км\n")
    }
}

class Train : Ground {

    override init() {
        super.init()
        type = "поїзд"
        capacity = 250
        avarage_Speed = 243
    }
    override func transportTo()->() {
        let timeToTransport : Double = (500 / avarage_Speed) * 2
        let counter : Int = Int(ceil(1000/capacity))
        let minutes : Int = Int(timeToTransport * Double(counter)*60) % 60
        let hour : Int = Int(floor(timeToTransport * Double(counter)))
        Transport.arrayOfCapacity.append(capacity)
        Transport.arrayOfTime.append((hours : hour , minutes : minutes, transportType : type))
        return print("\(type) перевезе 1000 людей за \(hour) годин \(minutes) хвилин на відстань 500 км\n")
    }
}

class Ship : Water {

    override init() {
        super.init()
        type = "корабель"
        capacity = 5000
        avarage_Speed = 60
    }
    override func transportTo()->() {
        let timeToTransport : Double = (500 / avarage_Speed) * 2
        let counter : Int = Int(ceil(1000/capacity))
        let minutes : Int = Int(timeToTransport * Double(counter)*60) % 60
        let hour : Int = Int(floor(timeToTransport * Double(counter)))
        Transport.arrayOfCapacity.append(capacity)
        Transport.arrayOfTime.append((hours : hour , minutes : minutes, transportType : type))
        return print("\(type) перевезе 1000 людей за \(hour) годин \(minutes) хвилин на відстань 500 км\n")
    }
}

class Metro : UnderGround {
    
    override init() {
        super.init()
        type = "метро"
        capacity = 350
        avarage_Speed = 80
    }
    override func transportTo()->() {
        let timeToTransport : Double = (500 / avarage_Speed) * 2
        let counter : Int = Int(ceil(1000/capacity))
        let minutes : Int = Int(timeToTransport * Double(counter)*60) % 60
        let hour : Int = Int(floor(timeToTransport * Double(counter)))
        Transport.arrayOfCapacity.append(capacity)
        Transport.arrayOfTime.append((hours : hour , minutes : minutes, transportType : type))
        return print("\(type) перевезе 1000 людей за \(hour) годин \(minutes) хвилин на відстань 500 км\n")
    }
}

//створив окремий класс який наслідується від батьківського класу для визначення питання
//Який із способів перевезення найшвидше перевезе 1000 пасажирів з точки А в точку В, відстань між якими 500 км?
public class whoFaster : Transport{
//метод для визначення найкращого результат
    public func whoIsTheBest()->(){
        var minTime = Transport.arrayOfTime[0]
        var indMin = 0
        for (indx,el) in Transport.arrayOfTime.enumerated(){
            if (el.hours < minTime.hours){
                minTime.hours = el.hours
                indMin = indx
            }else if (el.hours == minTime.hours){
                if (el.minutes < minTime.minutes){
                    minTime.minutes = el.minutes
                }
                
            }
        }
        return print("\(Transport.arrayOfTime[indMin].transportType.uppercased()) виявся найшвидшим транспортом для перевезення 1000 людей на відстань 500 км , який встиг виконати задвання за \(Transport.arrayOfTime[indMin].hours) годин \(Transport.arrayOfTime[indMin].minutes) хвилин .\n")
    }
}
// ще один кллас яккий також наслідується від батьківського і дає відповідь на 2-ге питання
public class generalCapacity : Transport{
//містить один метод де додаються всі значень capacity всіх транспортів з масиву arrayOfCapacity
   public func allCapacity()->Double {
        var sum : Double = 0
        for el in Transport.arrayOfCapacity{
            sum += el
        }
        print("\(Int(sum)) пасажирів можна за 1 раз перевезти усіма одночасно видами транспорту")
        return sum
    }
}
print("Загальні результати всіх транспортів :\n".uppercased())
//створив об'єкт всіх видів транспортів і виклакав метод перевезти з конжному на них для вирахування часу для перевезення 1000 людей на відстань 500 км
let object1 = Helicopter()
object1.transportTo()
let object2 = Car()
object2.transportTo()
let object3 = Bus()
object3.transportTo()
let object4 = Train()
object4.transportTo()
let object5 = Ship()
object5.transportTo()
let object6 = Metro()
object6.transportTo()
let object = Plane()
object.transportTo()
//викликав метод для визначення відповіді для першого питання
print("Хто ж виявся найшвидшим ?! :\n".uppercased())
whoFaster().whoIsTheBest()
//і для другого
print("яка загальна місткість всіх видів транспортів :\n".uppercased())
generalCapacity().allCapacity()
//ВЗАГАЛЬНОМУ Я ВИКОРИСТАВ НЕ ВСІ МОДИФІКАТОРИ ДОСТУПУ АЛЕ З УСІМА НИМИ ОЗНАЙОМИВСЯ. ДО КЛАСУ Tramsport Я ДОДАВ ПАБЛІК АЛЕ ДЛЯ МАССИВІВ ЗРОБИВ ФАЙЛ ПРАЙВЕЕТ ДЛЯ ТОГО ШОБ ДО НИХ НЕ МОЖНА БУЛО ЗВЕРТАТИСЬ НА ПРЯМУ І ЗМІНЮВАТИ ЗНАЧЕННЯ В ІНШИХ ФАЙЛАХ. ДЛЯ ІНШИХ ЗАЛИШАВ ІНТЕРНАЛ ЗНАЧЕННЯ ЗА ЗАМОВЧУВАННЯМ.ХОЧА В ВИПАДКУ ФРЕЙМВОРКА ТУТ МОЖНА БУЛО МОДИФІКУВАТИ МОДИФІКАТОРИ КЛАСИ АЛЕ ЗНОВ Ж ТАКИ ТРЕБА БУЛО ТЕСТИТИ В ІНШОМУ ПРОЕКТІ.
