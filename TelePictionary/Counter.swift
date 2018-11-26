//
//  Counter.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/24/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import Foundation
//import Parse



class Counter {
    
    var UD_KEY:String {
        return "TotalCount"
    }
    
    var currentTotal:Int {
        get{
            let userDefault = UserDefaults.standard
            return userDefault.integer(forKey: UD_KEY)
        }
        set(newValue){
            let userDefault = UserDefaults.standard
            userDefault.set(newValue, forKey: UD_KEY)
            userDefault.synchronize()
            
            // Post a notification to let observers know about the new value
            let notificationCenter = NotificationCenter.default
            let notification = Notification(name: Notification.Name(rawValue: "COUNTER_UPDATED"), object: nil)
            notificationCenter.post(notification)
        }
    }
}

postfix func ++ (counter:Counter){
    counter.currentTotal += 1
}

postfix func -- (counter:Counter){
    counter.currentTotal -= 1
}


/*
func Push (username: NSString) {
    
    println("invited called")
    
    var pushQuery:PFQuery = PFInstallation.query()!
    pushQuery.whereKey("user", equalTo: username)
    
    var push:PFPush = PFPush()
    push.setQuery(pushQuery)
    
    var message = "Test Push"
    push.setMessage(message)
    push.sendPushInBackgroundWithBlock(nil)
        /*success, error in
        if success {
        println("the push succeeded")
        } else {
        println("the push failed.")
    }
        })
*/
    
    println("sent invite?")
    
}
*/
