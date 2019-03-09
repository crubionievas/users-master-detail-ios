//
//  RandomUserAPI.swift
//  UsersMasterDetail
//
//  Created by Carlos Rubio on 09/03/2019.
//  Copyright © 2019 Carlos Rubio. All rights reserved.
//

import SwiftyJSON

struct APIService {
    var endpoint = ""
    var httpProtocol: HTTPClientBuilder.Method = .GET
    
    func formatEndpoint(with parameter: CVarArg) -> APIService {
        
        var formattedService = self
        formattedService.endpoint = String(format: endpoint, parameter)
        
        return formattedService
    }
    
    func add(_ query: String) -> APIService {
        
        var formattedService = self
        formattedService.endpoint = "\(formattedService.endpoint)?\(query)"
        
        return formattedService
    }
}

extension HTTPClientBuilder {
    
    func build(_ call: APIService, parameters: [String: Any]?, completion: @escaping (_ json: JSON?, _ error: APIError?) -> Void) {
        
        build(call.httpProtocol, endPoint: call.endpoint, parameters: parameters, completion: completion)
    }
}

final class APIServices {
    
    enum APICall {
        static let getUsers = APIService(endpoint: "/", httpProtocol: .GET)
    }
    
}

// MARK: - Public Interface
extension APIServices {
    
    class func getUsers(forResults numResults: Int,
                         onGetUsersSuccess: @escaping (_ usersJSON: JSON) -> Void,
                         onGetUsersFailed: @escaping (_ error: APIError?) -> Void) {
        
        let parameters: [String: Any] = ["seed": "xmoba",
                                         "results": numResults]
        
        HTTPClientBuilder
            .shared
            .build(APICall.getUsers, parameters: parameters) { (json, error) in
                
                guard
                    error == nil,
                    let usersJSON = json,
                    !usersJSON.isEmpty
                    else {
                        return onGetUsersFailed(error)
                }
                
                onGetUsersSuccess(usersJSON)
        }
    }
}

