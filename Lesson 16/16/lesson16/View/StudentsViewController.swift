//
//  StudentsViewController.swift
//  lesson16
//
//  Created by Максим Оліярник on 22.03.2023.
//

import UIKit

class StudentsViewController: UIViewController {



    @IBOutlet weak var studentTableView: UITableView!
    
    private var presenter: StudentsPresenter!
    private var delegate =  StudentDetailsPresenter()
    var students : [Student] =  []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        studentTableView.register(
            UINib.init(nibName: StudentTableViewCell.reuseIdentifier, bundle: nil),
            forCellReuseIdentifier: StudentTableViewCell.reuseIdentifier)
        studentTableView.tableFooterView = UIView()
        title = "Students"
        presenter = StudentsPresenter()
        students = presenter.updateStudents()
        studentTableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? StudentDetailViewController,
           let indexPath = sender as? IndexPath {
            destination.showInfo(data: students[indexPath.row])
            delegate.delegateStudentsInfo(student: students[indexPath.row])
        }
    }

}
extension StudentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        students.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StudentTableViewCell.reuseIdentifier,
                                                 for: indexPath)
        if let cell = cell as? StudentTableViewCell {
            cell.showStudents(index: indexPath, student: students[indexPath.row])
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "StudentDetails", sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
