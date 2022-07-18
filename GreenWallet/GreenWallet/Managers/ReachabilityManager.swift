//
//  ReachabilityManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 17.07.2022.
//

import Foundation
import SystemConfiguration

public class ReachabilityManager {
    
    class func connectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags : SCNetworkReachabilityFlags = []
        
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == false {
            
            return false
            
        }
        
        let isReachable = flags.contains(.reachable)
        
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
        
    }
    
}

