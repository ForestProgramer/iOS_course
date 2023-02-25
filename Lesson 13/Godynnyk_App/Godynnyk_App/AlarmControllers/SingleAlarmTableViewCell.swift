//
//  SingleAlarmTableViewCell.swift
//  Godynnyk_App
//
//  Created by Максим Оліярник on 23.02.2023.
//

import UIKit

class SingleAlarmTableViewCell: UITableViewCell {

    @IBOutlet weak var estimatedAlarmTime: UILabel!
    @IBOutlet weak var statusWhenRepeatLabel: UILabel!
    @IBOutlet weak var turnOfOnAlarmSwitcher: UISwitch!
    @IBOutlet weak var parametrSwitcher: UISwitch!
    @IBOutlet weak var titleParametrLabel: UILabel!
    @IBOutlet weak var chosedAlarmParametrLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
