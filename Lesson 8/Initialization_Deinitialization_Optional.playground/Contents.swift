import UIKit
//1. Описати сутність, що представляє фігуру лише на основі точок* та деякої назви, задання якої є необов’язковим. Кожна фігура повинна визначати свої периметр та площу.
//Створив класс замість структури як в минулому завдані №7
class geometricFigure {
    private var dots : [(x:Double,y:Double)] = []
//створив поле типу кортеж з такими параметрами для запису данних про нашу фігуру в один масив
    var courtegeFigure : (name : String, type: String , subtype: String, dots : [(x:Double,y:Double)] ,perymetr : Double, ploscha : Double) = (name : "", type: "" , subtype: "", dots : [] ,perymetr : 0, ploscha : 0)
// ось наш мав массив в який ми будемо апендити наші кортежі даннних.Він є статичним оскільки потрбіно щоб він не стрирався при створенні нового об'єкту
    static var arrayOfFigures : [(name : String, type: String , subtype: String, dots : [(x:Double,y:Double)] ,perymetr : Double, ploscha : Double)] = []
//тип фігури
    let typeOfFigure : String
// підтип фігури
    var subTypeOfFigure : String = ""
// назва фігури опціональна
    var nameOfFigure : String
// маисв сторін довжин фігури
    var sides : [Double] = []
// периметр
    var perimetr : Double = 0
//площа
    var areaSize : Double = 0
// статична змінна яка виступає індексом в нашому массиві для того щоб додавати  наші данні в кортежі в послідовності
    static var counterObjects : Int = 0
//Фігури бувають наступних видів: невідома, лінія, трикутник та чотирикутник. Вважається, що точки задають фігуру послідовно.
    enum figureType : String {
            case невідомо
            case лінія
            case трикутник
            case чотирикутник
        }
//Створив окремі функції для обрахування периметру фігури і площі
     func calculatePerimetr(countSides : Int , arrayOfDots: [(Double,Double)]) -> Double {
        if countSides == 2{
            perimetr = sqrt(pow((arrayOfDots[countSides-1].0 - arrayOfDots.first!.0), 2)+pow((arrayOfDots[countSides-1].1 - arrayOfDots.first!.1), 2))
            }else if countSides == 3{
                for el in Range(0...countSides-1) {
                    if el == 2{
                        sides.append(sqrt(pow((arrayOfDots[el-2].0 - arrayOfDots[el].0), 2)+pow((arrayOfDots[el-2].1 - arrayOfDots[el].1), 2)))
                    }else{
                        sides.append(sqrt(pow((arrayOfDots[el+1].0 - arrayOfDots[el].0), 2)+pow((arrayOfDots[el+1].1 - arrayOfDots[el].1), 2)))
                    }
                    perimetr += sides[el]
            }

            }else if countSides == 4{
                for el in Range(0...countSides-1) {
                    if el == 3{
                        sides.append(sqrt(pow((arrayOfDots[el-3].0 - arrayOfDots[el].0), 2)+pow((arrayOfDots[el-3].1 - arrayOfDots[el].1), 2)))
                    }else{
                        sides.append(sqrt(pow((arrayOfDots[el+1].0 - arrayOfDots[el].0), 2)+pow((arrayOfDots[el+1].1 - arrayOfDots[el].1), 2)))
                    }
                    perimetr += sides[el]
            }
    
            }
        geometricFigure.arrayOfFigures[geometricFigure.counterObjects].perymetr = perimetr
            return perimetr
        }
    //функція яка обраховує площу
         func calculateArea(countDots : Int) -> Double{
            if countDots == 3{
                areaSize = sqrt(((sides[0]+sides[1]+sides[2])/2)*(((sides[0]+sides[1]+sides[2])/2)-sides[0])*(((sides[0]+sides[1]+sides[2])/2)-sides[1])*(((sides[0]+sides[1]+sides[2])/2)-sides[2]))
            }else if countDots == 4 {
                areaSize = sqrt((((sides[0]+sides[1]+sides[2]+sides[3])/2)-sides[0])*(((sides[0]+sides[1]+sides[2]+sides[3])/2)-sides[1])*(((sides[0]+sides[1]+sides[2]+sides[3])/2)-sides[2])*(((sides[0]+sides[1]+sides[2]+sides[3])/2)-sides[3]))
            }
            geometricFigure.arrayOfFigures[geometricFigure.counterObjects].ploscha = areaSize
            return areaSize
        }
    
// функці яка визначає під тип нашої фігури тобто якщо чортирикутник то або ромб або квадрат або прямокутник або довільний так само і для трикутника
     func defineSubTypeOfFigure(){
        if typeOfFigure == "трикутник"{
            if sides[0] == sides[1] && sides[1] != sides[2] && sides[0] != sides[2] || sides[1] == sides[2] && sides[1] != sides[0] && sides[2] != sides[0]{
                subTypeOfFigure = "Рівнобедрений"
            }else if sides[0] == sides[1] && sides[1] == sides[2] && sides[2] == sides[0]{
                subTypeOfFigure = "Рівносторонній"
            }else if sides[0] != sides[1] && sides[1] != sides[2] && sides[2] != sides[0]{
                subTypeOfFigure = "Нерівносторонній"
            }
        }else if typeOfFigure == "чотирикутник"{
            if sqrt(pow((dots[2].x - dots.first!.x), 2)+pow((dots[2].y - dots.first!.y), 2)) == sqrt(pow((dots[3].x - dots[1].x), 2)+pow((dots[3].y - dots[1].y), 2)) && sides[0] == sides[1] && sides[1] == sides[2] && sides[2] == sides[3] && sides[3] == sides[0] {
                subTypeOfFigure = "Квадрат"
            }else if sides[0] == sides[2] && sides[1] == sides[3] && sides[0] != sides[1] && sides[2] != sides[3]{
                subTypeOfFigure = "Прямокутник"
            }else if sqrt(pow((dots[2].x - dots.first!.x), 2)+pow((dots[2].y - dots.first!.y), 2)) != sqrt(pow((dots[3].x - dots[1].x), 2)+pow((dots[3].y - dots[1].y), 2)) && sides[0] == sides[1] && sides[1] == sides[2] && sides[2] == sides[3] && sides[3] == sides[0]{
                subTypeOfFigure = "Ромб"
            }else if sides[0] != sides[2] || sides[1] != sides[3]{
                subTypeOfFigure = "Довільний"
            }
        }
//додавання підтипу до нашого кортежу за індексом counterObject
        geometricFigure.arrayOfFigures[geometricFigure.counterObjects].subtype = subTypeOfFigure
    }
//функія для виводу загальної іфнормації про об'єкт
    func showFigureDetails() {
        if typeOfFigure == "лінія"{
            print("Ім'я фігури : \(nameOfFigure)\n\(typeOfFigure).Складається з точок : \(dots.first ?? (0,0)) \(dots[1]). Довжина = \(perimetr)\n")
        }else{
            print("Ім'я фігури : \(nameOfFigure)\n\(typeOfFigure) - \(subTypeOfFigure).Складається з точок : \(dots).\nПериметр = \(perimetr).\nПлоща = \(areaSize)\n")
        }
        
    }
// створив функцію для вирахування скалярного добутку з анонімною змінною scalarMix і передбачив перевірку для введення вірних значень
    func calculateScalarMixing(otherLine : [(x:Double,y:Double)]){
        if typeOfFigure == "лінія" && otherLine.count == 2 && otherLine[0] == dots[1] || otherLine[0] == dots[0]{
            var scalarLine1 : (Ax:Double, Ay : Double) = (0,0)
            scalarLine1.Ax = dots[1].x - dots[0].x
            scalarLine1.Ay = dots[1].y - dots[0].y
            var scalarLine2 : (Bx:Double, By : Double) = (0,0)
            scalarLine2.Bx = otherLine[1].x - otherLine[0].x
            scalarLine2.By = otherLine[1].y - otherLine[0].y
            let scalarMix : Double = scalarLine1.Ax * scalarLine2.Bx + scalarLine1.Ay * scalarLine2.By
            print("Cкалярний добуток лінії \(dots) по віднощенню до лінії \(otherLine) = \(scalarMix)\n")
        }else{
            print("Об'єкт на якому ви використовуєте цей метод не є лінією. Застосуйте його виключно на об'єкті де задана лінія або ви не правильно вказали додатковий вектор для визначення скалярного добутку\n")
        }
    }
//конструктор классу
// зробив тип параметру який приймає масив тюплзів опціональним
    init(arrayOfDots : [(Double,Double)]? = nil,name : String? = nil) {
//        if arrayOfDots?.count == 1 && arrayOfDots?[0].0 == 0 && arrayOfDots![0].1 == 0{
//
//        }
        dots += arrayOfDots ?? [(x:0, y: 0)]
            nameOfFigure = name ?? ""
//заповним деякі данні в нашому тюплзі
        courtegeFigure.name = nameOfFigure
        courtegeFigure.dots = arrayOfDots ?? [(0,0)]
// зразу додаю його в масив потім інші параметри вже в функціях додаю після визначення їх
        geometricFigure.arrayOfFigures.append(courtegeFigure)
            switch dots.count {
            case 2:
                typeOfFigure = figureType.лінія.rawValue
                calculatePerimetr(countSides: dots.count, arrayOfDots: dots)
            case 3:
                typeOfFigure = figureType.трикутник.rawValue
                calculatePerimetr(countSides: dots.count, arrayOfDots: dots)
                calculateArea(countDots: dots.count)
                defineSubTypeOfFigure()
            case 4:
                typeOfFigure = figureType.чотирикутник.rawValue
                calculatePerimetr(countSides: dots.count, arrayOfDots: dots)
                calculateArea(countDots: dots.count)
                defineSubTypeOfFigure()
            default :
                typeOfFigure = figureType.невідомо.rawValue
                if arrayOfDots == nil {
                    print("")
                }else{
                    print("За вхідними данними не зрозуміло що це за фігура")
                }
                
            }
// додаю визначений тип до фігури
        geometricFigure.arrayOfFigures[geometricFigure.counterObjects].type = typeOfFigure
        
//збільшую каунтер на 1 оскільки ми вже повністю заповнили наш кортеж можливими данними
        geometricFigure.counterObjects += 1
        }

    
}
//перший об'єкт
var figure = geometricFigure(arrayOfDots: [(x:2,y:0),(x:0,y:4),(x:2,y:8),(x:4,y:4)], name: "Фігура №1")
//вивід іформації про фігуру
figure.showFigureDetails()
// другий об'єкт
var figure2 = geometricFigure(arrayOfDots: [(x:2,y:0),(x:0,y:4)], name: "Фігура №2")
//вивід іформації про фігуру
figure2.typeOfFigure
figure2.showFigureDetails()
//викликав метод скалярного добутку на заданій лінії
figure2.calculateScalarMixing(otherLine: [(x:2,y:0),(x:4,y:8)])
//опцінальний паретр name не вказав
var figure3 = geometricFigure(arrayOfDots: [(x:0,y:0),(x:2,y:6),(x:4,y:0)])
//вивід іформації про фігуру
figure3.showFigureDetails()

