//
//  ServerInfo.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 4/13/17.
//  Copyright © 2017 Claven Solutions. All rights reserved.
//

import Foundation



//struct ServerInfo {
//
//    let theAddress = "97.102.21.254"
//
//
//}

class ServerInfo {
    class var sharedInstance: String {
        struct Static {
            //static let instance = ServerInfo()
            //static let instance = "97.102.15.46"
            static let instance = "www.meganonmainstreet.com"
            
        }
        return Static.instance
    }
}
