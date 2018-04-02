//
//  InforProductViewController.swift
//  MShopKeeper
//
//  Created by ddthanh on 2/1/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import UIKit

class InforProductViewController: UIViewController {

    @IBOutlet weak var btWebsite: UIButton!
    @IBOutlet weak var btHelp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// vẽ giao diện.
    func initUI(){
//        vẽ button website
        let imgWeb = UIImageView.init()
        imgWeb.image = UIImage.init(named: "ic_browser")
        imgWeb.frame = CGRect.init(x: 10, y: btWebsite.frame.height/4, width: btWebsite.frame.height/2, height: btWebsite.frame.height/2)
        btWebsite.addSubview(imgWeb)
        btWebsite.addTarget(self, action: #selector(onClickButtonWebsite), for: .touchUpInside)
        
        let lbWeb = UILabel.init()
        lbWeb.frame = CGRect.init(x: imgWeb.frame.width + 30, y:0 , width: 250, height: btWebsite.frame.height)
        lbWeb.attributedText = NSAttributedString.init(string: "Website ", attributes: nil)
        let multiAttribute = NSMutableAttributedString.init(string: "Website ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)])
        let attribute = [NSAttributedStringKey.foregroundColor: MyColors.BLUE,
                         NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15),
                         NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue] as [NSAttributedStringKey : Any]
        let multiAttribute2 = NSMutableAttributedString.init(string: "www.mshopkeeper.vn", attributes: attribute)
        multiAttribute.append(multiAttribute2)
        lbWeb.attributedText = multiAttribute
        btWebsite.addSubview(lbWeb)
        
//        vẽ button trợ giúp
        let imgHelp = UIImageView.init()
        imgHelp.image = UIImage.init(named: "ic_help_gray")
        imgHelp.frame = CGRect.init(x: 10, y: btHelp.frame.height/4, width: btHelp.frame.height/2, height: btHelp.frame.height/2)
        btHelp.addSubview(imgHelp)
        
        let lbHelp = UILabel.init()
        lbHelp.frame = CGRect.init(x: imgHelp.frame.width + 30, y:0 , width: 250, height: btHelp.frame.height)
        lbHelp.text = NSLocalizedString(MatchKeyLocalizable.kTextHelp, comment: "")
        lbHelp.textColor = .black
        lbHelp.font = UIFont.systemFont(ofSize: 15)
        btHelp.addTarget(self, action: #selector(onClickButtonHelp), for: .touchUpInside)
        btHelp.addSubview(lbHelp)
        
    }
    
    /// sự kiên khi click butotn website
    @objc func onClickButtonWebsite() {
        UIApplication.shared.open(URL.init(string: "https://www.mshopkeeper.vn")!, options: [:], completionHandler: nil)
    }
    
    /// sự kiên khi click button help
    @objc func onClickButtonHelp () {
        UIApplication.shared.open(URL.init(string: "https://mhelp.mshopkeeper.vn/")!, options: [:], completionHandler: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: action

    /// sự kiên khi click button back
    ///
    /// - Parameter sender: 
    @IBAction func onClickBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
