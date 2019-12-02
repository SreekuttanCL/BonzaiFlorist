//
//  FlowerTableViewCell.swift
//  Bonzai Florist
//
//  Created by Sreekuttan C L on 2019-11-29.
//  Copyright © 2019 Sreekuttan C L. All rights reserved.
//

import UIKit

class FlowerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
