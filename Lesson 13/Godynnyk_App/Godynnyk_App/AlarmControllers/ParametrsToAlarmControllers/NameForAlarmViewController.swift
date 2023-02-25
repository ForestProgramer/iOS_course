//
//  NameForAlarmViewController.swift
//  Godynnyk_App
//
//  Created by Максим Оліярник on 24.02.2023.
//

import UIKit

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
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegateName?.addNameAlarm(text: textField.text!)
    }
}
