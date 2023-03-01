//
//  ChosedSoundTableViewCell.swift
//  Godynnyk_App
//
//  Created by Максим Оліярник on 28.02.2023.
//

import UIKit

class ChosedSoundTableViewCell: UITableViewCell {

    @IBOutlet weak var generalLabelChoose: UILabel!
    @IBOutlet weak var choosedSoundLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
