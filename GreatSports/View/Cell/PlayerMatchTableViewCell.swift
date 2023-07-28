//
//  PlayerMatchTableViewCell.swift
//  GreatSports
//
//  Created by Russel Dev on 26/07/23.
//

import UIKit

class PlayerMatchTableViewCell: UITableViewCell {

    @IBOutlet weak var matchDateLabel: UILabel!
    @IBOutlet weak var matchRoundLabel: UILabel!
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var homeTeamScoreLabel: UILabel!
    @IBOutlet weak var awayTeamScoreLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
