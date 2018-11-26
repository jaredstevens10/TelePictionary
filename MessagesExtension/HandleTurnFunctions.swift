//
//  HandleTurnFunctions.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 10/29/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//



import Foundation
import UIKit

func CreateNewGame(myID: NSString, NewGameTitle: NSString, NameInfoTemp: [NSString], EmailInfoTemp: [NSString], UNIDArrayTemp: [NSString], NumPlayerTemp: Int, NewGameFirstTurn: NSString, MediaType: NSString, NewGameTurnTime: NSString, NewGameContentRating: NSString, NewGameQuote: NSString, imageData: String) -> NSString {
    
    
    
    print("STARTING NEW GAME WITH THIS DATA")
    print("MediaType: \(MediaType)")
   // print("Image Data: \(imageData)")
    //  var progressHUD = ProgressHUD(text: "Creating New Game...")
    //  self.view.addSubview(progressHUD)
     let prefs:UserDefaults = UserDefaults.standard
   // var GameID = NSString()
    var TempImageCurrent = UIImage()
    var success = NSInteger()
    var audioData = String()
    let picData = imageData
    //picData = imageData
    print("Startin Game")
    
    var NameInfo = NameInfoTemp
    var NumPlayers = NumPlayerTemp
    var EmailInfo = EmailInfoTemp
    var UNIDArray = UNIDArrayTemp
    var GameID = NSString()
    var DoUploadImage = Bool()
    
    var post_old = NSString()
    var post = NSString()
    /*
    if !DidSelectGroup {
        NameInfo = NewGamePlayersName
        EmailInfo = NewGamePlayersContact
        NumPlayers = NewGamePlayers
    } else {
        NameInfo = GroupPlayers
        EmailInfo = GroupContact
        // NumPlayers = GroupNumbers
        NumPlayers = GroupVariance
        UNIDArray = GroupIDs
    }
    
    */
    // username = txtUsername.text as NSString
    let GameName:NSString = NewGameTitle
    let Player1:NSString = NameInfo[0]
    
    // Player1Email = myemail
    var Player1Email = "-"
    var Player1ID = myID as NSString
    //  let te = "jaredstevens10@yahoo.com"
    //  var tc = "13214364915"
    var itemsCT = 0
    
    
    
     var Player2 = NSString()
     var Player3 = NSString()
     var Player4 = NSString()
     var Player5 = NSString()
     var Player6 = NSString()
     var Player7 = NSString()
     var Player8 = NSString()
     var Player9 = NSString()
     var Player10 = NSString()
    
    var Player2Email = NSString()
    var Player3Email = NSString()
    var Player4Email = NSString()
    var Player5Email = NSString()
    var Player6Email = NSString()
    var Player7Email = NSString()
    var Player8Email = NSString()
    var Player9Email = NSString()
    var Player10Email = NSString()
    
    var Player2ID = NSString()
    var Player3ID = NSString()
    var Player4ID = NSString()
    var Player5ID = NSString()
    var Player6ID = NSString()
    var Player7ID = NSString()
    var Player8ID = NSString()
    var Player9ID = NSString()
    var Player10ID = NSString()
    
    
    
    for items in NameInfo {
        if items == "NA" {
            NameInfo.remove(at: itemsCT);
            EmailInfo.remove(at: itemsCT);
            UNIDArray.remove(at: itemsCT);
            NumPlayers -= 1
            print("removing NA at index \(itemsCT)")
        }
        itemsCT += 1
    }
    
    
    if NumPlayers >= 2 {
        Player2 = NameInfo[1]
        Player2Email = EmailInfo[1]
        Player2ID = UNIDArray[1]
        //.dataUsingEncoding(NSUTF8StringEncoding)
        //Player2Email = Player2EmailOld?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        //Player2Cell = tc //CellInfo[1]
        
        // Player2Email = te
        
        
    } else {
        Player2 = "-"
        Player2Email = "-"
        Player2ID = "-"
        /*
         var Player2Email = Player2Emailstr.dataUsingEncoding(NSUTF8StringEncoding)
         Player2Email = Player2EmailOld?.base64EncodedStringWithOptions
         (NSDataBase64EncodingOptions(rawValue: 0))
         */
        // Player2Cell = "-"
    }
    
    
    if NumPlayers >= 3 {
        Player3 = NameInfo[2]
        Player3Email = EmailInfo[2]
        Player3ID = UNIDArray[2]
        // Player3Email = tc //CellInfo[2]
        
    } else {
        Player3 = "-"
        Player3Email = "-"
        Player3ID = "-"
        //  Player3Cell = "-"
    }
    
    
    if NumPlayers >= 4 {
        Player4 = NameInfo[3]
        Player4Email = EmailInfo[3]
        Player4ID = UNIDArray[3]
        // Player4Cell = tc //CellInfo[3]
        
        
    } else {
        Player4 = "-"
        Player4Email = "-"
        Player4ID = "-"
        // Player4Cell = "-"
    }
    
    if NumPlayers >= 5 {
        Player5 = NameInfo[4]
        Player5Email = EmailInfo[4]
        Player5ID = UNIDArray[4]
        //   Player5Cell = tc //CellInfo[4]
        
    } else {
        Player5 = "-"
        Player5Email = "-"
        Player5ID = "-"
        //  Player5Cell = "-"
    }
    
    if NumPlayers >= 6 {
        Player6 = NameInfo[5]
        Player6Email = EmailInfo[5]
        Player6ID = UNIDArray[5]
        // Player6Cell = tc //CellInfo[5]
    } else {
        Player6 = "-"
        Player6Email = "-"
        Player6ID = "-"
        //   Player6Cell = "-"
    }
    
    if NumPlayers >= 7 {
        Player7 = NameInfo[6]
        Player7Email = EmailInfo[6]
        Player7ID = UNIDArray[6]
        
        //    Player7Cell = tc //CellInfo[6]
        
    } else {
        Player7 = "-"
        Player7Email = "-"
        Player7ID = "-"
        //  Player7Cell = "-"
    }
    
    if NumPlayers >= 8 {
        Player8 = NameInfo[7]
        Player8Email = EmailInfo[7]
        Player8ID = UNIDArray[7]
        
        //  Player8Cell = tc //CellInfo[7]
    } else {
        Player8 = "-"
        Player8Email = "-"
        //  Player8Cell = "-"
    }
    
    if NumPlayers >= 9 {
        Player9 = NameInfo[8]
        Player9Email = EmailInfo[8]
        Player9ID = UNIDArray[8]
        //  Player9Cell = tc //CellInfo[8]
    } else {
        Player9 = "-"
        Player9Email = "-"
        Player9ID = "-"
        //   Player9Cell = "-"
    }
    
    if NumPlayers >= 10 {
        Player10 = NameInfo[9]
        Player10Email = EmailInfo[9]
        Player10ID = UNIDArray[9]
        //  Player10Cell = tc //CellInfo[9]
    } else {
        Player10 = "-"
        Player10Email = "-"
        Player10ID = "-"
        //  Player10Cell = "-"
    }
    
    print("Start game NewGameFirstTurn = \(NewGameFirstTurn)")
    
    /*
     if Player10 == "NA" {
     NumPlayers--
     }
     if Player9 == "NA" {
     NumPlayers--
     }
     if Player8 == "NA" {
     NumPlayers--
     }
     if Player7 == "NA" {
     NumPlayers--
     }
     if Player6 == "NA" {
     NumPlayers--
     }
     if Player5 == "NA" {
     NumPlayers--
     }
     if Player4 == "NA" {
     NumPlayers--
     }
     if Player3 == "NA" {
     NumPlayers--
     }
     if Player2 == "NA" {
     NumPlayers--
     }
     */
    print("updated number of players = \(NumPlayers.description)")
    
    
    switch NumPlayers {
    case 2:
        Player3 = Player1
        //  Player3Email = Player1Email
        Player4 = Player2
        //  Player4Email = Player2Email
        Player5 = Player1
        ////  Player5Email = Player1Email
        Player6 = Player2
        //   Player6Email = Player2Email
        Player7 = Player1
        //   Player7Email = Player1Email
        Player8 = Player2
        //   Player8Email = Player2Email
        Player9 = Player1
        //   Player9Email = Player1Email
        Player10 = Player2
        //   Player10Email = Player2Email
        
        Player3ID = Player1ID
        //  Player3Email = Player1Email
        Player4ID = Player2ID
        //  Player4Email = Player2Email
        Player5ID = Player1ID
        ////  Player5Email = Player1Email
        Player6ID = Player2ID
        //   Player6Email = Player2Email
        Player7ID = Player1ID
        //   Player7Email = Player1Email
        Player8ID = Player2ID
        //   Player8Email = Player2Email
        Player9ID = Player1ID
        //   Player9Email = Player1Email
        Player10ID = Player2ID
        
    case 3:
        Player4 = Player1
        //Player4Email = Player1Email
        Player5 = Player2
        //// Player5Email = Player2Email
        Player6 = Player3
        //  Player6Email = Player3Email
        Player7 = Player1
        //  Player7Email = Player1Email
        Player8 = Player2
        //Player8Email = Player2Email
        Player9 = Player3
        //Player9Email = Player3Email
        Player10 = Player1
        // Player10Email = Player1Email
        
        Player4ID = Player1ID
        //Player4Email = Player1Email
        Player5ID = Player2ID
        //// Player5Email = Player2Email
        Player6ID = Player3ID
        //  Player6Email = Player3Email
        Player7ID = Player1ID
        //  Player7Email = Player1Email
        Player8ID = Player2ID
        //Player8Email = Player2Email
        Player9ID = Player3ID
        //Player9Email = Player3Email
        Player10ID = Player1ID
        
    case 4:
        Player5 = Player1
        ////  Player5Email = Player1Email
        Player6 = Player2
        //  Player6Email = Player2Email
        Player7 = Player3
        //  Player7Email = Player3Email
        Player8 = Player4
        //   Player8Email = Player4Email
        Player9 = Player1
        //   Player9Email = Player1Email
        Player10 = Player2
        //   Player10Email = Player2Email
        
        Player5ID = Player1ID
        ////  Player5Email = Player1Email
        Player6ID = Player2ID
        //  Player6Email = Player2Email
        Player7ID = Player3ID
        //  Player7Email = Player3Email
        Player8ID = Player4ID
        //   Player8Email = Player4Email
        Player9ID = Player1ID
        //   Player9Email = Player1Email
        Player10ID = Player2ID
        
    case 5:
        
        Player6 = Player1
        //   Player6Email = Player1Email
        Player7 = Player2
        //   Player7Email = Player2Email
        Player8 = Player3
        //   Player8Email = Player3Email
        Player9 = Player4
        //   Player9Email = Player4Email
        Player10 = Player5
        //   Player10Email = Player5Email
        
        Player6ID = Player1ID
        //   Player6Email = Player1Email
        Player7ID = Player2ID
        //   Player7Email = Player2Email
        Player8ID = Player3ID
        //   Player8Email = Player3Email
        Player9ID = Player4ID
        //   Player9Email = Player4Email
        Player10ID = Player5ID
        
        
    case 6:
        Player7 = Player1
        //   Player7Email = Player1Email
        Player8 = Player2
        //   Player8Email = Player2Email
        Player9 = Player3
        //   Player9Email = Player3Email
        Player10 = Player4
        //   Player10Email = Player4Email
        
        Player7ID = Player1ID
        //   Player7Email = Player1Email
        Player8ID = Player2ID
        //   Player8Email = Player2Email
        Player9ID = Player3ID
        //   Player9Email = Player3Email
        Player10ID = Player4ID
    case 7:
        Player8 = Player1
        //   Player8Email = Player1Email
        Player9 = Player2
        //   Player9Email = Player2Email
        Player10 = Player3
        
        Player8ID = Player1ID
        //   Player8Email = Player1Email
        Player9ID = Player2ID
        //   Player9Email = Player2Email
        Player10ID = Player3ID
        
    //  Player10Email = Player3Email
    case 8:
        Player9 = Player1
        //  Player9Email = Player1Email
        Player10 = Player2
        //  Player10Email = Player2Email
        
        Player9ID = Player1ID
        //  Player9Email = Player1Email
        Player10ID = Player2ID
        
    case 9:
        Player10 = Player1
        Player10ID = Player1
    //  Player10Email = Player1Email
    case 10:
        break
    default:
        break
        
    }
    
    let Player1ID2 = Player1ID.replacingOccurrences(of: ":", with: "")
    
    let Player2ID2 = Player2ID.replacingOccurrences(of: ":", with: "")
    
    let Player3ID2 = Player3ID.replacingOccurrences(of: ":", with: "")
    let Player4ID2 = Player4ID.replacingOccurrences(of: ":", with: "")
    
    let Player5ID2 = Player5ID.replacingOccurrences(of: ":", with: "")
    
    let Player6ID2 = Player6ID.replacingOccurrences(of: ":", with: "")
    
    let Player7ID2 = Player7ID.replacingOccurrences(of: ":", with: "")
    
    let Player8ID2 = Player8ID.replacingOccurrences(of: ":", with: "")
    
    let Player9ID2 = Player9ID.replacingOccurrences(of: ":", with: "")
    
    let Player10ID2 = Player10ID.replacingOccurrences(of: ":", with: "")
    
    // UIGraphicsBeginImageContext(PicPreview.bounds.size)
    /*        NewGameImage.image?.drawInRect(CGRect(x: 0, y: 0,
     width: NewGameImage.frame.size.width, height: NewGameImage.frame.size.height))
     
     
     */
    
    // mainImageView.image = NewGameImage
    
    /*
     
     UIGraphicsBeginImageContext(mainImageView.bounds.size)
     
     mainImageView.image?.drawInRect(CGRect(x: 0, y: 0,
     width: mainImageView.frame.size.width, height: mainImageView.frame.size.height))
     
     image = UIGraphicsGetImageFromCurrentImageContext()
     UIGraphicsEndImageContext()
     
     
     
     
     let smallImage = mainImageView.image!.resize(0.5)
     
     
     let imageData = UIImageJPEGRepresentation(smallImage, 0.6)
     
     NewGamePictureData = imageData.base64EncodedStringWithOptions(.allZeros)
     
     */
    
    /*
     if ( GameName.isEqualToString("") || QuoteBoxtext.isEqualToString("") ) {
     
     var alertView:UIAlertView = UIAlertView()
     alertView.title = "You Forgot!"
     alertView.message = "Please enter a Game Name and the first Quote"
     alertView.delegate = self
     alertView.addButtonWithTitle("OK")
     alertView.show()
     } else {
     */
    
    if NewGameFirstTurn == "quote" {
        
        if MediaType == "audio" {
            DoUploadImage = true
            print("audio type game")
            
            post_old = "Player1ID=\(Player1ID2)&Player2ID=\(Player2ID2)&Player3ID=\(Player3ID2)&Player4ID=\(Player4ID2)&Player5ID=\(Player5ID2)&Player6ID=\(Player6ID2)&Player7ID=\(Player7ID2)&Player8ID=\(Player8ID2)&Player9ID=\(Player9ID2)&Player10ID=\(Player10ID2)&GameName=\(GameName)&Player1=\(Player1)&Player2=\(Player2)&Player3=\(Player3)&Player4=\(Player4)&Player5=\(Player5)&Player6=\(Player6)&Player7=\(Player7)&Player8=\(Player8)&Player9=\(Player9)&Player10=\(Player10)&players=\(NumPlayers)&Player1Email=\(Player1Email)&Player2Email=\(Player2Email)&Player3Email=\(Player3Email)&Player4Email=\(Player4Email)&Player5Email=\(Player5Email)&Player6Email=\(Player6Email)&Player7Email=\(Player7Email)&Player8Email=\(Player8Email)&Player9Email=\(Player9Email)&Player10Email=\(Player10Email)&timelimit=\(NewGameTurnTime)&gamestyle=\(NewGameFirstTurn)&gameSetting=private&content=\(NewGameContentRating)" as NSString
            
            print("POST OLD DATA = \(post_old)")
            
            
            
            post = post_old.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
            
            
            
            
            
            //UNCOMMENT TO INSERT AUDIO FILE RAW DATA
            //post = ("\(post)&Turn1=\(audioData)&mediatype=audio")
            post = ("\(post)&Turn1=TBD&mediatype=audio" as NSString)
            
            
            
            
        } else {
            var QuoteBoxtext = NewGameQuote
            // DoUploadImage = false
            
            
            /*
             var ThisTitle = "image"
             
             
             
             //CREATE JSON WITH ENCODED MEDIA
             let DataJSON: [String : AnyObject] = ["Data": ["type":"quote","turninfo": QuoteBoxtext, "title": ThisTitle, "artist": username]]
             
             //CONVERT NEW JSON TO NSDATA
             let JSON_NSData = jsonToNSData(DataJSON)
             
             //ENCODE JSON NSDATA
             
             let QuoteBoxtextNew = NSString(data: JSON_NSData!, encoding: NSUTF8StringEncoding)!
             
             */
            
            post_old = "Player1ID=\(Player1ID2)&Player2ID=\(Player2ID2)&Player3ID=\(Player3ID2)&Player4ID=\(Player4ID2)&Player5ID=\(Player5ID2)&Player6ID=\(Player6ID2)&Player7ID=\(Player7ID2)&Player8ID=\(Player8ID2)&Player9ID=\(Player9ID2)&Player10ID=\(Player10ID2)&GameName=\(GameName)&Player1=\(Player1)&Player2=\(Player2)&Player3=\(Player3)&Player4=\(Player4)&Player5=\(Player5)&Player6=\(Player6)&Player7=\(Player7)&Player8=\(Player8)&Player9=\(Player9)&Player10=\(Player10)&players=\(NumPlayers)&Player1Email=\(Player1Email)&Player2Email=\(Player2Email)&Player3Email=\(Player3Email)&Player4Email=\(Player4Email)&Player5Email=\(Player5Email)&Player6Email=\(Player6Email)&Player7Email=\(Player7Email)&Player8Email=\(Player8Email)&Player9Email=\(Player9Email)&Player10Email=\(Player10Email)&timelimit=\(NewGameTurnTime)&gamestyle=\(NewGameFirstTurn)&Turn1=\(QuoteBoxtext)&mediatype=quote&gameSetting=private&content=\(NewGameContentRating)" as NSString
            
            //  println("POST OLD DATA = \(post_old)")
            
            
            
            post = post_old.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
            
        }
        
        
        
        print("Quote is posted")
    } else {
        
        
        
        if MediaType == "gif" {
            
            print("is gif file")
            DoUploadImage = true
            
            
            post_old = "Player1ID=\(Player1ID2)&Player2ID=\(Player2ID2)&Player3ID=\(Player3ID2)&Player4ID=\(Player4ID2)&Player5ID=\(Player5ID2)&Player6ID=\(Player6ID2)&Player7ID=\(Player7ID2)&Player8ID=\(Player8ID2)&Player9ID=\(Player9ID2)&Player10ID=\(Player10ID2)&GameName=\(GameName)&Player1=\(Player1)&Player2=\(Player2)&Player3=\(Player3)&Player4=\(Player4)&Player5=\(Player5)&Player6=\(Player6)&Player7=\(Player7)&Player8=\(Player8)&Player9=\(Player9)&Player10=\(Player10)&players=\(NumPlayers)&Player1Email=\(Player1Email)&Player2Email=\(Player2Email)&Player3Email=\(Player3Email)&Player4Email=\(Player4Email)&Player5Email=\(Player5Email)&Player6Email=\(Player6Email)&Player7Email=\(Player7Email)&Player8Email=\(Player8Email)&Player9Email=\(Player9Email)&Player10Email=\(Player10Email)&timelimit=\(NewGameTurnTime)&gamestyle=\(NewGameFirstTurn)&gameSetting=private&content=\(NewGameContentRating)" as NSString
            
            print("POST OLD DATA = \(post_old)")
            
            
            
            post = post_old.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
            
            
            
            
            //UNCOMMENT TO INSERT IMAGE RAW DATA
            //post = ("\(post)&Turn1=\(picData)&mediatype=image")
            
            post = ("\(post)&Turn1=TBD&mediatype=gif" as NSString)
            
            
        } else {
            
            
            print("pictureData is posted")
            DoUploadImage = true
            
            /////
            /*
             
             post_old = "GameName=\(GameName)&Player1=\(Player1)&Player2=\(Player2)&Player3=\(Player3)&Player4=\(Player4)&Player5=\(Player5)&Player6=\(Player6)&Player7=\(Player7)&Player8=\(Player8)&Player9=\(Player9)&Player10=\(Player10)&players=\(NumPlayers)&Player1Email=\(Player1Email)&Player2Email=\(Player2Email)&Player3Email=\(Player3Email)&Player4Email=\(Player4Email)&Player5Email=\(Player5Email)&Player6Email=\(Player6Email)&Player7Email=\(Player7Email)&Player8Email=\(Player8Email)&Player9Email=\(Player9Email)&Player10Email=\(Player10Email)&timelimit=\(NewGameTurnTime)&gamestyle=\(NewGameFirstTurn)&Turn1=\(picData)"
             
             //  println("POST OLD DATA = \(post_old)")
             
             
             
             post = post_old.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
             /////
             */
            
            post_old = "Player1ID=\(Player1ID2)&Player2ID=\(Player2ID2)&Player3ID=\(Player3ID2)&Player4ID=\(Player4ID2)&Player5ID=\(Player5ID2)&Player6ID=\(Player6ID2)&Player7ID=\(Player7ID2)&Player8ID=\(Player8ID2)&Player9ID=\(Player9ID2)&Player10ID=\(Player10ID2)&GameName=\(GameName)&Player1=\(Player1)&Player2=\(Player2)&Player3=\(Player3)&Player4=\(Player4)&Player5=\(Player5)&Player6=\(Player6)&Player7=\(Player7)&Player8=\(Player8)&Player9=\(Player9)&Player10=\(Player10)&players=\(NumPlayers)&Player1Email=\(Player1Email)&Player2Email=\(Player2Email)&Player3Email=\(Player3Email)&Player4Email=\(Player4Email)&Player5Email=\(Player5Email)&Player6Email=\(Player6Email)&Player7Email=\(Player7Email)&Player8Email=\(Player8Email)&Player9Email=\(Player9Email)&Player10Email=\(Player10Email)&timelimit=\(NewGameTurnTime)&gamestyle=\(NewGameFirstTurn)&gameSetting=private&content=\(NewGameContentRating)" as NSString
            
            print("POST OLD DATA = \(post_old)")
            
            
            
            post = post_old.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
            
            
            
            
            //UNCOMMENT TO INSERT IMAGE RAW DATA
            //post = ("\(post)&Turn1=\(picData)&mediatype=image")
            
            post = ("\(post)&Turn1=TBD&mediatype=image" as NSString)
            
        }
        
    }
    
    // progressHUD.removeFromSuperview()
    //  progressHUD = ProgressHUD(text: "Saving Game Data...")
    //  self.view.addSubview(progressHUD)
    
    
    print("NEW POST STRING 1: \(post)")
    
    
    /*
     &Player1Cell=\(Player1Cell)&Player2Cell=\(Player2Cell)&Player3Cell=\(Player3Cell)&Player4Cell=\(Player4Cell)&Player5Cell=\(Player5Cell)&Player6Cell=\(Player6Cell)&Player7Cell=\(Player7Cell)&Player8Cell=\(Player8Cell)&Player9Cell=\(Player9Cell)&Player10Cell=\(Player10Cell)
     */
    //NSLog("PostData: %@",post);
    
    let url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/NewGame.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    // var postData:NSData = post.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
    
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
        
        print("Response Initial: \(res)")
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
            
            //NSLog("Response ==> %@", responseData);
            
            print("Response Handle Turn: \(responseData)")
            
            //var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            success = jsonData.value(forKey: "success") as! NSInteger
            let NewGameID:NSInteger = jsonData.value(forKey: "gameid") as! NSInteger
            
            
            GameID = NewGameID.description as NSString
            print("THE NEW GAME ID = \(NewGameID)")
            //[jsonData[@"success"] integerValue];
            
            //NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                //NSLog("New Game SUCCESS");
                //self.dismissViewControllerAnimated(true, completion: nil)
                
                /*
                
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Success!"
                alertView.message = "Your Game has been created.  Each player is getting a message now about the new game now."
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                
                */
                // alertView.show()
                
                if DoUploadImage {
                    
                    if MediaType == "audio" {
                        
                        print("SHOULD UPLOAD AUDIO NOW")
                        
                        UploadGameFileData(audioData as String, FileName: "Game\(NewGameID)Turn1", Type: "audio")
                    } else if MediaType == "gif" {
                        print("UPLOADING GIF FILE for NEW GAME")
                        UploadGameFileData(picData as String, FileName: "Game\(NewGameID)Turn1", Type: "gif")
                        
                        
                    }else {
                        
                        print("SHOULD UPLOAD IMAGE NOW")
                        UploadGameFileData(picData as String, FileName: "Game\(NewGameID)Turn1", Type: "image")
                    }
                } else {
                    
                    TempImageCurrent = CreateTempImage(NewGameQuote as String)
                    
                    UploadGameFile(TempImageCurrent, FileName: "Game\(NewGameID)Turn1", Type: "image")
                    
                    
                    
                    let imageData = UIImageJPEGRepresentation(TempImageCurrent, 1.0)
                    
                    //DONT DELETE BELOW
                    var base64Image = String()
                    
                
                    base64Image = imageData!.base64EncodedString(options: [])
                
                    
                    prefs.setValue(base64Image, forKey: "PICTUREDATAD_QUOTE")
                    
                    
                    
                    
                }
                //  self.performSegueWithIdentifier("Turn_Complete", sender: self)
                
                //NEED TO ADD NSNotification to go back to Home
                
                
            } else {
                /*
                var error_msg:NSString
                
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign Up Failed!"
                alertView.message = error_msg as String
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                //  alertView.show()
                */
            }
            
        } else {
            /*
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Connection Failed"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            //   alertView.show()
            */
        }
    }  else {
        
        print("URL DATA is Nil April 2017")
        /*
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Sign in Failed!"
        alertView.message = "Connection Failure"
        if let error = reponseError {
            alertView.message = (error.localizedDescription)
        }
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        */
        //  alertView.show()
    }
    // }
    
    
    
    
    
    
    /*
    DispatchQueue.main.async(execute: {
        self.NewGameProgressHUD.removeFromSuperview()
        
        DispatchQueue.main.async(execute: {
            self.performSegue(withIdentifier: "Turn_Complete", sender: self)
        })
    })
    
    */
    
    
    
    
    
    
    
    //
    
    // NSNotificationCenter.defaultCenter().postNotificationName("NewGameStarted", object: nil)
    
    /*
     dispatch_async(dispatch_get_main_queue(),{
     
     var numPoints = Int()
     var LevelUpTime = Bool()
     (numPoints, LevelUpTime) = UPData(self.username, userid: self.userID, type: "add", points: "0", levelpoints: "1")
     //numPoints = FilterUPData(UPurldata)
     print("number of points = \(numPoints)")
     
     // let AC = JSController("Pixie Points!", MyMessage: "You earn Points to level up your Pixie by Liking Turns.  You just earned one!",Color: "Green")
     
     
     let alertController = UIAlertController(title: "Pixie Points!", message: "You earn Points to level up your Pixie by starting a new game.  You just earned one!", preferredStyle: .Alert)
     
     let OkAction = UIAlertAction(title: "Ok", style: .Default) { (action:UIAlertAction) in
     print("Ok button pressed")
     
     
     if LevelUpTime {
     var PointsNew = NSInteger()
     var LevelNew = NSInteger()
     
     (PointsNew, LevelNew) = UserLevelUp(self.username, userid: self.myID, type: "add", level: "1")
     
     let AC = JSController("Level \(LevelNew.description) - Level Up!", MyMessage: "You just got a Level up on your Pixie! Congrats",Color: "Green")
     self.presentViewController(AC, animated: true, completion:
     {
     NSNotificationCenter.defaultCenter().postNotificationName("updatePixie", object: nil)
     }
     
     )
     
     //  self.LevelPlayer?.play()
     
     
     }
     
     
     }
     
     
     
     alertController.addAction(OkAction);
     
     self.presentViewController(alertController, animated: true, completion: nil)
     
     })
     */
    
    //}
    print("Turn Complete Segue")
  //  return NewGameID.stringValue
    return GameID
    
}




