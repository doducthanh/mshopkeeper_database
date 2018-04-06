//
//  Detail_ItemViewController.swift
//  MShopKeeper
//
//  Created by ddthanh on 1/30/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class Detail_ItemViewController: UIViewController {

    //MARK: Property
    var viewHeader: UIView!
    var heightBar: CGFloat!
    var btMenu: UIButton!
    var btScan: UIButton!
    var btSearch: UIButton!
    var btBack: UIButton!
    var lbTitle: UILabel!
    var textfieldSearch: UITextField!
    var selectSwitch = 0
    
    var isTapItem: Bool!
    var isHaveProduct: Bool! = false
    var isButtonSelect = false
    var arrayColor = ["xanh", "do", "vang", "tim"]
    var arraySize = ["S"]
    var arrayButton:[CustomButton] = [CustomButton]()
    var arrayItem = [Item]()
    
    var imageString: String!
    
    let heighButton = 50
    let widthButton = 80
    
    var buttonMode: ButtonMode!
    var myTable: UITableView!
    var viewAddress: UIView!
    var heightViewScroll: CGFloat!
    
    var color = ""
    var size = ""
    
    @IBOutlet weak var imgSale: UIImageView!
    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var viewItem: UIView!
    @IBOutlet weak var viewColors: UIView!
    @IBOutlet weak var viewSize: UIView!
    @IBOutlet weak var viewFunc: UIView!
    @IBOutlet weak var viewScroll: UIView!
    
    @IBOutlet weak var contraintTopImage: NSLayoutConstraint!
    @IBOutlet weak var contraintHeightItem: NSLayoutConstraint!
    @IBOutlet weak var contranitTopViewMauSac: NSLayoutConstraint!
    @IBOutlet weak var contraintHeightViewColor: NSLayoutConstraint!
    
    @IBOutlet weak var contraintTopViewSize: NSLayoutConstraint!
    @IBOutlet weak var contraintHeightViewSize: NSLayoutConstraint!
    @IBOutlet weak var contraintHeightScrollView: NSLayoutConstraint!
    @IBOutlet weak var contraintBotViewResult: NSLayoutConstraint!
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var lbSKU: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    //MARK: Cycle view
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        initParam()
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        heightViewScroll = self.contraintHeightScrollView.constant
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isHaveProduct {
            contraintHeightScrollView.constant = 620 + viewSize.frame.height + viewColors.frame.height
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: private func
    
    /// khởi tao các thành phần cần thiết trên màn hình
    func initUI() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        HomeViewController.viewHeader.btMenu.isHidden = true
        HomeViewController.viewHeader.btBack.isHidden = false
        let title = UserDefaults.standard.value(forKey: "modelName") as! String
        HomeViewController.viewHeader.lbTitle.text = title
        HomeViewController.viewHeader.delegate = self

//        kiểm tra để hiển thị view có sản phẩm hoặc không.
        if isHaveProduct {
            resetUILayout()
        } else {
            viewFunc.isHidden = true
            let viewOut = ViewOutOfStock.init(frame: CGRect.init(x: 10, y: 300, width: self.view.frame.width, height: 217))
            viewScroll.addSubview(viewOut)
            contraintHeightScrollView.constant = 550
        }
    }
    
    /// vẽ lại giao diện group button khi có dữ liệu
    func resetUILayout() {
        // draw buttons color
        buttonMode = ButtonMode.init()
        buttonMode.delegate = self
        //vẽ group button color
        buttonMode.drawButtons(number: arrayColor.count, viewSub: viewColors, array: arrayColor, tag: 0) { (count) in
            contraintHeightViewColor.constant = CGFloat(20 + count*(heighButton + 20))
            contranitTopViewMauSac.constant = 35
            contraintHeightScrollView.constant = 620 + viewSize.frame.height + viewColors.frame.height
        }
        //vẽ group button size
        buttonMode.drawButtons(number: arraySize.count, viewSub: viewSize, array: arraySize, tag: 1) { (count) in
            contraintHeightViewSize.constant = CGFloat(35 + count*(heighButton + 15))
            contraintTopViewSize.constant = contraintHeightViewColor.constant + 70
            contraintHeightScrollView.constant = 620 + viewSize.frame.height + viewColors.frame.height
        }
        buttonMode.setAlphaButton(tag: 1)
    }

    /// khởi tạo các giá trị thsm số ban đầu
    func initParam() {
        isTapItem = false
        let tapItem = UITapGestureRecognizer.init(target: self, action: #selector(ScaleItem))
        viewItem.addGestureRecognizer(tapItem)
        let pictureLink = UserDefaults.standard.value(forKey: "pictureLink") as! String
        let resource = ImageResource.init(downloadURL: URL.init(string: pictureLink)!, cacheKey: pictureLink)
        self.imageItem.kf.setImage(with: resource)
        
    }
    
    /// hàm dùng khi click vào ảnh sản phẩm
    @objc func ScaleItem() {
        if !isTapItem {
            UIView.animate(withDuration: 1, animations: {
                self.contraintHeightItem.constant = 270
                self.isTapItem = true
                self.contraintTopImage.constant = 25
            })
        }else{
            UIView.animate(withDuration: 1, animations: {
                self.isTapItem = false
                self.contraintHeightItem.constant = 250
                self.contraintTopImage.constant = 15
            })
        }
    }
    /// khi click vào segment
    @IBAction func onSegentChange(_ sender: Any) {
        selectSwitch = segment.selectedSegmentIndex
        isButtonSelect = false
        
        //update config for buttons
        if segment.selectedSegmentIndex == 1 {
            contraintTopViewSize.constant = 35
            contranitTopViewMauSac.constant = contraintHeightViewSize.constant + 70
            buttonMode.setAlphaButton(tag: 0)
        }
        //update config for buttons
        if segment.selectedSegmentIndex == 0 {
            contraintTopViewSize.constant = contraintHeightViewColor.constant + 70
            contranitTopViewMauSac.constant = 35
            buttonMode.setAlphaButton(tag: 1)
        }
    }
    
    @IBAction func onClickSegmentAddress(_ sender: Any) {
        let segment = sender as! UISegmentedControl
        if segment.selectedSegmentIndex == 0 {
            CommonVariable.isSelectShopCurrent = true
        } else {
            CommonVariable.isSelectShopCurrent = false
        }
        self.setUI(color: self.color, size: self.size)
    }
    @objc func onClickSwitch() {
        
    }
}

