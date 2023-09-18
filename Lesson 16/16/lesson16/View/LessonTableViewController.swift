//
//  LessonTableViewController.swift
//  lesson16
//
//  Created by Максим Оліярник on 22.03.2023.
//

import UIKit

class LessonTableViewController: UITableViewController {

    private var lessons : [Lesson] = []
    
    private var presenter: LessonTablePresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LessonTablePresenter()
        lessons = presenter.updateLessons()
        title = "Lessons"
        tableView.reloadData()
    }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            lessons.count
        }
    
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LessonsTableViewCell", for: indexPath)
            cell.textLabel?.text = lessons[indexPath.row].name
            cell.detailTextLabel?.text = lessons[indexPath.row].hours
            return cell
        }

}
