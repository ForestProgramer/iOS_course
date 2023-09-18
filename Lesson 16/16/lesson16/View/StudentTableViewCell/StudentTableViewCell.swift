//
//  StudentTableViewCell.swift
//  testtt
//
//  Created by Volodymyr Rykhva on 29.06.2021.
//

import UIKit

final class StudentTableViewCell: UITableViewCell {

    static var reuseIdentifier = "StudentTableViewCell"

    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!

}

extension StudentTableViewCell : StudentsPresenterProtocol{

    func showStudents(index : IndexPath,student : Student) {
        logoImageView.load(url: student.logo)
        nameLabel.text = student.name
        emailLabel.text = student.email

        logoImageView.layer.cornerRadius = 30
        logoImageView.contentMode = .scaleAspectFit
    }
}
