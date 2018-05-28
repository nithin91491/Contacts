//
//  RequestManager.swift
//  Contacts
//
//  Created by Nithin on 04/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import Foundation

enum RequestType:String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum ServiceResponse<T> {
    case success(T)
    case failure(NetworkingError)
}

enum NetworkingError:Error, CustomStringConvertible{
    
    case custom(message:String)
    case noInternetConnection
    case generic
    case invalidJsonResponse
    case failedWithStatusCode(statusCode:Int)
    case serverError
    case inputValidationError
    
    var description: String{
        switch self {
        case .noInternetConnection:
            return "Please check your internet connectivity."
        case .custom(let message):
            return message
        case .generic:
            return "There is a technical issue. Please contact us if the issue persists."
        case .invalidJsonResponse:
            return "The response is not in a valid json format."
        case .failedWithStatusCode(let code):
            return "Failed with status code \(code)"
        case .serverError:
            return "An Internal Server Error occured."
        case .inputValidationError:
            return "There are some input validation errors."
        }
    }
    //Could not contact the server. Please try after some time.
}



protocol RequestManagerProtocol {
    func request(_ type:RequestType,apiPath:ApiPath,queryParameters:String?, httpBody:String?, headers:([String:String])?, block:@escaping (ServiceResponse<JSON>) -> ())
}

extension RequestManagerProtocol {
    func request(_ type:RequestType,apiPath:ApiPath,queryParameters:String? = nil, httpBody:String?, headers:([String:String])? = nil, block:@escaping (ServiceResponse<JSON>) -> ()){
        return request(type, apiPath: apiPath, queryParameters: queryParameters, httpBody: httpBody, headers: headers, block: block)
    }
}

class RequestManager:RequestManagerProtocol{

    
    func request(_ type:RequestType,apiPath:ApiPath,queryParameters:String? = nil, httpBody:String?, headers:([String:String])? = nil, block:@escaping (ServiceResponse<JSON>) -> ()){
        
        //Check for Internet connection and return early
        guard  Reachability.isConnectedToNetwork() else {
            block(.failure(.noInternetConnection))
            return
        }
        
        //Prepare url
        var urlString = BaseURL.url + apiPath.description + (queryParameters ?? "")
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url:URL = URL(string: urlString)!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        request.timeoutInterval = 30
        
        //Set Request Type
        if (type == .post || type == .put){
            request.httpBody = httpBody?.data(using: String.Encoding.utf8)
        }
        
        //Set Headers if any
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        //Fire a data task with the request
        session.dataTask(with: request){
            (data, response, error) in
            
            guard let data:Data = data, let _:URLResponse = response  , error == nil else {
                DispatchQueue.main.async {
                    block(.failure(.custom(message: error?.localizedDescription ?? "Error")))
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                
                switch httpResponse.statusCode {
                    
                case 200 : //Success
                    
                    DispatchQueue.main.async{
                        
                        guard let json =  try? JSON(data:data) else {
                            block(.failure(.invalidJsonResponse)) //Failure because, not able to parse response to JSON
                            return
                        }
                        
                        //On success callback completion handler
                        block(.success(json))
                    }

                case 201: //Content created

                    DispatchQueue.main.async {
                        block(.success(JSON(["success":true])))
                    }
                    
                case 500: //Internal server error
                    
                    DispatchQueue.main.async {
                        block(.failure(.serverError))
                    }
                    
                case 422: //Validation Errors
                    
                    DispatchQueue.main.async {
                        block(.failure(.inputValidationError))
                    }
                    
                case 404: //Not found
                    
                    DispatchQueue.main.async {
                        block(.failure(.generic))
                    }
                    
                default:
                    
                    DispatchQueue.main.async {
                        block(.failure(.custom(message: "Unexpected status code from server.")))
                    }
                    
                }//Switch closing
                
                session.finishTasksAndInvalidate()
                
            }//If Let closing
            
        }.resume()
        
    }
    
}
