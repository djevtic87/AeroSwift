//
//  ApiRequest.swift
//  AeroSwift
//
//  Created by Dejan Jevtic on 4/2/18.
//

import Foundation
import Alamofire

public class ApiRequest: NSObject {
    /// Shared instance used by the extensions across SnapShare.
    public static let sharedInstance = ApiRequest()
    
    private static let LOG_REQUEST = true
    private static let LOG_RESPONSE = true
    
    /**
     Creates and executes an URLRequest based on specified ‘url’ and ‘bodyParams’.
     
     - Parameters:
     - url:           The string URL.
     - httpMethod:    The HTTP request method.
     - bodyParams:    Data that will be sent as the message body of the request.
     - headerFields:  A dictionary containing all the HTTP header fields of the receiver.
     - completion:    Completion handler that will be called when the request is done.
     */
    
    public func request(_ url: String,
                        _ httpMethod: String,
                        _ bodyParams: [String: Any]?,
                        _ headerFields: [String: String]?,
                        _ completion: @escaping ((Data?, Int?) -> ())) {
        
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = httpMethod
        
        if let headers = headerFields {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        if let body = bodyParams {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
                urlRequest.httpBody = jsonData
            } catch {
                print("Error: cannot create JSON from APIRequest body params.")
                print(error)
                return
            }
        }
        
        if ApiRequest.LOG_REQUEST {
            print(urlRequest.toString())
        }
        Alamofire.request(urlRequest).responseData(completionHandler: { response in
            if ApiRequest.LOG_RESPONSE {
                print(response.toString(true))
            }
            completion(response.data, response.response?.statusCode)
        })
    }
}

