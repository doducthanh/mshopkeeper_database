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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell") as! MenuTableViewCell
        cell.row = indexPath.row
        return cell
    }
    
    
}
