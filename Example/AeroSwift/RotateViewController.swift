//
//  RotateViewController.swift
//  AeroSwift_Example
//
//  Created by Dejan Jevtic on 2/7/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import AeroSwift

class RotateViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func startRotationPressed(_ sender: UIButton) {
        if sender.titleLabel?.text == "Start Rotation" {
            self.imageView.startRotating()
            sender.setTitle("Stop Rotation", for: .normal)
        } else {
            self.imageView.stopRotating()
            sender.setTitle("Start Rotation", for: .normal)
        }
    }
    
}
