//
//  ExtensionsGameData.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 10/29/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation

//
//  GameData.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/8/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import Foundation


func CompleteGameData (_ Game_ID: NSString, username: NSString) -> Data {
    
    
    let post:NSString = "gameid=\(Game_ID)&username=\(username)" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
    //NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/CompleteGameData.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    let postLength:NSString = String( postData.count ) as NSString
    
    let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    
    var reponseError: NSError?
    var response: URLResponse?
    
    urlData = try! NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
        //NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            //NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            //NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                //NSLog("Login SUCCESS");
                /*
                 var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                 prefs.setObject(username, forKey: "USERNAME")
                 prefs.setInteger(1, forKey: "ISLOGGEDIN")
                 prefs.synchronize()
                 
                 self.dismissViewControllerAnimated(true, completion: nil)
                 
                 */
            } else {
                var error_msg:NSString
                
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                /*
                 
                 var alertView:UIAlertView = UIAlertView()
                 alertView.title = "Sign in Failed!"
                 alertView.message = error_msg as String
                 alertView.delegate = self
                 alertView.addButtonWithTitle("OK")
                 alertView.show()
                 
                 */
                
            }
            
        } else {
            /*
             var alertView:UIAlertView = UIAlertView()
             alertView.title = "Sign in Failed!"
             alertView.message = "Connection Failed"
             alertView.delegate = self
             alertView.addButtonWithTitle("OK")
             alertView.show()
             
             */
        }
    } else {
        
        /*
         var alertView:UIAlertView = UIAlertView()
         alertView.title = "Sign in Failed!"
         alertView.message = "Connection Failure"
         
         if let error = reponseError {
         alertView.message = (error.localizedDescription)
         
         }
         
         
         alertView.delegate = self
         alertView.addButtonWithTitle("OK")
         alertView.show()
         
         */
    }
    
    return urlData
}


import Foundation


func DeleteGameData (_ Game_ID: NSString) -> Data {
    
    
    let post:NSString = "gameid=\(Game_ID)" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
    //NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/DeleteGame.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    let postLength:NSString = String( postData.count ) as NSString
    
    let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    
    var reponseError: NSError?
    var response: URLResponse?
    
    urlData = try! NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
        //NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            //NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            //NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                //NSLog("Login SUCCESS");
                /*
                 var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                 prefs.setObject(username, forKey: "USERNAME")
                 prefs.setInteger(1, forKey: "ISLOGGEDIN")
                 prefs.synchronize()
                 
                 self.dismissViewControllerAnimated(true, completion: nil)
                 
                 */
            } else {
                var error_msg:NSString
                
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                /*
                 
                 var alertView:UIAlertView = UIAlertView()
                 alertView.title = "Sign in Failed!"
                 alertView.message = error_msg as String
                 alertView.delegate = self
                 alertView.addButtonWithTitle("OK")
                 alertView.show()
                 
                 */
                
            }
            
        } else {
            /*
             var alertView:UIAlertView = UIAlertView()
             alertView.title = "Sign in Failed!"
             alertView.message = "Connection Failed"
             alertView.delegate = self
             alertView.addButtonWithTitle("OK")
             alertView.show()
             
             */
        }
    } else {
        
        /*
         var alertView:UIAlertView = UIAlertView()
         alertView.title = "Sign in Failed!"
         alertView.message = "Connection Failure"
         
         if let error = reponseError {
         alertView.message = (error.localizedDescription)
         
         }
         
         
         alertView.delegate = self
         alertView.addButtonWithTitle("OK")
         alertView.show()
         
         */
    }
    
    return urlData
}


func AvailableTurnsData (_ username: NSString, userID: NSString) -> Data {
    
    
    let post:NSString = "username=\(username)&userID=\(userID)" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
    //NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/MyTurnsAvailable.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    let postLength:NSString = String( postData.count ) as NSString
    
    let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    
    var reponseError: NSError?
    var response: URLResponse?
    
    urlData = try! NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
        //NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            //NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            //NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                //NSLog("Login SUCCESS");
                
            } else {
                var error_msg:NSString
                
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                
                
            }
            
        } else {
            
        }
    } else {
        
        
    }
    
    return urlData
}


func LeadersGamesCompletedData (_ username: NSString) -> Data {
    
    
    let post:NSString = "getdata=1"
    
    var urlData = Data()
    
    //&password=\(password)"
    
    //NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GamesLeader.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    let postLength:NSString = String( postData.count ) as NSString
    
    let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    
    var reponseError: NSError?
    var response: URLResponse?
    
    urlData = try! NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
        //NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            //NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            //NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                //NSLog("Login SUCCESS");
                
            } else {
                var error_msg:NSString
                
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                
                
            }
            
        } else {
            
        }
    } else {
        
        
    }
    
    return urlData
}

