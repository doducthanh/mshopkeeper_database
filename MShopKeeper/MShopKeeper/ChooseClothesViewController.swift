//
//  ChooseClothesViewController.swift
//  MShopKeeper
//
//  Created by Admin on 4/6/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import UIKit

class ChooseClothesViewController: UIViewController {

    @IBOutlet var btAo: ButtonSelect!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let bt = ButtonSelect.init(frame: btAo.frame)
        bt.drawButton(frame: btAo.frame, lbText: "Ao", img: UIImage.init(named: "icon_tick")!)
        self.view.addSubview(bt)
        
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
