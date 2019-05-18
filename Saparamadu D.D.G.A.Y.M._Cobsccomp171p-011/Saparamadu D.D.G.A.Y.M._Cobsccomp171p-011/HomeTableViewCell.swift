//
//  HomeTableViewCell.swift
//  Saparamadu D.D.G.A.Y.M._Cobsccomp171p-011
//
//  Created by Yasith Maheshka Saparamadu on 5/18/2562 BE.
//  Copyright © 2562 BE Yasith Maheshka Saparamadu. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var name: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profileImage.layer.cornerRadius = self.profileImage.bounds.height / 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
