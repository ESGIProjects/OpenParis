//
//  EntryCell.swift
//  OpenParis
//
//  Created by Jason Pierna on 08/09/2017.
//  Copyright © 2017 ESGI. All rights reserved.
//

import UIKit

class EntryCell: UITableViewCell {
	
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		priceLabel.clipsToBounds = true
		priceLabel.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
