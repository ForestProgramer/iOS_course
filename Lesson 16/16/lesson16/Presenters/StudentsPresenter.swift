//
//  ViewController.swift
//  testtt
//
//  Created by Volodymyr Rykhva on 28.06.2021.
//

import UIKit

protocol StudentsPresenterProtocol: AnyObject {
    func showStudents(index : IndexPath,student : Student)
}


final class StudentsPresenter{

    private weak var userView: StudentsPresenterProtocol?

    private var students: [Student] = []
    
   

    // MARK: - Private

    func updateStudents()->[Student] {
        students = JsonService.shared.parseStudents()?.students ?? []
        
        return students
    }
}


