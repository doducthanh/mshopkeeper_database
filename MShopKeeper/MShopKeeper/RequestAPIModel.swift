//
//  RequestAPIMode.swift
//  MShopKeeper
//
//  Created by ddthanh on 3/19/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import Foundation
import Alamofire

// thực hiển xử lí thao tác với API tại đây.
class RequestAPIModel {
    var delegate: DisConnectInternet!
    
    func requestLogin(companyCode: String, username: String, password: String, complete: @escaping (_ value: AnyObject?, _ erorr: Error?) -> Void) {
        let parameter: [String: String]! = ["userName":username, "password":password]
        let httpHeader: HTTPHeaders! = ["CompanyCode":companyCode, "Content-Type":"application/x-www-form-urlencoded"]
        
        Alamofire.request(CommonURL.URL_TEST, method: HTTPMethod.post, parameters: parameter, encoding: URLEncoding.httpBody, headers: httpHeader)
            
            .responseJSON {(response) in
                //nếu dữ liệu gửi lên server sai.
                if response.response?.statusCode == 500 {
                    DispatchQueue.main.async {
                        complete(nil, response.error)
                    }
                    return
                }
                // nếu có dữ liệu trả vể.
                switch response.result {
                case .success:
                    do{
                        //parser data thành user
                        let dic  = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
                        if CommonVariable.USER == nil{
                            CommonVariable.USER = Account()
                        }
                        CommonVariable.USER.username = dic["userName"]! as! String
                        CommonVariable.USER.fullName = String.init(describing: (dic["fullName"]! as! String).utf8)
                        CommonVariable.USER.email = dic["email"]! as! String
                        CommonVariable.USER.tel = dic["tel"]! as! String
                        CommonVariable.USER.userId = dic["userID"]! as! Int
                        //lưu lại fullName và userName
                        UserDefaults.standard.set(dic["fullName"], forKey: "fullName")
                        UserDefaults.standard.synchronize()
                        UserDefaults.standard.set(dic["userName"], forKey: "userName")
                        UserDefaults.standard.synchronize()
                        //lưu lại token.
                        UserDefaults.standard.set(dic["token"], forKey: "token")
                        UserDefaults.standard.synchronize()
                        //lưu lại thời gian
                        // thực hiện thao tác với view.
                        DispatchQueue.main.async {
                            complete(response.response?.statusCode as AnyObject, nil)
                            //complete(response as AnyObject, nil)
                        }
                    }catch{
                        
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        complete(nil, error as Error)
                    }
                }
        }
    }
    
    func requestLoginToken(token: String, complete: @escaping(Int) -> Void) {
        let httpHeader: HTTPHeaders! = ["authorization":token, "Content-Type":"application/x-www-form-urlencoded"]
        Alamofire.request(CommonURL.URL_LOGIN_TOKEN, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: httpHeader)
            .responseJSON { (response) in

                if response.response != nil {
                    DispatchQueue.main.async {
                        complete(response.response!.statusCode)
                    }
                } else {
                    DispatchQueue.main.async {
                        complete(401)
                    }
                }
        }
    }
    
    // hàm lấy về thông tin các model
    func getAllModel(token: String, index: Int, startIndex: Int, endIndex: Int, complete:@escaping ([Model]) -> Void) {
        //lay du lieu local.
        if CommonVariable.isDisConnect {
            let array = DatabaseModel.share.getAllModelRecords()
            complete(array)
            return
        }
        
        var arrayModel = [Model]()
        var url = ""
        if index == 0 {
            url = CommonURL.URL_MODEL
        }
        if index == 1 {
            url = CommonURL.URL_MODEL_FOR_TIME
        }
        if index == 2 {
            url = CommonURL.URL_MODEL_BEST_SALE
        }
        if index == 3 {
            url = CommonURL.URL_MODEL_PROMOTION
        }
        if index == 4 {
            url = CommonURL.URL_SEARCH_BARCODE
        }
        let httpHeader: HTTPHeaders! = ["Content-Type":"application/x-www-form-urlencoded", "startindex": startIndex.description, "endindex": endIndex.description, "authorization": token]
        Alamofire.request(url, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: httpHeader)
            .responseJSON { (response) in
                if response.response?.statusCode == nil {
                    self.delegate.disConect()
                    return
                }
                CommonVariable.isDisConnect = false
                if response.response?.statusCode != 200 {
                    return
                }
                do {
                    let array: [Dictionary<String, Any>] = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [Dictionary<String, Any>]
                    for i in 0..<array.count {
                        let model = Model()
                        let dic: Dictionary = array[i]
                        model.modelID = dic["modelID"] as! Int
                        model.shopID = dic["shopID"] as! Int
                        model.modelName = String.init(describing: (dic["modelName"] as! String).utf8)
                        model.decription = dic["decription"] as! String
                        model.pictureLink = dic["pictureLink"] as! String
                        model.picturetype = dic["pictureType"] as! Int
                        model.isPromtion = dic["isPromotion"] as! Bool
                        model.isDisplayPrice = dic["isDisplayPrice"] as! Bool
                        model.percentPromtion = dic["percenPromotion"] as! Double
                        model.dateOfEntry = dic["dateOfEntry"] as! String
                        model.unitPrice = dic["unitPrice"] as! Int
                        arrayModel.append(model)
                    }
                    DispatchQueue.main.async {
                        complete(arrayModel)
                    }
                } catch {
                    DispatchQueue.main.async {
                        complete(arrayModel)
                    }
                    return
                }
        }
    }
    
