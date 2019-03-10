//
//  UsersMasterDetailTests.swift
//  UsersMasterDetailTests
//
//  Created by Carlos Rubio on 07/03/2019.
//  Copyright © 2019 Carlos Rubio. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import UsersMasterDetail

class UsersTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func fullName() {
        // 1. given
        let name = UserName(JSON.init(rawValue: ""))
        name.setFullName(title: "mr", first: "benjamin", last: "thomsen")
        
        // 2. when
        let fullName = name.getFullName()
        
        // 3. then
        XCTAssertEqual(fullName, "Mr Benjamin Thomsen", "User full name matches")
    }
    
    func downloadImage() {
        let thumbUrl = "https://randomuser.me/api/portraits/thumb/men/8.jpg"
        let imageView = UIImageView()
        // Download thumbnail
        if let url = URL(string: thumbUrl) {
            imageView.af_setImage(withURL: url)
        }

        XCTAssertNotNil(imageView.image)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
