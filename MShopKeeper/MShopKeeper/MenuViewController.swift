//
//  MenuViewController.swift
//  MShopKeeper
//
//  Created by ddthanh on 1/19/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import UIKit
import StoreKit

class MenuViewController: UIViewController {
    //MARK: property
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var lbFullName: UILabel!
    @IBOutlet weak var lbNameShop: UILabel!
    
    var heighBar: CGFloat!
    
    //MARK Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initParam()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// hàm khởi tạo giao diện cần thiết
    func initUI() {
        imageAvatar.layer.cornerRadius = imageAvatar.frame.size.height/2
        table.tag = 1
        heighBar = self.navigationController?.navigationBar.frame.size.height
    }
    
    func initParam() {
        lbFullName.text = UserDefaults.standard.value(forKey: "fullName") as! String!
        lbNameShop.text = (UserDefaults.standard.value(forKey: "userName") as! String) + ".mshopkeeper.vn"
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let menuCell = tableView.dequeueReusableCell(withIdentifier: "mycell") as! MenuTableViewCell
        tableView.separatorColor = UIColor.clear
        menuCell.row = indexPath.row
        return menuCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        click vào button chia sẻ app
        if indexPath.row == 0 {
            self.closeLeft()
            let activity = UIActivityViewController.init(activityItems: ["www.google.co.in"], applicationActivities: nil)
            activity.popoverPresentationController?.sourceView = self.view
            self.present(activity, animated: true, completion: nil)
        }
//        click vào button đánh giá app
        if indexPath.row == 1 {
            self.closeLeft()
            SKStoreReviewController.requestReview()
        }
//        click vào button giới thiệu
        if indexPath.row == 2 {
            self.closeLeft()
            let inforProduc = storyboard?.instantiateViewController(withIdentifier: "InforProductViewController")
            self.present(inforProduc!, animated: true, completion: nil)
        }
//        click vào button thay đổi mật khẩu
        if indexPath.row == 3 {
            self.closeLeft()
            let changeVC = storyboard?.instantiateViewController(withIdentifier: "ChangePassViewController")
            self.present(changeVC!, animated: true, completion: nil)
        }
//        click vào button đăng xuất
        if indexPath.row == 4 {
            self.closeLeft()
            let aler = UIAlertController.init(title: NSLocalizedString(MatchKeyLocalizable.kTextLogout, comment: ""), message: NSLocalizedString(MatchKeyLocalizable.kTextQuestionLogin, comment: ""), preferredStyle: .alert)
            let actionYes = UIAlertAction.init(title: NSLocalizedString(MatchKeyLocalizable.kTextYes, comment: ""), style: .default, handler: { (aler) in
                //quay ve man login
                self.dismiss(animated: true, completion: nil)
                //xoa token da luu
                UserDefaults.standard.set("", forKey: "token")
                UserDefaults.standard.synchronize()
            })
            let actionNo = UIAlertAction.init(title: NSLocalizedString(MatchKeyLocalizable.kTextNo, comment: ""), style: .cancel, handler: nil)
            aler.addAction(actionYes)
            aler.addAction(actionNo)
            self.present(aler, animated: true, completion: nil)
        }
    }
}
