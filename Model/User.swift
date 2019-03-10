//
//  User.swift
//  UsersMasterDetail
//
//  Created by Carlos Rubio on 09/03/2019.
//  Copyright © 2019 Carlos Rubio. All rights reserved.
//

import SwiftyJSON

open class UserName {
    open var title: String?
    open var first: String?
    open var last: String?
    
    init (_ data: JSON?) {
        let userName = data?["name"]
        first = userName?["first"].string
        last = userName?["last"].string
        title = userName?["title"].string
    }
    
    func setFullName(title: String, first: String, last: String) {
        self.title = title
        self.first = first
        self.last = last
    }
        
    func getFullName() -> String {
        if let title = title, let first = first, let last = last {
            return "\(title.capitalized) \(first.capitalized) \(last.capitalized)"
        }
        
        return ""
    }
}

open class UserPicture {
    open var large: String?
    open var medium: String?
    open var thumbnail: String?
    
    init (_ data: JSON?) {
        let photos = data?["picture"]
        large = photos?["large"].string
        medium = photos?["medium"].string
        thumbnail = photos?["thumbnail"].string
    }
}


open class User {
    
    open var gender: String?
    open var name: UserName?
    open var email: String?
    open var phone: String?
    open var cell: String?
    open var nationality: String?
    open var picture: UserPicture?
    
    var data: JSON? {
        didSet {
            gender = data?["gender"].string
            
            name = UserName.init(data)
            
            email = data?["email"].string
            phone = data?["phone"].string
            cell = data?["cell"].string
            
            picture = UserPicture.init(data)
            
            nationality = data?["nat"].string
        }
    }
    
    init() {}
    
    init(json: JSON?) {
        defer {
            data = json
        }
    }
}


