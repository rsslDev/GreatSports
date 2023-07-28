//
//  PlayerListCollectionViewCell.swift
//  GreatSports
//
//  Created by Russel Dev on 25/07/23.
//

import UIKit

class PlayerListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerTeamNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.containerView.layer.masksToBounds = false
    }

}
