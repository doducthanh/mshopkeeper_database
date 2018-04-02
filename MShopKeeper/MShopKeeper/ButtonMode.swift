//
//  ButtonMode.swift
//  MShopKeeper
//
//  Created by ddthanh on 3/9/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import UIKit

// quản lí điều khiển các sự kiện của button custom
class ButtonMode {
//    khai báo thuộc tính
    var delegate: ButtonModeProtocol!
    var arrayButton:[CustomButton] = [CustomButton]()
    let heighButton = 50
    let widthButton = 80
    var color = ""
    var size = ""
    
    /// hàm vẽ group button
    ///
    /// - Parameters:
    ///   - number: kích thước mảng tên button
    ///   - viewSub: view lưạ chọn để thêm group button
    ///   - array: mảng tên các button
    ///   - tag: tag của nhóm button này
    ///   - complete: callback sau khi thực hiện
    func drawButtons(number: Int, viewSub: UIView, array: [String], tag: Int, complete: (Int) -> Void) {
//        lấy ra số cột tối đa vẽ dc trên màn hình
        var countCollum: Int = Int(viewSub.frame.size.width / CGFloat(widthButton + 15))
//        lây ra số hàng tối đa vẽ được
        var countRow: Int = Int(number / countCollum)
        let cm_countCollum = countCollum
        if countRow == 0 {
            countRow = 1
        }else if (number % countCollum) != 0{
            countRow += 1
        }
//        vẽ các button
        for row in 0..<countRow {
            if row == (countRow - 1){
                countCollum = number - row * countCollum
            }
            for collum in 0..<countCollum{
                var bt: CustomButton!
                if row == 0 {
                    bt = CustomButton.init(frame: CGRect.init(x: (widthButton + 10)*collum, y: 35 + row*(heighButton + 15), width: widthButton, height: heighButton))
                }
                if row > 0{
                    bt = CustomButton.init(frame: CGRect.init(x: (widthButton + 10)*collum, y: 35 + row*(heighButton + 15), width: widthButton, height: heighButton))
                }
                bt.setTitle(array[row*cm_countCollum + collum], for: .normal)
                bt.addTarget(self, action: #selector(onclicButton(bt:)), for: .touchUpInside)
                bt.tag = tag
                viewSub.addSubview(bt)
                arrayButton.append(bt)
            }
        }
//         nếu chỉ có 1 button thì cho hiển thị sang luôn
        if array.count == 1 && array.count == 1 {
            for bt in arrayButton {
                bt.setButtonOnClick()
            }
        }
        complete(countRow)
    }
    
    /// set độ mờ của các button
    ///
    /// - Parameter tag: kiểu button lựa chọn.
    func setAlphaButton(tag: Int) {
        for bt in arrayButton {
            bt.layer.cornerRadius = 5
            bt.layer.masksToBounds = true
            bt.layer.borderColor = UIColor.gray.cgColor
            bt.layer.borderWidth = 1
            bt.backgroundColor = MyColors.BACKGROUND_BUTTON_DEFAULT
            bt.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            bt.setTitleColor(UIColor.gray, for: .normal)
            if bt.tag == tag {
                bt.alpha = 0.5
            } else {
                bt.alpha = 1
            }
        }
    }
    
    /// hàm bắt sự kiện click vào button
    ///
    /// - Parameter bt: button
    @objc func onclicButton(bt: CustomButton) {
        delegate.onClickButton(bt: bt)
    }
    
    /// hàm thực hiện công việc khi click vào button
    /// set lại trạng thai cho các button
    /// - Parameters:
    ///   - bt: button
    ///   - selectSwitch: trạng thái của switch
    ///   - isButtonSelect: biến kiểm tra xem button đã chọn chưa
    func setOnClickButton(bt: CustomButton, selectSwitch: Int, isButtonSelect: inout Bool ) {
        if bt.tag == 0 {
            color = (bt.titleLabel?.text!)!
        }
        
        if bt.tag == 1 {
            size = (bt.titleLabel?.text!)!
        }
        if bt.currentTitleColor == MyColors.BLUE {
            bt.setButtonOnClick()
            return
        }
//         nếu đang chọn theo color
        if selectSwitch == 0{
            if bt.tag == 1 && !isButtonSelect{
                return
            }else{
                for button in arrayButton{
                    if button.tag == 1{
                        button.alpha = 1
                    }
                    if button != bt && button.tag == bt.tag{
                        button.setButtonNotOnClick()
                    }
                }
                bt.setButtonOnClick()
                isButtonSelect = true
            }
        }
//         nếu đang chọn theo size
        if selectSwitch == 1{
            if bt.tag == 0  && !isButtonSelect{
                return
            }else{
                for button in arrayButton{
                    if button.tag == 0{
                        button.alpha = 1
                    }
                    if button != bt && button.tag == bt.tag{
                        button.setButtonNotOnClick()
                    }
                }
                bt.setButtonOnClick()
                isButtonSelect = true
            }
        }
        if color != "" && size != "" {
            self.delegate.setUI(color: color, size: size)
        }
    }

}

/// protocol cho custom button.
protocol ButtonModeProtocol {
    func onClickButton(bt: CustomButton)
    
    func setUI(color: String, size: String)
}
