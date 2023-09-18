//
//  StudentDetailsViewController.swift
//  testtt
//
//  Created by Volodymyr Rykhva on 07.07.2021.
//

import UIKit

protocol StudentInfoProtocol: AnyObject {
    func showInfo(data: Student?)
}


final class StudentDetailsPresenter {

    private var student: Student?


    // MARK: - Private

    func delegateStudentsInfo(student : Student?){
        self.student = student
    }
}
