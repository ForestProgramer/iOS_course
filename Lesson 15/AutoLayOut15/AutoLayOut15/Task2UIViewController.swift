//
//  Task2UIViewController.swift
//  AutoLayOut15
//
//  Created by Максим Оліярник on 10.03.2023.
//

import UIKit
// КОТРОЛЛЕР ДЛЯ ЕКАРНУ ЯКИЙ ВИКЛИКАЄТЬСЯ ПЕРШОЮ КНОПКОЮ
class Task2UIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
//ЕКШН ДЛЯ КНОПКИ НАЗАД
    @IBAction func didTapBack(_ sender: Any) {
        // ПРОПАДАЄ ЕКРАН ПРИ НАЖИМАННІ
        self.dismiss(animated: true)
    }
    


}
