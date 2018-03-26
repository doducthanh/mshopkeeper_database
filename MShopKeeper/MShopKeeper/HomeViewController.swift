//
//  NavigationViewController.swift
//  MShopKeeper
//
//  Created by ddthanh on 1/19/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController, SlideMenuControllerDelegate {
    
    //MARK: Property
    //@IBOutlet weak var viewTatCa: UIView!
    //var viewHeader: UIView!
    @IBOutlet weak var btAllItem: UIButton!
    @IBOutlet weak var btProduct: UIButton!
    
    @IBOutlet weak var constraintLeftCollect: NSLayoutConstraint!
    @IBOutlet weak var constraintRightCollect: NSLayoutConstraint!
    
    var heightBar: CGFloat!
    var btMenu: UIButton!
    var btScan: UIButton!
    var btSearch: UIButton!
    var btBack: UIButton!
    var lbTitle: UILabel!
    var lbAllItem: UILabel!
    var lbProduct: UILabel!
    var textfieldSearch: UITextField!
    
    var heightCollectCell: Double = 200.0
    var widthCollectCell: Double = 150.0
    
    var arrayImg = ["ic_chelsea", "ic_mancity", "ic_arsenal", "ic_introduction2"]
    var arrayModel: [Model]!
    var requestAPI: RequestAPIModel!
    var dataModel: DatabaseModel!
    
    var viewWait: ViewWaitingModel!
    
    var spiner: UIActivityIndicatorView! = nil
    var startIndex = 0
    var endIndex = 100
    
    //public let homeVC: HomeViewControlle
    public static var viewHeader: CustomNavigationBar!
    
    @IBOutlet weak var myCollection: UICollectionView!
    var itemsPerRow = 20
    //MARK: Cycle View
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
           
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInterface()
        viewWait = ViewWaitingModel(frame: self.view.frame, supperview: self)
        viewWait.startAnimatonWaiting()
        initUI()
        initParam()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        HomeViewController.viewHeader.delegate = self
        HomeViewController.viewHeader.lbTitle.text = "Tư vấn bán hàng"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private function
    func checkInternetConnect() {
        NotificationCenter.default.addObserver(self, selector: #selector(statusManager), name: .flagsChanged, object: Network.reachability)
        updateUserInterface()
    }
    
    func updateUserInterface() {
        guard let status = Network.reachability?.status else {
            print("mat ket noi")
            CommonVariable.isDisConnect = true
            return
        }
        CommonVariable.isDisConnect = false
        switch status {
        case .unreachable:
//            view.backgroundColor = .red
            break
        case .wifi:
            view.backgroundColor = .green
            break
        case .wwan:
            view.backgroundColor = .yellow
            break
        }
        print("Reachability Summary")
        print("Status:", status)
        print("HostName:", Network.reachability?.hostname ?? "nil")
        print("Reachable:", Network.reachability?.isReachable ?? "nil")
        print("Wifi:", Network.reachability?.isReachableViaWiFi ?? "nil")
    }
    
    @objc func statusManager(_ notification: Notification) {
        updateUserInterface()
    }
    
    func initUI() {
        heightBar = self.navigationController?.navigationBar.frame.size.height
        self.navigationController?.navigationBar.barTintColor = MyColors.BLUE

        HomeViewController.viewHeader = CustomNavigationBar.init(frame: CGRect.init(x: 0, y: heightBar/6, width: view.frame.size.width, height: heightBar*2/3 - 5))
        HomeViewController.viewHeader.delegate = self
        HomeViewController.viewHeader.btBack.isHidden = true
        HomeViewController.viewHeader.textfieldSearch.delegate = self
        self.navigationController?.navigationBar.addSubview(HomeViewController.viewHeader)
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            widthCollectCell = 200
            heightCollectCell = 250
        }
    }
    
    func initParam() {
        //Model_SQLite.init()
        // custom các button trên màn hình
        lbAllItem = UILabel.init()
        lbAllItem.frame = CGRect.init(x: 10, y: 0, width: btAllItem.frame.size.width - 40, height: btAllItem.frame.size.height)
        lbAllItem.text = "Tất cả"
        lbAllItem.textColor = .black
        btAllItem.addSubview(lbAllItem)
        
        let imgSpiner = UIImageView.init()
        imgSpiner.image = UIImage.init(named: "ic_dropdown")
        btAllItem.addSubview(imgSpiner)
        imgSpiner.translatesAutoresizingMaskIntoConstraints = false
        imgSpiner.rightAnchor.constraint(equalTo: btAllItem.rightAnchor, constant: 0).isActive = true
        imgSpiner.centerYAnchor.constraint(equalTo: btAllItem.centerYAnchor, constant: 0).isActive = true
        imgSpiner.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imgSpiner.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btAllItem.addTarget(self, action: #selector(onClickButtonTatCa), for: .touchUpInside)
        
        lbProduct = UILabel.init()
        lbProduct.frame = CGRect.init(x: 10, y: 0, width: btProduct.frame.size.width - 40, height: btProduct.frame.size.height)
        lbProduct.text = "Tên mẫu"
        lbProduct.textColor = .black
        btProduct.addSubview(lbProduct)
        
        let imgSpiner2 = UIImageView.init()
        imgSpiner2.image = UIImage.init(named: "ic_dropdown")
        btProduct.addSubview(imgSpiner2)
        imgSpiner2.translatesAutoresizingMaskIntoConstraints = false
        imgSpiner2.rightAnchor.constraint(equalTo: btProduct.rightAnchor, constant: 0).isActive = true
        imgSpiner2.centerYAnchor.constraint(equalTo: btProduct.centerYAnchor, constant: 0).isActive = true
        imgSpiner2.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imgSpiner2.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btProduct.addTarget(self, action: #selector(onClickButtonTenMau), for: .touchUpInside)
        setUpCollectionView()
        
        arrayModel = [Model]()
        let token = UserDefaults.standard.value(forKey: "token") as! String
        requestAPI = RequestAPIModel()
        dataModel = DatabaseModel()
        requestAPI.delegate = self
        requestAPI.getAllModel(token: token, index: 0, startIndex: startIndex, endIndex: endIndex) { (array) in
            self.arrayModel = array
            self.myCollection.reloadData()
            self.dataModel.insertRowModel(arrayModels: array)
            for model in self.arrayModel {
                self.requestAPI.getItemDetal(token: token, modelID: model.modelID, complete: { (arrayColor, arraySize, arrayItem) in
                    self.dataModel.insertRowItem(arrayItems: arrayItem)
                })
            }
            self.viewWait.endAnimationWaiting()
        }
    }
    
    // cấu hình lại kích thươc và vị trí cho cell trong CollectionView
    func setUpCollectionView() {
        let refreshControl = UIRefreshControl.init()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        
        self.myCollection.register(HomeCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footerID")
        let layout = UICollectionViewFlowLayout.init()
        let left: CGFloat = 5
        widthCollectCell = Double(self.view.frame.width/2 - 30/2)
    
        if UIDevice.current.userInterfaceIdiom == .pad {
            widthCollectCell = Double((self.view.frame.width - 50)/4)
        }
        heightCollectCell = 3*widthCollectCell/2
        layout.sectionInset = UIEdgeInsets.init(top: 2*left, left: left, bottom: left, right: left)
        layout.itemSize = CGSize.init(width: widthCollectCell, height: heightCollectCell)
        layout.minimumLineSpacing = 2*left
        layout.minimumInteritemSpacing = 0
        myCollection.setCollectionViewLayout(layout, animated: true)
        constraintLeftCollect.constant = left
        constraintRightCollect.constant = left
        myCollection.refreshControl = refreshControl
        
    }
    
    //
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y >= myCollection.contentOffset.y {
//            self.spiner.startAnimating()
////            print("scrollview height: \(scrollView.contentOffset.y) collectionview:\(myCollection.contentOffset.y)")
//            startIndex = endIndex + 1
//            endIndex = endIndex + 3
//            let token = UserDefaults.standard.value(forKey: "token") as! String
//            requestAPI.getAllModel(token: token, index: 0, startIndex: startIndex, endIndex: endIndex, complete: { (array) in
//                if array.count > 0 {
//                    for model in array {
//                        self.arrayModel.append(model)
//                    }
//                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer) in
//                        self.spiner.stopAnimating()
//                        self.myCollection.reloadData()
//                    })
//
//                }
//                self.spiner.stopAnimating()
//            })
//        }
    }
    
    @objc func reloadData() {
        let token = UserDefaults.standard.value(forKey: "token") as! String
        requestAPI = RequestAPIModel()
        requestAPI.getAllModel(token: token, index: 0, startIndex: 4, endIndex: 20) { (array) in
            self.arrayModel = array
            self.myCollection.reloadData()
            self.viewWait.endAnimationWaiting()
            self.myCollection.refreshControl?.endRefreshing()
        }
    }
    
    //MARK: OnClick
    // sự kiện click vào button tên mẫu
    @objc func onClickButtonTenMau() {
        let sort = SortView.init(nibName: "SortView", bundle: nil)
        sort.view.frame = view.frame
        self.addChildViewController(sort)
        sort.delegate = self
        self.view.addSubview(sort.view)
        HomeViewController.viewHeader.textfieldSearch.resignFirstResponder()
    }
    
    // sự kiện click vào button tất cả
    @objc func onClickButtonTatCa() {
        let catalogItem = CatalogItem.init(nibName: "CatalogItem", bundle: nil)
        catalogItem.view.frame = view.frame
        catalogItem.arrayContent = dataModel.getAllModelRecords()
        self.addChildViewController(catalogItem)
        catalogItem.delegate = self
        self.view.addSubview(catalogItem.view)
        HomeViewController.viewHeader.textfieldSearch.resignFirstResponder()
    }
}

extension HomeViewController: CustomNavigationBarDelegate{
    func tapScanCode() {

    }
    
    func tapSlideMenu() {
        openLeft()
    }
    
    // khi click vào button back
    func tapBackButton() {
        HomeViewController.viewHeader.lbTitle.isHidden = false
        HomeViewController.viewHeader.btMenu.isHidden = false
        HomeViewController.viewHeader.btSearch.isHidden = false
        HomeViewController.viewHeader.btBack.isHidden = true
        HomeViewController.viewHeader.textfieldSearch.isHidden = true
        HomeViewController.viewHeader.textfieldSearch.resignFirstResponder()
    }
    
    // click vào button search 
    func tapSearchButton() {
        HomeViewController.viewHeader.textfieldSearch.becomeFirstResponder()
        HomeViewController.viewHeader.lbTitle.isHidden = true
        HomeViewController.viewHeader.btMenu.isHidden = true
        HomeViewController.viewHeader.btSearch.isHidden = true
        HomeViewController.viewHeader.btBack.isHidden = false
        HomeViewController.viewHeader.textfieldSearch.isHidden = false
        HomeViewController.viewHeader.becomeFirstResponder()
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(arrayModel.count)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widthCollectCell, height: heightCollectCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as? HomeCollectionViewCell
        cell?.viewContent.layer.cornerRadius = 5
        cell?.viewContent.layer.masksToBounds = true
        if arrayModel.count > 0 {
            cell?.arrayModel = self.arrayModel
            cell?.model = self.arrayModel[indexPath.row]
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        CommonVariable.isDisConnect = true
        let cell: HomeCollectionViewCell = collectionView.cellForItem(at: indexPath) as! HomeCollectionViewCell
        cell.delegate = self as HomeCollectionViewCellDelegate
        cell.arrayModel = self.arrayModel
        cell.selectItem = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionFooter {
            //add spiner
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footerID", for: indexPath)
            spiner = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
            spiner.frame = CGRect.init(x: 0, y: 0, width: self.myCollection.frame.width, height: 44)
            //spiner.startAnimating()
            footer.addSubview(spiner)
            
//            self.spiner.startAnimating()
//            startIndex = endIndex + 1
//            endIndex = endIndex + 3
//            let token = UserDefaults.standard.value(forKey: "token") as! String
//            requestAPI.getAllModel(token: token, index: 0, startIndex: endIndex+1, endIndex: endIndex+3, complete: { (array) in
//                if array.count > 0 {
//                    for model in array {
//                        self.arrayModel.append(model)
//                    }
//                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer) in
//                        self.spiner.stopAnimating()
//                        self.myCollection.reloadData()
//                    })
//
//                }
//                self.spiner.stopAnimating()
//            })
            
            return footer
        }
        return UICollectionReusableView.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: 44)
    }
}

extension HomeViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        viewWait.startAnimatonWaiting()
        HomeViewController.viewHeader.btBack.isHidden = true
        HomeViewController.viewHeader.btMenu.isHidden = false
        HomeViewController.viewHeader.textfieldSearch.isHidden = true
        HomeViewController.viewHeader.btSearch.isHidden = false
        HomeViewController.viewHeader.lbTitle.isHidden = false
        let token = UserDefaults.standard.value(forKey: "token") as! String
        requestAPI.getModelForKey(token: token, keyWord: textField.text!) { (array) in
            self.arrayModel = array
            self.myCollection.reloadData()
            self.viewWait.endAnimationWaiting()
        }
        return true
    }
}

