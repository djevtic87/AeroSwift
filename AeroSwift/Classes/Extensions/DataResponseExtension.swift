//
//  DataResponseExtension.swift
//  AeroSwift
//
//  Created by Dejan Jevtic on 4/5/18.
//

import Foundation
import Alamofire

extension DefaultDataResponse {
    public func toString(_ printData: Bool = false) -> String {
        var retString = "RESPONSE\r\n*********\n"
        if let req = self.request {
            retString += "- request:     \(req)\n"
        }
        
        if let statusCode = self.response?.statusCode {
            retString += "- status code: \(statusCode)\n"
            
        }
        
        if let data = self.data, let value = String(data: data, encoding: .utf8), printData {
            retString += "- value:\n\(value)\n"
        }
        
        if let err = self.error {
            retString += "- error:       \(err.localizedDescription)\n"
        }
        retString += "*********\n"
        
        return retString
    }
}

extension DataResponse {
    public func toString(_ printData: Bool = false) -> String {
        var retString = "RESPONSE\r\n*********\n"
        if let req = self.request {
            retString += "- request:     \(req)\n"
        }

        if let statusCode = self.response?.statusCode {
            retString += "- status code: \(statusCode)\n"
            
        }

        if let data = self.data, let value = String(data: data, encoding: .utf8), printData {
            retString += "- value:\n\(value)\n"
        }

        if let err = self.error {
            retString += "- error:       \(err.localizedDescription)\n"
        }
        retString += "*********\n"
        
        return retString
    }
}