func LeadersLikesData (_ username: NSString) -> Data {
    
    
    let post:NSString = "getdata=1"
    
    var urlData = Data()
    
    //&password=\(password)"
    
    //NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GetLikeLeader.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    let postLength:NSString = String( postData.count ) as NSString
    
    let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    
    var reponseError: NSError?
    var response: URLResponse?
    
    urlData = try! NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
        //NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            //NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            //NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                //NSLog("Login SUCCESS");
                
            } else {
                var error_msg:NSString
                
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                
                
            }
            
        } else {
            
        }
    } else {
        
        
    }
    
    return urlData
}


func LeadersFailData (_ username: NSString) -> Data {
    
    
    let post:NSString = "getdata=1"
    
    var urlData = Data()
    
    //&password=\(password)"
    
    //NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GetFailLeader.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    let postLength:NSString = String( postData.count ) as NSString
    
    let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    
    var reponseError: NSError?
    var response: URLResponse?
    
    urlData = try! NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
        //NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            //NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            //NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                //NSLog("Login SUCCESS");
                
            } else {
                var error_msg:NSString
                
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                
                
            }
            
        } else {
            
        }
    } else {
        
        
    }
    
    return urlData
}

func UserLevelUp (_ username: NSString, userid: NSString, type: NSString, level: NSString) -> (NSInteger, NSInteger) {
    var points = NSInteger()
    var level2 = NSInteger()
    
    let userid2 = userid.replacingOccurrences(of: ":", with: "")
    
    
    // let post:NSString = "username=\(username)&userID=\(userid2)&type=\(type)&points=\(points)"
    
    //  var pointsST = NSString()
    let post:NSString = "username=\(username)&userID=\(userid2)&type=\(type)&level=\(level)" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
    //NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/UserLevel.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    let postLength:NSString = String( postData.count ) as NSString
    
    let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    
    // var reponseError: NSError?
    var response: URLResponse?
    
    urlData = try! NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
        //NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            //NSLog("Response ==> %@", responseData);
            
            //   var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            let level:NSInteger = jsonData.value(forKey: "level") as! NSInteger
            // points = jsonData.valueForKey("points") as! NSInteger
            let points:NSInteger = jsonData.value(forKey: "levelpoints") as! NSInteger
            
            
            let prefs:UserDefaults = UserDefaults.standard
            
            prefs.set(level, forKey: "USERLEVEL")
            // prefs.setInteger(tokens, forKey: "USERTOKENS")
            prefs.set(points, forKey: "USERLEVELPOINTS")
            
            
            var json = JSON(jsonData)
            // print("Json valueJSON: \(json)")
            
            /*
             for result in json["Data"].arrayValue {
             
             let num_likesTemp = result["levelpoints"].stringValue
             points = Int(num_likesTemp)!
             let num_level = result["level"].stringValue
             //   level = Int(num_level)!
             //print("Num Points = \(Game_UP)")
             let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
             
             prefs.setInteger(level, forKey: "USERLEVEL")
             // prefs.setInteger(tokens, forKey: "USERTOKENS")
             prefs.setInteger(points, forKey: "USERLEVELPOINTS")
             
             
             }
             */
            
            //   let num_likesTemp = jsonData.valueForKey("points") as! NSString
            //  var pointsST = json["Data"]["points"].stringValue
            //  pointsST = jsonData.valueForKey("points") as! String
            
            //  points = Int(pointsST)!
            //as! String)!
            // print("Num Points = \(points)")
            
            //[jsonData[@"success"] integerValue];
            
            //NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                //NSLog("Login SUCCESS");
                
            } else {
                var error_msg:NSString
                
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                
                
            }
            
        } else {
            
        }
    } else {
        
        
    }
    
    return (points, level2)
}

func UserLevelData (_ username: NSString, userid: NSString, type: NSString, level: NSString) -> NSInteger {
    var points = NSInteger()
    
    let userid2 = userid.replacingOccurrences(of: ":", with: "")
    
    
    // let post:NSString = "username=\(username)&userID=\(userid2)&type=\(type)&points=\(points)"
    
    //  var pointsST = NSString()
    let post:NSString = "username=\(username)&userID=\(userid2)&type=\(type)&level=\(level)" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
    //NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/UserLevel.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    let postLength:NSString = String( postData.count ) as NSString
    
    let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    
    // var reponseError: NSError?
    var response: URLResponse?
    
    urlData = try! NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
        //NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            //NSLog("Response ==> %@", responseData);
            
            //   var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            // points = jsonData.valueForKey("points") as! NSInteger
            
            var json = JSON(jsonData)
            // print("Json valueJSON: \(json)")
            
            
            for result in json["Data"].arrayValue {
                
                let num_likesTemp = result["level"].stringValue
                points = Int(num_likesTemp)!
                //print("Num Points = \(Game_UP)")
                
            }
            
            
            //   let num_likesTemp = jsonData.valueForKey("points") as! NSString
            //  var pointsST = json["Data"]["points"].stringValue
            //  pointsST = jsonData.valueForKey("points") as! String
            
            //  points = Int(pointsST)!
            //as! String)!
            // print("Num Points = \(points)")
            
            //[jsonData[@"success"] integerValue];
            
            //NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                //NSLog("Login SUCCESS");
                
            } else {
                var error_msg:NSString
                
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                
                
            }
            
        } else {
            
        }
    } else {
        
        
    }
    
    return points
}

