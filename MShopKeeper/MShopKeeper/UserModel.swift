//
//  UserModel.swift
//  MShopKeeper
//
//  Created by ddthanh on 3/8/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import Foundation
import Alamofire

// quản lí tất cả thao tác mới model User
class UserModel {
    
    // hàm xử lí sự kiện login
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
                        UserDefaults.standard.set(dic["token"], forKey: "token")
                        UserDefaults.standard.synchronize()
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
}