func SubmitImage (pointsUsed: Bool, username: NSString, userID: NSString, imageData: String, MediaType: NSString, gifNSData: Data, GameID: NSString, TurnNumber: NSString, IsCompleteInfo: NSString, turnStyle: NSString, NewTurn: NSString ) -> (NSString, Bool, Bool, NSInteger) {
    
    
    print("SUBMITTED IMAGE WITH THESE STATS")
    print("MediaType: \(MediaType)")
    //print("gifNSData: \(gifNSData)")
    
    let prefs = UserDefaults.standard
    
    var DeviceTKN = NSString()
    var turnInfo = NSString()
    var CurTurnNumber = NSString()
    var DoUploadImage = Bool()
    
    var GameComplete = Bool()
    var ImageSaved = Bool()
    var success = NSInteger()
    
    //let TurnNumberFinal = "Turn\(TurnNumber)"
    //var DeviceTKN = NSString()
    
    // ActInd.hidden = false
    //  ActInd.startAnimating()
    //let progressHUD = ProgressHUD(text: "Saving Game Data")
    
    // self.view.addSubview(progressHUD)
    
    prefs.set(false, forKey: "SHOWQUOTEVIEW")
    
    //boolForKey("SHOWQUOTEVIEW")
    
    
    var GameType = NSString()
    
    //  var sent = Bool()
    
    // ActInd.startAnimating()
    
    
    
    print("merging image layer 2 with main image")
    
    print("point used = \(pointsUsed)")
    
    
    
    
    if pointsUsed {
        print("points are being used")
        // var numPoints = 0;
        let TakePoints = UPData(username, userid: userID, type: "delete", points: "10", levelpoints: "0")
        //numPoints = FilterUPData(UPurldata)
        print("number of points after use = \(TakePoints)")
    }
    
   
    
    
    /*
     UIGraphicsBeginImageContext(mainImageView.frame.size)
     
     
     mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: mainImageView.frame.size.width, height: mainImageView.frame.size.height), blendMode: kCGBlendModeNormal, alpha: 1.0)
     
     tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: tempImageView.frame.size.width, height: tempImageView.frame.size.height), blendMode: kCGBlendModeNormal, alpha: opacity)
     
     mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
     UIGraphicsEndImageContext()
     
     tempImageView.image = nil
     println("tempImage / layer two = nil")
     
     
     //
     
     let smallImage = mainImageView.image!.resize(0.5)
     
     */
    
    
    
    
    
    //GETS IMAGE SIZE AND MERGES IMAGES BELOW
    /*
    
    UIGraphicsBeginImageContext(mainImageView.bounds.size)
    
    
    mainImageView.image?.draw(in: CGRect(x: 0, y: 0,
                                         width: mainImageView.frame.size.width, height: mainImageView.frame.size.height))
    
    tempImageView.image?.draw(in: CGRect(x: 0, y: 0,
                                         width: tempImageView.frame.size.width, height: tempImageView.frame.size.height))
    
    
    image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    */
    
    //UNCOMMENT BELOW TO CHANGE PICTURE SIZE
    //    let smallImage = image.resize(0.5)
    
    //   let imageData = UIImageJPEGRepresentation(smallImage, 0.6)
    //let imageData = UIImageJPEGRepresentation(image, 1.0)
   // let imageData2 = Data(base64Encoded: imageData as String, options: NSData.Base64DecodingOptions(rawValue: 0))
    
    //DONT DELETE BELOW
    var base64Image = String()
    
    if MediaType == "gif" {
        
        base64Image = gifNSData.base64EncodedString(options: [])
       // base64Image = imageData
       // base64Image = prefs.value(forKey: "PICTUREDATAD") as! String
        
       // let imageData2 = Data(base64Encoded: base64Image as String, options: NSData.Base64DecodingOptions(rawValue: 0))
        
        print("***BASE 64 GIF Data*** \(base64Image)")
        
    } else {
        
        base64Image = prefs.value(forKey: "PICTUREDATAD") as! String
       // base64Image = imageData
       // prefs.set(googleImageData, forKey: "PICTUREDATAD")
       // base64Image = imageData!.base64EncodedString(options: [])
        
    }
    
    
    let base64ImageName = "Game\(GameID)\(TurnNumber)"
    
    
    
    
    // uploadImageOne()
    let turnStyle = "picture"
    var post = NSString()
    
    if MediaType == "gif" {
        
        post = "GameID=\(GameID)&ImageData=\(base64ImageName)&TurnNumber=\(TurnNumber)&IsComplete=\(IsCompleteInfo)&NewTurn=\(NewTurn)&turnstyle=\(turnStyle)&username=\(username)&userID=\(userID)&mediatype=gif" as NSString
        
    } else {
        
        
        post = "GameID=\(GameID)&ImageData=\(base64ImageName)&TurnNumber=\(TurnNumber)&IsComplete=\(IsCompleteInfo)&NewTurn=\(NewTurn)&turnstyle=\(turnStyle)&username=\(username)&userID=\(userID)&mediatype=image" as NSString
    }
    //NSLog("PostData: %@",post);
    
    let url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/UpdateGame.php")!
    
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
        
        //   //NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
            
            //NSLog("Response ==> %@", responseData);
            
            // var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            success = jsonData.value(forKey: "success") as! NSInteger
            
            turnInfo = jsonData.value(forKey: "turn") as! NSString
            
            DeviceTKN = jsonData.value(forKey: "token") as! NSString
            
            CurTurnNumber = jsonData.value(forKey: "turnInfo") as! NSString
            
            GameType = jsonData.value(forKey: "gametype") as! NSString
            
            
            //var tokenNew = DeviceTKN.stringByReplacingOccurrencesOfString("'", withString: "")
            
            print("JSON TurnInfo - \(turnInfo)")
            
            
            // SendTurnNotice(TurnInfo, DeviceTKN, GameID, CurTurnNumber, AlertType)
            
            
            //[jsonData[@"success"] integerValue];
            
            //NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                //NSLog("Sign Up SUCCESS");
                
                DoUploadImage = true
                
                print("MEDIA UPLOAD TYPE: \(MediaType)")
                
                if DoUploadImage {
                    
                    if GameID != "demo" {
                        if MediaType == "gif" {
                            
                            base64Image = prefs.value(forKey: "PICTUREDATAD_GIF") as! String
                            
                            print("UPLOADING THIS GIF DATA = \(base64Image)")
                            
                            UploadGameFileData(base64Image as String, FileName: "Game\(GameID)\(TurnNumber)", Type: "gif")
                            
                        } else {
                            
                            
                            
                           // print("SHOULD UPLOAD IMAGE NOW")
                           // print("BASE 64 DATA IS = \(base64Image)")
                            UploadGameFileData(base64Image as String, FileName: "Game\(GameID)\(TurnNumber)", Type: "image")
                        }
                    }
                    // UploadGameFile(imageData, FileName: "TestTurn1")
                }
                
                
                
                let AlertType = "yourTurn"
                
                
                if GameID != "demo" {
                    
                    let GameData = MyTurnsCount(username, userID: userID)
                    
                    
                    if turnInfo == "NA" && DeviceTKN == "NA" && CurTurnNumber == "NA" && GameType == "NA" {
                        
                        print("Game Complete Notice Sent")
                        
                        GameComplete = true
                        
                        /*
                        
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Game Complete!"
                        alertView.message = "You have completed this game.  All Players have been sent a notice that the game is complete."
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        
                        */
                        
                        
                        /*
                         let AC = JSController("Game Complete!", "You have completed this game.  All Players have been sent a notice that the game is complete.","Green")
                         self.presentViewController(AC, animated: true, completion: nil)
                         */
                        
                        
                        //alertView.show()
                        
                        
                        
                        
                        //THIS IS WHERE THE STORY BOARD WOULD SEGUE, ONCE THE GAME WAS SAVED
                        
                        /*
                        let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc: UIViewController = sb.instantiateViewController(withIdentifier: "start") as UIViewController
                        
                        let window = UIApplication.shared.windows[0] as UIWindow;
                        
                        /* UIView.transition.FromView(window.rootViewController.view, toView: vc.view, duration: 0.65, options .TransitionCrossDissolve, completion: { finished in window.rootViewController = vc })
                         */
                        
                        self.SaveProgressHUD3.removeFromSuperview()
                        
                        
                        //  self.dismissViewControllerAnimated(true, completion: {
                        
                        
                        
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "DismissVC"), object: nil, userInfo: nil);
                        //   dispatch_async(dispatch_get_main_queue(), {
                        
                        self.dismiss(animated: true, completion: nil)
                        
                        
                        */
                        
                        
                        //GAME SAVE SEGUE IS ABOVE
                        
                        
                        
                        
                        
                        //  })
                        
                        
                        
                        
                        /*
                         UIView.transitionFromView((window.rootViewController?.view)!, toView: vc.view, duration: 0.65, options: .TransitionCrossDissolve, completion: {
                         
                         
                         
                         
                         finished in window.rootViewController = vc
                         
                         
                         
                         //   SendTurnNotice(self.TurnInfo, token: self.DeviceTKN, gameid: self.GameID, turninfo: self.CurTurnNumber, alertType: AlertType, gameType: GameType, turninfoID: "test")
                         
                         })
                         */
                        
                        
                        
                        
                        
                    } else {
                        
                        
                        ImageSaved = true
                        print("about to send turn notice")
                        
                        /*
                         SendTurnNotice(TurnInfo, token: DeviceTKN, gameid: GameID, turninfo: CurTurnNumber, alertType: AlertType, gameType: GameType, turninfoID: "test")
                         */
                        /*
                         let AC = JSController("Success!", "Your Image has been saved.  Each player is getting a message now about the new game now.","Green")
                         self.presentViewController(AC, animated: true, completion: nil)
                         */
                        
                        /*
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Success!"
                        alertView.message = "Your Image has been saved.  Each player is getting a message now about the new game now."
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        
                        */
                        
                        // alertView.show()
                        
                        
                        /*
                        
                        let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc: UIViewController = sb.instantiateViewController(withIdentifier: "start") as UIViewController
                        let window = UIApplication.shared.windows[0] as UIWindow;
                        
                        /* UIView.transition.FromView(window.rootViewController.view, toView: vc.view, duration: 0.65, options .TransitionCrossDissolve, completion: { finished in window.rootViewController = vc })
                         */
                        
                        self.SaveProgressHUD3.removeFromSuperview()
                        
                        
                        
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "DismissVC"), object: nil, userInfo: nil);
                        //   dispatch_async(dispatch_get_main_queue(), {
                        
                        self.dismiss(animated: true, completion: nil)
                        
                        
                        */
                        
                        /*
                         
                         NSNotificationCenter.defaultCenter().postNotificationName("DismissVC", object: nil, userInfo: nil);
                         
                         self.dismissViewControllerAnimated(true, completion: {
                         
                         
                         
                         
                         //   UIView.transitionFromView((window.rootViewController?.view)!, toView: vc.view, duration: 0.65, options: .TransitionCrossDissolve, completion: {
                         
                         
                         
                         
                         finished in window.rootViewController = vc
                         
                         
                         
                         SendTurnNotice(self.TurnInfo, token: self.DeviceTKN, gameid: self.GameID, turninfo: self.CurTurnNumber, alertType: AlertType, gameType: GameType, turninfoID: "test", myID: self.userID)
                         
                         //   NSNotificationCenter.defaultCenter().postNotificationName("DismissVC", object: nil, userInfo: nil);
                         //   dispatch_async(dispatch_get_main_queue(), {
                         //   self.dismissViewControllerAnimated(true, completion: nil)
                         
                         })
                         
                         */
                        
                        //  })
                        
                        
                    }
                } else {
                    
                    //ImageSaved = false
                    
                  //  SaveVideoToDirectory(imageData2!, name: "/DemoImageTurn.jpg")
                    
                    
                   // self.dismiss(animated: true, completion: nil)
                    
                }
                
                
            } else {
             ImageSaved = false
                
            }
            
        } else {
            
            
        }
    }  else {
        
        
    }
    
    
    
    
    print("Turn Complete Segue")
    
    return (turnInfo, GameComplete, ImageSaved, success)
    
}



