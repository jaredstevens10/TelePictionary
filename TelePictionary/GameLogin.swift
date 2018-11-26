//
//  GameLogin.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/26/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import Foundation
import GameKit


/*
func GameCenterLogin () -> (NSString, NSString) {
    println("login called")
   
    var localPlayer = GKLocalPlayer.localPlayer()
    
    localPlayer.authenticateHandler = {(ViewController: UIViewController!, error: NSError!) -> Void in
        if ((ViewController) != nil) {
            println("VC True")
            presentViewController(ViewController, animated: true, completion: nil)
            
            
        } else if self.localPlayer.authenticated {
            self.gcEnabled = true
            println("Player authenticated")
            
            //self.player = localPlayer.displayName
            self.playerid = self.localPlayer.playerID
            self.player = self.localPlayer.alias
            
            println("player: \(self.player)")
            println("playerid: \(self.playerid)")
            
            self.prefs.setValue(self.player, forKey: "USERNAME")
            self.prefs.setValue(self.playerid, forKey: "PLAYERID")
            
            
           // self.usernameLabel.text = ("Welcome back \(self.player)")
            
            
        } else {
            self.gcEnabled = false
            println("Local player could not be authenticated, disableing game")
            println("Authentifcate error: \(error)")
            println("Player NOT authenticated")
            
            //self.player = ""
            
            
            
        }
        
    }
    return (player, playerid)
}

*/

func promptUserToRegisterPushNotifications() {
    let types: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.sound, UIUserNotificationType.badge]
    let settings = UIUserNotificationSettings(types: types, categories: nil)
    UIApplication.shared.registerUserNotificationSettings(settings)
UIApplication.shared.registerForRemoteNotifications()
}

func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    
 
    UserDefaults.standard.set(deviceToken, forKey: "deviceToken")
    
}


func SyncVisitDate (_ username: NSString) {

    
    let post:NSString = "username=\(username)" as NSString

   //NSLog("PostData: %@",post);
    print("Searching for Player in TP database - TPLogin Query")
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/VisitDate.php")!
    
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
        
      //NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
            
           //NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
           // let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
          // //NSLog("Success: %ld", success);
            
            //Admin = jsonData.valueForKey("admin") as! NSString
            
            
         /*
            if(success == 1)
            {
              // //NSLog("Member Found - Success");
                
             //   let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                
                // prefs.setObject(user, forKey: "USERNAME")
                
             //   prefs.setInteger(1, forKey: "ISLOGGEDIN")
             //   prefs.synchronize()
                
                //  prefs.setValue(Admin, forKey: "ADMIN")

                // self.dismissViewControllerAnimated(true, completion: nil)
            } else {
               // var error_msg:NSString
                
         
                
                
                
            }
          */  
        } else {
     
        }
    } else {
    
        }
   
    }
//}

