//
//  MenuViewController.swift
//  MShopkeeper_Quanly
//
//  Created by ddthanh on 4/9/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var imageAvatar: UIImageView!
    
    @IBOutlet weak var lbFullName: UILabel!
    @IBOutlet weak var lbNameShop: UILabel!
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell") as! MenuTableViewCell
        cell.row = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.closeLeft()
            let bussinessStatus = storyboard?.instantiateViewController(withIdentifier: "BusinessSituationViewController")
            let navigation = UINavigationController.init(rootViewController: bussinessStatus!)
            self.slideMenuController()?.mainViewController = navigation
        }
        //        click vào button tư vấn
        if indexPath.row == 1 {
            self.closeLeft()
            let topSaller = storyboard?.instantiateViewController(withIdentifier: "TopSallerViewController")
            let navigation = UINavigationController.init(rootViewController: topSaller!)
            self.slideMenuController()?.mainViewController = navigation
        }
    }
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//        //        click vào button tư vấn
//        if indexPath.row == 0 {
//            self.closeLeft()
//            let changeVC = storyboard?.instantiateViewController(withIdentifier: "SelectCustomerViewController")
//            self.present(changeVC!, animated: true, completion: nil)
//        }
//        //        click vào button tư vấn
//        if indexPath.row == 1 {
//            self.closeLeft()
//            let topSaller = storyboard?.instantiateViewController(withIdentifier: "TopSallerViewController")
//            self.slideMenuController()?.navigationController?.pushViewController(topSaller!, animated: true)
//        }
//        //        click vào button chia sẻ app
//        if indexPath.row == 2 {
//            self.closeLeft()
//            let activity = UIActivityViewController.init(activityItems: ["www.google.co.in"], applicationActivities: nil)
//            activity.popoverPresentationController?.sourceView = self.view
//            self.present(activity, animated: true, completion: nil)
//        }
//        //        click vào button đánh giá app
//        if indexPath.row == 3 {
//            self.closeLeft()
//            //            SKStoreReviewController.requestReview()
//        }
//        //        click vào button giới thiệu
//        if indexPath.row == 4 {
//            self.closeLeft()
//            let inforProduc = storyboard?.instantiateViewController(withIdentifier: "InforProductViewController")
//            self.present(inforProduc!, animated: true, completion: nil)
//        }
//        //        click vào button thay đổi mật khẩu
//        if indexPath.row == 5 {
//            self.closeLeft()
//            let changeVC = storyboard?.instantiateViewController(withIdentifier: "ChangePassViewController")
//            self.present(changeVC!, animated: true, completion: nil)
//        }
//        //        click vào button đăng xuất
//        if indexPath.row == 6 {
//            self.closeLeft()
//            let aler = UIAlertController.init(title: "", message: "", preferredStyle: .alert)
//            let actionYes = UIAlertAction.init(title: "Yes", style: .default, handler: { (aler) in
//                //quay ve man login
//                self.dismiss(animated: true, completion: nil)
//                //xoa token da luu
//                UserDefaults.standard.set("", forKey: "token")
//                UserDefaults.standard.synchronize()
//            })
//            let actionNo = UIAlertAction.init(title: "No", style: .cancel, handler: nil)
//            aler.addAction(actionYes)
//            aler.addAction(actionNo)
//            self.present(aler, animated: true, completion: nil)
//        }
//    }
 
}
