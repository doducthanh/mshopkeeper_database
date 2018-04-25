//
//  LogInViewController.swift
//  MShopKeeper
//
//  Created by ddthanh on 1/18/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import UIKit
import Alamofire

class LogInViewController: UIViewController, UITextFieldDelegate, UISearchBarDelegate {
    //MARK: properties
//    các thuộc tính kéo tư Storyboard
    @IBOutlet weak var viewInput: UIView!
    @IBOutlet weak var textfieldStore: UITextField!
    @IBOutlet weak var textfieldUser: UITextField!
    @IBOutlet weak var textfieldPass: UITextField!
    @IBOutlet weak var btLogin: UIButton!
    @IBOutlet weak var contraintHeightView: NSLayoutConstraint!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var contraintViewInputX: NSLayoutConstraint!
    
    var requestAPI: RequestAPIModel!
    
//    var viewWait: ViewWaiting!
////    các biến view model
//    var userModel: UserModel!
//    var requestAPI: RequestAPIModel!
//    //quản lí animation waiting
//    var viewWaitingModel: ViewWaitingModel!

    //MARK: Cycle View
    override func loadView() {
        super.loadView()
        contraintHeightView.constant = self.view.frame.height
//        if AppDelegate.isPortrait! {
//            contraintHeightView.constant = self.view.frame.size.height
//        }else{
//            if UIDevice.current.userInterfaceIdiom == .phone {
//                contraintHeightView.constant = 568
//            }
//            if UIDevice.current.userInterfaceIdiom == .pad {
//                contraintHeightView.constant = self.view.frame.size.height
//            }
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contraintHeightView.constant = self.view.frame.height
        initUI()
        initParam()
        autoMoveScreen()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let dic = UserDefaults.standard.dictionary(forKey: "User_Information") else { return }
        textfieldStore.text = dic["Name_Store"] as? String
        textfieldUser.text = dic["User_Name"] as? String
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isPortrait {
            contraintHeightView.constant = self.view.frame.size.height
        }else{
            if UIDevice.current.userInterfaceIdiom == .phone {
                contraintHeightView.constant = 568
            }
            if UIDevice.current.userInterfaceIdiom == .pad {
                contraintHeightView.constant = self.view.frame.size.height
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// hàm vẽ giao diên
    func initUI() {
        viewInput.layer.cornerRadius = 5
        viewInput.layer.masksToBounds = true
        btLogin.layer.cornerRadius = 5
        btLogin.layer.masksToBounds = true
        
        //animation
//        viewWaitingModel = ViewWaitingModel.init(frame: self.view.frame, supperview: self)
    }
    
    /// hàm khởi tạo các paramester ban đầu.
    func initParam(){
        textfieldStore.delegate = self
        textfieldUser.delegate = self
        textfieldPass.delegate = self
        textfieldStore.clearButtonMode = .whileEditing
        textfieldUser.clearButtonMode = .whileEditing
        textfieldPass.clearButtonMode = .whileEditing
        textfieldStore.addTarget(self, action: #selector(LogInViewController.tapTextFieldStore), for: .touchUpInside)
        textfieldUser.addTarget(self, action: #selector(tapTextFieldUser), for: .touchUpInside)
        textfieldPass.addTarget(self, action: #selector(tapTextFieldPass), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(hindenBoard))
        self.view.addGestureRecognizer(tap)
        
//        userModel = UserModel()
        requestAPI = RequestAPIModel()
    }
    
    //MARK: private func
    /// hàm chuyển sang màn hình home nếu token còn hiệu lực
    func autoMoveScreen() {
//        viewWaitingModel.startAnimatonWaiting()
////        requestAPI = RequestAPIModel()
//        let token = UserDefaults.standard.value(forKey: "token") as? String
//        if token == nil || token == ""{
//            viewWaitingModel.endAnimationWaiting()
//            return
//        }
//        requestAPI.requestLoginToken(token: token!) { (status) in
//            if status == 200 {
////                chuyển từ màn login sang màn home
//                let main = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
//                let left = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController")
//                let navigation = UINavigationController.init(rootViewController: main!)
//                let slideMenu = SlideMenuController(mainViewController: navigation, leftMenuViewController: left!)
//                slideMenu.mainContainerView.backgroundColor = .white
//                slideMenu.opacityView.backgroundColor = .white
//                self.viewWaitingModel.endAnimationWaiting()
//                self.show(slideMenu, sender: nil)
//                self.viewWaitingModel.endAnimationWaiting()
//            } else {
//                self.viewWaitingModel.endAnimationWaiting()
//                return
//            }
//        }
    }

    /// hàm điểu khiển scroll màn hình kh
    @objc func hindenBoard() {
        textfieldStore.resignFirstResponder()
        textfieldUser.resignFirstResponder()
        textfieldPass.resignFirstResponder()
        if UIDevice.current.orientation.isPortrait {
            contraintHeightView.constant = self.view.frame.size.height
        }else{
            if UIDevice.current.userInterfaceIdiom == .phone {
                contraintHeightView.constant = 568
            }
            if UIDevice.current.userInterfaceIdiom == .pad {
                contraintHeightView.constant = self.view.frame.size.height
            }
        }
    }
    /// khi click vào trươngf tên cửa hàng
    @objc func tapTextFieldStore() {
        scrollview.setContentOffset(textfieldStore.frame.origin, animated: true)
    }
    /// khi click vào trường tên người dùng
    @objc func tapTextFieldUser() {
        scrollview.setContentOffset(textfieldUser.frame.origin, animated: true)
    }
    /// khi click vào trươngf password
    @objc func tapTextFieldPass() {
        scrollview.setContentOffset(textfieldPass.frame.origin, animated: true)
    }
    /// hàm show giao diện khi mất kết nối.
    func showDisInternet() {
        let aler = UIAlertController.init(title: "Mat ket noi", message: "Vui long kiem tra lai tinh trang mang", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
        aler.addAction(action)
        self.present(aler, animated: true, completion: nil)
    }
    
    //MARK: action
    /// sự kiện khi click vào button login
    @IBAction func onClickLogin(_ sender: Any) {
//         kiểm tra các trường nhập dữ liệu
        if (textfieldStore.text?.isEmpty)! {
            textfieldStore.becomeFirstResponder()
            return
        }else if (textfieldUser.text?.isEmpty)! {
            textfieldUser.becomeFirstResponder()
            return
        }else if (textfieldPass.text?.isEmpty)! {
            textfieldPass.becomeFirstResponder()
            return
        }
//        ẩn bàn phím
        contraintHeightView.constant = view.frame.size.height
        textfieldStore.resignFirstResponder()
        textfieldUser.resignFirstResponder()
        textfieldPass.resignFirstResponder()
        
//        let main = self.storyboard?.instantiateViewController(withIdentifier: "BusinessSituationViewController")
//        let left = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController")
//        let navigation = UINavigationController.init(rootViewController: main!)
//        let slideMenu = SlideMenuController(mainViewController: navigation, leftMenuViewController: left!)
//        slideMenu.mainContainerView.backgroundColor = .white
//        slideMenu.opacityView.backgroundColor = .white
//        self.show(slideMenu, sender: nil)
        
//        self.viewWaitingModel.startAnimatonWaiting()
//        gửi yêu cầu đăng nhập
        requestAPI.requestLogin(companyCode: textfieldStore.text!, username: textfieldUser.text!, password: textfieldPass.text!) { (value, error) in
            if (value as? Int) == 404 {
                self.showDisInternet()
            }
            if (value as? Int) == 200 {
                //set lai userName va NameStore trong UserDefault
                let dic = ["Name_Store":self.textfieldStore.text, "User_Name":self.textfieldUser.text, "Pass":self.textfieldPass.text]
                UserDefaults.standard.setValue(dic, forKeyPath: "User_Information")
                UserDefaults.standard.synchronize()
                //set lại thông tin cơ bản về người dùng
                //chuyen sang man hinh home.
                let main = self.storyboard?.instantiateViewController(withIdentifier: "BusinessSituationViewController")
                let left = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController")
                let navigation = UINavigationController.init(rootViewController: main!)
                let slideMenu = SlideMenuController(mainViewController: navigation, leftMenuViewController: left!)
                slideMenu.mainContainerView.backgroundColor = .white
                slideMenu.opacityView.backgroundColor = .white
                //self.viewWaitingModel.endAnimationWaiting()
                self.show(slideMenu, sender: nil)
            } else {
                print("invadiate infor")
                //self.viewWaitingModel.endAnimationWaiting()
            }
        }
    }
    
    /// sự kiện khi click vào button giới thiệu
    @IBAction func onClickIntroduce(_ sender: Any) {
//        let viewIntro = ViewIntroduce.init(nibName: "ViewIntroduce", bundle: nil)
//        self.addChildViewController(viewIntro)
//        viewIntro.delegate = self as endEditingDelegate
//        viewIntro.view.frame = self.view.frame
//        self.view.addSubview(viewIntro.view)
    }
    
    /// sự kiện khi click vào button quên mật khẩu
    @IBAction func onClickForgetPass(_ sender: Any) {
        let forgetVC = storyboard?.instantiateViewController(withIdentifier: "ForgetPassViewController")
        self.present(forgetVC!, animated: true, completion: nil)
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        scrollview.setContentOffset(CGPoint.init(x: 0, y: 50), animated: true)
        if UIDevice.current.orientation.isPortrait {
            contraintHeightView.constant = self.view.frame.size.height + 50
        }else{
            contraintHeightView.constant = 600
        }
        if UIDevice.current.userInterfaceIdiom == .pad{
            contraintHeightView.constant = self.view.frame.height + 20
        }
        return true
    }
    
    // sự kiên khi click vào button return trên keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case textfieldStore:
            textfieldUser.becomeFirstResponder()
            break
        case textfieldUser:
            textfieldPass.becomeFirstResponder()
            break
        case textfieldPass:
            if (textfieldStore.text?.isEmpty)! || (textfieldUser.text?.isEmpty)! ||
                (textfieldPass.text?.isEmpty)! {
                textField.resignFirstResponder()
            }else{
                textField.resignFirstResponder()
                contraintHeightView.constant = self.view.frame.height
            }
//            if AppDelegate.isPortrait! {
//                contraintHeightView.constant = self.view.frame.size.height
//                contraintViewInputX.constant = 0
//            }else{
//                contraintHeightView.constant = 600
//            }
            break
        default:
            break
        }
        return true
    }
}

//extension LogInViewController: endEditingDelegate {
//    func returnKeyBoard() {
//        contraintHeightView.constant = view.frame.size.height
//    }
//}

