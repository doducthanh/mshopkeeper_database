//
//  TopItemTableViewCell.swift
//  MShopkeeper_Quanly
//
//  Created by ddthanh on 4/10/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class TopItemTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UILabel!
    @IBOutlet weak var lbCount: UILabel!
    @IBOutlet weak var lbName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        img.layer.cornerRadius = img.frame.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
