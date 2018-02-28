//
//  UILabelExtension.swift
//  AeroSwift
//
//  Created by Dejan Jevtic on 2/28/18.
//

import Foundation

extension UILabel {
    
    // Set label text and based on text length expand label height.
    public func setTextAndAdjustHeight(_ newText: String?) {
        guard let text = newText else {
            return
        }
        self.numberOfLines = 0
        self.text = text
        self.sizeToFit()
    }
}
