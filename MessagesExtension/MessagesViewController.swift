//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Jared Stevens2 on 11/10/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import Messages
import AVFoundation

class MessagesViewController: MSMessagesAppViewController, UITextFieldDelegate {
    
    var AlreadyLoaded = Bool()
    
    var AppVersion = "1.0.9"
    
    
    @IBOutlet weak var userSubmitW: NSLayoutConstraint!
    @IBOutlet weak var userSubmitH: NSLayoutConstraint!
    
    
    @IBOutlet weak var usernameHolderViewW: NSLayoutConstraint!
     @IBOutlet weak var usernameHolderViewH: NSLayoutConstraint!
    
    
    @IBOutlet weak var usernameW: NSLayoutConstraint!
    @IBOutlet weak var usernameH: NSLayoutConstraint!
    
    @IBOutlet weak var usernameBOTTOM: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var PQLogoH: NSLayoutConstraint!
    
    @IBOutlet weak var PQLogoW: NSLayoutConstraint!
    
    @IBOutlet weak var pictureViewW: NSLayoutConstraint!
    @IBOutlet weak var pictureViewH: NSLayoutConstraint!
    @IBOutlet weak var quoteViewW: NSLayoutConstraint!
    @IBOutlet weak var quoteViewH: NSLayoutConstraint!
    
    @IBOutlet weak var imageTOP: NSLayoutConstraint!
    @IBOutlet weak var pictureTOP: NSLayoutConstraint!
    @IBOutlet weak var quoteTOP: NSLayoutConstraint!
    
    @IBOutlet weak var PQLogo: UIImageView!
    
  
    @IBOutlet weak var pictureLEAD: NSLayoutConstraint!
    @IBOutlet weak var quoteTRAIL: NSLayoutConstraint!
    
    let AppImageURL = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/"
    var ThisConversation = MSConversation()
    
    var HolderStatus = Bool()
    var SegueGameID = NSString()
    var SegueNewGame = Bool()
    var SegueMediaType = NSString()
    var SegueTurnNumber = NSString()
    
    var PREFIsNewGame = Bool()
    
    let prefs:UserDefaults = UserDefaults.standard
    
    var MyName = NSString()
    var MyID = NSString()
    
    var HasUserName = Bool()
    var ShowingUserNameView = Bool()
    
    @IBOutlet weak var quoteBTN: UIButton!
    
    @IBOutlet weak var pictureBTN: UIButton!
    
    @IBOutlet weak var pictureView: UIView!
    @IBOutlet weak var quoteView: UIView!
    
    @IBOutlet weak var aboutusBTN: UIButton!
    
    @IBOutlet weak var howtoBTN: UIButton!
    
    @IBOutlet weak var usernameBTN: UIButton!
    
    
    @IBOutlet weak var usernameLBL: UILabel!
    
    
    @IBOutlet weak var usernameHolderView: UIView!
    
    @IBOutlet weak var usernameSubmitBTN: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var usernameInfoLBL: UILabel!
    
    @IBOutlet weak var usernameHolderTOP: NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        
       
        
        self.PQLogo.isHidden = true
        self.pictureViewW.constant = 0
        self.pictureViewH.constant = 0
        self.quoteViewW.constant = 0
        self.quoteViewH.constant = 0
        self.PQLogoH.constant = 0
        self.PQLogoW.constant = 0
        /*
        let DeviceW = self.view.frame.width
        let DeviceH = self.view.frame.height
        let HalfDeviceW = DeviceW / 2
        let AppPresStyle = prefs.value(forKey:  "PresentationRawValue") as! String
        
        
        self.pictureViewW.constant = DeviceW / 4
        self.pictureViewH.constant = DeviceW / 4
        
        self.quoteViewW.constant = DeviceW / 4
        self.quoteViewH.constant = DeviceW / 4
        */
        
       // print("Width: \(DeviceW)")
       // print("Height: \(DeviceH)")
        
        
        super.viewDidLoad()
        
        SegueNewGame = true
        
        self.pictureView.layer.cornerRadius = 30
        self.pictureView.layer.masksToBounds = true
        self.pictureView.clipsToBounds = true
        
        self.quoteView.layer.cornerRadius = 30
        self.quoteView.layer.masksToBounds = true
        self.quoteView.clipsToBounds = true
        self.usernameSubmitBTN.layer.cornerRadius = 5
        self.usernameSubmitBTN.layer.masksToBounds = true
        
        self.usernameHolderView.layer.cornerRadius = 10
        self.usernameHolderView.clipsToBounds = true
        self.usernameHolderView.layer.masksToBounds = true
        
        
        
        
        
        
    NotificationCenter.default.addObserver(self, selector: #selector(MessagesViewController.SendMessage(_:)), name: NSNotification.Name(rawValue: "SendMessage"),  object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TurnQuoteViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // self.prefs.set(false, forKey: "HasUserName")
        
        
        
        self.HasUserName = prefs.bool(forKey: "HasUserName")
        
        print("HAS USERNAME = \(HasUserName)")
        
        prefs.set(AppVersion, forKey: "AppVersion")
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        requestPresentationStyle(.expanded)
        
        print("Did start editing textfield")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let DeviceW = self.view.frame.width
        let DeviceH = self.view.frame.height
        
     
        
        self.PQLogo.isHidden = false
        self.quoteBTN.isEnabled = false
        self.pictureBTN.isEnabled = false
        
        
        print("Viewdidappear")
        
        print("Already Loaded = \(AlreadyLoaded)")
       
        if !AlreadyLoaded {
        
        
        let HalfDeviceW = DeviceW / 2
           var AppPresStyle = String()
            
            if prefs.value(forKey:  "PresentationRawValue") == nil {
                
                AppPresStyle = "0"
                prefs.set("0", forKey: "PresentationRawValue")
                
            } else {
            
             AppPresStyle = prefs.value(forKey:  "PresentationRawValue") as! String
            
            }
            
        
        let ButtonInt: CGFloat = 8
        
        UIView.animate(withDuration: 3.0, animations: { () -> Void in
            
            self.PQLogo.center.y = self.PQLogo.center.y + 50
            
            self.imageTOP.constant = DeviceW / 20
            
            self.PQLogo.transform = CGAffineTransform(scaleX: 1.5, y: 1.5);
            
  
            self.PQLogoW.constant = DeviceW / 8
            let PQWidth = DeviceW / 8
            self.PQLogoH.constant = PQWidth * 0.8
            
            
            UIView.animate(withDuration: 1.5, animations: { () -> Void in
                
                self.pictureView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5);
                self.quoteView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5);
                
                self.pictureView.center.y = self.pictureView.center.y + 50
                
                self.quoteView.center.y = self.quoteView.center.y + 50
                
                self.pictureView.center.x = self.pictureView.center.x - 50
                
                self.quoteView.center.x = self.quoteView.center.x + 50
                
                self.pictureTOP.constant = DeviceW / 6
                self.quoteTOP.constant = DeviceW / 6
                
                self.pictureLEAD.constant = DeviceW / 6
                
                self.quoteTRAIL.constant = DeviceW / 6
                
                self.pictureViewW.constant = DeviceW / ButtonInt
                self.pictureViewH.constant = DeviceW / ButtonInt
                
                self.quoteViewW.constant = DeviceW / ButtonInt
                self.quoteViewH.constant = DeviceW / ButtonInt
                
                
              
                self.pictureView.layer.cornerRadius = (DeviceW / ButtonInt) / 2
                
                
                self.quoteView.layer.cornerRadius = (DeviceW / ButtonInt) / 2
                
                
                self.usernameH.constant = DeviceW / 12
                self.usernameW.constant = DeviceW / 12
                
            })
            
            
            
        })
        
