//
//  ViewController.swift
//  Transport
//
//  Created by Максим Оліярник on 22.01.2023.
//

import UIKit
import MathematicsFrameWork
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(Mathematics.return20ElementsFibonachi())
        print(Mathematics.factorial(10))
        print(Mathematics.calculatePerymetrAndArea(arrayOfDots: [(0,0),(4,4),(8,0)]))
    }


}