func uploadImageOne(image: UIImage){
    let imageData = UIImagePNGRepresentation(image)
    
    if imageData != nil{
        let request = NSMutableURLRequest(url: URL(string:"\(ServerInfo.sharedInstance)/Apps/TelePictionary/UpdateGame.php")!)
        var session = URLSession.shared
        
        request.httpMethod = "POST"
        
        let boundary = NSString(format: "---------------------------14737809831466499882746641449")
        let contentType = NSString(format: "multipart/form-data; boundary=%@",boundary)
        //  println("Content Type \(contentType)")
        request.addValue(contentType as String, forHTTPHeaderField: "Content-Type")
        
        let body = NSMutableData()
        
        
        // Title
        body.append(NSString(format: "\r\n--%@\r\n",boundary).data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format:"Content-Disposition: form-data; name=\"title\"\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
        body.append("Hello World".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
        
        // Image
        body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format:"Content-Disposition: form-data; name=\"profile_img\"; filename=\"img.jpg\"\\r\n").data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format: "Content-Type: application/octet-stream\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
        body.append(imageData!)
        body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
        
        print("Body: \(body)")
        
        request.httpBody = body as Data
        
        
        let returnData = try? NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: nil)
        
        let returnString = NSString(data: returnData!, encoding: String.Encoding.utf8.rawValue)
        
        print("returnString \(returnString)")
        
    }
    
    
}
func SubmitQuote(_ Quote: NSString, turnStyle: NSString, TheType: NSString, GameID_Orig: NSString, TurnNumber: NSString, username: NSString, userID: NSString, IsCompleteInfo: NSString, NewTurn: NSString) -> (NSString, Bool, Bool, NSInteger) {
    
   // let TurnNumberFinal = "Turn\(TurnNumber)"
    
    // ActInd
    // ActInd.hidden = false
    //  ActInd.startAnimating();
    var DoUploadImage = Bool()
    var GameType = NSString()
    
    let prefs = UserDefaults.standard
    
    var DeviceTKN = NSString()
    var turnInfo = NSString()
    var CurTurnNumber = NSString()
    
    
    var GameComplete = Bool()
    var ImageSaved = Bool()
    var success = NSInteger()
    
    var TempImageCurrent = UIImage()
    //var DeviceTKN = NSString()
    
    // ActInd.hidden = false
    //  ActInd.startAnimating()
    //let progressHUD = ProgressHUD(text: "Saving Game Data")
    
    // self.view.addSubview(progressHUD)
    
    prefs.set(false, forKey: "SHOWQUOTEVIEW")
    
    //   let progressHUD = ProgressHUD(text: "Saving Game Data")
    //   self.view.addSubview(progressHUD)
    
    var post = NSString()
    
    if TheType == "audio" {
        
        
        DoUploadImage = true
        
        
        if DoUploadImage {
            
            if GameID_Orig != "demo" {
                
                print("SHOULD UPLOAD IMAGE NOW")
                print("BASE 64 DATA IS = \(Quote)")
                UploadGameFileData(Quote as String, FileName: "Game\(GameID_Orig)\(TurnNumber)", Type: "audio")
                
            }
            // UploadGameFile(imageData, FileName: "TestTurn1")
        } else {
            
            TempImageCurrent = CreateTempImage(Quote as String)
            
            DispatchQueue.main.async(execute: {
                
                UploadGameFile(TempImageCurrent, FileName: "Game\(GameID_Orig)\(TurnNumber)", Type: "image")
                
                
                
                let imageData = UIImageJPEGRepresentation(TempImageCurrent, 1.0)
                
                //DONT DELETE BELOW
                var base64Image = String()
                
                
                base64Image = imageData!.base64EncodedString(options: [])
                
                
                prefs.setValue(base64Image, forKey: "PICTUREDATAD_QUOTE")
                
                
                
            })
            
            
        }
        
        
        let post_old:NSString = "GameID=\(GameID_Orig)&TurnNumber=\(TurnNumber)&IsComplete=\(IsCompleteInfo)&NewTurn=\(NewTurn)&turnstyle=\(turnStyle)&username=\(username)&mediatype=\(TheType)&userID=\(userID)" as NSString
        
        post = post_old.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        
        
        //UNCOMMENT TO INSERT AUDIO RAW DATA
        // post = "\(post)&ImageData=\(Quote)"
        post = "\(post)&ImageData=Game\(GameID_Orig)\(TurnNumber)" as NSString
        
        print("AUDIO POST = \(post)")
        
        
    } else {
        
        
        
        
        TempImageCurrent = CreateTempImage(Quote as String)
        
        //dispatch_async(dispatch_get_main_queue(), {
        
        
        
        
        
        
        
        //UPLOAD IMAGE QUOTE
       // UploadGameFile(TempImageCurrent, FileName: "Game\(GameID_Orig)\(TurnNumber)", Type: "image")
        
        //})
        
        //CONVERTS QUOTE IMAGE INTO RAW DATA
        let imageData = UIImageJPEGRepresentation(TempImageCurrent, 1.0)
        var base64Image = String()
        base64Image = imageData!.base64EncodedString(options: [])
        prefs.setValue(base64Image, forKey: "PICTUREDATAD_QUOTE")
        
        
        
        
        print("SHOULD UPLOAD IMAGE NOW")
        print("BASE 64 DATA IS = \(base64Image)")
        UploadGameFileData(base64Image as String, FileName: "Game\(GameID_Orig)\(TurnNumber)", Type: "image")
        
        
        let post_old:NSString = "GameID=\(GameID_Orig)&TurnNumber=\(TurnNumber)&IsComplete=\(IsCompleteInfo)&NewTurn=\(NewTurn)&turnstyle=\(turnStyle)&username=\(username)&mediatype=\(TheType)&ImageData=\(Quote)&userID=\(userID)" as NSString
        
        post = post_old.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        
        print("QUOTE POST = \(post)")
        // post = "\(post)&ImageData=\(Quote)"
        
    }
    
    
    //NSLog("PostData: %@",post);
    
    let url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/UpdateGame.php")!
    
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
    } catch {
        fatalError()
    }
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
        // //NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
            
            //NSLog("Response ==> %@", responseData);
            
            //    var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            success = jsonData.value(forKey: "success") as! NSInteger
            
            
            turnInfo = jsonData.value(forKey: "turn") as! NSString
            
            DeviceTKN = jsonData.value(forKey: "token") as! NSString
            
            // var tokenNew = DeviceTKN.stringByReplacingOccurrencesOfString("'", withString: "")
            CurTurnNumber = jsonData.value(forKey: "turnInfo") as! NSString
            
            GameType = jsonData.value(forKey: "gametype") as! NSString
            
            print("JSON TurnInfo - \(turnInfo)")
            
            
            
            //   SendTurnNotice(TurnInfo, DeviceTKN, GameID_Orig, CurTurnNumber, AlertType)
            
            
            //[jsonData[@"success"] integerValue];
            
            //NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                //NSLog("Sign Up SUCCESS");
                
                
                
                /*
                 let alertView:UIAlertView = UIAlertView()
                 alertView.title = "Success!"
                 alertView.message = "Your \(self.QorA) has been saved."
                 alertView.delegate = self
                 alertView.addButton(withTitle: "OK")
                 // alertView.show()
                 */
                
                
                if GameID_Orig != "demo" {
                    
                    let GameData = MyTurnsCount(username, userID: userID)
                    
                    
                    if turnInfo == "NA" && DeviceTKN == "NA" && CurTurnNumber == "NA" && GameType == "NA" {
                        print("Game Complete Notice Sent")
                        
                        GameComplete = true
                        
                        /*
                         let alertView:UIAlertView = UIAlertView()
                         alertView.title = "Game Complete!"
                         alertView.message = "You have completed this game.  All Players have been sent a notice that the game is complete."
                         alertView.delegate = self
                         alertView.addButton(withTitle: "OK")
                         //alertView.show()
                         
                         
                         
                         let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                         let vc: UIViewController = sb.instantiateViewController(withIdentifier: "start") as UIViewController
                         
                         let window = UIApplication.shared.windows[0] as UIWindow;
                         
                         /* UIView.transition.FromView(window.rootViewController.view, toView: vc.view, duration: 0.65, options .TransitionCrossDissolve, completion: { finished in window.rootViewController = vc })
                         */
                         
                         self.SaveProgressHUD.removeFromSuperview()
                         self.progressView.isHidden = true
                         self.QuoteBoxtxt.text = ""
                         
                         //  self.dismissViewControllerAnimated(true, completion: {
                         
                         
                         NotificationCenter.default.post(name: Notification.Name(rawValue: "DismissVC"), object: nil, userInfo: nil);
                         //   dispatch_async(dispatch_get_main_queue(), {
                         
                         self.dismiss(animated: true, completion: nil)
                         
                         */
                        
                        
                        //ABOVE IS WHERE IT SEGUES AFTER SUBMITTING QUOTE
                        
                        
                        
                        /*
                         UIView.transitionFromView((window.rootViewController?.view)!, toView: vc.view, duration: 0.65, options: .TransitionCrossDissolve, completion: {
                         
                         
                         
                         
                         finished in window.rootViewController = vc
                         
                         //  SendTurnNotice(self.TurnInfo, token: self.DeviceTKN, gameid: self.GameID_Orig, turninfo: self.CurTurnNumber, alertType: self.AlertType, gameType: GameType, turninfoID: "test")
                         
                         })
                         
                         */
                        
                        
                        
                        
                    } else {
                        
                        GameComplete = false
                        /*
                         SendTurnNotice(self.TurnInfo, token: self.DeviceTKN, gameid: self.GameID_Orig, turninfo: self.CurTurnNumber, alertType: self.AlertType, gameType: GameType, turninfoID: "test")
                         */
                        
                        
                        /*
                         let alertView:UIAlertView = UIAlertView()
                         alertView.title = "Success!"
                         alertView.message = "Your \(self.QorA) has been saved."
                         alertView.delegate = self
                         alertView.addButton(withTitle: "OK")
                         
                         alertView.tintColor = UIColor.green
                         
                         //alertView.show()
                         
                         
                         
                         
                         
                         
                         let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                         let vc: UIViewController = sb.instantiateViewController(withIdentifier: "start") as UIViewController
                         
                         let window = UIApplication.shared.windows[0] as UIWindow;
                         
                         /* UIView.transition.FromView(window.rootViewController.view, toView: vc.view, duration: 0.65, options .TransitionCrossDissolve, completion: { finished in window.rootViewController = vc })
                         */
                         
                         self.SaveProgressHUD.removeFromSuperview()
                         self.progressView.isHidden = true
                         self.QuoteBoxtxt.text = ""
                         
                         NotificationCenter.default.post(name: Notification.Name(rawValue: "DismissVC"), object: nil, userInfo: nil);
                         
                         */
                        
                        
                        
                        /*
                         self.dismiss(animated: true, completion: {
                         
                         //   UIView.transitionFromView((window.rootViewController?.view)!, toView: vc.view, duration: 0.65, options: .TransitionCrossDissolve, completion: {
                         
                         
                         
                         
                         //   finished in window.rootViewController = vc
                         
                         
                         
                         
                         SendTurnNotice(self.TurnInfo, token: self.DeviceTKN, gameid: self.GameID_Orig, turninfo: self.CurTurnNumber, alertType: self.AlertType as NSString, gameType: GameType, turninfoID: "test", myID: self.userID)
                         
                         })
                         
                         
                         */
                        
                        /*
                         let AC = JSController("Success!", "Your Quote has been saved.","Green")
                         self.presentViewController(AC, animated: true, completion: nil)
                         */
                        
                        
                    }
                    
                } else {
                    
                    
                    //self.dismiss(animated: true, completion: nil)
                }
                /*
                 let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                 let vc: UIViewController = sb.instantiateViewControllerWithIdentifier("start") as UIViewController
                 
                 let window = UIApplication.sharedApplication().windows[0] as UIWindow;
                 
                 /* UIView.transition.FromView(window.rootViewController.view, toView: vc.view, duration: 0.65, options .TransitionCrossDissolve, completion: { finished in window.rootViewController = vc })
                 */
                 
                 self.SaveProgressHUD.removeFromSuperview()
                 self.progressView.hidden = true
                 self.QuoteBoxtxt.text = ""
                 
                 //  self.dismissViewControllerAnimated(true, completion: {
                 
                 UIView.transitionFromView((window.rootViewController?.view)!, toView: vc.view, duration: 0.65, options: .TransitionCrossDissolve, completion: {
                 
                 
                 
                 
                 finished in window.rootViewController = vc
                 
                 SendTurnNotice(self.TurnInfo, token: self.DeviceTKN, gameid: self.GameID_Orig, turninfo: self.CurTurnNumber, alertType: self.AlertType, gameType: GameType, turninfoID: "test")
                 
                 })
                 
                 */
                
                
            } else {
                
                /*
                 var error_msg:NSString
                 
                 if jsonData["error_message"] as? NSString != nil {
                 error_msg = jsonData["error_message"] as! NSString
                 } else {
                 error_msg = "Unknown Error"
                 }
                 let alertView:UIAlertView = UIAlertView()
                 alertView.title = "Error!"
                 alertView.message = error_msg as String
                 alertView.delegate = self
                 alertView.addButton(withTitle: "OK")
                 alertView.show()
                 
                 */
                
            }
            
        } else {
            /*
             let alertView:UIAlertView = UIAlertView()
             alertView.title = "Error!"
             alertView.message = "Connection Failed"
             alertView.delegate = self
             alertView.addButton(withTitle: "OK")
             alertView.show()
             */
        }
    }  else {
        /*
         let alertView:UIAlertView = UIAlertView()
         alertView.title = "Error!"
         alertView.message = "Connection Failure"
         if let error = reponseError {
         alertView.message = (error.localizedDescription)
         }
         alertView.delegate = self
         alertView.addButton(withTitle: "OK")
         alertView.show()
         */
    }
    
    //    dispatch_async(dispatch_get_main_queue()) {
    // self.performSegueWithIdentifier("Turn_Complete", sender: self)
    
    
    //self.performSegueWithIdentifier("Turn_Complete", sender: self)
    /*
     let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
     let vc: UIViewController = sb.instantiateViewControllerWithIdentifier("start") as UIViewController
     
     let window = UIApplication.sharedApplication().windows[0] as UIWindow;
     
     /* UIView.transition.FromView(window.rootViewController.view, toView: vc.view, duration: 0.65, options .TransitionCrossDissolve, completion: { finished in window.rootViewController = vc })
     */
     
     self.SaveProgressHUD.removeFromSuperview()
     self.progressView.hidden = true
     self.QuoteBoxtxt.text = ""
     
     //  self.dismissViewControllerAnimated(true, completion: {
     
     UIView.transitionFromView((window.rootViewController?.view)!, toView: vc.view, duration: 0.65, options: .TransitionCrossDissolve, completion: {finished in window.rootViewController = vc })
     //   })
     */
    //  }
    return (turnInfo, GameComplete, ImageSaved, success)
    
}
func DeleteTempMessage(_ GameID: NSString, CurrentTurn: NSString) -> Bool {
    // ActInd
    // ActInd.hidden = false
    //  ActInd.startAnimating();
    var GameUpdated = Bool()
    
    let prefs = UserDefaults.standard
    
    
    var success = NSInteger()
    
    
    // var post = NSString()
    
    
    let post:NSString = "id=\(GameID)&turninfo=\(CurrentTurn)" as NSString
    
    print("DELETING GAME NOW: Post Message = \(post)")
    
    //NSLog("PostData: %@",post);
    
    let url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/DeleteTempMessage.php")!
    
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
    } catch {
        fatalError()
    }
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
        // //NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
            
            //NSLog("Response ==> %@", responseData);
            
            //    var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            success = jsonData.value(forKey: "success") as! NSInteger
            print("Game Message Deleted Success = \(success)")
            
            
            if(success == 1)
            {
                //NSLog("Sign Up SUCCESS");
                
                GameUpdated = true
                
                
                
                
            } else {
                GameUpdated = false
                
                
            }
            
        } else {
            GameUpdated = false
            
            
        }
    }  else {
        
        GameUpdated = false
        
    }
    
    
    return GameUpdated
    
}

