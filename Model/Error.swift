//
//  Error.swift
//  UsersMasterDetail
//
//  Created by Carlos Rubio on 09/03/2019.
//  Copyright © 2019 Carlos Rubio. All rights reserved.
//

class Error {
    var code: Int
    var message: String?
    
    init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
}

