import UIKit
import Foundation

//1. Геометричний примітив “Точка”.
print("Завдання №1")
//а) Створити структуру, що описує точку у декартовій (x; y) та полярній (radius; angle) системі координат за допомогою властивостей, які недоступні для зміни поза межами структури та надати їм значення за замовчуванням.
struct Dot {
    private var decartDot = (x:0.00, y:0.00)
    private var polarDot = (radius : 0.00, angle : 0.00)

//b) Описати ініціалізатори створення точки за допомогою декартових (x; y) та(або) полярних координат (radius; angle). Створення точки за допомогою декартових координат автоматично визначає полярні координати і навпаки.
    
    init(x : Double, y : Double) {
        decartDot.x = x
        decartDot.y = y
        
        polarDot.radius = sqrt(pow(x, 2) + pow(y, 2))
        polarDot.angle = atan(y/x)
    }
    
    init(radius : Double, angle : Double) {
        polarDot.radius = radius
        polarDot.angle = angle
        
        decartDot.x = radius * cos(angle)
        decartDot.y = radius * sin(angle)
    }

//c) Описати функції, що дозволяють змістити точку у нову позицію за координатами у декартовій (x; y) та полярній (radius; angle) системах.
    
    mutating func moveDecartDot (newX : Double, newY : Double){
        decartDot.x = newX
        decartDot.y = newY
        
        polarDot.radius = sqrt(pow(newX, 2) + pow(newY, 2))
        polarDot.angle = atan(newY/newX)
    }
    
    mutating func movePolarDot (newRadius : Double, newAngle : Double){
        polarDot.radius = newRadius
        polarDot.angle = newAngle
        
        decartDot.x = newRadius * cos(newAngle)
        decartDot.y = newRadius * sin(newAngle)
    }
    
//d) Описати функцію приведення точки до рядкового представлення з параметром, який вказує систему координат, у якій повинна бути e) виведена точка (за замовчуванням, декартова система координат).
    
    func showDot(typeCoordinates :String = "Декартова")->(){
        if typeCoordinates == "Полярна"{
            print("\(polarDot) - The distance from the earth's geometric center to either pole." )
        }else{
            print("\(decartDot) - Values of our dot on decart area")
        }
    }
//    *Полярний радіус - The distance from the earth's geometric center to either pole.
}
//Cпочатку створили об'єкт з точкою в декартовій системі координат
var dot1 = Dot(x: 4, y: 8)
//далі створили другий об'єкт з точкою в полярній системі координат
var dot2 = Dot(radius: 2, angle: 120)

// далі викликаємо функцію зміни положення точки задавши їй нові значення (декартові координати)
dot1.moveDecartDot(newX: 2, newY: 6)
//(полярні координати)
// також в цій функції реалізоване автоматичне перетворення декартових в полярні (або навпаки) при змінні значень точки
dot2.movePolarDot(newRadius: 3, newAngle: 60)
//виклик функції яка виводить ЗА ЗАМОВЧУВАННЯМ значення точки в декртовій системі координат
dot2.showDot()
//або ми можемо задати полярну систему і в нас виведуться відповідна точка в полярних координатах
dot1.showDot(typeCoordinates: "Полярна")


print("Завдання №2")
//2. Геометричний примітив “Фігура”

//а) Створити структуру, що описує фігуру на основі точок (структура із завдання №1). Доступ до списку точок є закритим на зміну за межами структури.

struct geometricFigure {
    private var dots : [(Double,Double)] = []
    //b) Описати перерахування, яке визначає тип фігури (невідомо, точка, лінія, трикутник, чотирикутник та многокутник). Описати властивість фігури, що представляє її тип.
    let typeOfFigure : String
//e) Описати властивості, що повертають площу та периметр фігури.
    var perimetr : Double = 0
    var areaSize : Double = 0
//також вказав додаткову властивість - масив значеннь довжин сторін нашої фігури оскільки з цими значннями ми можемо вирахувати периметр та(або) площу вказаної фігури
    var sides : [Double] = []
//визначив перехування
    enum figureType : String {
        case невідомо
        case точка
        case лінія
        case трикутник
        case чотирикутник
        case многокутник
    }
//це додаткова структура для запису значень з string-a в наш масив.Вона використовується в другому ініціалізаторі
    struct Point : Decodable {
        