extension Detail_ItemViewController: CustomNavigationBarDelegate {
    func tapSlideMenu() {
        
    }
    
    /// hàm thực hiện khi click vào button back
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
        HomeViewController.viewHeader.btBack.isHidden = true
        HomeViewController.viewHeader.btMenu.isHidden = false
        HomeViewController.viewHeader.lbTitle.text = "Tư vấn bán hàng"
    }
    
    /// hàm thực hiện khi click vào button search
    func tapSearchButton() {
        self.navigationController?.popViewController(animated: true)
        HomeViewController.viewHeader.btBack.isHidden = false
        HomeViewController.viewHeader.btMenu.isHidden = true
        HomeViewController.viewHeader.textfieldSearch.isHidden = false
        HomeViewController.viewHeader.textfieldSearch.becomeFirstResponder()
        HomeViewController.viewHeader.btSearch.isHidden = true
    }
    
    func tapScanCode() {
        
    }

}

extension Detail_ItemViewController: ButtonModeProtocol {
    func onClickButton(bt: CustomButton) {
        //self.contraintHeightScrollView.constant = CGFloat(620 + Int(viewSize.frame.height) + Int(viewColors.frame.height) + 30)
        self.buttonMode.setOnClickButton(bt: bt, selectSwitch: selectSwitch, isButtonSelect: &isButtonSelect)
    }
    
    /// hàm vẽ lại giao diện khi có button được lựa chọn
    ///
    /// - Parameters:
    ///   - color: tên màu
    ///   - size: tên kích thuước
    func setUI(color: String, size: String) {
        self.color = color
        self.size = size
        let itemMode = ItemModel()
        itemMode.delegate = self
        itemMode.arrayItem = self.arrayItem
        itemMode.color = color
        itemMode.size = size
        HomeViewController.viewHeader.lbTitle.text! = (UserDefaults.standard.value(forKey: "modelName") as! String) + "-" + color + "-" + size
        lbPrice.text = itemMode.getPrice(color: color, size: size)
        lbSKU.text = itemMode.getSKUCode(color: color, size: size)
//        thực hiện thêm view địa chỉ vào màn hình và set lại contraint
        
        
        let height = CGFloat(620 + Int(viewSize.frame.height) + Int(viewColors.frame.height))
        let array = itemMode.getArrayItemSelect(color: color, size: size)
        let frame = CGRect.init(x: 30, y: Int(height + 10), width: Int(self.view.frame.width - 60), height: 10 + array.count * 40)
        
        if self.viewAddress != nil {
            self.viewAddress.removeFromSuperview()
        }

        viewAddress = itemMode.addViewAddress(array: array, frame: frame)
        let count = CommonVariable.numberRowAddress
        if count > 0 {
            self.viewAddress.isHidden = false
            self.viewScroll.addSubview(viewAddress)
            self.contraintHeightScrollView.constant = CGFloat(620 + Int(viewSize.frame.height) + Int(viewColors.frame.height) + (40*count + 120))
            self.contraintBotViewResult.constant = CGFloat(40*count + 120)
        } else {
            self.contraintHeightScrollView.constant = CGFloat(620 + Int(viewSize.frame.height) + Int(viewColors.frame.height) + 20)
            self.contraintBotViewResult.constant = CGFloat(30)
        }
    }
    
    @objc func onClickSegment(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            CommonVariable.isSelectShopCurrent = true
        } else {
            CommonVariable.isSelectShopCurrent = false
        }
        self.setUI(color: self.color, size: self.size)
    }
}

extension Detail_ItemViewController: ItemModelDelegate {
    func segmentChangeValue(index: Int) {
        setUI(color: self.color, size: self.size)
    }
}
