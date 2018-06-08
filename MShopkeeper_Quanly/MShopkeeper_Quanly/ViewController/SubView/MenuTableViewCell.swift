//
//  MenuTableViewCell.swift
//  MShopKeeper
//
//  Created by ddthanh on 1/22/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var labelText: UILabel!
    
    var row: Int! {
        didSet{
            if row == 0 {
                self.img?.image = UIImage.init(named: "ic_revenue")
                self.labelText?.text = "Tình hình kinh doanh"
            }
            if row == 1 {
                self.img?.image = UIImage.init(named: "ic_trend_search")
                self.labelText?.text = "Xu hướng tìm kiếm sản phẩm"
                
            }
            if row == 2 {
                
                let line = UIView.init()
                line.frame = CGRect.init(x: 0, y: 0, width: 270, height: 1)
                line.backgroundColor = UIColor.gray
                self.addSubview(line)
                self.separatorInset = UIEdgeInsetsMake(0, 0, 1, 0)
                self.img?.image = UIImage.init(named: "ic_menu_share")
                self.labelText?.text = "Chia sẻ ứng dụng"
            }
            if row == 3 {
                self.img?.image = UIImage.init(named: "ic_menu_rate")
                self.labelText?.text = "Đánh giá ứng dụng"
            }
            if row == 4 {
                self.img?.image = UIImage.init(named: "ic_menu_about")
                self.labelText?.text = "Thông tin ứng dụng"
            }
            if row == 5 {
                let line = UIView.init()
                line.frame = CGRect.init(x: 0, y: 0, width: 270, height: 1)
                line.backgroundColor = UIColor.gray
                self.addSubview(line)
                self.separatorInset = UIEdgeInsetsMake(0, 0, 1, 0)
                self.img?.image = UIImage.init(named: "ic_menu_change_password")
                self.labelText?.text = "Đổi mật khẩu"
                
            }
            if row == 6 {
                self.img?.image = UIImage.init(named: "ic_menu_logout")
                self.labelText?.text = "Đăng xuất"
            }
        }
    }
    
    var didSelect: Int! {
        didSet {
            
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
