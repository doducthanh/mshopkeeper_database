//
//  ViewIntroduce.swift
//  MShopKeeper
//
//  Created by ddthanh on 2/8/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import UIKit

class ViewIntroduce: UIViewController {

    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var viewBackground: UIView!
    var delegate: endEditingDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        textview.returnKeyType = .done
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapView))
        textview.isUserInteractionEnabled = true
        viewBackground.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tapView() {
        textview.resignFirstResponder()
        delegate.returnKeyBoard()
    }
    
    @IBAction func onClickClose(_ sender: Any) {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
}

extension ViewIntroduce: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.becomeFirstResponder()
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
        delegate.returnKeyBoard()
    }
    
}

protocol endEditingDelegate {
    func returnKeyBoard()
}

