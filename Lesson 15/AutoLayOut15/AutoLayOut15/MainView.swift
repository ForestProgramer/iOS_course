//
//  ViewController.swift
//  AutoLayOut15
//
//  Created by Максим Оліярник on 10.03.2023.
//
// КОНТРОЛЛЕР ГОЛОВНОГО ЕКРАННУ
import UIKit

class MainView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
//ЕКШИНИ ДЛЯ ДВОХ КНОПОК ЯКІ ВИКЛИКАЮТЬ ІНШІ ЕКРАНИ
    @IBAction func didTapTask2(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Task2UIViewController")
        self.present(vc, animated: true)
        
    }
    @IBAction func didTapTask3(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Task3ViewController")
        self.present(vc, animated: true)
    }
    
}