// знизу перевіряв чи опцінальні значення спрацюють
//var figure4 = geometricFigure(arrayOfDots: [],name: "Пусто")
////вивід іформації про фігуру
//figure4.showFigureDetails()

//Описати клас Mathematics, який складається з набору фігур. Клас визначає найбільшу та найменшу площу та її фігуру, а також найдовший та найкоротший периметр та його фігуру.
class Mathematics : geometricFigure {
// в наслідуваннний класс передали і записали наш массив з данними про наші фігури
    
// створив нове поле масив і просвоїв йому масив з нашого батьківського класу за допомогою наслідування
    let array = geometricFigure.arrayOfFigures
// задав мін та макс поля для периметра і для площі
    var minPerymetr : Double = 0
    var maxPerymetr : Double = 0
    var minPloscha : Double = 0
    var maxPloscha : Double = 0
//реалізовуємо батькіський конструктор в наслідованному класі
   init() {
// там в нас буде nil то значення за замовчування буде (x: 0 , y : 0) тому я тут записав зразу масив для того щоб нам це значенння не мішало для показу функції мін та макс
    super.init()
        
        
    }
// функція яка шукає мін та макс периметр
    func findMInMaxPerymetrValue() {
        var maxPerymetr = array[0].perymetr
        var minPerymetr = array[0].perymetr
        var indMax = 0
        var indMin = 0
        for (indx,el) in array.enumerated(){
            if (el.perymetr > maxPerymetr){
                maxPerymetr = el.perymetr
                indMax = indx
            }
            else if(el.perymetr < minPerymetr){
                minPerymetr = el.perymetr
                indMin = indx
            }
        }
        print("Мінімальне значення периметра : \(array[indMin].perymetr)\nМаксимальне значення периметру : \(array[indMax].perymetr).\n")
    }
// функція яка шукає мін та макс площу серед наших фігур
    func findMinMaxPloschaValue() {
        
        var maxPloscha = array[0].perymetr
        var minPloscha = array[0].perymetr
        var indMax = 0
        var indMin = 0
        for (indx,el) in array.enumerated(){
            if (el.perymetr > maxPloscha){
                maxPloscha = el.perymetr
                indMax = indx
            }
            else if(el.perymetr < minPloscha){
                minPloscha = el.perymetr
                indMin = indx
            }
        }
        print("Мінімальне значення площі : \(array[indMin].ploscha).\nМаксимальне значення площі : \(array[indMax].ploscha).\n")
        //просто вивів значення які передав з батьківського классу в класс-нащадок для того щоб подивитись чи якісні вони
        print("\(array)\n")
    }
}
//створили об'єкт наслідуваного класса
let minMax = Mathematics()
// виводим мін та макс периметр
minMax.findMInMaxPerymetrValue()
// виводим мін та макс площі
minMax.findMinMaxPloschaValue()
//Хотів додати ще optional biding до цього завдання але чесно йго нема куди давати бо всі значення і так заданні за замовчуванням але я працював з дефолтним значенням і з optional biding працював але в кінцкевому результаті так і не використав їх окрім нейму і масиву точок при ініціалізації
//ЯКЩО В ВАС Є ЯКІСЬ ЗАМІЧАННЯ ДО РОБОТИ ТО ОБОВ'ЯЗКОВО СКАЖІТЬ БО МЕНІ ЦІКАВО ЧИ Я ВСЕ ДОБРЕ ВИКОНАВ.МОЖЕТЕ НАПИСАТИ В ФІДБЕЦІ АБО В ТГ В ОСОБИСТІ ПОВІДОМЛЕННЯ (ТГ : @BigValue)

