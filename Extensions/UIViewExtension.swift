//
//  UIViewExtension.swift
//  AeroSwift
//
//  Created by Dejan Jevtic on 2/7/18.
//

import Foundation

extension UIView {
    
    // Allocate new CABasicAnimation and start animation.
    public func startRotating(duration: Double = 0.8) {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) == nil {
            let animate = CABasicAnimation(keyPath: "transform.rotation")
            animate.duration = duration
            animate.repeatCount = Float.infinity
            animate.fromValue = 0.0
            animate.toValue = Float(Float.pi * 2.0)
            self.layer.add(animate, forKey: kAnimationKey)
        }
    }
    
    // Remove CABasicAnimation allocated in startRotating.
    public func stopRotating() {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) != nil {
            self.layer.removeAnimation(forKey: kAnimationKey)
        }
    }
}

