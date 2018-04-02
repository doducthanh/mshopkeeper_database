//
//  CatalogItem.swift
//  MShopKeeper
//
//  Created by ddthanh on 2/2/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import UIKit
// class hiển thị danh sách sản phẩm
class CatalogItem: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var viewBackground: UIView!
    var delegate: CatalogItemDelegate!
    var arrayContent = [Model]()
    var itemSelect: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        itemSelect = UserDefaults.standard.integer(forKey: "CatalogItemSelect")
        let tap: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapView))
        self.viewBackground.addGestureRecognizer(tap)
    }

    @objc func tapView() {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onClickClose(_ sender: Any) {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }

}

extension CatalogItem: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayContent.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib.init(nibName: "PopupCell", bundle: nil), forCellReuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PopupCell
        cell?.labelText.text = arrayContent[indexPath.row].modelName
        if indexPath.row == 0 {
            cell?.labelText.text = "Tất cả"
        }
        if indexPath.row == itemSelect {
            cell?.img.isHidden = false
        }else{
            cell?.img.isHidden = true
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PopupCell
        if indexPath.row != 0 {
            delegate.onClickCellItem(model: [arrayContent[indexPath.row]], title: cell.labelText.text!)
            UserDefaults.standard.set(indexPath.row, forKey: "CatalogItemSelect")
            UserDefaults.standard.synchronize()
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        }
        if indexPath.row == 0 {
            delegate.onClickCellItem(model: arrayContent, title: cell.labelText.text!)
            UserDefaults.standard.set(indexPath.row, forKey: "CatalogItemSelect")
            UserDefaults.standard.synchronize()
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        }
        
    }
}

protocol CatalogItemDelegate {
    func onClickCellItem(model: [Model], title: String)
}
