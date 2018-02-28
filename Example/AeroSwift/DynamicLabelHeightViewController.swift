//
//  DynamicLabelHeightViewController.swift
//  AeroSwift_Example
//
//  Created by Dejan Jevtic on 2/28/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class DynamicLabelHeightViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func showButtonPressed(_ sender: Any) {
        self.label.setTextAndAdjustHeight(self.textField.text)
    }
}
