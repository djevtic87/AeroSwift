//
//  UIApplicationExtension.swift
//  AeroSwift
//
//  Created by Dejan Jevtic on 3/16/18.
//

import Foundation

extension UIApplication {
    
    static var isDeviceWithSafeArea:Bool {
        
        if #available(iOS 11.0, *) {
            if let topPadding = shared.keyWindow?.safeAreaInsets.top,
                topPadding > 0 {
                return true
            }
        }
        
        return false
    }
}
