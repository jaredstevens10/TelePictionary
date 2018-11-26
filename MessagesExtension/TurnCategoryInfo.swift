//
//  TurnCategoryInfo.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 10/26/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation

import Foundation
import Messages



struct GameBoard {
    // MARK: Properties
    
    /*
    var currentUser: String?
    var lastUser: String?
    var TurnType: String?
    */
    
    
    
   // var TurnURL: String?
    //var base: Base?
    
    //var scoops: Scoops?
    
    //var topping: Topping?
    
    var isComplete: Bool {
        return true
        //return base != nil && scoops != nil && topping != nil
    }
}


struct TurnInfo {
    // MARK: Properties
    
    var currentUser: String!
    var currentUserID: String!
    //var currentUser: currentUser?
    var lastUser: String!
    var lastUserID: String!
    var TurnType: String!
    var theQuote: String!
    var theImageData: String!
    var gameID: String!
    var previousTurnNumber: String!
    var imageURL: String!
    var GameComplete: String!
    
   // var TurnURL: String?
    //var base: Base?
    
    //var scoops: Scoops?
    
    //var topping: Topping?
    
    var isComplete: Bool {
        return true
        //return base != nil && scoops != nil && topping != nil
    }
}


extension TurnInfo {
    init?(message: MSMessage?) {
        guard let messageURL = message?.url else { return nil }
      //  guard let urlComponents = NSURLComponents(url: messageURL, resolvingAgainstBaseURL: false), let queryItems = urlComponents.queryItems else { return nil }
        
        //self.init(queryItems: queryItems)
    }
}


/*
 Extends `IceCream` to be able to be represented by and created with an array of
 `NSURLQueryItem`s.
 */
extension TurnInfo {
    // MARK: Computed properties
    
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        
       //  items.append(URLQueryItem(name: "testname", value: "testvalue"))
       //  items.append(URLQueryItem(name: "testname2", value: "testvalue2"))
        
        /*
        if let part = currentUser {
            items.append(URLQueryItem(name: "currentUser", value: currentUser?.rawValue))
        }
        if let part = lastUser {
            items.append(URLQueryItem(name: "lastUser", value: lastUser?.rawValue))
           // items.append(part.queryItem)
        }
        
        if let part = TurnType {
            items.append(URLQueryItem(name: "turnType", value: TurnType?.rawValue))
           // items.append(part.queryItem)
        }
        
        */
        
      
          //  items.append(URLQueryItem(name: "currentUser: \(currentUser)", value: currentUser))
          //  items.append(URLQueryItem(name: "lastUser", value: lastUser?.rawValue))
            // items.append(part.queryItem)
          //  items.append(URLQueryItem(name: "turnType", value: TurnType?.rawValue))
            // items.append(part.queryItem)
        

       
        
 
        print("ITEMS: \(items)")
        
        return items
    }
    
    // MARK: Initialization
   
    
    init?(queryItems: [URLQueryItem]) {
       // var base: Base?
       // var scoops: Scoops?
       // var topping: Topping?
       
        var currentUser: String?
        var lastUser: String?
        var TurnType: String?
 
       // var currentUser: String?
       // var lastUser: String?
       // var TurnType: String?
        
        for queryItem in queryItems {
            guard let value = queryItem.value else { continue }
            
           // let decodedBase = "TestDecodedBase"
           // let currentUser = "TestCurrentUser"
           // let lastUser = "TestLastUser"
            
            //var testdecode: String?
            
           // currentUser = URLQUcurrentUser?.rawValue, currentUser?.queryItemKey
          //  currentUser = currentUser?.queryItem(URLQueryItem(name: "currentUser", value: currentUser?.rawValue))
            
      /*
            
            if let decodedPart = testdecode, queryItem.name == currentUser.queryItemKey {
                currentUser = decodedPart
            }
            if let decodedPart = "testLastUser", queryItem.name == lastUser?.queryItemKey {
                lastUser = decodedPart
            }
            
            if let decodedPart = "testTurnType", queryItem.name == TurnType?.queryItemKey {
                TurnType = decodedPart
            }
            
 */
            
            /*
            if let decodedPart = currentUser(rawValue: value), queryItem.name == currentUser.queryItemKey {
                currentUser = decodedPart
            }
            if let decodedPart = lastUser(rawValue: value), queryItem.name == lastUser.queryItemKey {
                lastUser = decodedPart
            }
            
            if let decodedPart = TurnType(rawValue: value), queryItem.name == TurnType.queryItemKey {
                TurnType = decodedPart
            }
            
            */
            /*
            if let decodedPart = currentUser(rawValue: value), queryItem.name == currentUser?.queryItemKey {
                currentUser = decodedPart
            }
            if let decodedPart = lastUser(rawValue: value), queryItem.name == lastUser?.queryItemKey {
                lastUser = decodedPart
            }
            
            if let decodedPart = TurnType(rawValue: value), queryItem.name == TurnType?.queryItemKey {
                TurnType = decodedPart
            }
            */
 
        }
        
        guard let decodedBase = TurnType else { return nil }
        
      //  self.TurnType = decodedBase
       // self.currentUser = "CurrentUserTest"
       // self.lastUser = "LastUserTest"
    }
    
}



/**
 Extends `IceCream` to be able to be created with the contents of an `MSMessage`.
 */
/*
extension TurnInfo {
    init?(message: MSMessage?) {
        guard let messageURL = message?.url else { return nil }
        guard let urlComponents = NSURLComponents(url: messageURL, resolvingAgainstBaseURL: false), let queryItems = urlComponents.queryItems else { return nil }
        
        self.init(queryItems: queryItems)
    }
}
*/


/**
 Extends `IceCream` to make it `Equatable`.
 */
extension TurnInfo: Equatable {}

func ==(lhs: TurnInfo, rhs: TurnInfo) -> Bool {
    return lhs.currentUser == rhs.currentUser && lhs.lastUser == rhs.lastUser && lhs.TurnType == rhs.TurnType
}
 
 