    //hàm search theo từ khoá
    func getModelForKey(token: String, keyWord: String, complete:@escaping ([Model]) -> Void) {
        var arrayModel = [Model]()
        let parameter: [String: String]! = ["keyword":keyWord]
        let httpHeader: HTTPHeaders! = ["authorization":token, "Content-Type":"application/x-www-form-urlencoded"]
        let url = CommonURL.URL_SEARCH_MODEL
    
        Alamofire.request(url, method: HTTPMethod.post, parameters: parameter, encoding: URLEncoding.httpBody, headers: httpHeader)
            .responseJSON { (response) in
                if response.response?.statusCode == nil {
                    self.delegate.disConect()
                    return
                }
                CommonVariable.isDisConnect = false
                
                if response.response?.statusCode == 500 {
                    return
                }
                do {
                    let array: [Dictionary<String, Any>] = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [Dictionary<String, Any>]
                    for i in 0..<array.count {
                        let model = Model()
                        let dic: Dictionary = array[i]
                        model.modelID = dic["modelID"] as! Int
                        model.shopID = dic["shopID"] as! Int
                        model.modelName = String.init(describing: (dic["modelName"] as! String).utf8)
                        model.decription = dic["decription"] as! String
                        model.pictureLink = dic["pictureLink"] as! String
                        model.picturetype = dic["pictureType"] as! Int
                        model.isPromtion = dic["isPromotion"] as! Bool
                        model.isDisplayPrice = dic["isDisplayPrice"] as! Bool
                        model.percentPromtion = dic["percenPromotion"] as! Double
                        model.dateOfEntry = dic["dateOfEntry"] as! String
                        model.unitPrice = dic["unitPrice"] as! Int
                        arrayModel.append(model)
                    }
                    DispatchQueue.main.async {
                        complete(arrayModel)
                    }
                } catch {
                    DispatchQueue.main.async {
                        complete(arrayModel)
                    }
                    return
                }
        }
    }
    //hàm lấy về thông tin chi tiết sản phẩm
    func getItemDetal(token: String, modelID: Int, complete:@escaping ([String], [String], [Item]) -> Void) {
        
        //lay du lieu local.
        if CommonVariable.isDisConnect {
            let tuple = DatabaseModel.share.getAllItemRecords(modelID: modelID)
            complete(tuple.arrayColor, tuple.arraySize, tuple.arrayItem)
            return
        }
        
        var arrayItems = [Item]()
        let httpHeader: HTTPHeaders! = ["Content-Type":"application/x-www-form-urlencoded", "authorization": token, "modelid": modelID.description]
        Alamofire.request(CommonURL.URL_ITEM_DETAIL, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: httpHeader)
            .responseJSON { (response) in
                if response.response?.statusCode == nil {
                    self.delegate.disConect()
                    return
                }
                CommonVariable.isDisConnect = false
                if response.response?.statusCode == 500 {
                    return
                }
                do {
                    let dic = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
                    let arrayColor = dic["arrayColor"] as! [String]
                    let arraySize = dic["arraySize"] as! [String]
                    let arrayItem = dic["row"] as! [Dictionary<String, Any>]
                    for json in arrayItem {
                        let item = Item()
                        item.itemId = json["itemID"] as! Int
                        item.modelID = json["modelID"] as! Int
                        item.SKUCode = json["SKUCode"] as! String
                        item.decription = json["decription"] as! String
                        item.unitPrice = json["unitPrice"] as! Int
                        item.addressShop = json["addressShop"] as! String
                        //
                        item.color = json["color"] as! String
                        item.size = json["size"] as! String
                        item.barCode = json["barCode"] as! String
                        if (json["isPromotion"] as! Int) == 0 {
                            item.isPromotion = false
                        } else {
                            item.isPromotion = true
                        }
                        arrayItems.append(item)
                    }
                    DispatchQueue.main.async {
                        complete(arrayColor, arraySize, arrayItems)
                    }
                } catch {
                    DispatchQueue.main.async {
//                        complete(arrayModel)
                    }
                    return
                }
        }
    }
    
    // hàm thay đổi mật khẩu.
    func changePassword(token: String, newPass: String, complete: @escaping (Int) -> Void) {
        let parameter: [String: String]! = ["newpassword":newPass]
        let httpHeader: HTTPHeaders! = ["authorization":token, "Content-Type":"application/x-www-form-urlencoded"]
        let url = CommonURL.URL_CHANGE_PASSWORD
        Alamofire.request(url, method: HTTPMethod.post, parameters: parameter, encoding: URLEncoding.httpBody, headers: httpHeader)
            .responseJSON { (response) in
                if response.response?.statusCode == 200 {
                    complete(200)
                } else {
                    complete (400)
                }
        }
    }
    // hàm lấy lại mật khẩu.
    func getPassword(token: String, companyCode: String, complete: @escaping (Int) -> Void) {
        let parameter: [String: String]! = ["companyCode":companyCode]
        let httpHeader: HTTPHeaders! = ["authorization":token, "Content-Type":"application/x-www-form-urlencoded"]
        let url = CommonURL.URL_GET_PASSWORD
        Alamofire.request(url, method: HTTPMethod.post, parameters: parameter, encoding: URLEncoding.httpBody, headers: httpHeader)
            .responseJSON { (response) in
                if response.response?.statusCode == 200 {
                    complete(200)
                } else {
                    complete (400)
                }
        }
    }
}

protocol DisConnectInternet {
    func disConect ()
}
