//
//  PickerLabels.swift
//  Godynnyk_App
//
//  Created by Максим Оліярник on 17.02.2023.
//


import Foundation
import UIKit

// функція для додавання лейблів до компонентів  пікера (ЗАПУСКТИ ТІЛЬКИ НА IPHONE 12 PRO БО ЯКЩО НА ІНШИХ ТО БУДЕ БОЛЯЧЕ ДИВИТИСЬ)0))) ) ше пофікшу
// НУ І НА РАХУНОК СТОРІБОРДУ ТО ТАМ ВПРИНЦИПІ ЯК НА ДРУГИЙ РАЗ НЕПОГАНО ЗРОБЛЕНІ КОНСТРЕЙТИ ПЛЮС НАВЧИВСЯ ЗАДАВАТИ СПІВВІДНОШЕННЯ В ПРОЦЕНТАХ ЩО НА МОЮ ДУМКУ Є ДУЖЕ КРУТО, ТОЖЕ ПОТІМ ПОФІКШУ
//ЧЕКАЮ ФІДБЕКУ)))
 extension UIPickerView {
   
    func setPickerLabels(labels: [Int:UILabel], containedView: UIView) { // [component number:label]
        
        let fontSize:CGFloat = 18
        let labelWidth:CGFloat = containedView.bounds.width / CGFloat(self.numberOfComponents)
        let x:CGFloat = self.frame.origin.x
        let y:CGFloat = (self.frame.size.height / 2) - (fontSize / 2)
        
        for i in 0..<self.numberOfComponents {
            
            if let label = labels[i] {
                
                if self.subviews.contains(label) {
                    label.removeFromSuperview()
                }
                
                label.frame = CGRect(x: x + labelWidth * CGFloat(i)+35, y: y+40,width: labelWidth, height: fontSize)
                label.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
                label.backgroundColor = .clear
                label.textColor = .white
                label.textAlignment = NSTextAlignment.center
                
                self.addSubview(label)
            }
        }
    }
}
