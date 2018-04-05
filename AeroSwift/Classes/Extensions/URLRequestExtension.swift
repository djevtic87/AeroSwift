//
//  URLRequestExtension.swift
//  AeroSwift
//
//  Created by Dejan Jevtic on 4/5/18.
//

import Foundation

extension URLRequest {
    public func toString() -> String {
        var retString = "REQUEST\r\n*********\n"
        if let urlReq = self.urlRequest {
            retString += "- url:    \(urlReq)\n"
        }
        
        if let method = self.httpMethod {
            retString += "- method: \(method)\n"
        }
        
        if let headers = self.allHTTPHeaderFields {
            retString += "- header: \(headers)\n"
        }
        
        if let body = self.httpBody {
            do {
                let jsonBody = try JSONSerialization.jsonObject(with: body, options: []) as! [String: AnyObject]
                print("- body:   ", jsonBody)
            } catch {
                print("Error can not parse httpBody.")
            }
        }
        
        retString += "*********\n"
        
        return retString
    }
}
