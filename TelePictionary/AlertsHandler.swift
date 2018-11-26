//
//  AlertsHandler.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/27/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import Foundation



func MergeWithGame (_ gameid: NSString, username: NSString, turninfo: NSString, status: NSString, userID: NSString) -> NSString {
    
    let post:NSString = "username=\(username)&turn=\(turninfo)&gameid=\(gameid)&status=\(status)&userid=\(userID)" as NSString
    var syncResult = NSString()
    
   // NSLog("PostData: %@",post);
    
    let url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/SyncGameUser.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    let postLength:NSString = String( postData.count ) as NSString
    
    let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    
    //var reponseError: NSError?
    var response: URLResponse?
    
    var urlData: Data?
    do {
        urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    } catch let error as NSError {
        //let reponseError = error
        print(error)
        urlData = nil
    }
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
      //  NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
            
            NSLog("Response ==> %@", responseData);
            
          //  var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            if(success == 1)
            {
            NSLog("Sign Up SUCCESS");
                syncResult = "yes"
              //  self.dismissViewControllerAnimated(true, completion: nil)
            } else if (success == 2) {
               syncResult = "yes"
            } else {
                syncResult = "no"
                            }
            
        } else {
            syncResult = "no"
        }
    }  else {
        syncResult = "no"
    }
    return syncResult
}


func TurnHolder (_ gameid: NSString, username: NSString, turninfo: NSString, status: NSString, userid: NSString) -> (Bool, NSString) {
    
    let post:NSString = "username=\(username)&turn=\(turninfo)&gameid=\(gameid)&status=\(status)&userid=\(userid)" as NSString
    var error_msg:NSString
    var syncResult = Bool()
    
    NSLog("PostData: %@",post);
    
    let url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/TurnHolder.php")!
    
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
    
    var urlData: Data?
    do {
        urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    } catch let error as NSError {
        print(error)
        urlData = nil
    }
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
      //  NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
            
            NSLog("Response ==> %@", responseData);
            
        //    var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                NSLog("Sign Up SUCCESS");
                syncResult = true
                error_msg = ""
                //  self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                
               
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                
                
                syncResult = false
            }
            
        } else {
            syncResult = false
            error_msg = "Network Error"
        }
    }  else {
        syncResult = false
        error_msg = "Network Error"
    }
    return (syncResult, error_msg)
}

/*

func displayLaunchDetails() {
    
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var URLGameID: NSString!
    var URLTurn: NSString!
    var URLName: NSString!
    
    
    if delegate.scheme != nil {
        println("scheme scheme: \(delegate.scheme)")
        
        if delegate.scheme == "fb669563119812230" {
            
        } else {
            
            let URLQuery = delegate.nsurl.queryDictionary
            //let URLGameID = URLQuery["gameid"]
            URLGameID = URLQuery?["gameid"]?.first
            URLTurn = URLQuery?["turn"]?.first
            URLName = URLQuery?["name"]?.first
            println("URLTurn: \(URLTurn!)")
            println("URLGameID: \(URLGameID!)")
            
            /*
            if let queryString = delegate.nsurl.getKeyVals() {
            println("Query String: \(queryString)")
            }
            */
            
            
            // }
            if delegate.path != nil {
                println("scheme path: \(delegate.path)")
                
                if (delegate.path == "/FirstInvite"){
                    self.performSegueWithIdentifier("FirstGame_Invite", sender: self)
                }
                
                if (delegate.path == "/EmailInvite"){
                    // self.performSegueWithIdentifier("FirstGame_Invite", sender: self)
                    println("New Game Alert")
                    
                    NewGameAlert(URLGameID, turn: URLTurn)
                }
                
                
            }
            if delegate.query2 != nil {
                println("scheme query: \(delegate.query2)")
                
                let URLQuery = delegate.nsurl.queryDictionary
                //let URLGameID = URLQuery["gameid"]
                let URLGameID = URLQuery?["gameid"]?.first
                let URLTurn = URLQuery?["turn"]?.first
                println("URLTurn: \(URLTurn!)")
                println("URLGameID: \(URLGameID!)")
            }
        }
    }
}

*/

func EmailInvite (_ email: NSString, username: NSString, ToUser: NSString) -> Bool {
    
    let post:NSString = "username=\(username)&toUser=\(ToUser)&email=\(email)" as NSString
    var sentResult = Bool()
    
    NSLog("PostData: %@",post);
    
    let url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/EmailInvite.php")!
    
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
    
    var urlData: Data?
    do {
        urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    } catch let error as NSError {
        print(error)
        urlData = nil
    }
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
    //    NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
            
            NSLog("Response ==> %@", responseData);
            
           // var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                NSLog("Sign Up SUCCESS");
                sentResult = true
                //  self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                sentResult = false
            }
            
        } else {
            sentResult = false
        }
    }  else {
        sentResult = false
    }
    return sentResult
}