func UPData (_ username: NSString, userid: NSString, type: NSString, points: NSString, levelpoints: NSString) -> (NSInteger, Bool) {
    var points2 = NSInteger()
    //  var pointsST = NSString()
    var LevelUpTime = Bool()
    let userid2 = userid.replacingOccurrences(of: ":", with: "")
    
    
    let post:NSString = "username=\(username)&userID=\(userid2)&type=\(type)&points=\(points)&levelpoints=\(levelpoints)" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
    //NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/UserPoints.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    let postLength:NSString = String( postData.count ) as NSString
    
    let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    
    // var reponseError: NSError?
    var response: URLResponse?
    
    urlData = try! NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
        //NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            //NSLog("Response ==> %@", responseData);
            
            //   var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            // points = jsonData.valueForKey("points") as! NSInteger
            
            var json = JSON(jsonData)
            // print("Json valueJSON: \(json)")
            var level = Int()
            var levelpoints = Int()
            for result in json["Data"].arrayValue {
                
                let num_likesTemp = result["points"].stringValue
                points2 = Int(num_likesTemp)!
                
                let level2 = result["level"].stringValue
                level = Int(level2)!
                
                let levelpoints2 = result["levelpoints"].stringValue
                levelpoints = Int(levelpoints2)!
                //print("Num Points = \(Game_UP)")
                
            }
            
            
            
            var nextTier = Int()
            
            
            switch level {
            case 1:
                // pixieBTN.setImage(Char1, forState: .Normal)
                nextTier = 200
            case 2:
                //  pixieBTN.setImage(Char2, forState: .Normal)
                nextTier = 300
            case 3:
                //  pixieBTN.setImage(Char3, forState: .Normal)
                nextTier = 400
            case 4:
                //  pixieBTN.setImage(Char4, forState: .Normal)
                nextTier = 500
            case 5:
                //  pixieBTN.setImage(Char5, forState: .Normal)
                nextTier = 600
            case 6:
                //   pixieBTN.setImage(Char5, forState: .Normal)
                nextTier = 700
            case 7:
                //   pixieBTN.setImage(Char5, forState: .Normal)
                nextTier = 800
            case 8:
                //    pixieBTN.setImage(Char5, forState: .Normal)
                nextTier = 900
            case 9:
                //   pixieBTN.setImage(Char5, forState: .Normal)
                nextTier = 1000
            case 10:
                //   pixieBTN.setImage(Char6, forState: .Normal)
                nextTier = 10000
            default:
                break
                //   pixieBTN.setImage(Char1, forState: .Normal)
            }
            
            print("Current Level = \(level)")
            print("Next Tier = \(nextTier)")
            
            
            if levelpoints >= nextTier {
                LevelUpTime = true
                print("level up time SHOULD be true")
            } else {
                LevelUpTime = false
                print("level up time SHOULD be false")
            }
            
            
            
            
            //   let num_likesTemp = jsonData.valueForKey("points") as! NSString
            //  var pointsST = json["Data"]["points"].stringValue
            //  pointsST = jsonData.valueForKey("points") as! String
            
            //  points = Int(pointsST)!
            //as! String)!
            // print("Num Points = \(points)")
            
            //[jsonData[@"success"] integerValue];
            
            //NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                //NSLog("Login SUCCESS");
                
            } else {
                var error_msg:NSString
                LevelUpTime = false
                
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                
                
            }
            //  LevelUpTime = false
            
            
        } else {
            LevelUpTime = false
            
        }
    } else {
        LevelUpTime = false
        
        
    }
    
    return (points2, LevelUpTime)
}



func FilterUPData(_ urlData: Data) -> Int {
    
    var Total_Likes_UP = Int()
    var Game_UP = Int()
    
    let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
    
    var json = JSON(jsonData)
    print("Json valueJSON: \(json)")
    
    let num_likesTemp = json["points"].stringValue
    Game_UP = Int(num_likesTemp)!
    print("Num Points = \(Game_UP)")
    /*
     for result in json["Data"].arrayValue {
     
     let num_likesTemp = result["points"].stringValue
     Game_UP = Int(num_likesTemp)!
     print("Num Points = \(Game_UP)")
     
     }
     */
    
    return Game_UP
}


