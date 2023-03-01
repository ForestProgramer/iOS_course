//
//  NameForAlarmViewController.swift
//  Godynnyk_App
//
//  Created by Максим Оліярник on 24.02.2023.
//

import UIKit
// тут так само як і в попердньому класі просто тут текст фіелд делегат і при нажиманні кнопки ретурн ми  передаєм данні делегату
protocol NameOfNewAlarm {
    func addNameAlarm(text : String)
}

class NameForAlarmViewController: UIViewController {

    @IBOutlet weak var textFieldAlarmName: UITextField!
    var delegateName : NameOfNewAlarm?
    override func viewDidLoad() {
        super.viewDidLoad()

        textFieldAlarmName.delegate = self

    }
    

    

}

extension NameForAlarmViewController : UITextFieldDelegate {
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldAlarmName.resignFirstResponder()
        delegateName?.addNameAlarm(text: textField.text!)
        return true
    }
}
