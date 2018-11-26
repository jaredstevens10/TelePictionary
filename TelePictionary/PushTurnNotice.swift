//
//  PushTurnNotice.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/26/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import Foundation

func SendTurnNotice(_ player: NSString, token: NSString, gameid: NSString, turninfo: NSString, alertType: NSString, gameType: NSString, turninfoID: NSString, myID: NSString)
{
    
    let prefs:UserDefaults = UserDefaults.standard
    let username = prefs.value(forKey: "USERNAME") as! NSString as String
    
    let playerNew = player.replacingOccurrences(of: "'", with: "")
    
    let tokenNew = token.replacingOccurrences(of: "'", with: "")
    
    let turninfoNew = turninfo.replacingOccurrences(of: "'", with: "")
    
    print("TOKEN NEW: \(tokenNew)")
    print("Turn info from push send: \(turninfo)")
    
    let post:NSString = "player=\(playerNew)&token=\(tokenNew)&id=\(gameid)&turninfo=\(turninfoNew)&gameBy=\(username)&alert=\(alertType)&gameType=\(gameType)&turninfoID=\(turninfoID)&myid=\(myID)" as NSString
    
    //  let post:NSString = "player=\(playerNew)&token=\(tokenNew)&id=\(gameid)&turninfo=\(turninfoNew)&gameBy=\(username)&alert=\(alertType)&gameType=\(gameType)&turninfoID=\(turninfoID)"
    
   // //NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GamePush.php")!
    
    print("URL entered")
    
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
    
    var urlData: Data?
    do {
        urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    } catch let error as NSError {
        reponseError = error
        urlData = nil
    }
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
      //  //NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
            
            ////NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            //NSLog("Success: %ld", success);
            
            //Admin = jsonData.valueForKey("admin") as! NSString
            
            
            
            if(success == 1)
            {
                //NSLog("Login SUCCESS");
                
            //    var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                print("success in sending push alert")
                
                //prefs.setObject(username, forKey: "USERNAME")
                
             //   prefs.setInteger(1, forKey: "ISLOGGEDIN")
             //   prefs.synchronize()
                
                //  prefs.setValue(Admin, forKey: "ADMIN")
                
             //   Email = jsonData.valueForKey("email") as! NSString
                
             //   prefs.setValue(Email, forKey: "EMAIL")
                
             //   prefs.setValue(username, forKey: "USERNAME")
                
             //   self.dismissViewControllerAnimated(true, completion: nil)
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
                //alertView.message = "Sign in Error"
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
}


func SendGameNotice(_ player: NSString, gameid: NSString, turninfo: NSString, alertType: NSString, gameType: NSString, turninfoID: NSString, playerid: NSString) -> Bool
{
    
    var sent = Bool()
    
    let prefs:UserDefaults = UserDefaults.standard
    let username = prefs.value(forKey: "USERNAME") as! NSString as String
    
    let playerNew = player.replacingOccurrences(of: "'", with: "")
    
    let PlayerID2 = playerid.replacingOccurrences(of: ":", with: "")
    //var tokenNew = token.stringByReplacingOccurrencesOfString("'", withString: "")
    
    let turninfoNew = turninfo.replacingOccurrences(of: "'", with: "")
    
  //  println("TOKEN NEW: \(tokenNew)")
  //  println("Turn info from push send: \(turninfo)")
    
    
    let post:NSString = "player=\(playerNew)&id=\(gameid)&turninfo=\(turninfoNew)&gameBy=\(username)&alert=\(alertType)&gameType=\(gameType)&playerid=\(PlayerID2)" as NSString
    
    //NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameNotice.php")!
    
    print("URL entered")
    
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
    
    var urlData: Data?
    do {
        urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    } catch let error as NSError {
        reponseError = error
        urlData = nil
    }
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
       // //NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
            
            //NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            //NSLog("Success: %ld", success);
            
            //Admin = jsonData.valueForKey("admin") as! NSString
            
            
            
            if(success == 1)
            {
                //NSLog("Login SUCCESS");
                
                
                //    var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                print("success in sending push alert")
                
                sent = true
                
                //prefs.setObject(username, forKey: "USERNAME")
                
                //   prefs.setInteger(1, forKey: "ISLOGGEDIN")
                //   prefs.synchronize()
                
                //  prefs.setValue(Admin, forKey: "ADMIN")
                
                //   Email = jsonData.valueForKey("email") as! NSString
                
                //   prefs.setValue(Email, forKey: "EMAIL")
                
                //   prefs.setValue(username, forKey: "USERNAME")
                
                //   self.dismissViewControllerAnimated(true, completion: nil)
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
                //alertView.message = "Sign in Error"
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
    
    return sent
    
}


