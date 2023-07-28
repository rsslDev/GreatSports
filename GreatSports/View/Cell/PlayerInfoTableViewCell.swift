//
//  PlayerInfoTableViewCell.swift
//  GreatSports
//
//  Created by Russel Dev on 26/07/23.
//

import UIKit

class PlayerInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var infoValueLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
