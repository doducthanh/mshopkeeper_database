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
    
    @IBOutlet var btDate: UIButton!
    var id = 0
    var arrayShop: [Shop] = [Shop]()
    var arraySearch: [Dictionary<String, Any>] = []
    var arrayProduct: [Dictionary<String, Any>] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let dic = UserDefaults.standard.value(forKey: "User_Information") as! Dictionary<String, String>
        self.lbShopName.text = dic["Name_Store"]
        
//        let btFilter = UIBarButtonItem.init(title: "Lọc", style: .done, target: self, action: #selector(onClickDate))
//        self.navigationItem.setRightBarButton(btFilter, animated: true)
        self.navigationController?.navigationBar.barTintColor = MyColors.BLUE
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        let requestAPI = RequestAPIModel()
        requestAPI.getTopProductShop(type: 0, shopID: 3) { (array) in
            self.arrayProduct = array
            DispatchQueue.main.async {
                self.tableTopItem.reloadData()
            }
        }
        
        let requestAPI2 = RequestAPIModel()
        requestAPI2.getTopSearch(type: 0, shopID: 3) { (array) in
            self.arraySearch = array
            print(self.arraySearch)
            DispatchQueue.main.async {
                self.tableTopSearch.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickTime(_ sender: Any) {
        let sheetUI = UIAlertController.init(title: "Tình hình doanh thu", message: "Chọn thời gian thống kê", preferredStyle: .actionSheet)
        let day = UIAlertAction.init(title: "Hôm nay", style: .default) { (action) in
            
            let requestAPI = RequestAPIModel()
            requestAPI.getTopProductShop(type: 0, shopID: 3) { (array) in
                self.arrayProduct = array
                DispatchQueue.main.async {
                    self.tableTopItem.reloadData()
                }
            }
            self.btDate.setTitle("Hôm nay", for: .normal)
        }
        let week = UIAlertAction.init(title: "Tuần nay", style: .default) { (action) in
            
            let requestAPI = RequestAPIModel()
            requestAPI.getTopProductShop(type: 1, shopID: 3) { (array) in
                self.arrayProduct = array
                DispatchQueue.main.async {
                    self.tableTopItem.reloadData()
                }
            }
            self.btDate.setTitle("Tuần này", for: .normal)
        }
        let month = UIAlertAction.init(title: "Tháng nay", style: .default) { (action) in
            
            let requestAPI = RequestAPIModel()
            requestAPI.getTopProductShop(type: 3, shopID: 3) { (array) in
                self.arrayProduct = array
                DispatchQueue.main.async {
                    self.tableTopItem.reloadData()
                }
            }
            self.btDate.setTitle("Tháng này", for: .normal)
        }
        sheetUI.addAction(day)
        sheetUI.addAction(week)
        sheetUI.addAction(month)
        self.present(sheetUI, animated: true, completion: nil)
    }
    @IBAction func onClickMenu(_ sender: Any) {
        openLeft()
    }
    
    @IBAction func onClickBtOtherShop(_ sender: Any) {
        // kick vao đây hiển thị danh sách các cửa hàng chi nhánh.
        let requestAPI = RequestAPIModel()
        requestAPI.getShops { (status, arrayShop) in
            let otherVC = OtherShops.init(nibName: "OtherShops", bundle: nil)
            otherVC.arrayShop = arrayShop
            self.arrayShop = arrayShop
            otherVC.delegate = self as OtherShopDelegate
            self.present(otherVC, animated: true, completion: nil)
        }
    }
    
}

extension TopSallerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            return arrayProduct.count
        } else {
            return arraySearch.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 0 {
            tableView.register(UINib.init(nibName: "TopItemTableViewCell", bundle: nil), forCellReuseIdentifier: "mycell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "mycell") as! TopItemTableViewCell
            cell.img.text = String(indexPath.row + 1)
            if arrayProduct.count > 0 {
                cell.lbName.text = (self.arrayProduct[indexPath.row]["modelName"] as! String)
                cell.lbCount.text = (self.arrayProduct[indexPath.row]["count"] as! Int).description
            }
            
            return cell
        } else {
            tableView.register(UINib.init(nibName: "TopItemTableViewCell", bundle: nil), forCellReuseIdentifier: "mycell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "mycell") as! TopItemTableViewCell
            cell.img.text = String(indexPath.row + 1)
            if arraySearch.count > 0 {
                cell.lbName.text = (self.arraySearch[indexPath.row]["modelName"] as! String)
                cell.lbCount.text = (self.arraySearch[indexPath.row]["totalSearch"] as! Int).description
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension TopSallerViewController: OtherShopDelegate {
    func selectShop(id: Int, shop: Shop) {
        let requestAPI = RequestAPIModel()
        requestAPI.getTopProductShop(type: 0, shopID: id) { (array) in
            self.arrayProduct = array
            DispatchQueue.main.async {
                self.tableTopItem.reloadData()
            }
        }
    }
}

