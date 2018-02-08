//
//  DecoderExtension.swift
//  AeroSwift
//
//  Created by Dejan Jevtic on 2/7/18.
//

import Foundation

extension Decoder {
    
    // Just a wrapper around decode function with try catch block.
    public func decodeItem<T, K>(_ type: T.Type, key: K,
                       container: KeyedDecodingContainer<K>) -> T? where T : Decodable {
        var res: T? = nil
        do {
            res = try container.decode(type, forKey: key)
        } catch {
            print("\(error.localizedDescription) Key: \(key) type: \(T.self).")
        }
        return res
    }
}