func DeleteTempMessageGame(_ GameID: NSString, CurrentTurn: NSString) -> Bool {
    // ActInd
    // ActInd.hidden = false
    //  ActInd.startAnimating();
    var GameUpdated = Bool()
    
    let prefs = UserDefaults.standard
    
 
    var success = NSInteger()
  
    
   // var post = NSString()
    
   
    let post:NSString = "id=\(GameID)&turninfo=\(CurrentTurn)" as NSString
        

    
    //NSLog("PostData: %@",post);
    
    let url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/DeleteTempMessageGame.php")!
    
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
    } catch {
        fatalError()
    }
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
        // //NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
            
            //NSLog("Response ==> %@", responseData);
            
            //    var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            success = jsonData.value(forKey: "success") as! NSInteger
            
    
            
            if(success == 1)
            {
                //NSLog("Sign Up SUCCESS");
                
                GameUpdated = true
                
               
                
                
            } else {
                GameUpdated = false
              
                
            }
            
        } else {
            GameUpdated = false
            
         
        }
    }  else {
        
        GameUpdated = false
      
    }
    
  
   return GameUpdated
    
}

func LoadImage (GameID_Orig: NSString, GameTurn: NSString) -> (NSString, UIImage, NSString) {
    
   // print("Selected YT Audio = \(SelectedYTAudio)")
   // print("YT Complete = \(YTComplete)")
    // ShowPickerBTN.enabled = false
    var Image64Data2 = NSString()
    var MediaType = NSString()
    var UseImageURL = NSString()
    var TheImageURL = NSString()
    
    var data = Data()
    var image = UIImage()
    
    
    print("Loading Quote: GameID = \(GameID_Orig)")
    print("Loading Quote: GameTurn = \(GameTurn)")
    
   // ImageLoading.startAnimating();
    
    (Image64Data2, MediaType, UseImageURL, TheImageURL) = GetGameData(GameID_Orig, turn: GameTurn)
    
    // print("Image64Data2 = \(Image64Data2)")
    
    if UseImageURL == "no" {
        
        let Image64NSData = Data(base64Encoded: Image64Data2 as String, options: NSData.Base64DecodingOptions(rawValue: 0))
        
        
        //  print("Image64NSData = \(Image64NSData!)")
        
        let Image64Data = NSString(data: Image64NSData!, encoding: String.Encoding.utf8.rawValue)!
        
        print("IMAGE 64 DATA =           \(Image64Data)")
        
        
        let decodedData = Data(base64Encoded: Image64Data as String, options: NSData.Base64DecodingOptions(rawValue: 0))
        
        
        print("DECODED DATA =         \(decodedData)")
        print("Setting Image")
        
        image = UIImage(data: decodedData!)!
        
        
        /*
        ImagePic.image = image
        
        ImagePic.contentMode = UIViewContentMode.scaleAspectFit
        
        ImagePic.layer.cornerRadius = 0
        
        ImageLoading.stopAnimating()
        */
        
        
    } else {
        
        var TheImageURL2 = NSString()
        
        
        
        if MediaType == "gif" {
            
            print("Get GIF from URL")
            
            TheImageURL2 = "\(TheImageURL).gif" as NSString
            let url = URL(string: TheImageURL2 as String)
            data = try! Data(contentsOf: url!)
            
            //ImagePic.image = UIImage.animatedImage(withAnimatedGIFData: data)
            
        } else {
            
            TheImageURL2 = "\(TheImageURL).jpg" as NSString
            
            
            
            print("Get image from URL: \(TheImageURL2)")
            let url = URL(string: TheImageURL2 as String)
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
            image = UIImage(data: data!)!
           // ImagePic.image = UIImage(data: data!)
           // ImagePic.contentMode = UIViewContentMode.scaleAspectFit
            
        }
        
    }
    
    //ImagePic.layer.cornerRadius = 0
    /*
    DispatchQueue.main.async(execute: {
        
        self.ImageLoading.stopAnimating()
        
    })
    
    */
    return (MediaType, image,TheImageURL)
    //ADD Function to get URL
}



