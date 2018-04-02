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
    
    // Get the parent view controller of any UIView.
    public var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    // Get superview of specific type.
    public func superview<T>(of type: T.Type) -> T? {
        return superview as? T ?? superview.flatMap { $0.superview(of: type) }
    }
    
    // Get subview of specific type.
    public func subview<T>(of type: T.Type) -> T? {
        return subviews.compactMap { $0 as? T ?? $0.subview(of: type) }.first
    }
}

