
//
//  PopupCell.swift
//  MShopKeeper
//
//  Created by ddthanh on 2/2/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import UIKit

class PopupCell: UITableViewCell {

    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
