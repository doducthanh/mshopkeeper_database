//
//  ViewTopRevenue.swift
//  MShopkeeper_Quanly
//
//  Created by Admin on 5/6/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ViewTopRevenue: UIViewController {
    @IBOutlet var viewBackground: UIView!
    var array: [Dictionary<String, Any>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(tapView))
        viewBackground.addGestureRecognizer(pan)
    }
    
    @objc func tapView() {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewTopRevenue: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib.init(nibName: "TopRevenueTableViewCell", bundle: nil), forCellReuseIdentifier: "mycell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell") as! TopRevenueTableViewCell
        cell.lbShopName.text = (array[indexPath.row]["shopName"] as! String)
        cell.lbShopRevenue.text = (array[indexPath.row]["doanhthu"] as! Int).description
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
}
