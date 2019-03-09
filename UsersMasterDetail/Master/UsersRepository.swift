//
//  UsersRepository.swift
//  UsersMasterDetail
//
//  Created by Carlos Rubio on 09/03/2019.
//  Copyright © 2019 Carlos Rubio. All rights reserved.
//

import SwiftyJSON

protocol UsersRepositoryDelegate: class {
    func usersFailed(error: APIError?, forRequestedNumber: Int)
    func usersReceived()
}

final class UsersRepository {
    weak var delegate: UsersRepositoryDelegate?
    var users = [User]()
    fileprivate var loadingUsers = false
    
    init(delegate: UsersRepositoryDelegate) {
        self.delegate = delegate
    }
}

// MARK: - Service calls
extension UsersRepository {
    func getUsers(forResults results: Int) {
        
        guard !loadingUsers else { return }
        
        loadingUsers = true
        
        APIServices.getUsers(forResults: results,
                              onGetUsersSuccess: { [weak self] (json) in
                                
                                guard let saveSelf = self else { return }
                                
                                var users = [User]()
                                
                                if let results = json["results"].array {
                                    for jsonItem in results {
                                        users.append( User(json: jsonItem) )
                                    }
                                }
                                
                                saveSelf.users = users
                                
                                saveSelf.delegate?.usersReceived()
                                saveSelf.loadingUsers = false
                                
            }, onGetUsersFailed: { [weak self] (error) in
                guard let saveSelf = self else { return }
                saveSelf.delegate?.usersFailed(error: error, forRequestedNumber: results)
                saveSelf.loadingUsers = false
        })
    }
}

