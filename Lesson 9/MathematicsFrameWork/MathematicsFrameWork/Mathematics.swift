//
//  Mathematics.swift
//  MathematicsFrameWork
//
//  Created by Максим Оліярник on 22.01.2023.
//
//2. Написати свій власний фреймворк Mathematics, який може
import Foundation

public class Mathematics{
//а) повернути масив із 20 перших чисел Фібоначчі (не хардкод).
    
   public static func return20ElementsFibonachi()->[Int]{
        var fibArray : [Int] = [1,1]
        var fib1 = 1
        var fib2 = 1
        var fib_sum = 0
        let n = 22
        var i = 0
        while i<n-2 {
            fib_sum = fib1+fib2
            fib1 = fib2
            fib2 = fib_sum
            i = i+1
            fibArray.append(fib2)
        }
        return fibArray
    }
//б) порахувати факторіал числа
   public static func factorial(_ n: Int) -> Double {
          return (1...n).map(Double.init).reduce(1.0, *)
    }
    
//в) порахувати площу Фігури (Трикутника, Чотирикутника) і її периметр.
    
//насправді міг би поексперементувати з іншими модифікаторами доступу, але використав звчиайні пабліки для того щоб показати в іншому проекті, після того як імпортую їх тужди ,що я можу їх викликати і вони працюють.Логіка кожної функції реалізована перевірка і файлі Transport.
   public static  func calculatePerymetrAndArea(arrayOfDots : [(x: Double,y: Double)]) -> (type : String , perymetr : Double , ploscha : Double){
        var typeOfFigure : String = ""
        var perimetr : Double = 0
        var areaSize : Double = 0
        var sides : [Double] = []
        let countDots : Int = arrayOfDots.count
        if countDots == 3{
            typeOfFigure = "трикутник"
            for el in Range(0...countDots-1) {
                if el == 2{
                    sides.append(sqrt(pow((arrayOfDots[el-2].0 - arrayOfDots[el].0), 2)+pow((arrayOfDots[el-2].1 - arrayOfDots[el].1), 2)))
                }else{
                    sides.append(sqrt(pow((arrayOfDots[el+1].0 - arrayOfDots[el].0), 2)+pow((arrayOfDots[el+1].1 - arrayOfDots[el].1), 2)))
                }
                perimetr += sides[el]
            }
            areaSize = sqrt(((sides[0]+sides[1]+sides[2])/2)*(((sides[0]+sides[1]+sides[2])/2)-sides[0])*(((sides[0]+sides[1]+sides[2])/2)-sides[1])*(((sides[0]+sides[1]+sides[2])/2)-sides[2]))
        }else if countDots == 4 {
            typeOfFigure = "чотирикутник"
            for el in Range(0...countDots-1) {
                if el == 3{
                    sides.append(sqrt(pow((arrayOfDots[el-3].0 - arrayOfDots[el].0), 2)+pow((arrayOfDots[el-3].1 - arrayOfDots[el].1), 2)))
                }else{
                    sides.append(sqrt(pow((arrayOfDots[el+1].0 - arrayOfDots[el].0), 2)+pow((arrayOfDots[el+1].1 - arrayOfDots[el].1), 2)))
                }
                perimetr += sides[el]
        }
            areaSize = sqrt((((sides[0]+sides[1]+sides[2]+sides[3])/2)-sides[0])*(((sides[0]+sides[1]+sides[2]+sides[3])/2)-sides[1])*(((sides[0]+sides[1]+sides[2]+sides[3])/2)-sides[2])*(((sides[0]+sides[1]+sides[2]+sides[3])/2)-sides[3]))
        }
        return (type : typeOfFigure , perymetr : perimetr , ploscha : areaSize)
    }
}



