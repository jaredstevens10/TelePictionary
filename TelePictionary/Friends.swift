//
//  Friends.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/9/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import Foundation

class friend: CustomStringConvertible {
    
    var firstName: String!
    var lastName: String!
    var phoneNumber: String!
    var imageData: Data!
    
    var description : String {
        return firstName + " " + lastName
    }
    
    
    init(firstName: String, lastName: String, phoneNumber: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
       // self.imageData = UIImage
    }
    
}


struct MyFriends {
    let name : String
    let email : String
}
