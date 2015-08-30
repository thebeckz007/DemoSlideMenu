//
//  MenuCell.swift
//  PovertyChallenge
//
//  Created by david  beckz on 7/9/15.
//  Copyright (c) 2015 Appable. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var lblMenu: UILabel!
    @IBOutlet weak var lblNumber: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
