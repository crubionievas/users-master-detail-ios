//
//  HttpClientBuilder.swift
//  UsersMasterDetail
//
//  Created by Carlos Rubio on 09/03/2019.
//  Copyright © 2019 Carlos Rubio. All rights reserved.
//

import Alamofire
import SwiftyJSON

let kBaseUrl = "https://api.randomuser.me/"

class APIError: Error {
    var errorExtraInformation: [String: Any]?
    
    init(code: Int, message: String, extraInformation: [String: Any]? = nil) {
        super.init(code: code, message: message)
        
        errorExtraInformation = extraInformation
    }
}

class HTTPClientBuilder {
    
    var sessionManager: SessionManager = .default
    var imageSessionManager: SessionManager?
    static let shared = HTTPClientBuilder()
    
    private init() {
        
    }
    
    typealias CompletionHandler = (_ json: JSON?, _ error: APIError?) -> Void
}

// MARK: - Properties

extension HTTPClientBuilder {
    
    enum Method {
        case GET, POST, PUT, DELETE
        
        var toAlamofire: Alamofire.HTTPMethod {
            switch self {
            case .GET: return .get
            case .POST: return .post
            case .PUT: return .put
            case .DELETE: return .delete
            }
        }
    }
}

// MARK: - Public Interface

extension HTTPClientBuilder {
    
    func build(_ method: Method, endPoint: String, parameters: [String: Any]?, completion: @escaping (_ json: JSON?, _ error: APIError?) -> Void) {
        
        let url = baseURL(appending: endPoint)
        
        sessionManager
            .request(url as URLConvertible, method: method.toAlamofire as HTTPMethod, parameters: parameters)
            .response { [weak self] (responseData) in
                
                guard let saveSelf = self else { return }
                
                if responseData.response == nil {
                    
                    if responseData.error != nil {
                        completion(nil, APIError.init(code: saveSelf.getErrorCode(str: responseData.error.debugDescription), message: responseData.error.debugDescription))
                    } else {
                        completion(nil, nil)
                    }
                    
                    return
                }
                
                saveSelf.responseBuilder(responseData.response!, data: responseData.data, handler: { (json, error) in
                    completion(json, error)
                })
        }
        
    }
    
    func buildWithExternalUrl(_ method: Method, url: String, completion: @escaping (_ json: JSON?, _ error: Error?) -> Void) {
        
        sessionManager.request(url as URLConvertible, method: method.toAlamofire as HTTPMethod, parameters: nil)
            .response { [weak self] (responseData) in
                
                guard let saveSelf = self else { return }
                
                if responseData.response == nil {
                    completion(nil, nil)
                    return
                }
                
                saveSelf.responseBuilder(responseData.response!, data: responseData.data, handler: { (json, error) in
                    completion(json, error)
                })
        }
        
    }
}

// MARK: - Private Interface

extension HTTPClientBuilder {
    
    fileprivate func baseURL(appending endPoint: String) -> URLConvertible {
        
        guard
            let encodedEndpoint = endPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            else {
                let unencodedBaseURL = "\(kBaseUrl)\(endPoint)"
                return unencodedBaseURL
        }
        
        let encodedBaseURL = "\(kBaseUrl)\(encodedEndpoint)"
        return encodedBaseURL
    }
    
    fileprivate func responseBuilder(_ response: HTTPURLResponse, data: Data?, handler: CompletionHandler) {
        
        guard let data = data else { return }
        
        let code = response.statusCode
        let json = JSON(data: data)
        
        switch code {
        case let codeNumber where codeNumber < 299:
            
            // Success
            handler(json, nil)
            
        default:
            
            // Error
            let errorResponse = APIError(code: response.statusCode, message: HTTPURLResponse.localizedString(forStatusCode: response.statusCode), extraInformation: json.dictionaryObject)
            handler(json, errorResponse)
        }
    }
    
    fileprivate func getErrorCode(str: String) -> Int {
        
        let stringParts = str.split { $0 == " " }.map(String.init)
        if stringParts.count > 2 && stringParts[2].contains("Code") {
            
            let codeParts = stringParts[2].split { $0 == "=" }.map(String.init)
            
            if codeParts.count > 1 {
                if let codeInt = Int(codeParts[1]) {
                    return codeInt
                }
            }
        }
        return -1
    }
}
