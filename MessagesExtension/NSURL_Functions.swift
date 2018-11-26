//
//  NSURL_Functions.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 10/28/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation


extension NSURL {
    func getKeyVals() -> Dictionary<String, String>? {
        var results = [String:String]()
        var keyValues = self.query?.components(separatedBy: "&")
        if (keyValues?.count)! > 0 {
            for pair in keyValues! {
                let kv = pair.components(separatedBy: "=")
                if kv.count > 1 {
                    results.updateValue(kv[1], forKey: kv[0])
                }
            }
            
        }
        return results
    }
}

extension URL {
    func getKeyVals() -> Dictionary<String, String>? {
        var results = [String:String]()// = [String:AnyObject]()
        let keyValues = self.query?.components(separatedBy: "&")
        if (keyValues?.count)! > 0 {
            for pair in keyValues! {
                let kv = pair.components(separatedBy: "=")
                if kv.count > 1 {
                    results.updateValue(kv[1], forKey: kv[0])
                }
            }
            /*
             if let queryString = self.query{
             for parameter in queryString.componentsSeparatedByString("&"){
             let parts = parameter.componentsSeparatedByString("=")
             if parts.count > 1{
             let key = (parts[0] as String).stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
             let value = (parts[1] as String).stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
             if key != nil && value != nil {
             info[key!] = value
             }
             }
             }
             }
             */
        }
        return results
    }
    
    
    
}


extension URL {
    var queryDictionary:[String: [String]]? {
        get {
            if let query = self.query {
                var dictionary = [String: [String]]()
                for keyValueString in query.components(separatedBy: "&") {
                    var parts = keyValueString.components(separatedBy: "=")
                    if parts.count < 2 { continue; }
                    let key = parts[0].removingPercentEncoding!
                    let value = parts[1].removingPercentEncoding!
                    var values = dictionary[key] ?? [String]()
                    values.append(value)
                    dictionary[key] = values
                }
                return dictionary
            }
            
            return nil
        }
    }
}
