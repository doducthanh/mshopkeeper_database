//
//  HomeCollectionViewCell.swift
//  MShopKeeper
//
//  Created by ddthanh on 1/22/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    //khai báo thuộc tín
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var labelItem: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var imgSale: UIImageView!
    @IBOutlet weak var viewBackground: UIView!
    var arrayModel: [Model]!
    
    var item: Item! = Item()
    var requestAPI: RequestAPIModel!
    var delegate: HomeCollectionViewCellDelegate!
    /// vẽ cell khi có giá trị
    var model: Model! {
        didSet{
            //let model = arrayModel[index]
            let resource = ImageResource.init(downloadURL: URL.init(string: model.pictureLink)!, cacheKey: model.pictureLink)
//            self.img.kf.setImage(with: resource, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cache, url) in
//                self.img.image = image!
//
//            }
            if model.dataImage != nil && CommonVariable.isDisConnect {
                self.img.image = UIImage.init(data: model.dataImage!)
            } else {
                self.img.kf.setImage(with: resource)  
            }
//            if model.isPromtion {
//                self.imgSale.isHidden = false
//            } else {
//                self.imgSale.isHidden = true
//            }
            
            self.labelItem.text = model.modelName
            self.labelPrice.text = String(model.unitPrice) + Constant.Currency_Unit
        }
    }
    
    /// thực hiện khi chọn vào 1 cell
    var selectItem: Int! {
        didSet {
            let model = arrayModel[selectItem]
            UserDefaults.standard.set(model.modelID, forKey: "modelID")
            UserDefaults.standard.set(model.pictureLink, forKey: "pictureLink")
            UserDefaults.standard.set(model.modelName, forKey: "modelName")
            requestAPI = RequestAPIModel()
            requestAPI.delegate = self
            let token = UserDefaults.standard.value(forKey: "token") as! String
            requestAPI.getItemDetal(token: token, modelID: model.modelID) { (arrayColor, arraySize, arrayItem) in
                self.delegate.onClickCell(arrayColor: arrayColor, arraySize: arraySize, arrayItem: arrayItem)
            }
        }
    }
    
}

protocol HomeCollectionViewCellDelegate {
    func onClickCell (arrayColor: [String], arraySize: [String], arrayItem: [Item])
    func disconnectOnCell()
}
extension HomeCollectionViewCell: DisConnectInternet {
    func disConect() {
        self.delegate.disconnectOnCell()
//        CommonVariable.isDisConnect = true
    }
}
