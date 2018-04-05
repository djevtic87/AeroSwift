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
                                      _ completion: @escaping ((T?, Int?) -> ())) {
        
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
        
        if responseType == String.self || responseType == Data.self {
            Alamofire.request(urlRequest).validate(statusCode: 200..<300).response { response in
                if ApiRequest.LOG_RESPONSE {
                    print(response.toString())
                }
                
                if let data = response.data {
                    if responseType == String.self {
                        completion(String(data: data, encoding: .utf8) as? T, nil)
                    } else if responseType == Data.self {
                        completion(data as? T, response.response?.statusCode)
                    } else {
                        print("Error unknown response type.")
                        completion(nil, response.response?.statusCode)
                    }
                } else {
                    print("Error parsing response data.")
                    completion(nil, response.response?.statusCode)
                }
            }
        } else {
            Alamofire.request(urlRequest).validate().responseJSON { (response) in
                if ApiRequest.LOG_RESPONSE {
                    print(response.toString(true))
                }
                
                if let data = response.data {
                    do {
                        let resp = try JSONDecoder().decode(responseType, from: data)
                        completion(resp, response.response?.statusCode)
                    } catch {
                        print(error)
                        completion(nil, response.response?.statusCode)
                    }
                } else {
                    completion(nil, response.response?.statusCode)
                }
            }
        }
    }
}

