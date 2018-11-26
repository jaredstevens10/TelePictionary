//
//  GetImageData.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/9/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import Foundation



func GetGameData(_ id: NSString, turn: NSString) -> (NSString, NSString,NSString, NSString) {
    
    var TName = NSString()
    var TDesc = NSString()
    var ImageBase = NSString()
    var MediaType = NSString()
    var UseImageURL = NSString()
    var TheImageURL = NSString()
    
    let TurnString:String = turn.description
    let TurnInt:Int? = Int(TurnString)
    
    let LastTurn = TurnInt! - 1
    
    let TurnID = ("Turn\(LastTurn)")
    
    let post:NSString = "id=\(id)&turn=\(TurnID)" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
   //NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GetImage.php")!
    
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
        
     //  //NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
        //   //NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            print("response = \(responseData)")
            
       //    TName = jsonData.valueForKey("TraitName") as! NSString
            
      //      TDesc = jsonData.valueForKey("TraitDesc") as! NSString
            
            ImageBase = jsonData.value(forKey: "imageData") as! NSString
           // print("From Function - ImageBase = \(ImageBase)")
            MediaType = jsonData.value(forKey: "mediaType") as! NSString
            
            UseImageURL = jsonData.value(forKey: "useimageURL") as! NSString
            
            TheImageURL = jsonData.value(forKey: "imageURL") as! NSString
           // print("From Function - Media type = \(MediaType)")
            
        //    println("Image base: \(ImageBase)")
           // println(TDesc)
            
            //[jsonData[@"success"] integerValue];
            
      //     //NSLog("Success: %ld", success);
            
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
    
    return (ImageBase, MediaType, UseImageURL, TheImageURL)
}