extension HomeViewController: SortViewDelegate{
    func onClickCellSort(text: String, index: Int) {
        lbProduct.text = text
        //gọi model request API tương ứng
        let token = UserDefaults.standard.value(forKey: "token") as! String
        requestAPI.getAllModel(token: token, index: index, startIndex: 0, endIndex: 30) { (array) in
            self.arrayModel = array
            self.myCollection.reloadData()
        }
    }
}

extension HomeViewController: CatalogItemDelegate{
    func onClickCellItem(model: [Model], title: String) {
        lbAllItem.text = title
        self.arrayModel = model
        self.myCollection.reloadData()
        //gọi model request API tương ứng.
    }
}

extension HomeViewController: HomeCollectionViewCellDelegate {
    func onClickCell(arrayColor: [String], arraySize: [String], arrayItem: [Item]) {
        let detailItem = storyboard?.instantiateViewController(withIdentifier: "Detail_ItemViewController") as? Detail_ItemViewController
        detailItem?.isHaveProduct = true
        detailItem?.arrayColor = arrayColor
        detailItem?.arraySize = arraySize
        detailItem?.arrayItem = arrayItem
        if (arrayColor.count == 0 || arraySize.count == 0) {
            detailItem?.isHaveProduct = false
        } else {
            detailItem?.isHaveProduct = true
        }
        self.navigationController?.pushViewController(detailItem!, animated: true)
        HomeViewController.viewHeader.btMenu.isHidden = true
        HomeViewController.viewHeader.btBack.isHidden = false
        HomeViewController.viewHeader.textfieldSearch.resignFirstResponder()
        HomeViewController.viewHeader.textfieldSearch.isHidden = true
        HomeViewController.viewHeader.btSearch.isHidden = false
        HomeViewController.viewHeader.lbTitle.isHidden = false
    }
}

extension HomeViewController: DisConnectInternet {
    func disConect() {
        CommonVariable.isDisConnect = true
    }
}

