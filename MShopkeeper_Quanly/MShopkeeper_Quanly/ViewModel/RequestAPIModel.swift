//
//  RequestAPIMode.swift
//  MShopKeeper
//
//  Created by ddthanh on 3/19/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import Foundation
import Alamofire

/// thực hiển xử lí thao tác với API tại đây.
class RequestAPIModel {
    var delegate: DisConnectInternet!
    
    /// hàm request login
    ///
    /// - Parameters:
    ///   - companyCode: mã cửa hàng
    ///   - username: tên đăng nhập
    ///   - password: mật khẩu
    ///   - complete: callback khi hàm thực hiện xong.
    func requestLogin(companyCode: String, username: String, password: String, complete: @escaping (_ value: AnyObject?, _ erorr: Error?) -> Void) {
        let parameter: [String: String]! = ["userName":username, "password":password]
        let httpHeader: HTTPHeaders! = ["CompanyCode":companyCode, "Content-Type":"application/x-www-form-urlencoded"]
        
        Alamofire.request(CommonURL.URL_TEST, method: HTTPMethod.post, parameters: parameter, encoding: URLEncoding.httpBody, headers: httpHeader)
            
            .responseJSON {(response) in
//                neu mat ket noi, hoac mat mang => tra ve ma loi 404
                if response.response == nil {
                    complete(404 as AnyObject, nil)
                }
//                nếu dữ liệu gửi lên server sai.
                if response.response?.statusCode == 500 {
                    DispatchQueue.main.async {
                        complete(nil, response.error)
                    }
                    return
                }
//                 nếu có dữ liệu trả vể.
                switch response.result {
                case .success:
                    do{
//                        parser data thành user
                        let dic  = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
                        if CommonVariable.USER == nil{
                            CommonVariable.USER = Account()
                        }
                        CommonVariable.USER.username = dic["userName"]! as! String
                        CommonVariable.USER.fullName = String.init(describing: (dic["fullName"]! as! String).utf8)
                        CommonVariable.USER.email = dic["email"]! as! String
                        CommonVariable.USER.tel = dic["tel"]! as! String
                        CommonVariable.USER.userId = dic["userID"]! as! Int
//                        lưu lại fullName và userName
                        UserDefaults.standard.set(dic["fullName"], forKey: "fullName")
                        UserDefaults.standard.synchronize()
                        UserDefaults.standard.set(dic["userName"], forKey: "userName")
                        UserDefaults.standard.synchronize()
//                        lưu lại token.
                        UserDefaults.standard.set(dic["token"], forKey: "token")
                        UserDefaults.standard.synchronize()
//                        lưu lại shopID
                        UserDefaults.standard.set(dic["shopID"], forKey: "shopID")
                        UserDefaults.standard.synchronize()
            
                        // thực hiện thao tác với view.
                        DispatchQueue.main.async {
                            complete(response.response?.statusCode as AnyObject, nil)
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
    
  
    /// hàm login với token có sẵn
    ///
    /// - Parameters:
    ///   - token: token của lần đăng nhập gần nhất
    ///   - complete: callback cho giao diện xử lí.
    func requestLoginToken(token: String, complete: @escaping(Int) -> Void) {
        let httpHeader: HTTPHeaders! = ["authorization":token, "Content-Type":"application/x-www-form-urlencoded"]
        Alamofire.request(CommonURL.URL_LOGIN_TOKEN, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: httpHeader)
            .responseJSON { (response) in
//                neu mat ket noi, hoac mat mang => tra ve ma loi 404
                if response.response == nil {
                    complete(404)
                }
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
    
    
    /// hàm thưc hiện khi muốn thay đổi mật khẩu
    ///
    /// - Parameters:
    ///   - token: mã token của phiên đăng nhập
    ///   - newPass: mật khẩu mới.
    ///   - complete: callback trả về status
    func changePassword(token: String, newPass: String, complete: @escaping (Int) -> Void) {
        let parameter: [String: String]! = ["newpassword":newPass]
        let httpHeader: HTTPHeaders! = ["authorization":token, "Content-Type":"application/x-www-form-urlencoded"]
        let url = CommonURL.URL_CHANGE_PASSWORD
        Alamofire.request(url, method: HTTPMethod.post, parameters: parameter, encoding: URLEncoding.httpBody, headers: httpHeader)
            .responseJSON { (response) in
                if response.response == nil {
                    complete(404)
                }
                if response.response?.statusCode == 200 {
                    complete(200)
                } else {
                    complete (400)
                }
        }
    }

    /// hàm lấy lại mật khẩu
    ///
    /// - Parameters:
    ///   - username: tên đăng nhập
    ///   - companyCode: tên cửa hàng
    ///   - complete: callback trả về mã status và password
    func getPassword(username: String, companyCode: String, complete: @escaping (Int, String) -> Void) {
//        let parameter: [String: String]! = ["companyCode":companyCode]
        let httpHeader: HTTPHeaders! = ["companycode":companyCode, "username": username, "Content-Type":"application/x-www-form-urlencoded"]
        let url = CommonURL.URL_GET_PASSWORD
        Alamofire.request(url, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: httpHeader)
            .responseJSON { (response) in
                if response.response == nil {
                    complete(404, "")
                }
                if response.response?.statusCode == 200 {
                    do {
                        let dic = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
                        print(dic)
                        complete(200, dic["password"] as! String)
                    } catch {
                        
                    }
                    
                } else {
                    complete (400, "")
                }
        }
    }
    
    func getShops( complete: @escaping (Int, [Shop]) -> Void) {
        let token = UserDefaults.standard.value(forKey: "token") as! String
        let httpHeader: HTTPHeaders! = ["authorization": token, "Content-Type":"application/x-www-form-urlencoded"]
        let url = CommonURL.GET_SHOP
        Alamofire.request(url, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: httpHeader)
            .responseJSON { (respone) in
                if respone.response?.statusCode == 200 {
                    do {
                        var arrayShop = [Shop]()
                        let array = try JSONSerialization.jsonObject(with: respone.data!, options: .allowFragments) as! [Dictionary<String, Any>]
                        for result in array {
                            let shop = Shop()
                            shop.shopID = result["shopID"] as! Int
                            shop.parentShopID = result["parentShopID"] as! Int
                            shop.shopName = result["shopName"] as! String
                            shop.shopCode = result["shopCode"] as! String
                            shop.tel = result["tel"] as! String
                            shop.address = result["addressShop"] as! String
                            arrayShop.append(shop)
                        }
                        complete(200, arrayShop)
                    } catch {
                        print("")
                    }
                }
        }
    }
    
    func getRevenue(shopID: Int, type: Int, complete: @escaping (Int, [Int]) -> Void)  {

        var url_string: String = ""
        switch type {
        case 0:
            url_string = CommonURL.GET_REVENUE_DAY
            break
        case 1:
            url_string = CommonURL.GET_REVENUE_WEEK
            break
        case 2:
            url_string = CommonURL.GET_REVENUE_MONTH
            break
        default:
            url_string = CommonURL.GET_REVENUE_DAY
            break
        }
        let httpHeader: HTTPHeaders! = ["shopid": String(shopID), "Content-Type":"application/x-www-form-urlencoded"]
        Alamofire.request(url_string, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: httpHeader)
            .responseJSON { (respone) in
                if respone.response?.statusCode == 200 {
                    do {
                        var array = [Int]()
                        let dic = try JSONSerialization.jsonObject(with: respone.data!, options: .allowFragments) as! Dictionary<String, Any>
                        array.append(dic["thu"] as! Int)
                        array.append(dic["chi"] as! Int)
                        array.append(dic["lai"] as! Int)
                        complete(200, array)
                    } catch {
                        print("")
                    }
                }
        }
    }
    
    func getTopRevenueShop(type: Int, complete: @escaping ([Dictionary<String, Any>]) -> Void) {
        let token = UserDefaults.standard.value(forKey: "token") as! String
        let httpHeader: HTTPHeaders! = ["authorization": token, "Content-Type":"application/x-www-form-urlencoded"]
        var url = ""
        if type == 0 {
            url = CommonURL.GRT_TOP_REVENUE_SHOP_DAY
        }
        if type == 1 {
            url = CommonURL.GRT_TOP_REVENUE_SHOP_WEEK
        }
        if type == 2 {
            url = CommonURL.GRT_TOP_REVENUE_SHOP_MONTH
        }
        Alamofire.request(url, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: httpHeader)
            .responseJSON { (response) in
                if response.response?.statusCode == 200 {
                    do {
                        let dic = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [Dictionary<String, Any>]
                        complete(dic)
                    } catch {
                        print("")
                    }
                }
        }
    }
    
    
    func getTopProductShop(type: Int, shopID: Int, complete: @escaping ([Dictionary<String, Any>]) -> Void) {
        let httpHeader: HTTPHeaders! = ["shopid": shopID.description, "Content-Type":"application/x-www-form-urlencoded"]
        var url = ""
        if type == 0 {
           url = CommonURL.GET_TOP_PRODUCT_SHOP_DAY
        }
        if type == 1 {
            url = CommonURL.GET_TOP_PRODUCT_SHOP_WEEk
        }
        if type == 2 {
            url = CommonURL.GET_TOP_PRODUCT_SHOP_MONTH
        }
        
        Alamofire.request(url, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: httpHeader)
            .responseJSON { (response) in
                if response.response?.statusCode == 200 {
                    do {
                        let dic = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [Dictionary<String, Any>]
                        complete(dic)
                    } catch {
                        print("")
                    }
                }
        }
    }

}

protocol DisConnectInternet {
    func disConect ()
}
