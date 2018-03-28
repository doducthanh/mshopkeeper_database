//
//  ScanCodeViewController.swift
//  MShopKeeper
//
//  Created by ddthanh on 2/1/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import UIKit
import AVFoundation
import MTBBarcodeScanner

class ScanCodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate{

    var scanner: MTBBarcodeScanner?
    var delegate: ScanCodeDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanner = MTBBarcodeScanner(previewView: self.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        MTBBarcodeScanner.requestCameraPermission(success: { success in
            if success {
                do {
                    try self.scanner?.startScanning(resultBlock: { codes in
                        if let codes = codes {
                            for code in codes {
                                let stringValue = code.stringValue!
                                self.delegate.searchBarCode(barcode: stringValue)
                                self.dismiss(animated: true, completion: nil)
                                break
                            }
                        }
                    })
                } catch {
                    NSLog("Unable to start scanning")
                }
            } else {
                print("error")
            }
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.scanner?.stopScanning()
        super.viewWillDisappear(animated)
    }
}

protocol ScanCodeDelegate {
    func searchBarCode(barcode: String)
}