func LoadQuote (GameID: NSString, GameTurn: NSString) -> (NSString, NSString) {
    
    var Quote64Data2 = NSString()
    var MediaType = NSString()
    var UseImageURL = NSString()
    var TheImageURL = NSString()
    
    var Quote64NSData = Data()
    
    var QuoteData = NSString()
    
    print("Loading Quote: GameID = \(GameID)")
    print("Loading Quote: GameTurn = \(GameTurn)")
    
    (Quote64Data2, MediaType, UseImageURL, TheImageURL) = GetGameData(GameID, turn: GameTurn)
    
    // print("The Image Data = \(Image64Data2)")
    // print("the Media Type = \(MediaType)")
    
    //print("encoded Quote String = \(Image64Data2)")
    
   // print("base 64 encoded file = \(Image64Data2)")
    
    Quote64NSData = Data(base64Encoded: Quote64Data2 as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
    
    
    print("media type = \(MediaType)")
    
    if MediaType != "audio" {
        
        //WAS IMAGE64DATA BELOW
        QuoteData = NSString(data: Quote64NSData, encoding: String.Encoding.utf8.rawValue)!
        
    } else {
        
        
        /*
        deleteAllRecordings()
        
        if UseImageURL == "no" {
            
            //  print("Sound NSData = \(Image64NSData)")
            let Image64Data2 = NSString(data: Image64NSData, encoding: String.Encoding.utf8.rawValue)!
            // print("Sound Data2 = \(Image64Data2)")
            Image64Data_Audio = Data(base64Encoded: Image64Data2 as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
            
        } else {
            
            let FileURL = "\(TheImageURL).mp3"
            let url = URL(string: FileURL as String)
            Image64Data_Audio = try! Data(contentsOf: url!)
        }
        
        
        //    print("SoundNSData 2 = \(Image64Data)")
        
        let format = DateFormatter()
        format.dateFormat="yyyy-MM-dd-HH-mm-ss"
        let currentFileName = "audio-\(format.string(from: Date())).m4a"
        
        let currentFileNameTemp = "AudioClip.m4a"
        //   print("Current File Name = \(currentFileNameTemp)")
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        soundFileURLTemp = documentsDirectory.appendingPathComponent(currentFileNameTemp)
        
        if FileManager.default.fileExists(atPath: soundFileURLTemp.absoluteString) {
            // probably won't happen. want to do something about it?
            // print("soundfile \(soundFileURLTemp.absoluteString) exists")
        }
        
        
        
       */
        
        //  print("soundFile URL = \(soundFileURLTemp)")
        
    }
    
     return (MediaType, QuoteData)
    
}

func CreateTempImage (_ TempQuote: String) -> UIImage {
    // let font = UIFont(name: "ChalkboardSE-Regular", size: 11.0)
    
    let QBoxImage = UIImage(named: "QuoteBoxImage.png")
    
    print("Creating image with quote = \(TempQuote)")
    var TempImage = UIImage()
    
    
    let font = UIFont(name: "DK Cool Crayon", size: 30.0)
    
    let fontTitle = UIFont(name: "Chalkduster", size: 30.0)
    
    
    let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
    textStyle.alignment = NSTextAlignment.center
    
    let textColor = UIColor.black
    
    let shadow = NSShadow()
    shadow.shadowColor = UIColor.white
    shadow.shadowOffset = CGSize(width: 0,height: 1)
    // let textColorShadow = UIColor.whiteColor()
    
    var textFontAttributes: [String : AnyObject]?
    
    
    if let actualFont = font {
        textFontAttributes = [NSFontAttributeName: actualFont, NSForegroundColorAttributeName: textColor, NSParagraphStyleAttributeName: textStyle]
        
    }
    
    let ih = QBoxImage!.size.height
    let iw = QBoxImage!.size.width
    
    let newSize = CGSize(width: iw, height: ih)
    
    
    UIGraphicsBeginImageContext(newSize)
    
    
    
    let Rect2 = CGRect(x: 0,y: 0,width: iw,height: ih)
    
    
    let picRect = CGRect(x: 25,y: 85,width: iw,height: ih)
    
    QBoxImage!.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
    
    
    let qRect1 = CGRect(x: 10,y: 130,width: iw-20,height: ih)
    
    //  let PreviousQTemp = "\(PreviousQuote) -\(CurrentPlayer)"
    
    TempQuote.draw(in: qRect1, withAttributes: textFontAttributes)
    TempImage = UIGraphicsGetImageFromCurrentImageContext()!
    
    return TempImage
    
}

func CreateTempImageForLayout (QBoxImage: UIImage, TurnNumber: String, TempQuote: String) -> UIImage {
    // let font = UIFont(name: "ChalkboardSE-Regular", size: 11.0)
    //let TempQuote = "Tap here to view quote"
    
   // var TempImage = UIImage()
    var NumImage = UIImage()
    
    switch TurnNumber {
      case "1":
        NumImage = UIImage(named: "num1")!
    case "2":
        NumImage = UIImage(named: "num2")!
    case "3":
        NumImage = UIImage(named: "num3")!
    case "4":
        NumImage = UIImage(named: "num4")!
    case "5":
        NumImage = UIImage(named: "num5")!
    case "6":
        NumImage = UIImage(named: "num6")!
    case "7":
        NumImage = UIImage(named: "num7")!
    case "8":
        NumImage = UIImage(named: "num8")!
    case "9":
        NumImage = UIImage(named: "num9")!
    case "10":
        NumImage = UIImage(named: "num10")!
        
    default:
        break
    }
    
    //let QBoxImage = UIImage(named: "QuoteBoxImage.png")
    
    //print("Creating image with quote = \(TempQuote)")
    var TempImage = UIImage()
    
    
    
    let font = UIFont(name: "DK Cool Crayon", size: 30.0)
    
    let fontTitle = UIFont(name: "Chalkduster", size: 30.0)
    
    
    let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
    textStyle.alignment = NSTextAlignment.center
    
    let textColor = UIColor.black
    
    let shadow = NSShadow()
    shadow.shadowColor = UIColor.white
    shadow.shadowOffset = CGSize(width: 0,height: 1)
    // let textColorShadow = UIColor.whiteColor()
    
    var textFontAttributes: [String : AnyObject]?
    
    
    if let actualFont = font {
        textFontAttributes = [NSFontAttributeName: actualFont, NSForegroundColorAttributeName: textColor, NSParagraphStyleAttributeName: textStyle]
        
    }
 
    
    let ih = QBoxImage.size.height
    let iw = QBoxImage.size.width
    
    let newSize = CGSize(width: iw, height: ih)
    
    
    let PicRecX = iw - 70
    let PicRecY = ih - 50
    
    UIGraphicsBeginImageContext(newSize)
    
    
    
    let Rect2 = CGRect(x: 0,y: 0,width: iw,height: ih)
    
    
    let picRect = CGRect(x: PicRecX,y: PicRecY,width: 40,height: 40)
    
    QBoxImage.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
    NumImage.draw(in: picRect, blendMode:CGBlendMode.normal, alpha: 1.0)
    
    let qRect1 = CGRect(x: 10,y: 130,width: iw-20,height: ih)
    
    //  let PreviousQTemp = "\(PreviousQuote) -\(CurrentPlayer)"
    
    TempQuote.draw(in: qRect1, withAttributes: textFontAttributes)
    TempImage = UIGraphicsGetImageFromCurrentImageContext()!
    
    return TempImage
    
}


func CreateTempImageGameComplete (_ TempQuote: String) -> UIImage {
    // let font = UIFont(name: "ChalkboardSE-Regular", size: 11.0)
    
    let QBoxImage = UIImage(named: "CSBackgroundTileNew4.png")
    
    print("Creating image with quote = \(TempQuote)")
    var TempImage = UIImage()
    
    
    let font = UIFont(name: "DK Cool Crayon", size: 30.0)
    
    let fontTitle = UIFont(name: "Chalkduster", size: 30.0)
    
    
    let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
    textStyle.alignment = NSTextAlignment.center
    
    let textColor = UIColor.white
    
    let shadow = NSShadow()
    shadow.shadowColor = UIColor.white
    shadow.shadowOffset = CGSize(width: 0,height: 1)
    // let textColorShadow = UIColor.whiteColor()
    
    var textFontAttributes: [String : AnyObject]?
    
    
    if let actualFont = font {
        textFontAttributes = [NSFontAttributeName: actualFont, NSForegroundColorAttributeName: textColor, NSParagraphStyleAttributeName: textStyle]
        
    }
    
   // let ih = QBoxImage!.size.height
   // let iw = QBoxImage!.size.width
    
    let ih = 400
    let iw = 400
    
    let newSize = CGSize(width: iw, height: ih)
    
    
    UIGraphicsBeginImageContext(newSize)
    
    
    
    let Rect2 = CGRect(x: 0,y: 0,width: iw,height: ih)
    
    
    let picRect = CGRect(x: 25,y: 85,width: iw,height: ih)
    
    QBoxImage!.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
    
    
    let qRect1 = CGRect(x: 10,y: 130,width: iw-20,height: ih)
    
    //  let PreviousQTemp = "\(PreviousQuote) -\(CurrentPlayer)"
    
    TempQuote.draw(in: qRect1, withAttributes: textFontAttributes)
    TempImage = UIGraphicsGetImageFromCurrentImageContext()!
    
    return TempImage
    
}


func CreateTempImageTapToView (_ TempQuote: String, QBoxImage: UIImage) -> UIImage {
    // let font = UIFont(name: "ChalkboardSE-Regular", size: 11.0)
    
   // let QBoxImage = UIImage(named: "CSBackgroundTileNew4.png")
    
    print("Creating image with quote = \(TempQuote)")
    var TempImage = UIImage()
    
    
    let font = UIFont(name: "DK Cool Crayon", size: 30.0)
    
    let fontTitle = UIFont(name: "Chalkduster", size: 30.0)
    
    
    let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
    textStyle.alignment = NSTextAlignment.center
    
    let textColor = UIColor.white
    
    let shadow = NSShadow()
    shadow.shadowColor = UIColor.white
    shadow.shadowOffset = CGSize(width: 0,height: 1)
    // let textColorShadow = UIColor.whiteColor()
    
    var textFontAttributes: [String : AnyObject]?
    
    
    if let actualFont = font {
        textFontAttributes = [NSFontAttributeName: actualFont, NSForegroundColorAttributeName: textColor, NSParagraphStyleAttributeName: textStyle]
        
    }
    
     let ih = QBoxImage.size.height
     let iw = QBoxImage.size.width
    
   // let ih = 400
   // let iw = 400
    
    let newSize = CGSize(width: iw, height: ih)
    
    
    UIGraphicsBeginImageContext(newSize)
    
    
    
    let Rect2 = CGRect(x: 0,y: 0,width: iw,height: ih)
    
    
    let picRect = CGRect(x: 25,y: 85,width: iw,height: ih)
    
    QBoxImage.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
    
    
    let qRect1 = CGRect(x: 10,y: 130,width: iw-20,height: ih)
    
    //  let PreviousQTemp = "\(PreviousQuote) -\(CurrentPlayer)"
    
    TempQuote.draw(in: qRect1, withAttributes: textFontAttributes)
    TempImage = UIGraphicsGetImageFromCurrentImageContext()!
    
    return TempImage
    
}



func snapShotImage(theView: UIImageView) -> UIImage {
    UIGraphicsBeginImageContext(theView.frame.size)
    if let context = UIGraphicsGetCurrentContext() {
        theView.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    return UIImage()
}

func bluredImage(image: UIImage, radius:CGFloat = 1) -> UIImage {
    // let image = view.snapShotImage()
    
    print("bluredImage Radius = \(radius)")
    
    //let image = snapShotImage(theView: view)
    
    if let source = image.cgImage {
        let context = CIContext(options: nil)
        let inputImage = CIImage(cgImage: source)
        
        let clampFilter = CIFilter(name: "CIAffineClamp")
        clampFilter?.setDefaults()
        clampFilter?.setValue(inputImage, forKey: kCIInputImageKey)
        
        if let clampedImage = clampFilter?.value(forKey: kCIOutputImageKey) as? CIImage {
            let explosureFilter = CIFilter(name: "CIExposureAdjust")
            explosureFilter?.setValue(clampedImage, forKey: kCIInputImageKey)
            explosureFilter?.setValue(-1.0, forKey: kCIInputEVKey)
            
            if let explosureImage = explosureFilter?.value(forKey: kCIOutputImageKey) as? CIImage {
                let filter = CIFilter(name: "CIGaussianBlur")
                filter?.setValue(explosureImage, forKey: kCIInputImageKey)
                filter?.setValue("\(radius)", forKey:kCIInputRadiusKey)
                
                if let result = filter?.value(forKey: kCIOutputImageKey) as? CIImage {
                   // let bounds = UIScreen.main.bounds
                    let bounds = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
                    let cgImage = context.createCGImage(result, from: bounds)
                    let returnImage = UIImage(cgImage: cgImage!)
                    return returnImage
                }
            }
        }
    }
    return UIImage()
}

func bluredImageView(view: UIImageView, radius:CGFloat = 1) -> UIImage {
   // let image = view.snapShotImage()
    
    let image = snapShotImage(theView: view)
    
    if let source = image.cgImage {
        let context = CIContext(options: nil)
        let inputImage = CIImage(cgImage: source)
        
        let clampFilter = CIFilter(name: "CIAffineClamp")
        clampFilter?.setDefaults()
        clampFilter?.setValue(inputImage, forKey: kCIInputImageKey)
        
        if let clampedImage = clampFilter?.value(forKey: kCIOutputImageKey) as? CIImage {
            let explosureFilter = CIFilter(name: "CIExposureAdjust")
            explosureFilter?.setValue(clampedImage, forKey: kCIInputImageKey)
            explosureFilter?.setValue(-1.0, forKey: kCIInputEVKey)
            
            if let explosureImage = explosureFilter?.value(forKey: kCIOutputImageKey) as? CIImage {
                let filter = CIFilter(name: "CIGaussianBlur")
                filter?.setValue(explosureImage, forKey: kCIInputImageKey)
                filter?.setValue("\(radius)", forKey:kCIInputRadiusKey)
                
                if let result = filter?.value(forKey: kCIOutputImageKey) as? CIImage {
                   // let bounds = UIScreen.main.bounds
                    let bounds = view.bounds
                    let cgImage = context.createCGImage(result, from: bounds)
                    let returnImage = UIImage(cgImage: cgImage!)
                    return returnImage
                }
            }
        }
    }
    return UIImage()
}
