//
//  DataExtension.swift
//  AeroSwift
//
//  Created by Dejan Jevtic on 4/5/18.
//

import Foundation

extension Data {
    public func decode<T: Decodable>(_ type: T.Type) -> T? {
        do {
            let resp = try JSONDecoder().decode(type, from: self)
            return resp
        } catch {
            print(error)
        }
        return nil
    }
}
