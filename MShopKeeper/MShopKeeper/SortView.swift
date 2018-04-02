//
//  SortView.swift
//  MShopKeeper
//
//  Created by ddthanh on 2/7/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import UIKit
//class hiển thị lọc dữ liệu
class SortView: UIViewController {

    @IBOutlet weak var viewBackground: UIView!
    let arrayText = ["Tên mẫu mã", "Hàng mới về", "Hàng bán chạy", "Hàng khuyến mại"]
    var delegate: SortViewDelegate!
    var itemSelect:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        itemSelect = UserDefaults.standard.integer(forKey: "ItemSortSelect")
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

extension SortView: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib.init(nibName: "PopupCell", bundle: nil), forCellReuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PopupCell
        cell?.labelText.text = arrayText[indexPath.row]
        if indexPath.row == itemSelect {
            cell?.img.isHidden = false
        }else{
            cell?.img.isHidden = true
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.onClickCellSort(text: arrayText[indexPath.row], index: indexPath.row)
        UserDefaults.standard.set(indexPath.row, forKey: "ItemSortSelect")
        UserDefaults.standard.synchronize()
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
}

protocol SortViewDelegate {
    func onClickCellSort(text: String, index: Int)
}

