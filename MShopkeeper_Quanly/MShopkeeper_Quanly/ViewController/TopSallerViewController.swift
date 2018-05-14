//
//  TopSallerViewController.swift
//  MShopkeeper_Quanly
//
//  Created by ddthanh on 4/10/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class TopSallerViewController: UIViewController {

    @IBOutlet var tableTopItem: UITableView!
    @IBOutlet var tableTopSearch: UITableView!
    @IBOutlet var lbShopName: UILabel!
    @IBOutlet var lbAddress: UILabel!
    @IBOutlet var btOtherShop: UIButton!
    
    var arrayProduct: [Dictionary<String, Any>] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let dic = UserDefaults.standard.value(forKey: "User_Information") as! Dictionary<String, String>
        self.lbShopName.text = dic["Name_Store"]
        
        let requestAPI = RequestAPIModel()
        requestAPI.getTopProductShop(type: 0, shopID: 3) { (array) in
            self.arrayProduct = array
            DispatchQueue.main.async {
                self.tableTopItem.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickMenu(_ sender: Any) {
        openLeft()
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

extension TopSallerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib.init(nibName: "TopItemTableViewCell", bundle: nil), forCellReuseIdentifier: "mycell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell") as! TopItemTableViewCell
        cell.img.text = String(indexPath.row + 1)
        if arrayProduct.count > 0 {
            cell.lbName.text = (self.arrayProduct[indexPath.row]["modelName"] as! String) + " (" + (self.arrayProduct[indexPath.row]["color"] as! String) + "-" + (self.arrayProduct[indexPath.row]["size"] as! String) + ")"
            cell.lbCount.text = (self.arrayProduct[indexPath.row]["count"] as! Int).description
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