func SaveVideoToDirectory(_ data: Data, name: String ) {
    
    //let data = NSData(contentsOfURL: YTLink)
    
    let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    
    
    let tempTYVideo = (documentDirectory as NSString).appending(name)
    //let tempTYVideo = (documentDirectory as NSString).stringByAppendingString("/tempYTVideo.mov")
    if FileManager.default.fileExists(atPath: tempTYVideo as String) {
        print("Deleting existing file\n")
        
        do {
            
            try FileManager.default.removeItem(atPath: tempTYVideo as String)
            
            
            
            
        } catch {
            print("Error = \(error)")
        }
    }
    
    
    
    
    do {
        
        //     try data?.writeToFile(tempTYVideo, options: NSDataWritingOptions.AtomicWrite)
        
        try data.write(to: URL(fileURLWithPath: tempTYVideo), options: [.atomic])
        print("File saved to path = \(tempTYVideo)")
        let prefs:UserDefaults = UserDefaults.standard
        
        switch name {
            
        case "/PQTempMusic4.m4v" :
            prefs.set(true, forKey: "DEFAULTSAVEDvideo")
            
        case "/tada.caf" :
            prefs.set(true, forKey: "DEFAULTSAVEDtada")
            
        case "/please.caf" :
            prefs.set(true, forKey: "DEFAULTSAVEDplease")
            
        case "/joy.caf" :
            prefs.set(true, forKey: "DEFAULTSAVEDjoy")
            
        case "/metroid.caf" :
            prefs.set(true, forKey: "DEFAULTSAVEDmetroid")
            
        case "/doorbell.caf" :
            prefs.set(true, forKey: "DEFAULTSAVEDdoorbell")
            
        case "/ComedicFun.mp3":
            prefs.set(true, forKey: "DEFAULTCFUN")
            prefs.set(false, forKey: "MuteGameAudio")
            
        case "/DemoImageTurn.jpg":
            prefs.set(true, forKey: "DemoImageTurn")
            
        default:
            break
            
        }
        
        
    } catch {
        print("ERROR Saving Temp Video = \(error)")
    }
    
    
    
    print("Temp Video Saved at path = \(tempTYVideo)")
    
    //  let savePath = (documentDirectory as NSString).stringByAppendingString("/tempYTAudio.m4a")
    
    //   dispatch_async(dispatch_get_main_queue(), {
    
    // self.createVideoNow(YTLink)
    
    //    })
    
}


func SaveVideo(_ fileURL: String, name: String) {
    
    let request: URLRequest = URLRequest(url: URL(string: fileURL)!)
    let mainQueue = OperationQueue.main
    NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
        if error == nil {
            // Convert the downloaded data in to a UIImage object
            
            
            
            
            SaveVideoToDirectory(data!, name: name)
            
            //var image = UIImage(data: data!)
            // Store the imge in to our cache
            //  self.imageCache[urlString] = image
            // Update the cell
            DispatchQueue.main.async(execute: {
                //if let cellToUpdate = TableView.cellForItemAtIndexPath(indexPath) {
                //if let cellToUpdate = TableView.cel
                
            })
        }
        
    })
    
}

func MyTurnsCount (_ username: NSString, userID: NSString) -> Data {
    
    
    let post:NSString = "username=\(username)&userID=\(userID)" as NSString
    
    
    //&password=\(password)"
    
    //NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/MyTurns.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    let postLength:NSString = String( postData.count ) as NSString
    
    let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    
    var reponseError: NSError?
    var response: URLResponse?
    
    
    var urlData = Data()
    
    urlData = try! NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
        //NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            //NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            let turnCount:NSInteger = jsonData.value(forKey: "myturns") as! NSInteger
            
            
            
            print("Number of turns available = \(turnCount.description)")
            
            UserDefaults.standard.set(turnCount, forKey: "numTurns")
            
            let numBadges =  UserDefaults.standard.integer(forKey: "appBadges")
            
            if numBadges == 0 {
                
                
            }
            
            // let appbadges = NSUserDefaults.standardUserDefaults().integerForKey("appBadges")
            //  let newAppBadges = appbadges + turnCount
            
            //NSUserDefaults.standardUserDefaults().setInteger(newAppBadges, forKey: "appBadges")
            
            //UIApplication.shared.applicationIconBadgeNumber = turnCount
            
            //[jsonData[@"success"] integerValue];
            
            //NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                //NSLog("Login SUCCESS");
                
            } else {
                var error_msg:NSString
                
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                
                
            }
            
        } else {
            
        }
    } else {
        
        
    }
    
    return urlData
}