        var x : Double
        var y : Double
        func toTuple()->(Double,Double){
            let tuple : (x:Double,y:Double) = (x,y)
            return tuple
        }
    }
//Створив окремі функції для обрахування периметру фігури і площі
    mutating func calculatePerimetr(countSides : Int , arrayOfDots: [(Double,Double)]) -> Double {
        if countSides == 2{
            perimetr = sqrt(pow((arrayOfDots[countSides-1].0 - arrayOfDots.first!.0), 2)+pow((arrayOfDots[countSides-1].1 - arrayOfDots.first!.1), 2))
            print("Результатом є лінія з точок : \(dots.first ?? (0,0)) \(dots[1]). Довжина = \(perimetr)")
        }else if countSides == 3{
            for el in Range(0...countSides-1) {
                if el == 2{
                    sides.append(sqrt(pow((arrayOfDots[el-2].0 - arrayOfDots[el].0), 2)+pow((arrayOfDots[el-2].1 - arrayOfDots[el].1), 2)))
                }else{
                    sides.append(sqrt(pow((arrayOfDots[el+1].0 - arrayOfDots[el].0), 2)+pow((arrayOfDots[el+1].1 - arrayOfDots[el].1), 2)))
                }
                perimetr += sides[el]
        }
            print("Результатом є трикутник з точок : \(dots). Периметр = \(perimetr).")
        }else if countSides == 4{
            for el in Range(0...countSides-1) {
                if el == 3{
                    sides.append(sqrt(pow((arrayOfDots[el-3].0 - arrayOfDots[el].0), 2)+pow((arrayOfDots[el-3].1 - arrayOfDots[el].1), 2)))
                }else{
                    sides.append(sqrt(pow((arrayOfDots[el+1].0 - arrayOfDots[el].0), 2)+pow((arrayOfDots[el+1].1 - arrayOfDots[el].1), 2)))
                }
                perimetr += sides[el]
        }
            print("Результатом є чотирикутник з точок : \(dots). Периметр = \(perimetr).")
            
        }else if countSides > 4{
            for el in Range(0...countSides-1) {
                if el == 4{
                    sides.append(sqrt(pow((arrayOfDots[el-4].0 - arrayOfDots[el].0), 2)+pow((arrayOfDots[el-4].1 - arrayOfDots[el].1), 2)))
                }else{
                    sides.append(sqrt(pow((arrayOfDots[el+1].0 - arrayOfDots[el].0), 2)+pow((arrayOfDots[el+1].1 - arrayOfDots[el].1), 2)))
                }
                perimetr += sides[el]
        }
            print("Результатом є \(dots.count)-кутник з точок : \(dots). Периметр = \(perimetr).")
        }
        
        return perimetr
    }
//функція яка обраховує площу
    mutating func calculateArea(countDots : Int) -> Double{
        if countDots == 3{
            areaSize = sqrt(((sides[0]+sides[1]+sides[2])/2)*(((sides[0]+sides[1]+sides[2])/2)-sides[0])*(((sides[0]+sides[1]+sides[2])/2)-sides[1])*(((sides[0]+sides[1]+sides[2])/2)-sides[2]))
            print("Площа трикутника = \(areaSize)")
        }else if countDots == 4 {
            areaSize = sqrt((((sides[0]+sides[1]+sides[2]+sides[3])/2)-sides[0])*(((sides[0]+sides[1]+sides[2]+sides[3])/2)-sides[1])*(((sides[0]+sides[1]+sides[2]+sides[3])/2)-sides[2])*(((sides[0]+sides[1]+sides[2]+sides[3])/2)-sides[3]))
            print("Площа чотирикутника = \(areaSize)")
        }else if countDots > 4 {
            areaSize = (((Double(dots.count)*pow(sides[0],2))/4) * (tan(Double(180/dots.count))))
            print("Площа \(dots.count)-кутника = \(areaSize)")
        }
        return areaSize
    }
    
//c) Описати ініціалізатори для створення фігури з допомогою масиву точок, або ряду точок. Тип фігури визначається у момент її створення.
//1-ий ініціалізатор приймає масив tuples-ів
    init(arrayOfDots : [(Double,Double)] ) {
        dots += arrayOfDots
        
        switch dots.count {
        case 0:
            typeOfFigure = figureType.невідомо.rawValue
            print("За вхідними данними не зрозуміло що це за фігура")
        case 1:
            typeOfFigure = figureType.точка.rawValue
            print("Результат даних - точка : \(dots)")
        case 2:
            typeOfFigure = figureType.лінія.rawValue
            calculatePerimetr(countSides: dots.count, arrayOfDots: dots)
        case 3:
            typeOfFigure = figureType.трикутник.rawValue
            calculatePerimetr(countSides: dots.count, arrayOfDots: dots)
            calculateArea(countDots: dots.count)
        case 4:
            typeOfFigure = figureType.чотирикутник.rawValue
            calculatePerimetr(countSides: dots.count, arrayOfDots: dots)
            calculateArea(countDots: dots.count)
        default :
            typeOfFigure = figureType.многокутник.rawValue
            calculatePerimetr(countSides: dots.count, arrayOfDots: dots)
            calculateArea(countDots: dots.count)
        }
    }
//2-ий іціалізатор . Він примає стрінгу яку потім перетворює в тип нашого масиву dots
    init(arrayOfDots : String ) {
//тут не дуже гарно по коду вийшло але довго махався з тим тому вирішив лишити так шоб час не затягувати
        for substring in arrayOfDots.dropLast().dropFirst().dropLast().dropFirst().components(separatedBy: "},{"){
            let point : (x:Double,y: Double)
            do{
            point = try JSONDecoder().decode(Point.self, from: Data(("{"+substring+"}").utf8)).toTuple()
            }catch let error{
                point = (0,0)
                print(error)
            }
            dots.append(point)
        }
        switch dots.count {
        case 0:
            typeOfFigure = figureType.невідомо.rawValue
            print("За вхідними данними не зрозуміло що це за фігура")
        case 1:
            typeOfFigure = figureType.точка.rawValue
            print("Результат даних - точка : \(dots)")
        case 2:
            typeOfFigure = figureType.лінія.rawValue
            calculatePerimetr(countSides: dots.count, arrayOfDots: dots)
        case 3:
            typeOfFigure = figureType.трикутник.rawValue
            calculatePerimetr(countSides: dots.count, arrayOfDots: dots)
            calculateArea(countDots: dots.count)
        case 4:
            typeOfFigure = figureType.чотирикутник.rawValue
            calculatePerimetr(countSides: dots.count, arrayOfDots: dots)
            calculateArea(countDots: dots.count)
        default :
            typeOfFigure = figureType.многокутник.rawValue
            calculatePerimetr(countSides: dots.count, arrayOfDots: dots)
            calculateArea(countDots: dots.count)
        }
    }
//d) Описати індексатор (subscript), який повертає точку фігури фігури за індексом.
    subscript(index : Int)->(Double,Double){
        get{
            assert(index<dots.count,"Index out of bounds of array\(index)")
            return dots[index]
        }set{
            dots[index] = newValue
        }
    }
}
//створив об'єкт з чотирма точками
//при ініціалізації зразу обраховується периметр і площа
//можна було зробити щоб тільки при виклику функції в об'єкті виводився результат
print("Фігура №1")
var figure = geometricFigure(arrayOfDots: [(x:0,y:0),(x:0,y:6),(x:4,y:6),(x:4,y:0)])
//поле повернее тип фігури
figure.typeOfFigure
//поле яке поверне периметр фігури
figure.perimetr
//поле яке поверне площу фігури
figure.areaSize
//доступ через сабскріпт до приватного масиву точок dots
figure[1]
print("Фігура №2")
var figure2 = geometricFigure(arrayOfDots: [(x:0,y:0),(x:0,y:4),(x:4,y:4),(x:6,y:2),(x:4,y:0)])
figure2.typeOfFigure
figure2.perimetr
figure2.areaSize
figure2[1]
//тут реалізований другий ініціалізатор типу JSON String який каститься до нашого масиву тюплзів
print("Фігура №3")
var figure3 = geometricFigure(arrayOfDots: """
[{"x":0,"y":0},{"x":1,"y":1}]
""")
//виводим ті самі поля що в попередніх екземплярах
figure3.typeOfFigure
figure3.perimetr
figure3.areaSize
figure3[1]
