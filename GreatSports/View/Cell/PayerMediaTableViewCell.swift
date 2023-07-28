//
//  PayerMediaTableViewCell.swift
//  GreatSports
//
//  Created by Russel Dev on 26/07/23.
//

import UIKit

class PayerMediaTableViewCell: UITableViewCell {
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mediaTitleLabel: UILabel!
    
    @IBOutlet weak var mediaDescriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
