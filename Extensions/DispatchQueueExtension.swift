//
//  DispatchQueueExtension.swift
//  AeroSwift
//
//  Created by Dejan Jevtic on 2/8/18.
//

import Foundation

extension DispatchQueue {
    
    // Wrapper for running some task in background.
    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
    
}
