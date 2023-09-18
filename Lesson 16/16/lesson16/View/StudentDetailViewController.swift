//
//  StudentDetailViewController.swift
//  lesson16
//
//  Created by Максим Оліярник on 23.03.2023.
//

import UIKit

class StudentDetailViewController: UIViewController {
    
    private var presenter: StudentDetailsPresenter!
    
    private var student : Student?
    
    @IBOutlet weak var studentImageView: UIImageView!
    @IBOutlet weak var studentNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = StudentDetailsPresenter()
        
        if let student = student{
            title = student.name
            self.studentImageView.load(url: student.logo)
            self.studentNameLabel.text = student.email
        }
    }
}
extension StudentDetailViewController : StudentInfoProtocol{
    func showInfo(data: Student?) {
        guard let student = data else {
            return
        }
        self.student = student
    }
}



