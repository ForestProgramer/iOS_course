//
//  Task3ViewController.swift
//  AutoLayOut15
//
//  Created by Максим Оліярник on 10.03.2023.
//

import UIKit
//КОНТРОЛЛЕР ДЛЯ ЕКРАНУ ЯКИЙ ВИКЛИКАЄТЬСЯ 2-ОЮ КНОПКОЮ
class Task3ViewController: UIViewController {
//АУТЛЕТ ТЕКУСФІЛДА
    @IBOutlet weak var textFieldActive: UITextField!
    //ЗМІННА ДЛЯ ВИВОДУ ТЕКСТУ В ТЕКСФІЛДІ
    var returnString : String = ""
    //ТАП ЖЕСТ ЗМІННА
    var tapGest : UITapGestureRecognizer?
    override func viewDidLoad() {
        super.viewDidLoad()
        //ПРИСВОЇВ ДЕЛЕГАТ
        textFieldActive.delegate = self
        // ВИКЛИКАВ ЖЕСТ
        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        self.view.addGestureRecognizer(tapGest!)
        
    }
    // ФУНКЦІЯ ДЛЯ ОБРОБКИ ЖЕСТУ
    @objc func endEditing(){
        self.view.endEditing(true)
    }
    //ЕКШН КНОПКИ НАЗАД
    @IBAction func didTapBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
}
//РОЗШИРЕННЯ КЛАСУ
extension Task3ViewController : UITextFieldDelegate{
    //ФУНКЦІЯ ЯКА ВИКЛИКАЄТЬСЯ ПРИ ЗМІНІ ОДНОГО СИМВОЛУ В ТЕКСТ ФІЛДІ
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // ЛОГІКА ДОДАВАННЯ І ВИДАЛЕННЯ В ЗМІННУ СИМВОЛІВ ДЛЯ ВИВЕДУ В КОНСОЛЬ РЕЗУЛЬТАТУ
        if !string.isEmpty || string == " "{
            returnString += string
            print(returnString)
        }else if string.isEmpty {
            returnString.removeLast()
            print(returnString)
        }
        return true
    }
    
}
