//
//  DecodeItemViewController.swift
//  AeroSwift_Example
//
//  Created by Dejan Jevtic on 2/7/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import AeroSwift

struct Swifter {
    let fullName: String?
    let id: Int?
    let twitter: URL?
    
    init(fullName: String?, id: Int?, twitter: URL?) { // default struct initializer
        self.fullName = fullName
        self.id = id
        self.twitter = twitter
    }
}

extension Swifter: Decodable {
    enum MyStructKeys: String, CodingKey { // declaring our keys
        case fullName = "fullName"
        case id = "id"
        case twitter = "twitter"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MyStructKeys.self)
        let fullName = decoder.decodeItem(String.self, key: MyStructKeys.fullName, container: container)
        let id = decoder.decodeItem(Int.self, key: MyStructKeys.id, container: container)
        let twitter = decoder.decodeItem(URL.self, key: MyStructKeys.twitter, container: container)
        
        self.init(fullName: fullName, id: id, twitter: twitter) // initializing our struct
    }
}

extension Swifter: CustomStringConvertible {
    var description: String {
        return "Name: \(self.fullName ?? "")\nid: \(self.id ?? -1)\ntwitter: \(self.twitter ?? URL(fileURLWithPath: "ERROR"))"
        
    }
    
}

class DecodeItemViewController: UIViewController {
    let json = """
{
 "fullName": "Elon Musk",
 "id": 123456,
 "twitter": "https://twitter.com/elonmusk"
}
"""
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textView2: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textView.text = json
    }
    
    @IBAction func decodeButtonPressed(_ sender: Any) {
        let jsonData = json.data(using: .utf8)!
        do {
            let myStruct = try JSONDecoder().decode(Swifter.self, from: jsonData) // decoding our data
            print(myStruct) // decoded!
            self.textView2.text = myStruct.description
        } catch {
            self.textView2.text = error.localizedDescription
            print(error)
        }
    }
    
}
