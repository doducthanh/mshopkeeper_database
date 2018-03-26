//
//  InternetModel.swift
//  MShopKeeper
//
//  Created by ddthanh on 3/22/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import Foundation

class InternetModel {
    
    func checkInternetConnect() {
        NotificationCenter.default.addObserver(self, selector: #selector(statusManager), name: .flagsChanged, object: Network.reachability)
//        updateUserInterface(complete: <#()#>)
    }
    
    func updateUserInterface(complete: @escaping(Int) -> Void) {
        guard let status = Network.reachability?.status else { return }
        switch status {
        case .unreachable:
            complete(InternetNumberConnect.reachable.hashValue)
        case .wifi:
            complete(InternetNumberConnect.wifi.hashValue)
        case .wwan:
            complete(InternetNumberConnect.wwan.hashValue)
        }
        print("Reachability Summary")
        print("Status:", status)
        print("HostName:", Network.reachability?.hostname ?? "nil")
        print("Reachable:", Network.reachability?.isReachable ?? "nil")
        print("Wifi:", Network.reachability?.isReachableViaWiFi ?? "nil")
    }
    
    @objc func statusManager(_ notification: Notification) {
//        updateUserInterface(complete: <#()#>)
    }
}

enum InternetNumberConnect {
    case reachable
    case wifi
    case wwan
}
