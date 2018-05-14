//
//  OtherShops.swift
//  MShopkeeper_Quanly
//
//  Created by Admin on 4/22/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class OtherShops: UIViewController {

    var arrayShop = [Shop]()
    var delegate: OtherShopDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        let tap = UITapGestureRecognizer.init(target: self, action: #selector(removeView))
//        self.view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func removeView() {
        self.dismiss(animated: true, completion: nil)
    }

}

extension OtherShops: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayShop.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "mycell")
        cell.imageView?.image = UIImage.init(named: "icon")
        cell.textLabel?.text = arrayShop[indexPath.row].shopName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shopid = arrayShop[indexPath.row].shopID
        delegate.selectShop(id: shopid, shop: arrayShop[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }

}

protocol OtherShopDelegate {
    func selectShop(id: Int, shop: Shop)
}
