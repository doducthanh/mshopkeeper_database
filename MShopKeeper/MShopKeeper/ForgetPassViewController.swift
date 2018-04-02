//
//  ForgetPassViewController.swift
//  MShopKeeper
//
//  Created by ddthanh on 2/21/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import UIKit
import Alamofire

class ForgetPassViewController: UIViewController {

    @IBOutlet weak var btGetPass: UIButton!
    @IBOutlet weak var lbLine: UILabel!
    @IBOutlet weak var textfieldStore: UITextField!
    @IBOutlet weak var textfieldUserName: UITextField!
    @IBOutlet weak var lbUserName: UILabel!
    
    var requestAPI: RequestAPIModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        btGetPass.layer.cornerRadius = 5
        btGetPass.layer.masksToBounds = true
        lbUserName.isHidden = true
        initParam()
    }

    func initParam() {
        textfieldStore.delegate = self
        textfieldUserName.delegate = self
        textfieldStore.returnKeyType = .next
        textfieldUserName.returnKeyType = .done
        textfieldStore.clearButtonMode = .whileEditing
        textfieldUserName.clearButtonMode = .whileEditing
        textfieldUserName.addTarget(self, action: #selector(onClickTextField), for: .touchUpInside)
    }
    
    func showDisInternet() {
        let aler = UIAlertController.init(title: "Mat ket noi", message: "Vui long kiem tra lai tinh trang mang", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
        aler.addAction(action)
        self.present(aler, animated: true, completion: nil)
    }
    
    @objc func onClickTextField() {
        textfieldUserName.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func onClickGetPass(_ sender: Any) {
        if (textfieldUserName.text?.isEmpty)! {
            textfieldUserName.becomeFirstResponder()
            return
        }
        if (textfieldStore.text?.isEmpty)! {
            textfieldStore.becomeFirstResponder()
            return
        }
        textfieldUserName.resignFirstResponder()
        textfieldStore.resignFirstResponder()
        requestAPI = RequestAPIModel()
//        let token = UserDefaults.standard.value(forKey: "token") as! String
        requestAPI.getPassword(username: textfieldUserName.text!, companyCode: textfieldStore.text!) { (status, pass) in
            if status == 404 {
                self.showDisInternet()
                return
            }
            let aler = UIAlertController.init(title: "Password", message: pass, preferredStyle: .alert)
            let ok = UIAlertAction.init(title: NSLocalizedString(MatchKeyLocalizable.kTextOK, comment: ""), style: .cancel, handler: nil)
            aler.addAction(ok)
            self.present(aler, animated: true, completion: nil)
        }
    }
}

extension ForgetPassViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textfieldStore {
            textfieldUserName.becomeFirstResponder()
        }
        if textField == textfieldUserName {
            textField.resignFirstResponder()
            if (textfieldUserName.text?.isEmpty)!{
                lbLine.backgroundColor = .red
                lbUserName.isHidden = false
            }else{
                lbLine.backgroundColor = UIColor.lightGray
                lbUserName.isHidden = true
            }
        }
        return true
    }
}
