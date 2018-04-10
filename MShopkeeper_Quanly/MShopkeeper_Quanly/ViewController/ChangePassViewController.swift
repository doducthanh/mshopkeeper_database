//
//  ChangePassViewController.swift
//  MShopKeeper
//
//  Created by ddthanh on 2/1/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import UIKit

class ChangePassViewController: UIViewController {

    //MARK: property
    @IBOutlet weak var textfieldCurrentPass: UITextField!
    @IBOutlet weak var textfieldNewPass: UITextField!
    @IBOutlet weak var textfieldConfirmPass: UITextField!
    
    @IBOutlet weak var lbCurrentPass: UILabel!
    @IBOutlet weak var lbNewPass: UILabel!
    @IBOutlet weak var lbConfirmPass: UILabel!
    @IBOutlet weak var lbLineCurrentPass: UILabel!
    @IBOutlet weak var lbLineNewPass: UILabel!
    @IBOutlet weak var lbLineConfirmPass: UILabel!
    
    @IBOutlet weak var btChangePass: UIButton!
    
//    var manageInputTextModel: ManageInputModel!
//    var requestAPI: RequestAPIModel!
    //MARK: Cycle view
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initParam()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: private function
    func initUI() {
        btChangePass.layer.cornerRadius = 5
        btChangePass.layer.masksToBounds = true
    }
    
    /// set giá trị cuả tham số ban đầu
    func initParam(){
        textfieldCurrentPass.delegate = self
        textfieldNewPass.delegate = self
        textfieldConfirmPass.delegate = self
        textfieldCurrentPass.becomeFirstResponder()
//        manageInputTextModel = ManageInputModel()
//        requestAPI = RequestAPIModel()
    }
    
    //MARK: action
    /// sự kiện khi click vào button back
    ///
    /// - Parameter sender:
    @IBAction func onClickBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// sự kiện khi click vào button đổi password
    ///
    /// - Parameter sender:
    @IBAction func onClickChangePass(_ sender: Any) {
//        kiểm tra các trường dữ liệu
        if (textfieldCurrentPass.text?.isEmpty)! {
            textfieldCurrentPass.becomeFirstResponder()
            return
        }
        if (textfieldNewPass.text?.isEmpty)! {
            textfieldNewPass.becomeFirstResponder()
            return
        }
        if (textfieldConfirmPass.text?.isEmpty)! {
            textfieldConfirmPass.becomeFirstResponder()
            return
        }
        if textfieldNewPass.text! != textfieldConfirmPass.text! {
            return
        }
        //do something.
//        let token = UserDefaults.standard.value(forKey: "token") as! String
//        requestAPI.changePassword(token: token, newPass: textfieldNewPass.text!) { (status) in
////            ẩn bàn phím
//            self.textfieldNewPass.resignFirstResponder()
//            self.textfieldConfirmPass.resignFirstResponder()
//            self.textfieldCurrentPass.resignFirstResponder()
//            if status == 200 {
//                let aler = UIAlertController.init(title: NSLocalizedString(MatchKeyLocalizable.kChangePassSuccess, comment: ""), message: nil, preferredStyle: .alert)
//                let action = UIAlertAction.init(title: NSLocalizedString(MatchKeyLocalizable.kTextOK, comment: ""), style: .default, handler: { (aler) in
//                    self.dismiss(animated: true, completion: nil)
//                    UserDefaults.standard.set("", forKey: "token")
//                    UserDefaults.standard.synchronize()
//                })
//                aler.addAction(action)
//                self.present(aler, animated: true, completion: nil)
//                print("change password success")
//            } else {
//                print ("change password error")
//            }
//        }
    }
}

extension ChangePassViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textfieldCurrentPass {
            textfieldNewPass.becomeFirstResponder()
            if (textfieldCurrentPass.text?.isEmpty)!{
                lbLineCurrentPass.backgroundColor = .red
                lbCurrentPass.isHidden = false
            }else{
                lbLineCurrentPass.backgroundColor = .black
                lbCurrentPass.isHidden = true
            }
        }
//        if textField == textfieldNewPass {
//            textfieldConfirmPass.becomeFirstResponder()
//            if (textfieldNewPass.text?.isEmpty)!{
//                lbLineNewPass.backgroundColor = .red
//                lbNewPass.isHidden = false
//                lbNewPass.text = NSLocalizedString(MatchKeyLocalizable.kTextPassEmpty, comment: "")
//            } else if (manageInputTextModel.checkValidateText(text: textField.text!) == ErorrValidate.textShort) {
//                lbLineNewPass.backgroundColor = .red
//                lbNewPass.isHidden = false
//                lbNewPass.text = NSLocalizedString(MatchKeyLocalizable.kTextPassShort, comment: "")
//            } else{
//                lbLineNewPass.backgroundColor = .black
//                lbNewPass.isHidden = true
//            }
//        }
//        if textField == textfieldConfirmPass {
//            if (textfieldConfirmPass.text?.isEmpty)!{
//                lbLineConfirmPass.backgroundColor = .red
//                lbConfirmPass.isHidden = false
//            } else if (!manageInputTextModel.compairPassword(pass: textfieldNewPass.text!, rePass: textfieldConfirmPass.text!)) {
//                lbConfirmPass.text = NSLocalizedString(MatchKeyLocalizable.kTextPassNotMatch, comment: "")
//                lbConfirmPass.isHidden = false
//            } else{
//                lbLineConfirmPass.backgroundColor = .black
//                lbConfirmPass.isHidden = true
//            }
//            textField.resignFirstResponder()
//        }
        return true
    }
}
