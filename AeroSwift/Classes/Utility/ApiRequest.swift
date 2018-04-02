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
     - url:          The string URL.
     - httpMethod:   The HTTP request method.
     - responseType: Type of the response object. Use String.self or Data.self for non-JSON response.
     - bodyParams:   Data that will be sent as the message body of the request.
     - completion:   Completion handler that will be called when the request is done.
     */
    
    public func request<T: Decodable>(_ url: String,
                                      _ httpMethod: String,
                                      _ responseType: T.Type,
                                      _ bodyParams: [String: Any]?,
                                      _ headerFields: [String: String]?,
                                      _ completion: @escaping ((T?, Error?) -> ())) {
        
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
            print("REQUEST\r\n*********")
            print("- url:    ", urlRequest)
            if let method = urlRequest.httpMethod {
                print("- method: ", method)
            }
            
            if let headers = urlRequest.allHTTPHeaderFields {
                print("- header: ", headers)
            }
            
            if let body = bodyParams {
                print("- body:   ", body)
            }
            print("*********")
        }
        
        if responseType == String.self || responseType == Data.self {
            Alamofire.request(urlRequest).validate(statusCode: 200..<300).response { response in
                if ApiRequest.LOG_RESPONSE {
                    print("RESPONSE\r\n*********")
                    if let req = response.request {
                        print("- request: ", req)
                    }
                    
                    if let data = response.data, let value = String(data: data, encoding: .utf8) {
                        print("- value: ", value)
                    }
                    
                    if let error = response.error {
                        print("- error:   ", error.localizedDescription)
                    }
                    print("*********")
                }
                
                if let e = response.error {
                    completion(nil, e)
                    return
                }
                
                if let data = response.data {
                    if responseType == String.self {
                        completion(String(data: data, encoding: .utf8) as? T, nil)
                    } else if responseType == Data.self {
                        completion(data as? T, nil)
                    } else {
                        print("Error unknown response type.")
                        completion(nil, nil)
                    }
                } else {
                    print("Error parsing response data.")
                    completion(nil, nil)
                }
            }
        } else {
            Alamofire.request(urlRequest).validate().responseJSON { (response) in
                if ApiRequest.LOG_RESPONSE {
                    print("RESPONSE\r\n*********")
                    print("- result:  ", response.result)
                    if let req = response.request {
                        print("- request: ", req)
                    }
                    
                    if let value = response.value {
                        print("- value:   ", value)
                    }
                    
                    if let error = response.error {
                        print("- error:   ", error.localizedDescription)
                    }
                    
                    print("*********")
                }
                
                if let e = response.error {
                    completion(nil, e)
                    return
                }
                
                if let data = response.data {
                    do {
                        let resp = try JSONDecoder().decode(responseType, from: data)
                        completion(resp, nil)
                    } catch {
                        print(error)
                        completion(nil, nil)
                    }
                }
            }
        }
    }
}

