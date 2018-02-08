//
//  UIButtonExtension.swift
//  AeroSwift
//
//  Created by Dejan Jevtic on 2/8/18.
//

import Foundation

extension UIButton {
    
    // Align UIButton image and title vertically.
    public func alignImageAndTitleVertically(padding: CGFloat = 4.0) {
        let imageSize = self.imageView!.frame.size
        let titleSize = self.titleLabel!.frame.size
        let totalHeight = imageSize.height + titleSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageSize.height),
            left: 0,
            bottom: 0,
            right: -titleSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -imageSize.width,
            bottom: -(totalHeight - titleSize.height),
            right: 0
        )
    }
    
}