func EmailGameInvite (_ email: NSString, username: NSString, ToUser: NSString, turn:NSString, gamestyle: NSString, gameid: NSString) -> Bool {
    
    print("Email Game Invite")
    
    let post:NSString = "username=\(username)&toUser=\(ToUser)&email=\(email)&turn=\(turn)&gamestyle=\(gamestyle)&gameid=\(gameid)" as NSString
    
    var sentResult = Bool()
    
    NSLog("PostData: %@",post);
    
    let url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/EmailGameInvite.php")!
    
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
    
    var urlData: Data?
    do {
        urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    } catch let error as NSError {
        print(error)
        urlData = nil
    }
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
     //   NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
            
            NSLog("Response ==> %@", responseData);
            
       //     var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                NSLog("Sign Up SUCCESS");
                sentResult = true
                //  self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                sentResult = false
            }
            
        } else {
            sentResult = false
        }
    }  else {
        sentResult = false
    }
    return sentResult
}



func LikeImage (_ id: NSString, username: NSString, TurnInfo: NSString) -> Bool {
    
    let post:NSString = "username=\(username)&turninfo=\(TurnInfo)&GameID=\(id)" as NSString
    var sentResult = Bool()
    
    NSLog("PostData: %@",post);
    
    let url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/LikeGame.php")!
    
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
    
    var urlData: Data?
    do {
        urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    } catch let error as NSError {
        print(error)
        urlData = nil
    }
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
    //    NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
            
            NSLog("Response ==> %@", responseData);
            
           // var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                NSLog("Sign Up SUCCESS");
                sentResult = true
                //  self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                sentResult = false
            }
            
        } else {
            sentResult = false
        }
    }  else {
        sentResult = false
    }
    return sentResult
}



func GameStatusChange (_ id: NSString, status: NSString) -> Bool {
    
    let post:NSString = "status=\(status)&gameid=\(id)" as NSString
    var sentResult = Bool()
    
    NSLog("PostData: %@",post);
    
    let url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/ChangeGameStatus.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    let postLength:NSString = String( postData.count ) as NSString
    
    let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    
  //  var reponseError: NSError?
    var response: URLResponse?
    
    var urlData: Data?
    do {
        urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    } catch let error as NSError {
        print(error)
        urlData = nil
    }
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
      //  NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
            
            NSLog("Response ==> %@", responseData);
            
           // var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            if(success > 0)
            {
                NSLog("Sign Up SUCCESS");
                sentResult = true
                //  self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                sentResult = false
            }
            
        } else {
            sentResult = false
        }
    }  else {
        sentResult = false
    }
    return sentResult
}

func UserStatusCheck (_ username: NSString, userID: NSString, status: NSString, action: NSString) -> Bool {
    
    let post:NSString = "status=\(status)&username=\(username)&action=\(action)&userid=\(userID)" as NSString
    
    var sentResult = Bool()
    
    NSLog("PostData: %@",post);
    
    let url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/CheckUserStatus.php")!
    
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
    
    var urlData: Data?
    do {
        urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    } catch let error as NSError {
        print(error)
        urlData = nil
    }
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
     //   NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
            
            NSLog("Response ==> %@", responseData);
            
          //  let error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            if(success > 0)
            {
                NSLog("Item Verified");
                sentResult = true
                //  self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                
                
                sentResult = false
            }
            
        } else {
            sentResult = false
        }
    }  else {
        sentResult = false
    }
    return sentResult
}



func CheckAppVersion (_ AppVersion: NSString) -> Bool {
    
    var UpdateVerion = Bool()
    
    let post:NSString = "version=\(AppVersion)" as NSString
   // var syncResult = NSString()
    
    NSLog("PostData: %@",post);
    
    let url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/AppVersion.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    let postLength:NSString = String( postData.count ) as NSString
    
    let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    
    //var reponseError: NSError?
    var response: URLResponse?
    
    var urlData: Data?
    do {
        urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    } catch let error as NSError {
        //let reponseError = error
        print(error)
        urlData = nil
    }
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
      //  NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
            
            NSLog("Response ==> %@", responseData);
            
            //  var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                NSLog("Sign Up SUCCESS");
                UpdateVerion = true
                //  self.dismissViewControllerAnimated(true, completion: nil)
            } else if (success == 2) {
               // UpdateVerion = false
            } else {
                UpdateVerion = false
            }
            
        } else {
            UpdateVerion = false
        }
    }  else {
        UpdateVerion = false
    }
    return UpdateVerion
}