        self.AlreadyLoaded = true
        
    }
    
        
        
        if self.prefs.value(forKey: "EXTUSERNAME") == nil {
            self.usernameLBL.text = ""
        } else {
            self.usernameLBL.text = self.prefs.value(forKey: "EXTUSERNAME") as! String
        }
        
        
        print("Should Show username form now")
        if !HasUserName {
            
            
            self.usernameHolderViewW.constant = DeviceW / 1.3
            
            let usernameViewWidth = (DeviceW / 1.3) / 2
            self.usernameHolderViewH.constant = usernameViewWidth
            
            self.userSubmitW.constant = DeviceW / 3.2
            self.userSubmitH.constant = (DeviceW / 3.2) / 3
            
           // self.usernameInfoLBL.adjustsFontSizeToFitWidth = true
            
            let FontSizeTemp = DeviceW / 20
            
            self.usernameInfoLBL.font.withSize(FontSizeTemp)
            
            self.usernameInfoLBL.font = UIFont(name: "DK Cool Crayon", size: FontSizeTemp)
            
            //self.usernameInfo
            if !ShowingUserNameView {
              
          requestPresentationStyle(.expanded)
            
                
                print("Requesting Expaneded Style to show username")
        self.usernameInfoLBL.text = "Just one thing before we get started...what's your name?"
        
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            
            self.usernameHolderView.center.y = self.usernameHolderView.center.y + 420
            self.usernameHolderTOP.constant = 20
            
        })
                
          ShowingUserNameView = true
            
        }
        
        } else {
            
            
            self.quoteBTN.isEnabled = true
            self.pictureBTN.isEnabled = true
        }
        
 
    
    
    
    }
    
    func SendMessage(_ notification:Notification) {
        
        var MyName = String()
        
        if self.prefs.value(forKey: "EXTUSERNAME") == nil {
            MyName = "Guest"
        } else {
            MyName = self.prefs.value(forKey: "EXTUSERNAME") as! String
        }
        
        
        
        let userInfo:Dictionary<String,String?> = (notification as NSNotification).userInfo as! Dictionary<String,String?>
        
        var jsonAlert = JSON(userInfo)
       // print("JSON ALERT \(jsonAlert)")
        //   println("JSON ALERT \(jsonAlert)")
        
        let NotificationMessage = jsonAlert["message"].stringValue
        

        let gameID = jsonAlert["gameID"].stringValue
        let turnType = jsonAlert["turnType"].stringValue
        let theQuote = jsonAlert["quote"].stringValue
        let imageData = jsonAlert["imageData"].stringValue
        let mediaType = jsonAlert["mediaType"].stringValue
        let CurrentTurnNumber = jsonAlert["currentTurnNumber"].stringValue
        let TurnNumber = jsonAlert["turnNumber"].stringValue
        let username = jsonAlert["username"].stringValue
        let userID = jsonAlert["userID"].stringValue
        let turnStyle = jsonAlert["turnStyle"].stringValue
        let IsCompleteInfo = jsonAlert["IsCompleteInfo"].stringValue
        let newTurn = jsonAlert["newTurn"].stringValue
        let NG_GameTitle = jsonAlert["NG_GameTitle"].stringValue
        let NG_PlayerTemp = jsonAlert["NG_PlayerTemp"].stringValue
        let NG_FirstTurn = jsonAlert["NG_FirstTurn"].stringValue
        let NG_TurnTime = jsonAlert["NG_TurnTime"].stringValue
        let NG_ContentRating = jsonAlert["NG_ContentRating"].stringValue
        let NameArrayDELETE = jsonAlert["NameArrayDELETE"].stringValue
        let EmailArrayDELETE = jsonAlert["EmailArrayDELETE"].stringValue
        let UNIDArrayDELETE = jsonAlert["UNIDArrayDELETE"].stringValue
        let newGame = jsonAlert["newGame"].stringValue
        
        print("***SENDING MESSAGE WITH THIS INFO***")
        print("GameID: \(gameID)")
        print("turnType: \(turnType)")
       // print("theQuote: \(theQuote)")
       // print("imageData: \(imageData)")
        print("mediaType: \(mediaType)")
        print("CurrentTurnNumber: \(CurrentTurnNumber)")
        print("TurnNumber: \(TurnNumber)")
        print("username: \(username)")
        print("userID: \(userID)")
        print("turnStyle: \(turnStyle)")
        print("IsCompleteInfo: \(IsCompleteInfo)")
        print("newTurn: \(newTurn)")
        print("NG_GameTitle: \(NG_GameTitle)")
        print("NG_PlayerTemp: \(NG_PlayerTemp)")
        print("NG_FirstTurn: \(NG_FirstTurn)")
        print("NG_TurnTime: \(NG_TurnTime)")
        print("NG_ContentRating: \(NG_ContentRating)")
        print("newGame: \(newGame)")
        
        
        
        let SendingUserUUID = UIDevice.current.identifierForVendor!.uuidString
        let NewGameTitle: NSString = "iMessageGame"
        let NewGameNumPlayers = 10
        
        var NameInfoTemp = [NSString]()
        NameInfoTemp.append(MyName as NSString)
        NameInfoTemp.append("Guest2")
        NameInfoTemp.append("Guest3")
        NameInfoTemp.append("Guest4")
        NameInfoTemp.append("Guest5")
        NameInfoTemp.append("Guest6")
        NameInfoTemp.append("Guest7")
        NameInfoTemp.append("Guest8")
        NameInfoTemp.append("Guest9")
        NameInfoTemp.append("Guest10")
        
        var EmailInfoTemp = [NSString]()
        EmailInfoTemp.append(MyName as NSString)
        EmailInfoTemp.append("Guest2")
        EmailInfoTemp.append("Guest3")
        EmailInfoTemp.append("Guest4")
        EmailInfoTemp.append("Guest5")
        EmailInfoTemp.append("Guest6")
        EmailInfoTemp.append("Guest7")
        EmailInfoTemp.append("Guest8")
        EmailInfoTemp.append("Guest9")
        EmailInfoTemp.append("Guest10")
        
        var UNIDArrayTemp = [NSString]()
        UNIDArrayTemp.append(MyID)
        UNIDArrayTemp.append("Guest2ID")
        UNIDArrayTemp.append("Guest3ID")
        UNIDArrayTemp.append("Guest4ID")
        UNIDArrayTemp.append("Guest5ID")
        UNIDArrayTemp.append("Guest6ID")
        UNIDArrayTemp.append("Guest7ID")
        UNIDArrayTemp.append("Guest8ID")
        UNIDArrayTemp.append("Guest9ID")
        UNIDArrayTemp.append("Guest10ID")
        
        let NewGameTurnTime = "00:00"
        let NewGameContentRating = "E"
        
        var ImageURL_Message = String()
        var NewTurnNumber = String()
        var GameCompleteTemp = String()
        
        var TurnInfoSubmit = NSString()
        var GameCompleteSubmit = Bool()
        var ImageSavedSubmit = Bool()
        var successSubmit = Int()
        var ImageToSubmit = UIImage()
       // var GifData = Data()
        
        let GifDataString = prefs.value(forKey: "PICTUREDATAD_GIF")
        
       //print("PASS GIF STRING \(GifDataString)")
        
        var GifData = NSData()
        
        if prefs.value(forKey: "PICTUREDATAD_GIF") != nil {
        
         GifData = NSData(base64Encoded: GifDataString as! String, options: NSData.Base64DecodingOptions(rawValue: 0))!
            
        }
        
       // let GifData = Data(base64Encoded: GifDataString as! String, options: NSData.Base64DecodingOptions(rawValue: 0))
        
       // print("*****GIF DATA***** \(GifData)")
        //ImageToSubmit = UIImage.animatedImage(withAnimatedGIFData: GifData)
        
        
        switch CurrentTurnNumber {
            
            
        case "1":
            NewTurnNumber = "2"
            GameCompleteTemp = "no"
        case "2":
            NewTurnNumber = "3"
            GameCompleteTemp = "no"
        case "3":
            NewTurnNumber = "4"
            GameCompleteTemp = "no"
        case "4":
            NewTurnNumber = "5"
            GameCompleteTemp = "no"
        case "5":
            NewTurnNumber = "6"
            GameCompleteTemp = "no"
        case "6":
            NewTurnNumber = "7"
            GameCompleteTemp = "no"
        case "7":
            NewTurnNumber = "8"
            GameCompleteTemp = "no"
        case "8":
            NewTurnNumber = "9"
            GameCompleteTemp = "no"
        case "9":
            NewTurnNumber = "10"
            GameCompleteTemp = "no"
        case "10":
            NewTurnNumber = "11"
            GameCompleteTemp = "yes"
            
        default:
            break
        }
        
       
        
        
        
        
        
        if newGame == "yes" {
            print("IS NEW GAME")
            
            prefs.set(true, forKey: "DELETEISNEWGAME")
            
            if NG_FirstTurn == "quote" {
                print("NEW GAME: QUOTE FIRST  / Media Type = \(mediaType)")
            
            
            var NewGameID = CreateNewGame(myID: SendingUserUUID as NSString, NewGameTitle: NewGameTitle, NameInfoTemp: NameInfoTemp, EmailInfoTemp: EmailInfoTemp, UNIDArrayTemp: UNIDArrayTemp, NumPlayerTemp: NewGameNumPlayers, NewGameFirstTurn: NG_FirstTurn as NSString, MediaType: mediaType as NSString, NewGameTurnTime: NewGameTurnTime as NSString, NewGameContentRating: NewGameContentRating as NSString, NewGameQuote: theQuote as NSString, imageData: imageData)
                
                
                
                
                    
                self.prefs.set(NewGameID, forKey: "TempGameID")
                self.prefs.set("1", forKey: "TempTurnNumber")
                
                 /*
                guard let conversation = activeConversation else { fatalError("Expected a conversation") }
                */
                
 var conversation = MSConversation()
                
 if activeConversation == nil {
 //fatalError("Expected a conversation")
 conversation = ThisConversation
 } else {
 conversation = activeConversation!
 }
 
 
                DispatchQueue.main.async(execute: {
 
                ImageURL_Message = "Game\(NewGameID)Turn1"
                    
                    print("COMPOSING THE MESSAGE, IN DISPATCH QUE NOW")
                
                let TurnInfoMessage = TurnInfo(currentUser: MyName, currentUserID: SendingUserUUID, lastUser: "NA", lastUserID: "NA_ID", TurnType: "quote", theQuote: theQuote, theImageData: imageData, gameID: NewGameID as String!, previousTurnNumber: "1", imageURL: ImageURL_Message, GameComplete: "no")
                
                let message = self.composeMessage(with: TurnInfoMessage, caption: NotificationMessage, session: conversation.selectedMessage?.session)
                
                    
                    DispatchQueue.main.async(execute: {
                // Add the message to the conversation.
                conversation.insert(message) { error in
                    
                    print("***ADDING THE QUOTE MESSAGE NOW***")
                    
                    if let error = error {
                        print(error)
                    }
                }
                    
                    self.dismiss()
                        
                    })
                    
                    
                    
            })
            
            
        } else {
                
                
            print("NEW GAME: IMAGE FIRST  / Media Type = \(mediaType)")
            var NewGameID = NSString()
                
                if mediaType == "gif" {
                    
                    let base64Image = prefs.value(forKey: "PICTUREDATAD_GIF") as! String
                   
                    
                    NewGameID = CreateNewGame(myID: SendingUserUUID as NSString, NewGameTitle: NewGameTitle, NameInfoTemp: NameInfoTemp, EmailInfoTemp: EmailInfoTemp, UNIDArrayTemp: UNIDArrayTemp, NumPlayerTemp: NewGameNumPlayers, NewGameFirstTurn: NG_FirstTurn as NSString, MediaType: mediaType as NSString, NewGameTurnTime: NewGameTurnTime as NSString, NewGameContentRating: NewGameContentRating as NSString, NewGameQuote: theQuote as NSString, imageData: base64Image)
                    
                } else {
            
               NewGameID = CreateNewGame(myID: SendingUserUUID as NSString, NewGameTitle: NewGameTitle, NameInfoTemp: NameInfoTemp, EmailInfoTemp: EmailInfoTemp, UNIDArrayTemp: UNIDArrayTemp, NumPlayerTemp: NewGameNumPlayers, NewGameFirstTurn: NG_FirstTurn as NSString, MediaType: mediaType as NSString, NewGameTurnTime: NewGameTurnTime as NSString, NewGameContentRating: NewGameContentRating as NSString, NewGameQuote: theQuote as NSString, imageData: imageData)
                
                }
                
            self.prefs.set(NewGameID, forKey: "TempGameID")
            self.prefs.set("1", forKey: "TempTurnNumber")
                /*
                 
                guard let controller = storyboard?.instantiateViewController(withIdentifier: IceCreamsViewController.storyboardIdentifier) as? IceCreamsViewController else { fatalError("Unable to instantiate an IceCreamsViewController from the storyboard") }
                
                guard let conversation = activeConversation else { fatalError("Expected a conversation") }
                guard var TurnInfo = controller.TurnInfo else { fatalError("Expected the controller to be displaying an ice cream") }
                
                */
                
               // guard let conversation = activeConversation else { fatalError("Expected a conversation") }
                
                 var conversation = MSConversation()
                
                 if activeConversation == nil {
                 //fatalError("Expected a conversation")
                 conversation = ThisConversation
                 } else {
                 conversation = activeConversation!
                 }
                
                
                DispatchQueue.main.async(execute: {
                    
                ImageURL_Message = "Game\(NewGameID)Turn1"
                
                let TurnInfoMessage = TurnInfo(currentUser: MyName, currentUserID: SendingUserUUID, lastUser: "NA", lastUserID: "NA_ID", TurnType: "image", theQuote: theQuote, theImageData: "na", gameID: NewGameID as String!, previousTurnNumber: "1", imageURL: ImageURL_Message, GameComplete: "no")
                
                let message = self.composeMessage(with: TurnInfoMessage, caption: NotificationMessage, session: conversation.selectedMessage?.session)
                
                    DispatchQueue.main.async(execute: {
                // Add the message to the conversation.
                conversation.insert(message) { error in
                    
                    print("***ADDING THE IMAGE MESSAGE NOW***")
                    
                    if let error = error {
                        print(error)
                    }
                }
                
                    self.dismiss()
                    })
                    
                })
                
        }
        
        } else {
            
            prefs.set(false, forKey: "DELETEISNEWGAME")
            
            if mediaType == "quote" {
                print("NOT NEW GAME - Quote Turn  / Media Type = \(mediaType)")
                
                self.prefs.set(gameID, forKey: "TempGameID")
                self.prefs.set(CurrentTurnNumber, forKey: "TempTurnNumber")
                
                ImageURL_Message = "Game\(gameID)Turn\(CurrentTurnNumber)"
                
                var conversation = MSConversation()
                //ThisConversation
                
                if activeConversation == nil {
                    //fatalError("Expected a conversation")
                    conversation = ThisConversation
                } else {
                    conversation = activeConversation!
                }
                
                
                
                (TurnInfoSubmit, GameCompleteSubmit, ImageSavedSubmit, successSubmit) = SubmitQuote(theQuote as NSString, turnStyle: "quote", TheType: "quote", GameID_Orig: gameID as NSString, TurnNumber: "Turn\(CurrentTurnNumber)" as NSString, username: MyName as NSString, userID: SendingUserUUID as NSString, IsCompleteInfo: GameCompleteTemp as NSString, NewTurn: NewTurnNumber as NSString)
                
                //SubmitQuote(pointsUsed: false, username: MyName as NSString, userID: SendingUserUUID as NSString, image: ImageToSubmit, MediaType: mediaType as NSString, gifNSData: GifData, GameID: gameID as NSString, TurnNumber: CurrentTurnNumber as NSString, IsCompleteInfo: GameCompleteTemp as NSString, turnStyle: turnStyle as NSString, NewTurn: NewTurnNumber as NSString)
                
                
                let TurnInfoMessage = TurnInfo(currentUser: MyName, currentUserID: SendingUserUUID, lastUser: "NA", lastUserID: "NA_ID", TurnType: "quote", theQuote: theQuote, theImageData: imageData, gameID: gameID, previousTurnNumber: CurrentTurnNumber, imageURL: ImageURL_Message, GameComplete: GameCompleteTemp)
                
                let message = composeMessage(with: TurnInfoMessage, caption: NotificationMessage, session: conversation.selectedMessage?.session)
                
                
                DispatchQueue.main.async(execute: {
                    // Add the message to the conversation.
                    conversation.insert(message) { error in
                        if let error = error {
                            print(error)
                        }
                    }
                    
                    /*
                     if TurnInfo.isComplete {
                     var history = IceCreamHistory.load()
                     history.append(iceCream)
                     history.save()
                     }
                     
                     */
                    
                    self.dismiss()
                    
                })
            } else {
                print("NOT NEW GAME - Image Turn / Media Type = \(mediaType)")
                
                
                 self.prefs.set(gameID, forKey: "TempGameID")
                 self.prefs.set(CurrentTurnNumber, forKey: "TempTurnNumber")
                
                /*
                guard let conversation = activeConversation else { fatalError("Expected a conversation") }
                
                */
                var conversation = MSConversation()
                
                if activeConversation == nil {
                    //fatalError("Expected a conversation")
                    conversation = ThisConversation
                } else {
                    conversation = activeConversation!
                }
                
               
                
                (TurnInfoSubmit, GameCompleteSubmit, ImageSavedSubmit, successSubmit) = SubmitImage(pointsUsed: false, username: MyName as NSString, userID: SendingUserUUID as NSString, imageData: imageData, MediaType: mediaType as NSString, gifNSData: GifData as Data, GameID: gameID as NSString, TurnNumber: "Turn\(CurrentTurnNumber)" as NSString, IsCompleteInfo: GameCompleteTemp as NSString, turnStyle: "picture", NewTurn: NewTurnNumber as NSString)
                
                
               // let conversation = activeConversation
                
                /*else {
                    fatalError("Expected a conversation")
                    //  print("ERROR WITH ACTIVE CONVERSATION")
                }
 */
                
                ImageURL_Message = "Game\(gameID)Turn\(CurrentTurnNumber)"
                
                let TurnInfoMessage = TurnInfo(currentUser: MyName, currentUserID: SendingUserUUID, lastUser: "NA", lastUserID: "NA_ID", TurnType: "image", theQuote: theQuote, theImageData: "na", gameID: gameID, previousTurnNumber: CurrentTurnNumber, imageURL: ImageURL_Message, GameComplete: GameCompleteTemp)
                
                let message = composeMessage(with: TurnInfoMessage, caption: NotificationMessage, session: conversation.selectedMessage?.session)
                DispatchQueue.main.async(execute: {
                // Add the message to the conversation.
                    
                conversation.insert(message) { error in
                    if let error = error {
                        print(error)
                    }
                }
                
                self.dismiss()
                })
                
            }
            
   
            
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
        
        //prefs.set(AppVersion, forKey: "AppVersion")
        
        
        super.willBecomeActive(with: conversation)
        
        self.ThisConversation = conversation
       // print("*****THIS CONVERSATION*****: \(ThisConversation)")
       // prefs.set(conversation, forKey: "CurrentConversation")
        
        
        print("****Active Message Tapped*** Tapped URL:\(conversation.selectedMessage?.url)")
        
        print("View is now active")
        
        /*
        guard let conversationTemp = conversation.selectedMessage()
        
        guard let messageURL = message.url else { return }
        guard let urlComponents = NSURLComponents(url: messageURL, resolvingAgainstBaseURL: false), let queryItems = urlComponents.queryItems else { return }
        
        print("Active View: URL Components", urlComponents)
        print("Active View: queryItems", queryItems)
        
        for item in queryItems {
            print("Active View: \(item.name) with value \(item.value)")
        }
        */
        
        // Present the view controller appropriate for the conversation and presentation style.
        presentViewController(for: conversation, with: presentationStyle)
        
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        print("Did receive message")
       
            // Called when a message arrives that was generated by another instance of this
            // extension on a remote device.
            
            // Use this method to trigger UI updates in response to the message.
            guard let messageURL = message.url else { return }
            guard let urlComponents = NSURLComponents(url: messageURL, resolvingAgainstBaseURL: false), let queryItems = urlComponents.queryItems else { return }
            
            print("URL Components", urlComponents)
            print("queryItems", queryItems)
            
            for item in queryItems {
                print("Received \(item.name) with value \(item.value)")
            }
            
        
        
        
        
        
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
        
        print("****Message Sent*** Sending URL:\(conversation.selectedMessage?.url)")
        
        print("****Message Sent*** Sending Message URL:\(message.url)")
        
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        
        var DeleteGameID = NSString()
        var DeleteCurrentTurn = NSString()
        
        DeleteGameID = prefs.value(forKey: "TempGameID") as! NSString
        DeleteCurrentTurn = prefs.value(forKey: "TempTurnNumber") as! NSString
        print("Deleting Game Message Now: GameID = \(DeleteGameID)")

        PREFIsNewGame = prefs.bool(forKey: "DELETEISNEWGAME")
        
        if PREFIsNewGame {
            
            let GameDeleted = DeleteTempMessageGame(DeleteGameID, CurrentTurn: "1")
            
            print("Game was deleted = \(GameDeleted)")
            
        } else {
            
           let GameDeleted = DeleteTempMessage(DeleteGameID, CurrentTurn: DeleteCurrentTurn)
            print("Game, Turn was deleted = \(GameDeleted)")
        }
        
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        
        
        guard let conversation = activeConversation else { fatalError("Expected an active converstation") }
        
        print("view will transition")
        
        
        switch presentationStyle.rawValue {
            
        case 0:
            
           // NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdatePictureFrameView"), object: nil, userInfo: ["rawValue":"0"])
            
           // NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateQuoteFrameView"), object: nil, userInfo: ["rawValue":"0"])
            
            prefs.set("0", forKey: "PresentationRawValue")
            
        case 1:
            
           // NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdatePictureFrameView"), object: nil, userInfo: ["rawValue":"1"])
            
           // NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateQuoteFrameView"), object: nil, userInfo: ["rawValue":"1"])
            
            prefs.set("1", forKey: "PresentationRawValue")
            
        default:
            break
            
        }
        
        // Present the view controller appropriate for the conversation and presentation style.
        presentViewController(for: conversation, with: presentationStyle)
        
        // Called before the extension transitions to a new presentation style.
    
        // Use this method to prepare for the change in presentation style.
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
        
        print("did transition")
        switch presentationStyle.rawValue {
            
        case 0:
        
          NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdatePictureFrameView"), object: nil, userInfo: ["rawValue":"0"])
        
          NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateQuoteFrameView"), object: nil, userInfo: ["rawValue":"0"])
            
            prefs.set("0", forKey: "PresentationRawValue")
            
        case 1:
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdatePictureFrameView"), object: nil, userInfo: ["rawValue":"1"])
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateQuoteFrameView"), object: nil, userInfo: ["rawValue":"1"])
            
            prefs.set("1", forKey: "PresentationRawValue")
            
        default:
            break
            
        }
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }
    
    @IBAction func UpdateUserNameBTN(_ sender: Any) {
        
        
        //  self.SegueGameID = "766"
        //  self.performSegue(withIdentifier: "GameComplete", sender: self)
        //let storyboard = UIStoryboard(name: "MainInterface", bundle: nil)
        //let vc = storyboard.instantiateViewController(withIdentifier: "GalleryItemExtViewController")
        //self.present(vc, animated: false, completion: nil)
        
        
        
        
        
        let inputName = usernameTextField.text
        
        
        
        if inputName == ""  {
            
            
            
            let alertController = UIAlertController(title: "Username?", message: "Please enter your username", preferredStyle: .alert)
            
            let CancelAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                print("Cancel button pressed")
                
            }
            
            
            //  alertController.addAction(yesAction);
            
            alertController.addAction(CancelAction);
            
            // alertController.view.tintColor = UIColor.blackColor();
            
            self.present(alertController, animated: true, completion: nil)
            
            
            
        } else {
            
            
            
            let myNameTemp = usernameTextField.text
            
            prefs.set(myNameTemp, forKey: "EXTUSERNAME")
            
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.usernameHolderView.center.y = self.usernameHolderView.center.y - 420
                self.usernameHolderTOP.constant = -400
                
            })
            
            ShowingUserNameView = false
            self.quoteBTN.isEnabled = true
            self.pictureBTN.isEnabled = true
            
            
            self.prefs.set(true, forKey: "HasUserName")
            
            self.HasUserName = true
            
            print("Username Set: HasUserName = \(HasUserName)")
            
            view.endEditing(true)
            
        }
     
        
        
    }

    
    
    @IBAction func AboutUsBTN(_ sender: Any) {
         requestPresentationStyle(.expanded)
        
        self.performSegue(withIdentifier: "AboutUs", sender: self)
        
    }
    
    @IBAction func HowToBTN(_ sender: Any) {
        requestPresentationStyle(.expanded)

        
        /*
        
        let myLoadView: LoadingCameraView = UINib(nibName: "LoadingCameraView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LoadingCameraView
        
        
        // myRemindView.remindLBL?.text = RemindString
        
        let DeviceH = self.view.frame.height
        //let halfH = DeviceH / 2;
        let DeviceW = self.view.frame.width
        //let WLess10 = DeviceW - 10;
        let startX = (DeviceW / 2) - 125;
        let startY = (DeviceH / 2) - 125;
        myLoadView.alpha = 0.0
        myLoadView.frame = UIScreen.main.bounds
        
        
        self.view.addSubview(myLoadView)
        
        UIView.animate(withDuration: 0.25, animations: {
            myLoadView.alpha = 1.0
        })
 
        */
 
 
        /*
        let myLoadView:LoadingViewOne = UINib(nibName: "LoadingView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LoadingViewOne
        
        // myRemindView.remindLBL?.text = RemindString
        
        let DeviceH = self.view.frame.height
        //let halfH = DeviceH / 2;
        let DeviceW = self.view.frame.width
        //let WLess10 = DeviceW - 10;
        let startX = (DeviceW / 2) - 125;
        let startY = (DeviceH / 2) - 125;
        
        
        myLoadView.alpha = 0.0
        myLoadView.theView.layer.cornerRadius = 10
        myLoadView.theView.layer.masksToBounds = true
        myLoadView.theView.clipsToBounds = true
        myLoadView.frame = UIScreen.main.bounds
        
        self.view.addSubview(myLoadView)
        
        
        UIView.animate(withDuration: 0.25, animations: {
            myLoadView.alpha = 1.0
        })
        
        */
        
        self.performSegue(withIdentifier: "ShowHowTo", sender: self)
        
        
        
        
        
        
        /*
        
        let alertController = UIAlertController(title: "How To Play", message: "It's Simple, just insert a quote or an image describing the one sent to you...or to start a new game simply insert a quote or image.  Each game has 10 Turns!", preferredStyle: .alert)
        
        let CancelAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            print("Cancel button pressed")
            
        }
        
      
        
        alertController.addAction(CancelAction);
        
        // alertController.view.tintColor = UIColor.blackColor();
        
        self.present(alertController, animated: true, completion: nil)
        
        */
        
    }
    
    
    
    
    @IBAction func PictureTurnBTN(_ sender: Any) {
        
        
        prefs.set(true, forKey: "VIEWINGPICTURETURN")
        
       //   NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdatePictureFrameView"), object: nil, userInfo: ["rawValue":"1"])
        
        requestPresentationStyle(.expanded)
        
         print("image turn selected")
       // NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdatePictureFrameView"), object: nil, userInfo: ["rawValue":"1"])
        
        self.performSegue(withIdentifier: "PictureTurn", sender: self)
        
        /*
        let storyboard = UIStoryboard(name: "MainInterface", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TurnPictureViewController")
        self.present(vc, animated: false, completion: nil)
        */
        
        
        
    }
    
    @IBAction func QuoteTurnBTN(_ sender: Any) {
        
      
        
      //  NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateQuoteFrameView"), object: nil, userInfo: ["rawValue":"1"])
        
        print("quote turn selected")
        
         requestPresentationStyle(.expanded)
       // NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateQuoteFrameView"), object: nil, userInfo: ["rawValue":"1"])
        self.performSegue(withIdentifier: "QuoteTurn", sender: self)
        
        /*
        
        let storyboard = UIStoryboard(name: "MainInterface", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TurnQuoteViewController")
        self.present(vc, animated: false, completion: nil)
        */
    }
    
    
    
    
    
    
    private func presentViewController(for conversation: MSConversation, with presentationStyle: MSMessagesAppPresentationStyle) {
        // Determine the controller to present.
        let controller: UIViewController
        
        
        //var MyName = String()
        
        if self.prefs.value(forKey: "EXTUSERNAME") == nil {
            MyName = "Guest"
        } else {
            MyName = self.prefs.value(forKey: "EXTUSERNAME") as! NSString
        }
        
        
        if presentationStyle == .compact {
            
            let TurnInfoTemp = TurnInfo(message: conversation.selectedMessage) ?? TurnInfo()
            print("Compact Conversation TEST: \(conversation.selectedMessage)")
            
            self.usernameLBL.isHidden = true
            self.usernameBTN.isHidden = true
            print("Tapped Compact TurnInfo = \(TurnInfoTemp)")
            
            if TurnInfoTemp == nil {
                
                
            } else {
                
            }
          //  NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdatePictureFrameView"), object: nil, userInfo: ["rawValue":"0"])
            
          //  NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateQuoteFrameView"), object: nil, userInfo: ["rawValue":"0"])
            
            print("Is Compact View")
            // Show a list of previously created ice creams.
            //print("instantiate ice creams controllers")
            //controller = instantiateIceCreamsController()
            
            
        } else {
            print("Is Expanded View")
            
            
            
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdatePictureFrameView"), object: nil, userInfo: ["rawValue":"1"])
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateQuoteFrameView"), object: nil, userInfo: ["rawValue":"1"])
            
            prefs.set("1", forKey: "PresentationRawValue")
            
            
            
            
            
            
            
        
            self.usernameLBL.isHidden = false
            self.usernameBTN.isHidden = false
            
          //  NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdatePictureFrameView"), object: nil, userInfo: ["rawValue":"1"])
            
          //  NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateQuoteFrameView"), object: nil, userInfo: ["rawValue":"1"])
            
            let TurnInfoTemp = TurnInfo(message: conversation.selectedMessage) ?? TurnInfo()
            
            let TempURL = conversation.selectedMessage?.url
            
            if TempURL != nil {
            
           
            
            }
          //  let TurnInfoQueryItems = TurnInfoTemp.queryItemsDictionary
            
            
            print("Tapped Expanded TurnInfo Query Items = \(TurnInfoTemp.queryItems)")
            
            if TempURL == nil {
                
                
            } else {
            
                
                
                
                
                
                
                
                
                
                let components = NSURLComponents(url: TempURL!, resolvingAgainstBaseURL: false)
                print("COMPONETS QUERY ITEMS: \(components?.queryItems)")
                
               let TappedGameID = components?.queryItems?[0].value
               let SentUsername = components?.queryItems?[1].value
               let SentUserID = components?.queryItems?[2].value
                
               let SentTurnType = components?.queryItems?[5].value
               let SentQuote = components?.queryItems?[6].value
               let SentImageData = components?.queryItems?[7].value
               let SentTurnNumber = components?.queryItems?[8].value
               let SentImageURL = components?.queryItems?[9].value
               let SentGameComplete = components?.queryItems?[10].value
                
                //var TappedInfoDict = Dictionary<String,String?>()
                var TappedInfoDict = Dictionary<String, String>()
                
                for queryItem in (components?.queryItems!)! {
                    print("\(queryItem.name) = \(queryItem.value)")
                   // TappedInfoDict.app
                }
                
                SegueGameID = TappedGameID! as NSString
                SegueNewGame = false
                SegueMediaType = SentTurnType! as NSString
                SegueTurnNumber = SentTurnNumber! as NSString
                
                prefs.set(SegueGameID, forKey: "TURNINFO_GAMEID")
                prefs.set(SegueTurnNumber, forKey: "TURNINFO_TURNNUMBER")
                
                var NewTurnNum = String()
                
                switch SegueTurnNumber {
                    case "1":
                    NewTurnNum = "2"
                case "2":
                    NewTurnNum = "3"
                case "3":
                    NewTurnNum = "4"
                case "4":
                    NewTurnNum = "5"
                case "5":
                    NewTurnNum = "6"
                case "6":
                    NewTurnNum = "7"
                case "7":
                    NewTurnNum = "8"
                case "8":
                    NewTurnNum = "9"
                case "9":
                    NewTurnNum = "10"
                case "10":
                    NewTurnNum = "11"
                    
                default:
                    break
                }
                
                
             
                
                
                
                
                
                
            
               // let TappedGameID = components?.queryItems.name["gameID"]
                
                
                
            if SentGameComplete == "yes" {
                
                 HolderStatus = true
                //controller = instantiateCompletedIceCreamController(with: iceCream)
                print("Turn is Complete, while presenting view controller")
                
               // self.performSegue(withIdentifier: "GameComplete", sender: self)
                let storyboard = UIStoryboard(name: "MainInterface", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "GalleryItemExtViewController")
                self.present(vc, animated: false, completion: nil)
                
                
            } else {
                
                
                
                let (HolderStatus2, Error_Msg2) = TurnHolder(SegueGameID, username: MyName as NSString, turninfo: NewTurnNum as NSString, status: "Get", userid: UIDevice.current.identifierForVendor!.uuidString as NSString)
                
                HolderStatus = HolderStatus2
                var Error_Msg = Error_Msg2 as String
                print("HOLDER STATUS = \(HolderStatus)")
                
                
                
               // controller = instantiateBuildIceCreamController(with: iceCream)
                if HolderStatus {
                
                if SentUserID == UIDevice.current.identifierForVendor!.uuidString {
                
                let alertController = UIAlertController(title: "You took the last turn", message: "Are you sure you want to take this turn?", preferredStyle: .alert)
                
                let CancelAction = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction) in
                    print("Cancel button pressed")
                    
                }
                
                
                
                let yesAction = UIAlertAction(title: "Take Turn", style: .default) { (action:UIAlertAction) in
                   
                    
                    if SentTurnType == "quote" {
                        
                       
                      //  self.performSegue(withIdentifier: "PictureTurn", sender: self)
                    
                    let storyboard = UIStoryboard(name: "MainInterface", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "TurnPictureViewController")
                    self.present(vc, animated: false, completion: nil)
                    
                    } else {
                        
                      //  self.performSegue(withIdentifier: "QuoteTurn", sender: self)
                      
                        let storyboard = UIStoryboard(name: "MainInterface", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "TurnQuoteViewController")
                        self.present(vc, animated: false, completion: nil)
                        
                        
                    }
                    
                    
                }
                
                
                alertController.addAction(yesAction);
                
                alertController.addAction(CancelAction);
                
               // alertController.view.tintColor = UIColor.blackColor();
                
                self.present(alertController, animated: true, completion: nil)

                } else {
                    
                    
                    if SentTurnType == "quote" {
                        
                        
                       // self.performSegue(withIdentifier: "PictureTurn", sender: self)
                        
                         let storyboard = UIStoryboard(name: "MainInterface", bundle: nil)
                         let vc = storyboard.instantiateViewController(withIdentifier: "TurnPictureViewController")
                         self.present(vc, animated: false, completion: nil)
                        
                    } else {
                        
                       // self.performSegue(withIdentifier: "QuoteTurn", sender: self)
                        
                         let storyboard = UIStoryboard(name: "MainInterface", bundle: nil)
                         let vc = storyboard.instantiateViewController(withIdentifier: "TurnQuoteViewController")
                         self.present(vc, animated: false, completion: nil)
                        
                        
                    }
                    
                    
                }
                    
                } else {
                    
                    
                    let alertController = UIAlertController(title: "Turn Unavailable", message: "Someone else is taking this turn", preferredStyle: .alert)
                    
                    let CancelAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                        print("Cancel button pressed")
                        
                    }
                    
                    
                    alertController.addAction(CancelAction);
                    
                    // alertController.view.tintColor = UIColor.blackColor();
                    
                    self.present(alertController, animated: true, completion: nil)

                }
               
                
                
                
                
                
                
                
            }
              
                
                
                
                
                
                
                
        
            
         }
            
            
            
            
            
            
            
            
            
            
            
        }
     
    }
    
 
    
    fileprivate func composeMessage(with TurnInfo: TurnInfo, caption: String, session: MSSession? = nil) -> MSMessage {
        print("***COMPOSING THE MESSAGE NOW***")
        
       // print("Compose Message: TurnInfo = \(TurnInfo)")
        
        var components = URLComponents()
        
        var URLQueryItems = [URLQueryItem]()
        
        var MessageGameID = self.prefs.value(forKey: "TempGameID")
        print("COMPOSE MESSAGE GAME ID: \(MessageGameID)")
        
        URLQueryItems.append(URLQueryItem(name: "gameID", value: TurnInfo.gameID))
        URLQueryItems.append(URLQueryItem(name: "username", value: TurnInfo.currentUser))
        URLQueryItems.append(URLQueryItem(name: "userID", value: TurnInfo.currentUserID))
        URLQueryItems.append(URLQueryItem(name: "lastusername", value: TurnInfo.lastUser))
        URLQueryItems.append(URLQueryItem(name: "lastuserID", value: TurnInfo.lastUserID))
        URLQueryItems.append(URLQueryItem(name: "turnType", value: TurnInfo.TurnType))
        URLQueryItems.append(URLQueryItem(name: "quote", value: TurnInfo.theQuote))
        URLQueryItems.append(URLQueryItem(name: "imageData", value: TurnInfo.theImageData))
        URLQueryItems.append(URLQueryItem(name: "turnNumber", value: TurnInfo.previousTurnNumber))
        URLQueryItems.append(URLQueryItem(name: "imageURL", value: TurnInfo.imageURL))
        URLQueryItems.append(URLQueryItem(name: "gameComplete", value: TurnInfo.GameComplete))
        
        print("***MESSAGE URL QUERY ITEMS: \(URLQueryItems)")
        
        components.queryItems = URLQueryItems
        
        
       // print("Components Query Items: \(components.queryItems)")
        
       // let GameID = TurnInfo.queryItems.
       // let TurnNumber = TurnInfo.qu
        
       // let userInfo:Dictionary<String,String?> = (notification as NSNotification).userInfo as! Dictionary<String,String?>
       // let userInfo:Dictionary<String,String?> = TurnInfo.queryItems as! Dictionary<String,String?>
        
       // print("UserInfo: \(userInfo)")
        //var jsonAlert = JSON(userInfo)
        // print("JSON ALERT \(jsonAlert)")
        //   println("JSON ALERT \(jsonAlert)")
        
        //let NotificationMessage = jsonAlert["message"].stringValue
        
        
        
        
        var GameIDmessage = TurnInfo.gameID
        
        print("GameID: \(GameIDmessage)")
        
        
        var TurnInfoURL: URL!
        
       // TurnInfoURL.
        
       // components = TurnInfoURL
        
        print("TURN INFO: QUERY ITEMS - \(components.url)")
        
        let layout = MSMessageTemplateLayout()
        let message = MSMessage(session: session ?? MSSession())
        
        
        let TheImageURL = "\(AppImageURL)\(TurnInfo.imageURL)"
        
        print("COMPOSE MESSAGE: IMAGE URL = \(TheImageURL)")
        
        print("TurnType in COMPOSE: \(TurnInfo.TurnType)")
        print("ImageURL in COMPOSE: \(TurnInfo.imageURL)")
        
        if TurnInfo.GameComplete == "no" {
        
        switch TurnInfo.TurnType {
            
            
                        case "quote":
                            
            print("Composing Message: TurnType is Quote")
            
            
            let TempImage = CreateTempImage(TurnInfo.theQuote)
            
            
            let TempBlurredImage = bluredImage(image: TempImage, radius: 20)
            
            let FinalImage = CreateTempImageForLayout(QBoxImage: TempBlurredImage, TurnNumber: TurnInfo.previousTurnNumber, TempQuote: "Tap to view the quote!")
            
            /*
            let TheImageURL2 = "\(TheImageURL).jpg" as NSString
            let url = URL(string: TheImageURL2 as String)
            let data = try? Data(contentsOf: url!)
            */
            
            
            
            layout.image = FinalImage
            layout.caption = caption
            //layout.image = TurnInfo.renderSticker(opaque: true)
            //layout.caption = caption
            
           // message.url = components.url!
            
            
            //print("MESSAGE URL = \(message.url)")
            
            //message.layout = layout
            
            
            
                        case "image":
                            
            print("Composing Message: TurnType is image")
            
            
            
            //layout.image = TurnInfo.renderSticker(opaque: true)
           // layout.caption = caption
            
           // message.url = components.url!
           // message.layout = layout
            
            let ComposeMessageMediaType = self.prefs.value(forKey: "PICTUREDATA_MEDIATYPE") as! String
            
          //  if ComposeMessageMediaType == "image" {
                
            let Image64Data2 = prefs.value(forKey: "PICTUREDATAD")
            
           // print("******Image 64 Data******* \(Image64Data2)")
            
            
            
                //let Image64Data2 = TurnInfo.theImageData as String

             // let Image64NSData = Data(base64Encoded: Image64Data2 as! String, options: NSData.Base64DecodingOptions(rawValue: 0))
            
             // print("Image64NSData = \(Image64NSData!)")
            
           //   let Image64Data = NSString(data: Image64NSData!, encoding: String.Encoding.utf8.rawValue)!
            
            
                //print("IMAGE 64 DATA =           \(Image64Data)")
            
            
                let decodedData = Data(base64Encoded: Image64Data2 as! String, options: NSData.Base64DecodingOptions(rawValue: 0))
               // print("DECODED DATA =         \(decodedData)")
               // print("Setting Image")
            
           //  DispatchQueue.main.async(execute: {
                
                let TempImage = UIImage(data: decodedData!)!
            //let TempImage = UIImage(data: Image64NSData!)!
            
                let TempBlurredImage = bluredImage(image: TempImage, radius: 15)// (image: TempImage, radius: 0.7)
                let FinalImage = CreateTempImageForLayout(QBoxImage: TempBlurredImage, TurnNumber: TurnInfo.previousTurnNumber, TempQuote: "Tap to view the picture!")
                /*
                let TheImageURL2 = "\(TheImageURL).jpg" as NSString
                let url = URL(string: TheImageURL2 as String)
                let data = try? Data(contentsOf: url!)
                */
                
                layout.image = FinalImage //UIImage(data: data!)
                layout.caption = caption
                
                
          //  }
            
            
            //layout.caption = caption
            
           // message.url = components.url!
           // message.layout = layout
            
            
            default:
            break
          }
        } else {
            
            let FinalImage = CreateTempImageGameComplete("Game Complete.  Check it out!")
            layout.image = FinalImage
            layout.caption = "Your Game is Complete!"
            
        }

     
        //layout.image = TurnInfo.renderSticker(opaque: true)
        /*
        layout.caption = caption
        message.url = components.url!
        message.layout = layout
        */
        
        //print("Message URL = \(message.url)")
        
       // layout.caption = caption
        
        
        switch TurnInfo.previousTurnNumber {
            
        case "1":
            layout.subcaption = "Turn 1 of 10"
        case "2":
            layout.subcaption = "Turn 2 of 10"
        case "3":
            layout.subcaption = "Turn 3 of 10"
        case "4":
            layout.subcaption = "Turn 4 of 10"
        case "5":
            layout.subcaption = "Turn 5 of 10"
        case "6":
            layout.subcaption = "Turn 6 of 10"
        case "7":
            layout.subcaption = "Turn 7 of 10"
        case "8":
            layout.subcaption = "Turn 8 of 10"
        case "9":
            layout.subcaption = "Turn 9 of 10"
        case "10":
            layout.subcaption = "Turn 10 of 10"
            
            default:
            break
        }
        
        message.url = components.url!
        message.layout = layout
        
        return message
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
     
        
    
        //  if segue.identifier == GameSegue {
        if let destination = segue.destination as? TurnPictureViewController {
            // destination.GameName = GameNameInfo[GameIndex]
            destination.GameID = SegueGameID
            destination.newGame = SegueNewGame
            destination.MediaType = SegueMediaType
            destination.TempTurnNumber = SegueTurnNumber
        
        }
        
        if let destination = segue.destination as? TurnQuoteViewController {
            // destination.GameName = GameNameInfo[GameIndex]
            destination.GameID = SegueGameID
            destination.newGame = SegueNewGame
            destination.mediaType = SegueMediaType
            destination.TempTurnNumber = SegueTurnNumber
            
        }
        
        if let destination = segue.destination as? GalleryItemExtViewController {
            // destination.GameName = GameNameInfo[GameIndex]
            destination.GameID = SegueGameID
            
        }
     
        
    }
    
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    
    
    @IBAction func enterUsernameBTN(_ sender: Any) {
        
        if !ShowingUserNameView {
        
        let DeviceW = self.view.frame.width
        let DeviceH = self.view.frame.height
            
            
            self.usernameHolderViewW.constant = DeviceW / 1.3
            
            let usernameViewWidth = (DeviceW / 1.3) / 2
            self.usernameHolderViewH.constant = usernameViewWidth
            
            self.userSubmitW.constant = DeviceW / 3.2
            self.userSubmitH.constant = (DeviceW / 3.2) / 3
            
            // self.usernameInfoLBL.adjustsFontSizeToFitWidth = true
            
            let FontSizeTemp = DeviceW / 20
            
            self.usernameInfoLBL.font.withSize(FontSizeTemp)
            
            self.usernameInfoLBL.font = UIFont(name: "DK Cool Crayon", size: FontSizeTemp)
            
            //self.usernameInfo
            if !ShowingUserNameView {
                
                requestPresentationStyle(.expanded)
                
                
                print("Requesting Expaneded Style to show username")
                self.usernameInfoLBL.text = "Update Username?"
                
                
                UIView.animate(withDuration: 1.0, animations: { () -> Void in
                    
                    
                    self.usernameHolderView.center.y = self.usernameHolderView.center.y + 420
                    self.usernameHolderTOP.constant = 20
                    
                })
                
                ShowingUserNameView = true
                
            }
        
    }
    
    }
    
    

}

/*
extension NSURL {
    func queryDictionary() -> [String:String] {
        let components = self.query?.stringByAppendingPathComponent("&")// componentsSeparatedByString("&")
        var dictionary = [String:String]()
        
        for pairs in components ?? [String:String] {
            let pair = pairs.componentsSeparatedByString("=")
            if pair.count == 2 {
                dictionary[pair[0]] = pair[1]
            }
        }
        
        return dictionary
    }
}
*/

extension NSURL {
    
    var queryItemsDictionary: [String: String] {
        var queryItemsDictionary = [String: String]()
        guard let components = NSURLComponents(url: self as URL, resolvingAgainstBaseURL: false), let queryItems = components.queryItems else { return queryItemsDictionary }
        queryItems.forEach { queryItemsDictionary[$0.name] = $0.value }
        return queryItemsDictionary
    }
    
}
