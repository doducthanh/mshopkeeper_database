//
//  TopRevenuesTableViewCell.swift
//  MShopkeeper_Quanly
//
//  Created by Admin on 5/25/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class TopRevenuesTableViewCell: UITableViewCell {

    @IBOutlet var lbNameShop: UILabel!
    @IBOutlet var lbRevenue: UILabel!
    var diction: Dictionary<String, Any>! {
        didSet{
            self.lbNameShop.text = (self.diction["shopName"] as! String) + "-" + (self.diction["addressShop"] as! String)
            self.lbRevenue.text = (self.diction["doanhthu"] as! Int).description + "K"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
