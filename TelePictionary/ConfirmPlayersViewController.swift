//
//  ConfirmPlayersViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 8/16/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import AddressBookUI
import CoreData
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
import GameKit

class ConfirmPlayersViewController: UIViewController, ABPeoplePickerNavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate, UIActionSheetDelegate, UIAlertViewDelegate, FBSDKAppInviteDialogDelegate, UIPopoverPresentationControllerDelegate, GroupPickerViewControllerDelegate, RepeatFriendsViewControllerDelegate, FBFriendsViewControllerDelegate, GKGameCenterControllerDelegate {
    
    var IsPlayerLoggedInGC = Bool()
    var localPlayer = GKLocalPlayer.local
    var GAMECENTERLOGGEDIN = Bool()
    var GCplayer = NSString()
    var GCplayerid = NSString()
    
    
    var GameID = NSString()
    var TextPlayerTurnNumber = [NSString]()
    var TextPlayerContact = [NSString]()
    var TextPlayerNames = [NSString]()
//, EasyGameCenterDelegate {
    let NewGameProgressHUD = ProgressHUD(text: "Creating Game...")
    var expGame = Bool()
    var ShowInfoKey = Bool()
    var ShowingInfo = Bool()
    @IBOutlet var DontShowBTN: UIButton!
    var DontShowIntro = Bool()
    let OtherUserProfile = true
    @IBOutlet var ViewHolder: UIView!
    
    let prefs:UserDefaults = UserDefaults.standard
    
    @IBOutlet var theView: UIView!
    @IBOutlet var View1NextBTN: UIButton!
    @IBOutlet var View1LBL: UILabel!
    
    @IBOutlet var theView2: UIView!
    @IBOutlet var View2NextBTN: UIButton!
    @IBOutlet var View2LBL: UILabel!
    @IBOutlet var View2TOP: NSLayoutConstraint!
    var profileID = NSString()
    
    @IBOutlet var ViewTrans: UIView!
    
    @IBOutlet var ViewTransTOP: NSLayoutConstraint!
    var grouppickerviewcontroller: GroupPickerViewController = GroupPickerViewController()
    
    var repeatfriendsviewcontroller: RepeatFriendsViewController = RepeatFriendsViewController()
    
    var fbfriendsviewcontroller: FBFriendsViewController = FBFriendsViewController()
    
    var dict = NSDictionary()
    
   // var localPlayer = GKLocalPlayer.local
    
    @IBOutlet weak var picPreview: UIView!
    
    @IBOutlet weak var introTOP: NSLayoutConstraint!

    @IBOutlet weak var infoBTN: UIButton!
    let index = 10
    var username = String()
    var myemail = String()
    var myID = String()
    
    @IBOutlet weak var editBTN: UIBarButtonItem!
    @IBOutlet weak var TableView: UITableView!
    
    @IBOutlet weak var getgroupsBTN: UIBarButtonItem!
    
    @IBOutlet weak var startBTN: UIButton!
    @IBOutlet weak var GameLBL: UILabel!
    
    
    var post = NSString()
    var post_old = NSString()
    var QuoteBoxtext = NSString()
    
    
    var EmailInfo = [NSString]()
    var CellInfo = [NSString]()
   
    var groupName = NSString()
    
    
    var theFriends = [MyFriends]()
    
    var Friends = [NSManagedObject]()
    var FriendsName = [NSString]()
    var FriendsEmail = [NSString]()
    var NameTable = [NSString]()
    var FriendsInfo = [NSString]()
    var EmailTable = [NSString]()
    var NameInfo = [NSString]()
    var numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    var UNIDArray = [NSString]()
    var MediaType = NSString()
    var NumSelected = [Int]()
    var PlayerCount = [NSString]()
    var NumFriends = [NSString]()
    var varNum = Int()
    
    var NumPlayers = Int()
    var GroupData = [NSArray]()
    var NameData = [NSString]()
    var ContactData = [NSString]()
    
    var SelectedGroup = Bool()
    var GroupSelected = NSString()
    var DidSelectGroup = Bool()
    var DidSelectGCFriend = Bool()
    var SelectedGCFriend = Bool()
    var DidSelectedFBFriend = Bool()
    var SelectedFBFriend = Bool()
    var userID = NSString()
    
    // NEW VARIABLES
    var NewGameContentRating = NSString()
    var NewGameTitle = NSString()
    var NewGamePlayers = Int()
    var NewGameTurnTime = NSString()
    var NewGameFirstTurn = NSString()
    var NewGameAudioData = NSString()
    var NewGameQuote = NSString()
    var NewGameImage = UIImage()
    var NewNumbersArray = [NSString]()
    var NewGamePlayersName = [NSString]()
    var NewGamePlayersContact = [NSString]()
    var NewGamePictureData = NSString()
    var picData = NSString()
    var audioData = NSString()
    var replaceRow = Int()
    
    
    
    var inputname = NSString()
    var inputcontact = NSString()
    var inputID = NSString()
    var GroupPlayers = [NSString]()
    var GroupContact = [NSString]()
    var GroupIDs = [NSString]()
    var GroupVariance = Int()
    var GroupNumbers = [NSString]()
    
    var image = UIImage()
    //var myemail = NSString()
    
    var Player1 = NSString()
    var Player2 = NSString()
    var Player3 = NSString()
    var Player4 = NSString()
    var Player5 = NSString()
    var Player6 = NSString()
    var Player7 = NSString()
    var Player8 = NSString()
    var Player9 = NSString()
    var Player10 = NSString()
    
    var Player1ID = NSString()
    var Player2ID = NSString()
    var Player3ID = NSString()
    var Player4ID = NSString()
    var Player5ID = NSString()
    var Player6ID = NSString()
    var Player7ID = NSString()
    var Player8ID = NSString()
    var Player9ID = NSString()
    var Player10ID = NSString()
    
    
    var DoUploadImage = Bool()
    var Player1Email = NSString()
    var Player2Email = NSString()
    var Player3Email = NSString()
    var Player4Email = NSString()
    var Player5Email = NSString()
    var Player6Email = NSString()
    var Player7Email = NSString()
    var Player8Email = NSString()
    var Player9Email = NSString()
    var Player10Email = NSString()
    
    var pictureData = NSString()
    
    var GCFriendName = NSString()
    var GCFriendContact = NSString()
    var GCFriendID = NSString()
    
    var FBFriendName = NSString()
    var FBFriendContact = NSString()
    var FBFriendID = NSString()
    
   // var mainImageView = UIImageView()
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var ConfirmTitle: UILabel!
    
    var ViewShowing = true
    
    @IBOutlet var View1TOP: NSLayoutConstraint!
    
    
    //END NEW VARIABLES
    
    
    @IBAction func seeImage(_ sender: AnyObject) {
        
        print("image data: \(picData)")
        
    }
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        View1NextBTN.layer.cornerRadius = 10
        theView.layer.cornerRadius = 10
        
        View2NextBTN.layer.cornerRadius = 10
        theView2.layer.cornerRadius = 10
        
        View1LBL.layer.masksToBounds = true
        
        View1LBL.roundCorners([.topLeft, .topRight], radius: 10)
        
        View2LBL.layer.masksToBounds = true
        
        View2LBL.roundCorners([.topLeft, .topRight], radius: 10)
        
        ViewHolder.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
      
        
        
        //ViewTrans.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).CGColor
        
        
        TableView.backgroundColor = UIColor.clear
        
        
        let prefs:UserDefaults = UserDefaults.standard
        
        username = prefs.value(forKey: "USERNAME") as! NSString as String
        
        myID = prefs.value(forKey: "PLAYERID") as! NSString as String
        
        if prefs.value(forKey: "PICTUREDATAD") == nil {
            
        } else {
            
            picData = prefs.value(forKey: "PICTUREDATAD") as! NSString
            print("Picture data = \(picData)")
            
        }
        
        if prefs.value(forKey: "AUDIODATAD") == nil {
            
        } else {
            
           audioData = prefs.value(forKey: "AUDIODATAD") as! NSString
            
        }
//print("AUDIO DATA = \(audioData)")
  //      print("NEW GAME AUDIO DATA = \(NewGameAudioData)")
        
    //    print("assigning image")
       // mainImageView.image = NewGameImage

        
        grouppickerviewcontroller.adelegate=self
        
        repeatfriendsviewcontroller.rdelegate=self
        
        fbfriendsviewcontroller.fdelegate=self
        
        
        
        startBTN.layer.cornerRadius = 10
        startBTN.layer.borderWidth = 2
        startBTN.layer.borderColor = UIColor.white.cgColor
        
       // navigationController!.navigationBar.barTintColor = UIColor(red: 0.6, green: 1.0, blue: 0.6, alpha: 1.0)
        let NewGamePlayersText:NSString = NewGamePlayers.description as NSString
        switch NewGamePlayersText {
        case "2":
            NewNumbersArray.append("1")
            NewNumbersArray.append("2")
            NewGamePlayersName.append(username as NSString)
            NewGamePlayersName.append("NA")
            NewGamePlayersContact.append("PUSH")
            NewGamePlayersContact.append("NA")
            UNIDArray.append(myID as NSString)
            UNIDArray.append("NA")
        case "3":
            NewNumbersArray.append("1")
            NewNumbersArray.append("2")
            NewNumbersArray.append("3")
            NewGamePlayersName.append(username as NSString)
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersContact.append("PUSH")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            UNIDArray.append(myID as NSString)
            UNIDArray.append("NA")
            UNIDArray.append("NA")
   
            
        case "4":
            NewNumbersArray.append("1")
            NewNumbersArray.append("2")
            NewNumbersArray.append("3")
            NewNumbersArray.append("4")
            NewGamePlayersName.append(username as NSString)
            //NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersContact.append("PUSH")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            UNIDArray.append(myID as NSString)
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
 

        case "5":
            NewNumbersArray.append("1")
            NewNumbersArray.append("2")
            NewNumbersArray.append("3")
            NewNumbersArray.append("4")
            NewNumbersArray.append("5")
            NewGamePlayersName.append(username as NSString)
            //NewGamePlayersName.append("NA")
            
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersContact.append("PUSH")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            UNIDArray.append(myID as NSString)
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
  
            
            
        case "6":
            NewNumbersArray.append("1")
            NewNumbersArray.append("2")
            NewNumbersArray.append("3")
            NewNumbersArray.append("4")
            NewNumbersArray.append("5")
            NewNumbersArray.append("6")
            NewGamePlayersName.append(username as NSString)
            //NewGamePlayersName.append("NA")
            
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersContact.append("PUSH")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            UNIDArray.append(myID as NSString)
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")

            
            
        case "7":
            NewNumbersArray.append("1")
            NewNumbersArray.append("2")
            NewNumbersArray.append("3")
            NewNumbersArray.append("4")
            NewNumbersArray.append("5")
            NewNumbersArray.append("6")
            NewNumbersArray.append("7")
            NewGamePlayersName.append(username as NSString)
            //            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersContact.append("PUSH")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
          //  NewGamePlayersContact.append("NA")
            UNIDArray.append(myID as NSString)
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
 

            
            
        case "8":
            NewNumbersArray.append("1")
            NewNumbersArray.append("2")
            NewNumbersArray.append("3")
            NewNumbersArray.append("4")
            NewNumbersArray.append("5")
            NewNumbersArray.append("6")
            NewNumbersArray.append("7")
            NewNumbersArray.append("8")
            NewGamePlayersName.append(username as NSString)
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersContact.append("PUSH")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
          //  NewGamePlayersContact.append("NA")
            UNIDArray.append(myID as NSString)
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
  
            
            
        case "9":
            NewNumbersArray.append("1")
            NewNumbersArray.append("2")
            NewNumbersArray.append("3")
            NewNumbersArray.append("4")
            NewNumbersArray.append("5")
            NewNumbersArray.append("6")
            NewNumbersArray.append("7")
            NewNumbersArray.append("8")
            NewNumbersArray.append("9")
            NewGamePlayersName.append(username as NSString)
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            
            NewGamePlayersContact.append("PUSH")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
          //  NewGamePlayersContact.append("NA")
            UNIDArray.append(myID as NSString)
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            
        case "10":
            NewNumbersArray.append("1")
            NewNumbersArray.append("2")
            NewNumbersArray.append("3")
            NewNumbersArray.append("4")
            NewNumbersArray.append("5")
            NewNumbersArray.append("6")
            NewNumbersArray.append("7")
            NewNumbersArray.append("8")
            NewNumbersArray.append("9")
            NewNumbersArray.append("10")
            NewGamePlayersName.append(username as NSString)
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersName.append("NA")
            NewGamePlayersContact.append("PUSH")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
            NewGamePlayersContact.append("NA")
          //  NewGamePlayersContact.append("NA")
            UNIDArray.append(myID as NSString)
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
            UNIDArray.append("NA")
    
        default:
            NewNumbersArray.append("1")
            NewGamePlayersContact.append("PUSH")
            NewGamePlayersName.append(username as NSString)
            UNIDArray.append(myID as NSString)
           
        }
        
        NumPlayers = NewGamePlayers
        
        //TableView.allowsMultipleSelection = true
        
       // GameLBL.text = "Game Players : \(numPlayers)"
        
        //   TableView.registerClass(UITableView.self, forCellReuseIdentifier: "BasicCell")
    
        
        
        
        //println("my gamecenter user name = \(username)")
        
        //need to add my email address default
        myemail = "jared.stevens@\(ServerInfo.sharedInstance)"
        //NameTable.append(username)
        //EmailTable.append(myemail)
        //FriendsName.append(username)
        //FriendsEmail.append(myemail)
        //varNum = 1
        //PlayerCount.append(varNum.description)
        
        TableView.dataSource = self
        TableView.delegate = self
        
        self.TableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        
        let AlreadySeenHowTo = prefs.bool(forKey: "DidShowHowTo_SelectPlayers")
     
        if !AlreadySeenHowTo {
         
            
        /*
        if prefs.boolForKey("ShowPlayerInfo") ?? false {
            ShowInfoKey = true
        } else {
            ShowInfoKey = prefs.boolForKey("ShowPlayerInfo")
        }
        */
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
         // self.View1TOP.constant = middleY
       // ShowInfoKey = true
        
        
        
       // if ShowInfoKey {
            
          //  DontShowBTN.imageView?.image = UIImage(named: "CheckBox_Empty.png")
      //  print("showing how to info")
            
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            self.View1TOP.constant = middleY
            
            self.ViewHolder.center.y = self.ViewHolder.center.y - 1000
            
            self.introTOP.constant = 0
            //self.ViewShowing = true
           // ShowingInfo = true
            
           // self.ViewTransTOP.constant = 0
         })
            ViewShowing = true
       /*
} else {
            DontShowBTN.imageView?.image = UIImage(named: "CheckBox_Full.png")
        }
      */
    }

   }
    
    override func viewDidAppear(_ animated: Bool) {
        
       // ConfirmTitle.text = "\(NewGameTitle): Select Players"
        ConfirmTitle.text = "Select Players"
        
        
        print("New game title: \(NewGameTitle)")
        print("New game number of players: \(NewGamePlayers)")
        print("New game turn time: \(NewGameTurnTime)")
        print("New game first turn: \(NewGameFirstTurn)")
        print("New game quote: \(NewGameQuote)")
        //NewGameImage
        print("New Numbers array: \(NewNumbersArray)")
        
        pictureData = NewGamePictureData
        
       // EasyGameCenter.delegate = self
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if !ViewShowing {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.ViewShowing = true
                self.View1TOP.constant = middleY
                
                
                self.ViewHolder.center.y = self.ViewHolder.center.y - 1000
                
                self.introTOP.constant = 0
              //  self.ViewTransTOP.constant = 0

               // ShowingInfo = true
                
                
            })
startBTN.isHidden = true
            
        }
        
        
        GAMECENTERLOGGEDIN = UserDefaults.standard.bool(forKey: "GameCenterEnabled")
       
        
    }
    
    
    @IBAction func View1NextBTN(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
       // self.theView.center.y = self.theView.center.y - 1000
        
        self.View2TOP.constant = middleY
        
        let animationOptions: UIView.AnimationOptions = [UIView.AnimationOptions.transitionFlipFromRight, UIView.AnimationOptions.showHideTransitionViews]
        
        UIView.transition(from: self.theView, to: self.theView2, duration: 0.8, options: animationOptions, completion: nil)
        
    }
    
    @IBAction func hideViewBTN(_ sender: AnyObject) {
        //ViewShowing = false
        self.ViewHolder.center.y = self.ViewHolder.center.y + 1000
        
        self.introTOP.constant = 1000
       //self.ViewTransTOP.constant = 1000
       // self.ViewTrans.hidden = true
        self.ViewHolder.isHidden = true
        
        
      
        self.prefs.set(true, forKey: "DidShowHowTo_SelectPlayers")
        startBTN.isHidden = false
        ViewShowing = false
        //ShowingInfo = false
    }
    
    @IBAction func showViewBTN(_ sender: AnyObject) {
        print("Showing How To View")
        if !ViewShowing {
            
             let animationOptions: UIView.AnimationOptions = [UIView.AnimationOptions.transitionFlipFromRight, UIView.AnimationOptions.showHideTransitionViews]
            
             UIView.transition(from: self.theView2, to: self.theView, duration: 0.8, options: animationOptions, completion: nil)
            
       startBTN.isHidden = true
      //  self.ViewTrans.hidden = false
        self.ViewHolder.isHidden = false
        
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        // self.View1TOP.constant = middleY
        
        
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.View1TOP.constant = middleY
                self.ViewHolder.center.y = self.ViewHolder.center.y - 1000
                
                self.introTOP.constant = 0
               // self.ViewTransTOP.constant = 0
            })
            ViewShowing = true
        }
    }
    
    /*
    @IBAction func DontShowBTN(sender: AnyObject) {
        
        print("Presed Dont Show again button")
        if DontShowIntro {
            //
            DontShowBTN.imageView?.image = UIImage(named: "CheckBox_Empty.png")
            
            DontShowIntro = false
            self.prefs.setBool(true, forKey: "ShowSelectPlayersInfo")
            print("Selected to show again")
            
        } else {
            
            DontShowBTN.imageView?.image = UIImage(named: "CheckBox_Full.png")
            DontShowIntro = true
            
            self.prefs.setBool(false, forKey: "ShowSelectPlayersInfo")
            
            print("Selected to NOT show again")
        }
    }
   */
    
    @IBAction func infoBTN(_ sender: AnyObject) {
       
        let AC = JSController("Choose Your Game Players", MyMessage: "By selecting one of the three buttons (Facebook, Game Center, or My Contacts) next to each available player you can confirm how that player will be notified of the New Game.\n \nYou may add additional players (up to 10 players), by clicking the bottom left button (with the Green Plus Symbol), Delete the bottom  most player (minimum 2 Players), by clicking the button on the bottom right (with the Red Minus Symbol), or Select one of your My Friend Groups using the bottom middle Button ",Color: "Blue")
        self.present(AC, animated: true, completion: nil)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
      /*  if SelectedGroup {
        
        GetGroupCoreData(GroupSelected)
        
        }
*/
    }
    
    func GetGroupCoreData(_ ReturnedGroup: NSString) {
        
       // NewGamePlayersName.removeAll()
       // NewGamePlayersContact.removeAll()
       // NewGamePlayers.removeAll()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //let fetchRequest = NSFetchRequest(entityName: "Person")
         let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Person")
      //  let error: NSError?
        
        do {
        let fetchedResults = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
        
        
        
        if let results = fetchedResults {
            Friends = results
            print(Friends)
            
            
            
            for items in Friends as [NSManagedObject] {
                
                let FName = items.value(forKey: "name") as! String
                
                let EmailAdd = items.value(forKey: "email") as! String
                
                let GroupNameObject = items.value(forKey: "group") as! String
                let UNID = items.value(forKey: "id") as! String
                
                print(items)
                print(items.value(forKey: "name")!)
                
                if GroupNameObject == ReturnedGroup as String {
                    
                    GroupPlayers.append(FName as NSString)
                    GroupContact.append(EmailAdd as NSString)
                    GroupIDs.append(UNID as NSString)
                    
                  //  FriendsName.append(FName)
                  //  FriendsEmail.append(EmailAdd)
                    
                    FriendsName.append(FName as NSString)
                    FriendsEmail.append(EmailAdd as NSString)
                  //  FriendsID.append(UNID)
                    
               
                    
                    
                    
                    GroupVariance = GroupNumbers.count
                    GroupVariance += 1
                    GroupNumbers.append(GroupVariance.description as NSString)
                    
                    //varNum = NumFriends.count
                    //varNum++
                    //NumFriends.append(varNum.description)
                    
                }
                //   theFriends.append(MyFriends(name:FName,email:EmailAdd))
                
            }
            print("Group Members are: \(GroupPlayers)")
            
          //  NewGamePlayersName = GroupPlayers
          //  NewGamePlayersContact = GroupContact
          //  NewNumbersArray = GroupNumbers
          //  UNIDArray = GroupIDs
            self.TableView.reloadData()
            
        }
        else {
          //  print("Could not fetch \(error), \(error!.userInfo)")
        }
        } catch {
            print(error)
        }
       // println("Friends Now: \(NameTable)")
    }
    
    @IBAction func FBLogin(_ sender: AnyObject) {
        
        // GetFBFriends()
        
        
       
        
        //sendGameInvite()
        
    }
    
    
    
    func appInviteDialog(_ appInviteDialog: FBSDKAppInviteDialog!, didCompleteWithResults results: [AnyHashable: Any]!) {
        print("did complete")
    }
    
    func appInviteDialog(_ appInviteDialog: FBSDKAppInviteDialog!, didFailWithError error: Error!) {
        print("did not complete: error = \(error)")
    }
    
    
    
      
    
    
    func didTouchUpInsidePickButton(_ row: Int) {
        let picker = ABPeoplePickerNavigationController()
        picker.peoplePickerDelegate = self
        print("ADDING NEW PERSON")
        
        //picker.displayedProperties = [NSNumber(int: kABPersonEmailProperty)]
        //picker.displayedProperties = [NSNumber(int: kABPersonPhoneMainLabel)]
        
        if picker.responds(to: #selector(getter: ABPeoplePickerNavigationController.predicateForEnablingPerson)) {
            //  picker.predicateForEnablingPerson = NSPredicate(format: "emailAddresses.@count > 0")
            // picker.predicateForEnablingPerson = NSPredicate
        }
        
        present(picker, animated: true, completion: nil)
    }
    func peoplePickerNavigationController(_ peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord, property: ABPropertyID, identifier: ABMultiValueIdentifier) {
        // let cell = ABMultiValueRef = ABRecordCopyValue(person, kABPersonPhoneMainLabel).takeRetainedValue()
        
        let multivalue: ABMultiValue = ABRecordCopyValue(person, property).takeRetainedValue()
        let index = ABMultiValueGetIndexForIdentifier(multivalue, identifier)
        let email = ABMultiValueCopyValueAtIndex(multivalue, index).takeRetainedValue() as! String
        //let cell = ABMultiValueCopyValue
        
        let fullnameString : CFString = ABRecordCopyCompositeName(person).takeRetainedValue()
        let fullname : NSString = fullnameString as NSString
        
        print("MultiValue: \(multivalue)")
        print("Email: \(email)")
        
        
        if email.contains("@") {
            
        } else {
            self.TextPlayerNames.append(fullname)
            self.TextPlayerContact.append(email as NSString)
            let theNumber = replaceRow + 1
            self.TextPlayerTurnNumber.append(theNumber.description as NSString)
        }
        
        //EmailInfo.append(email)
       // NameInfo.append(email)
       inputname = fullname
       inputcontact = email as NSString
        
        let item = inputname
        let itemcontact = inputcontact
        let itemID = "NA"
        
        UNIDArray.remove(at: replaceRow);
        NewGamePlayersName.remove(at: replaceRow);
        NewGamePlayersContact.remove(at: replaceRow);
        //      NameInfo.removeAtIndex(sourceIndexPath.row);
        
        UNIDArray.insert(itemID as NSString, at: replaceRow)
        NewGamePlayersName.insert(item, at: replaceRow)
        NewGamePlayersContact.insert(itemcontact, at: replaceRow)
        
        self.TableView.reloadData()

        
        
        
        //PlayerCount.append("NA")
        
        //self.TableView.reloadData()
        
    }
    
    
    func condenseWhitespace(_ string: String) -> String {
        let components = string.components(separatedBy: CharacterSet.whitespacesAndNewlines).filter({!$0.characters.isEmpty})
        return components.joined(separator: " ")
    }
    
    
    /*        let emails: ABMultiValueRef = ABRecordCopyValue(person, kABPersonEmailProperty).takeRetainedValue()
    if (ABMultiValueGetCount(emails) > 0) {
    let index = 0 as CFIndex
    let email = ABMultiValueCopyValueAtIndex(emails, index).takeRetainedValue() as! String
    
    println("first email for selected contact = \(email)")
    } else {
    println("No email address")
    }
    
    */
    
    
    func peoplePickerNavigationController(_ peoplePicker: ABPeoplePickerNavigationController, shouldContinueAfterSelectingPerson person: ABRecord, property: ABPropertyID, identifier: ABMultiValueIdentifier) -> Bool {
        peoplePickerNavigationController(peoplePicker, shouldContinueAfterSelectingPerson: person, property: property, identifier: identifier)
        peoplePicker.dismiss(animated: true, completion: nil)
        return false;
    }
    /*
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, shouldContinueAfterSelectingPerson person: ABRecordRef!) -> Bool {
    
    peoplePickerNavigationController(peoplePicker, didSelectPerson: person)
    
    peoplePicker.dismissViewControllerAnimated(true, completion: nil)
    
    return false;
    }
    */
    func peoplePickerNavigationControllerDidCancel(_ peoplePicker: ABPeoplePickerNavigationController) {
        peoplePicker.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if DidSelectGroup {
            
        return self.GroupPlayers.count;
            
        } else {
       // return self.NameInfo.count;
        return NewGamePlayers;
            
        }
    }
    
    
    func removeObject<T : Equatable>(_ object: T, fromArray array: inout [T])
    {
        let index = array.index(of: object)
        array.remove(at: index!)
    }
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let row = (indexPath as NSIndexPath).row
        let selectedResult = (indexPath as NSIndexPath).item
        
        let FriendsRow = NameInfo[row] as String
        
        print("Before deselect: \(FriendsName)")
        
        print("Row deselect: \(row)")
        // FriendsName.removeAtIndex(row)
        
        //if (row > 0) {
        
        //        if FriendsRow != "0" {
        
        
        
        let add = row + 1
        print("add one: \(add) Row = NA")
        FriendsName[add] = "NA"
        FriendsEmail[add] = "NA"
        
        varNum -= 1
        PlayerCount[row] = "NA"
        //        }
        
        //  }
        
        //  FriendsName = FriendsName.filter{$0 != FriendsRow}
        
        //   FriendsEmail.removeAtIndex(row)
        
        //   FriendsEmail = FriendsEmail.filter{$0 != FriendsRow}
        
        print("After deselect: \(FriendsName)")

        
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
        
        //  cell.numbers.hidden = true
        // cell.background = UIColor.clearColor()
        
        //    self.TableView.reloadData()
        
        if NumPlayers == 1 {
            NumPlayers = 1
        } else {
            NumPlayers -= 1
        }
        
        GameLBL.text = "Game Players : \(NumPlayers)"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = (indexPath as NSIndexPath).row
        let selectedResult = (indexPath as NSIndexPath).item
        
        print("Row selected: \(row)")
        print("Selected: \(selectedResult)")
        
        print("index path: \(indexPath)")
        

        
        self.TableView.reloadData()
     //   NumPlayers++
     //   GameLBL.text = "Game Players : \(NumPlayers)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.backgroundColor = UIColor.clear
        
        if (UNIDArray[(indexPath as NSIndexPath).row] as NSString).isEqual(to: "") || (UNIDArray[(indexPath as NSIndexPath).row] as NSString).isEqual(to: "NA") {
            
            cell.contentBTN?.isHidden = true
        } else {
            cell.contentBTN?.isHidden = false
            cell.contentBTN?.imageView?.image = UIImage(named: "YouIcon.png")
            cell.contentBTN?.tag = (indexPath as NSIndexPath).row
            cell.contentBTN?.addTarget(self, action: #selector(ConfirmPlayersViewController.ShowProfile(_:)), for: .touchUpInside)
            

        }
        
        
        if (indexPath as NSIndexPath).row == 0 {
            
                cell.numbers?.text = "1"
            
                cell.TableImageFB?.isHidden = true
                
                cell.TableImageCTs?.isHidden = true
                cell.TableImageGC?.isHidden = true
        } else {
            cell.TableImageFB?.isHidden = false
            
            cell.TableImageCTs?.isHidden = false
            cell.TableImageGC?.isHidden = false
        }
        
        
        if tableView == TableView {
            
            if DidSelectGroup {
                
                
                
                
                
                cell.titleLabel?.text = self.GroupPlayers[(indexPath as NSIndexPath).row] as String

                cell.numbers?.text = self.GroupNumbers[(indexPath as NSIndexPath).row] as String
                
                if self.GroupPlayers[(indexPath as NSIndexPath).row] == "NA" {
                    cell.titleLabel?.text = "Select Player ->"
                    
                   cell.cellViewBG?.layer.backgroundColor = UIColor.darkGray.cgColor
                    
                    if (indexPath as NSIndexPath).row == 0 {
                        
                         cell.cellViewBG?.layer.backgroundColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).cgColor
                        
                    } else {
                        
                    //cell.cellViewBG?.layer.backgroundColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).CGColor
                    
                    cell.TableImageFB?.imageView?.image = UIImage(named: "facebook-1.png")
                    cell.TableImageCTs?.imageView?.image = UIImage(named: "contacts.png")
                    
                    cell.TableImageCTs?.addTarget(self, action: #selector(ConfirmPlayersViewController.ContactsClicked(_:)), for: .touchUpInside)
                    
                    cell.TableImageCTs?.tag = (indexPath as NSIndexPath).row
                    
                    cell.TableImageFB?.addTarget(self, action: #selector(ConfirmPlayersViewController.FacebookClicked(_:)), for: .touchUpInside)
                    cell.TableImageFB?.tag = (indexPath as NSIndexPath).row
                    
                    cell.TableImageGC?.addTarget(self, action: #selector(ConfirmPlayersViewController.GameCenterClicked(_:)), for: .touchUpInside)
                    cell.TableImageGC?.tag = (indexPath as NSIndexPath).row
                    
                    
                    
                    
                    cell.TableImageGC?.imageView?.image = UIImage(named: "GameCenter.png")
                    }
                    
                } else {
                    cell.cellViewBG?.layer.backgroundColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).cgColor
                }
                
                
            } else {
            
            if self.NewGamePlayersName[(indexPath as NSIndexPath).row] == "NA" {
                cell.titleLabel?.text = "Select Player ->"
                cell.cellViewBG?.layer.backgroundColor = UIColor.darkGray.cgColor
                
            } else {
                cell.titleLabel?.text = self.NewGamePlayersName[(indexPath as NSIndexPath).row] as String
                cell.cellViewBG?.layer.backgroundColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).cgColor
                
            }
            
            
           // cell.titleLabel?.text = self.NameInfo[indexPath.row] as String
            
                if (indexPath as NSIndexPath).row == 0 {
                    
                } else {
            
            cell.numbers?.text = self.NewNumbersArray[(indexPath as NSIndexPath).row] as String

            cell.TableImageFB?.imageView?.image = UIImage(named: "GameFriends_blue3.png")
            cell.TableImageCTs?.imageView?.image = UIImage(named: "contacts.png")
            
            cell.TableImageCTs?.addTarget(self, action: #selector(ConfirmPlayersViewController.ContactsClicked(_:)), for: .touchUpInside)
            
            cell.TableImageCTs?.tag = (indexPath as NSIndexPath).row
            
            cell.TableImageFB?.addTarget(self, action: #selector(ConfirmPlayersViewController.PreviousFriendsClicked(_:)), for: .touchUpInside)
            cell.TableImageFB?.tag = (indexPath as NSIndexPath).row
            
            cell.TableImageGC?.addTarget(self, action: #selector(ConfirmPlayersViewController.GameCenterClicked(_:)), for: .touchUpInside)
            cell.TableImageGC?.tag = (indexPath as NSIndexPath).row

            
            
            
            cell.TableImageGC?.imageView?.image = UIImage(named: "GameCenter.png")
                }
            
            }
            
        }
        
 
        
        return cell
    }
    
    @IBAction func AddPlayer(_ sender: AnyObject) {
        
        if DidSelectGroup {
            
            if GroupVariance > 9 {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Player Limit Max"
                alertView.message = "You cannot add anymore players"
                alertView.delegate = self
                alertView.addButton(withTitle: "Ok")
//                alertView.show()
                
                let theAlert = SCLAlertView()
                theAlert.addButton("Ok") {
                }
                theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor.red, title: "Player Limit Max", subTitle: "You cannot add anymore players")
                
            } else {
             GroupVariance += 1
                GroupPlayers.append("NA")
                GroupContact.append("NA")
                GroupIDs.append("NA")
                GroupNumbers.append(GroupVariance.description as NSString)
                self.TableView.reloadData()
            }

            
        } else {
        
        if NewGamePlayers > 9 {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Player Limit Max"
            alertView.message = "You cannot add anymore players"
            alertView.delegate = self
            alertView.addButton(withTitle: "Ok")
          //  alertView.show()
            
            let theAlert = SCLAlertView()
            theAlert.addButton("Ok") {
            }
            theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor.red, title: "Player Limit Max", subTitle: "You cannot add anymore players")
            
            
        } else {
            NewGamePlayers += 1
            NewGamePlayersName.append("NA")
            NewGamePlayersContact.append("NA")
            UNIDArray.append("NA")
            NewNumbersArray.append(NewGamePlayers.description as NSString)
            self.TableView.reloadData()
         }
      }
        
        print("NewNumber Array = \(NewNumbersArray)")
        print("New Players Array = \(NewGamePlayersName)")
        print("New Players contact Array = \(NewGamePlayersContact)")
        print("New numbers INt Array = \(NewGamePlayers.description)")
    }
    
    @IBAction func DeletePlayer(_ sender: AnyObject) {
        
        if DidSelectGroup {
            
            /*
            if GroupVariance < 4 {
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Player Limit Minimum"
                alertView.message = "You have to have atleast 3 players to play"
                alertView.delegate = self
                alertView.addButtonWithTitle("Ok")
                alertView.show()
            } else {
                GroupVariance--
                GroupPlayers.removeLast()
                GroupContact.removeLast()
                GroupNumbers.removeLast()
                self.TableView.reloadData()
            }
   */
            
        } else {
        
        if NewGamePlayers < 3 {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Player Limit Minimum"
            alertView.message = "You have to have atleast 2 players to play"
            alertView.delegate = self
            alertView.addButton(withTitle: "Ok")
          //  alertView.show()
            
            
            let theAlert = SCLAlertView()
            theAlert.addButton("Ok") {
            }
            theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor.red, title: "Player Limit Miminum", subTitle: "You have to have atleast 2 players to play")
            
        } else {
            NewGamePlayers -= 1
            NewGamePlayersName.removeLast()
            NewGamePlayersContact.removeLast()
            NewNumbersArray.removeLast()
            UNIDArray.removeLast()
            self.TableView.reloadData()
        }
      }
        print("NewNumber Array = \(NewNumbersArray)")
        print("New Players Array = \(NewGamePlayersName)")
        print("New Players contact Array = \(NewGamePlayersContact)")
        print("New Players content rating = \(NewGameContentRating)")
        print("New numbers INt Array = \(NewGamePlayers.description)")
        
    }
    @objc func ContactsClicked(_ sender: UIButton!) {
        print("the Contacts tag: \(sender.tag)")
        
        replaceRow = sender.tag
        didTouchUpInsidePickButton(sender.tag)
        
        
    }
    

        
    @objc func FacebookClicked(_ sender: UIButton!) {
            replaceRow = sender.tag
            
            print("replace row selected: \(replaceRow)")
            
            
            let FBFriendViewController2 = self.storyboard?.instantiateViewController(withIdentifier: "FB Friends") as! FBFriendsViewController
            
         
            FBFriendViewController2.fdelegate = self
            
            
            FBFriendViewController2.modalPresentationStyle = .popover
            
            
            
         //   if FBSDKAccessToken.currentAccessToken() != nil {
                
                
            
                if let popoverControllerFB = FBFriendViewController2.popoverPresentationController {
                    // popoverController2.sourceView = sender as! UIView
                    popoverControllerFB.sourceView = self.view
                    // popoverController2.sourceView = getgroupsBTN.self as! UIView
                    //popoverController2.sourceRect = sender.bounds
                    let DeviceW = self.view.frame.width
                    let middleScreenW = DeviceW / 2
                    let middleX = middleScreenW - 100
                    
                    
                    popoverControllerFB.sourceRect = CGRect(x: middleX,y: 150,width: 0,height: 0)
                    
                 //   popoverControllerFB.permittedArrowDirections = nil
                    popoverControllerFB.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
                    
                    popoverControllerFB.delegate = self
                }
                self.present(FBFriendViewController2, animated: true, completion: nil)

        }
    
    func ParseJSON(_ jsonData: NSDictionary) -> [NSString] {
        
    var ParsedArray = [NSString]()
    
    var json = JSON(jsonData)
    
    //println("Json value: \(jsonData)")
    // println("Json valueJSON: \(json)")
    
    
    
    for result in json["fields"].arrayValue {
    
    
    if ( 1 == 1 ) {

    
    let FBName = result["first_name"].stringValue
   

    
   ParsedArray.append(FBName as NSString)
 
      }
    
     }
        return ParsedArray
    
    }
 
func getFBUserData() -> NSDictionary {
    if((FBSDKAccessToken.current()) != nil) {
        FBSDKGraphRequest(graphPath: "me/friends", parameters: ["fields": "id, name, friends, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
            if (error == nil) {
                self.dict = result as! NSDictionary
                print(result)
                print(self.dict)
              // //NSLog(self.dict.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as! String)
                //NSLog(self.dict.objectForKey("email")?!)
            
            }
        })
    }
       return self.dict 
}

    func GameCenterClicked_old(_ sender: UIButton!) {
     //   EasyGameCenter.findMatchWithMinPlayers(2, maxPlayers: 2)

    }
    
    @objc func PreviousFriendsClicked(_ sender: UIButton!) {
        
       
        replaceRow = sender.tag
        print("the gamecenter tag: \(sender.tag)")
        
        let GCFriendViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "GC Friends") as! RepeatFriendsViewController
        
        //let savingsInformationViewController = WeaponsViewController(nibName: "WeaponsMenu", bundle: nil)
        //  savingsInformationViewController.delegate=self
        
        //   savingsInformationViewController.weaponPKLabel=weaponLabel.text
        GCFriendViewController.rdelegate = self
        
        
        GCFriendViewController.modalPresentationStyle = .popover
        if let popoverControllerGC = GCFriendViewController.popoverPresentationController {
            // popoverController2.sourceView = sender as! UIView
            popoverControllerGC.sourceView = self.view
            // popoverController2.sourceView = getgroupsBTN.self as! UIView
            //popoverController2.sourceRect = sender.bounds
            let DeviceW = self.view.frame.width
            let middleScreenW = DeviceW / 2
            let middleX = middleScreenW - 100
            
            popoverControllerGC.sourceRect = CGRect(x: middleX,y: 150,width: 0,height: 0)
            
           // popoverControllerGC.permittedArrowDirections = nil
            popoverControllerGC.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
            
            popoverControllerGC.delegate = self
        }
        present(GCFriendViewController, animated: true, completion: nil)
        
        
        
       // self.TableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "Turn_Complete" {
            
            
            if let destination = segue.destination as? GameStartedViewController {
                
              //  destination.StartedAGame = true
                destination.username = self.username as NSString
                destination.userID = self.myID as NSString
                destination.PlayerNames = self.TextPlayerNames
                destination.TextPlayerContact = self.TextPlayerContact
                destination.TextPlayerTurnNumber = self.TextPlayerTurnNumber
                destination.GameID = self.GameID
                destination.GameStyleInfo = self.NewGameFirstTurn
               // destination.ShowB2 = true
              //  destination.playerID = self.profileID
                print("Starting A Game")
            }
        }

        
        
        if segue.identifier == "ShowProfile" {
            
       
            if let destination = segue.destination as? LevelInfoViewController {
          
            destination.OtherUserProfile = self.OtherUserProfile
            destination.ShowB2 = true
            destination.playerID = self.profileID
            print("Profile show segue")
            }
        }

        
        
        if segue.identifier == "Group Picker" {
            let GroupPickerViewController = segue.destination 
            GroupPickerViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            
            GroupPickerViewController.popoverPresentationController!.delegate = self
            
         
        }
        
        if segue.identifier == "GC Friends" {
            
            let RepeatFriendViewController = segue.destination 
            RepeatFriendViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            
            RepeatFriendViewController.popoverPresentationController!.delegate = self
            
            if let destination = segue.destination as? RepeatFriendsViewController {
            
            destination.RowSelected = replaceRow
            
            }
    
        }
        
        
        if segue.identifier == "FB Friends" {
            
            let FBFriendViewController = segue.destination 
            FBFriendViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            
            FBFriendViewController.popoverPresentationController!.delegate = self
            
            if let destination = segue.destination as? FBFriendsViewController {
                
                destination.RowSelected = replaceRow
                
             
                
            }
            
        }
        
       
      
    }
  
   // @IBAction func FBFriendPick(sender: AnyObject) {
    
    @IBAction func ShowProfile(_ sender: AnyObject) {
        
        replaceRow = sender.tag
        profileID = UNIDArray[replaceRow]
        self.performSegue(withIdentifier: "ShowProfile", sender: self)
        
    }
    
    @IBAction func GameCenterClicked(_ sender: AnyObject) {
        
        if GAMECENTERLOGGEDIN {
        
        replaceRow = sender.tag
        print("the gamecenter tag: \(sender.tag)")
    
        
        let fbfriendViewController = storyboard?.instantiateViewController(withIdentifier: "FB Friends") as! FBFriendsViewController
        
        //let savingsInformationViewController = WeaponsViewController(nibName: "WeaponsMenu", bundle: nil)
        //  savingsInformationViewController.delegate=self
        
        //   savingsInformationViewController.weaponPKLabel=weaponLabel.text
        fbfriendViewController.fdelegate = self
        
        
        fbfriendViewController.modalPresentationStyle = .popover
        if let popoverControllerfb = fbfriendViewController.popoverPresentationController {
            // popoverController2.sourceView = sender as! UIView
            popoverControllerfb.sourceView = self.view
            // popoverController2.sourceView = getgroupsBTN.self as! UIView
            //popoverController2.sourceRect = sender.bounds
            let DeviceW = self.view.frame.width
            let middleScreenW = DeviceW / 2
            let middleX = middleScreenW - 100
            
            popoverControllerfb.sourceRect = CGRect(x: middleX,y: 150,width: 50,height: 50)
            
        //    popoverControllerfb.permittedArrowDirections = nil
            popoverControllerfb.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
            
            popoverControllerfb.delegate = self
        }
        present(fbfriendViewController, animated: true, completion: nil)
        
        } else {
            
            
            DispatchQueue.main.async(execute: {
                
                
                let theAlert = SCLAlertView()
                
                theAlert.addButton("Ok", action: {
                     DispatchQueue.main.async(execute: {
                    self.LogIntoGameCenter()
                    })
                })
                    
                    theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Center", subTitle: "Login to Game Center", duration: nil, completeText: "Cancel", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
            
            
        }
        
    }
    
    @IBAction func GroupPick(_ sender: AnyObject) {
        
        let savingsInformationViewController = storyboard?.instantiateViewController(withIdentifier: "Group Picker") as! GroupPickerViewController
        
        //let savingsInformationViewController = WeaponsViewController(nibName: "WeaponsMenu", bundle: nil)
        //  savingsInformationViewController.delegate=self
        
        //   savingsInformationViewController.weaponPKLabel=weaponLabel.text
        savingsInformationViewController.adelegate = self
        
        
        savingsInformationViewController.modalPresentationStyle = .popover
        if let popoverController2 = savingsInformationViewController.popoverPresentationController {
            // popoverController2.sourceView = sender as! UIView
            popoverController2.sourceView = self.view
            // popoverController2.sourceView = getgroupsBTN.self as! UIView
            //popoverController2.sourceRect = sender.bounds
            let DeviceW = self.view.frame.width
            let middleScreenW = DeviceW / 2
            let middleX = middleScreenW - 100
            
            
            popoverController2.sourceRect = CGRect(x: middleX,y: 150,width: 0,height: 0)
            
        //    popoverController2.permittedArrowDirections = nil
            popoverController2.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
            
            popoverController2.delegate = self
        }
        present(savingsInformationViewController, animated: true, completion: nil)
        
        
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    @IBAction func editTableView(_ sender: AnyObject) {
        
        if TableView.isEditing{
            TableView.setEditing(false, animated: false)
            editBTN.style = UIBarButtonItem.Style.plain;
            editBTN.title = "Edit";
            TableView.reloadData()
        } else {
            TableView.setEditing(true, animated: true)
            editBTN.title = "Done";
            editBTN.style = UIBarButtonItem.Style.done;
            TableView.reloadData()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (indexPath as NSIndexPath).row == 0 {
            
        } else {
        
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            if DidSelectGroup {
                
            } else {
            NameInfo.remove(at: (indexPath as NSIndexPath).row)
            EmailInfo.remove(at: (indexPath as NSIndexPath).row);
                UNIDArray.remove(at: (indexPath as NSIndexPath).row);
            //  NameInfo.removeAtIndex(indexPath.row)
            self.editTableView(editBTN)
            TableView.reloadData()
            }
        } else if editingStyle == UITableViewCell.EditingStyle.insert{
            //Friends.append("New Item")
            //NameTable.append("New Item")
            if DidSelectGroup {
                
            } else {
            
             EmailInfo.append("New Item");
              NameInfo.append("New Name");
                UNIDArray.append("NA");
            }
        }
         
      }
        
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if (indexPath as NSIndexPath).row == 0 {
            return false;
        } else {
        
        return true;
    
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        if (sourceIndexPath as NSIndexPath).row == 0 || (destinationIndexPath as NSIndexPath).row == 0 {
            
            print("tried to move to indexPath.row 0.  You can't replace Player 1")
            
        } else {
        
        if DidSelectGroup {
            
        
        }  else {
        let item : String = NameInfo[(sourceIndexPath as NSIndexPath).row] as String;
        //  let item : String = EmailInfo[sourceIndexPath.row] as String;
        //  let item2 : String = NameInfo[sourceIndexPath.row] as String;
        NameInfo.remove(at: (sourceIndexPath as NSIndexPath).row);
        NewGamePlayersName.remove(at: (sourceIndexPath as NSIndexPath).row);
        NewGamePlayersContact.remove(at: (sourceIndexPath as NSIndexPath).row);
        EmailInfo.remove(at: (sourceIndexPath as NSIndexPath).row);
        UNIDArray.remove(at: (sourceIndexPath as NSIndexPath).row);
        //      NameInfo.removeAtIndex(sourceIndexPath.row);
        
        NameInfo.insert(item as NSString, at: (destinationIndexPath as NSIndexPath).row)
        NewGamePlayersName.insert(item as NSString, at: (destinationIndexPath as NSIndexPath).row);
        NewGamePlayersContact.insert(item as NSString, at: (destinationIndexPath as NSIndexPath).row);
        EmailInfo.insert(item as NSString, at: (destinationIndexPath as NSIndexPath).row)
        UNIDArray.insert(item as NSString, at: (destinationIndexPath as NSIndexPath).row);
        //      NameInfo.insert(item2, atIndex: destinationIndexPath.row)
          }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func backBTN(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func StartGame(_ sender: AnyObject) {
        
        print("new game players count = \(NewGamePlayersName.count)")
        
        print("new game contact count = \(NewGamePlayersContact.count)")
        
        
        var notReady = Bool()
        
        for names in NewGamePlayersName {
            
            if names == "NA" {
                notReady = true
            }
            
        }
        
        
        if notReady {
            
               SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Unknown Players?", subTitle: "Please reduce the number of players or assign a player to each slot", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
            
        } else {
         print("new game players  = \(NewGamePlayers)")
        
        
        if Reachability.isConnectedToNetwork() {
        
        
        Player1Email = "-"
        Player1ID = myID as NSString
        let Player1Temp: NSString = username as NSString
        print("player i d= \(Player1ID)")
        print("player 1 name = \(Player1)")
        
        if Player1ID.isEqual(to: "") || Player1Temp.isEqual(to: "") {
            
            let AC = JSController("Error Loading User Profile", MyMessage: "Please confirm you are logged in before starting a new game.",Color: "Red")
            //self.presentViewController(AC, animated: true, completion: nil)
            
            
            let theAlert = SCLAlertView()
            theAlert.addButton("Ok") {
            }
            theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor.red, title: "Error Loading User Profile", subTitle: "Please confirm you are logged in")
  
            
        } else {
        
            
          if NewGamePlayersName[1].isEqual(to: "-") || NewGamePlayersName[1].isEqual(to: "") || NewGamePlayersName[1].isEqual(to: "NA") {
            
            DispatchQueue.main.async(execute: {
                
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Player 2?", subTitle: "Please assign Player 2", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            })
           
          } else {
            
        
        self.view.addSubview(self.NewGameProgressHUD)
        
        //dispatch_async(dispatch_get_main_queue
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: { () -> Void in
            self.createGame()
            //self.ActInd.stopAnimating()
        });
      }
    }
        
        
    } else {
    
            DispatchQueue.main.async(execute: {
                
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Connection Error!", subTitle: "Check your network settings", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
    }
    
        }
        
        
    }
    
      func createGame() {
      //  var progressHUD = ProgressHUD(text: "Creating New Game...")
      //  self.view.addSubview(progressHUD)
        
        print("Startin Game")
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
        // username = txtUsername.text as NSString
        let GameName:NSString = NewGameTitle
        let Player1:NSString = NameInfo[0]
        
       // Player1Email = myemail
        Player1Email = "-"
        Player1ID = myID as NSString
      //  let te = "jaredstevens10@yahoo.com"
      //  var tc = "13214364915"
        var itemsCT = 0
        
        for items in NameInfo {
            if items == "NA" {
                self.NameInfo.remove(at: itemsCT);
                self.EmailInfo.remove(at: itemsCT);
                self.UNIDArray.remove(at: itemsCT);
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
            QuoteBoxtext = NewGameQuote
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
        
        
            print("NEW POST STRING: \(post)")
            
            
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
                
                if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
                {
                    let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
                    
                   //NSLog("Response ==> %@", responseData);
                    
                    print("Response Confirm Players: \(responseData)")
                    
                    //var error: NSError?
                    
                    let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
                    
                    
                    let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
                    let NewGameID:NSInteger = jsonData.value(forKey: "gameid") as! NSInteger
    
                    
                    self.GameID = NewGameID.description as NSString
                    print("THE NEW GAME ID = \(NewGameID)")
                    //[jsonData[@"success"] integerValue];
                    
                   //NSLog("Success: %ld", success);
                    
                    if(success == 1)
                    {
                       //NSLog("New Game SUCCESS");
                        //self.dismissViewControllerAnimated(true, completion: nil)
                        
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Success!"
                        alertView.message = "Your Game has been created.  Each player is getting a message now about the new game now."
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                       // alertView.show()
                        
                        if DoUploadImage {
                            
                            if MediaType == "audio" {
                                
                            print("SHOULD UPLOAD AUDIO NOW")
                            UploadGameFileData(audioData as String, FileName: "Game\(NewGameID)Turn1", Type: "audio")
                            } else if MediaType == "gif" {
                                
                                UploadGameFileData(picData as String, FileName: "Game\(NewGameID)Turn1", Type: "gif")
                            
                                
                            }else {
                            
                            print("SHOULD UPLOAD IMAGE NOW")
                            UploadGameFileData(picData as String, FileName: "Game\(NewGameID)Turn1", Type: "image")
                            }
                        } else {
                            
                            let TempImageCurrent = CreateTempImage(NewGameQuote as String)
                            
                            UploadGameFile(TempImageCurrent, FileName: "Game\(NewGameID)Turn1", Type: "image")
                            
                            
                        }
                      //  self.performSegueWithIdentifier("Turn_Complete", sender: self)
                        
                    //NEED TO ADD NSNotification to go back to Home
                        
                        
                    } else {
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
                        
                    }
                    
                } else {
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign Up Failed!"
                    alertView.message = "Connection Failed"
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                 //   alertView.show()
                }
            }  else {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign in Failed!"
                alertView.message = "Connection Failure"
                if let error = reponseError {
                    alertView.message = (error.localizedDescription)
                }
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
              //  alertView.show()
            }
       // }
        
        DispatchQueue.main.async(execute: {
            self.NewGameProgressHUD.removeFromSuperview()
            
             DispatchQueue.main.async(execute: {
            self.performSegue(withIdentifier: "Turn_Complete", sender: self)
              })
            })
            
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
        
    }
    
    /*
   func ActionFindPlayer() {
    
        println("finding player")
        EasyGameCenter.findMatchWithMinPlayers(2, maxPlayers: 4)
    }
    
*/
    func easyGameCenterMatchRecept(_ match: GKMatch, didReceiveData data: Data, fromPlayer playerID: String) {
        
        print("\n[MultiPlayerActions Recept From player = \(playerID)", terminator: "")
        /*
        let autre = Packet.unarchive(data)
        
        
        print("\n[MultiPlayerActions Recept packet.name = \(autre.name)")

        print("\n[MultiPlayerActions Recept packet.index = \(autre.index)")
        */
        
    }
    
    
    
    //let GCPlayer: CGLocalPlayer  = GKLocalPlayer
    //func loadFriendPlayersWithCompletionhandler(
    
    
    
    /*
    func GameLogin () -> [NSString] {
        println("login called")
        //localPlayer = GKLocalPlayer.local
        
        //var FriendList = [NSString]()
        
        localPlayer.authenticateHandler = {(ViewController: UIViewController!, error: NSError!) -> Void in
            if ((ViewController) != nil) {
                println("VC True")
                self.presentViewController(ViewController, animated: true, completion: nil)
                
                
            } else if self.localPlayer.authenticated {
              //  self.gcEnabled = true
                println("Player authenticated")
                
                //self.player = localPlayer.displayName
               // self.playerid = self.localPlayer.playerID
               // self.player = self.localPlayer.alias
                
              //  println("player: \(self.player)")
              //  println("playerid: \(self.playerid)")
                
                var sameuserTest = false
                
               // var GCFriends = [NSString]()
                //var GCError = NSString()
                
             //   self.localPlayer.loadFriendsWithCompletionHandler({ (GCFriends, GCError) -> Void in
                    
            //    })
               /*
                self.localPlayer.loadFriendPlayersWithCompletionHandler({ (GCFriends: NSArray, error: NSError) -> Void in
                    println("TEST")
                    println("GCFriend = \(GCFriends)")
                    FriendList = GCFriends
                })
*/
                
                self.localPlayer.loadFriendPlayersWithCompletionHandler({ (GCFriends) -> Void in
                    println("TEST")
                    println("My GameCenter Friends: \(GCFriends)")
                    
                    var FriendList = GCFriends
                  //  var Friends1 = GCFriends[0]
                  //  var FriendsError = GCFriends[1]
                  //  println("List = \(Friends1)")
                  //  println("Error = \(FriendsError)")
                })
                
                
            } else {
               
                println("Local player could not be authenticated, disableing game")
               // println("Authentifcate error: \(error)")
              //  println("Player NOT authenticated")
                
                //self.player = ""

            }
            
        }
        return FriendList
    }

*/
    
  //  func loadFriendPlayersWithCompletionHandler(
        
    
    func LogIntoGameCenter() -> Bool {
        
        print("Logging into game center")
        var gameCenterEnabled2 = Bool()
        
        //REVIEW BELOW
        //var localPlayer = getLocalPlayer() // see GKLocalPlayerHack.h
        print("Local Player = \(localPlayer)")
       // print("GCError ViewShowing = \(GCErrorViewShowing)")
        
        
        localPlayer.authenticateHandler =
            { (viewController : UIViewController?, error : Error?) -> Void in
                if viewController != nil
                {
                    print("should present ViewController for Game Center")
                    self.present(viewController!, animated:true, completion: nil)
                }
                else
                {
                    
                    /*
                    
                    print("Local Player Auth = \(localPlayer.authenticated)")
                    
                    if localPlayer.playerID == nil {
                    print("the player ID is nil")
                    
                    self.presentViewController(viewController!, animated:true, completion: nil)
                    
                    } else {
                    print("player ID = \(localPlayer.playerID)")
                    }
                    */
                    
                    
                    
                    if self.localPlayer.isAuthenticated
                    {
                        // print("GCErrorViewShowing = \(self.GCErrorViewShowing)")
                        
                        /*
                        
                        if self.GCErrorViewShowing {
                            
                            UIView.animateWithDuration(1.0, animations: { () -> Void in
                                self.GameCenterErrorHolder.center.y = self.GameCenterErrorHolder.center.y + 1050
                                self.GCErrorViewTOP.constant = 1000
                            })
                            
                            self.menuButton.enabled = true
                            self.helpBTN.enabled = true
                            self.revealViewController().panGestureRecognizer().enabled = true
                            self.GCErrorViewShowing = false
                            
                        }
                        
                        */
                        
                        gameCenterEnabled2 = true
                        self.GAMECENTERLOGGEDIN = true
                        UserDefaults.standard.set(true, forKey: "GameCenterEnabled")
                        // self.PlayerIsLoggedInToGameCenter = true
                        
                       // print("GameCenter Enabled = \(self.gameCenterEnabled)")
                        
                        
                        //self.player = localPlayer.displayName
                        self.GCplayerid = self.localPlayer.playerID as NSString
                        self.GCplayer = self.localPlayer.alias as NSString
                        
                        print("player: \(self.GCplayer)")
                        print("playerid: \(self.GCplayerid)")
                        
                        var sameuserTest = false
                        
                        /*
                        if (self.prefs.valueForKey("USERNAME") != nil) {
                            if (self.player.description == self.prefs.valueForKey("USERNAME")?.description) {
                                sameuserTest = true
                            } else {
                                sameuserTest = false
                            }
                        }
                        */
                        
                        print("SETTING COREDATA FOR PLAYER NAME AND ID")
                      //  self.prefs.setValue(self.GCplayer, forKey: "USERNAME")
                     //   let PlayerIDEdit = self.GCplayerid.stringByReplacingOccurrencesOfString(":", withString: "")
                        
                       // self.prefs.setValue(PlayerIDEdit, forKey: "PLAYERID")
                        //self.prefs.setValue(self.playerid, forKey: "PLAYERID")
                        
                        
                       // self.usernameLabel.text = ("Welcome back \(self.player)")
                        
                        
                        //self.welcometxt = self.prefs.valueForKey("USERNAME") as! NSString as String
                      //  self.userID = self.prefs.valueForKey("PLAYERID") as! NSString as String
                        
                        

                        
                        /*
                        
                        
                        localPlayer.loadDefaultLeaderboardIdentifierWithCompletionHandler
                        { (leaderboardIdentifier, error) -> Void in
                        if error != nil
                        {
                        print("error")
                        }
                        else
                        {
                        self.leaderboardIdentifier = leaderboardIdentifier
                        print("\(self.leaderboardIdentifier)") //in your example "VHS" should be returned
                        
                        
                        
                        
                        
                        
                        
                        }
                        }
                        
                        */
                        
                    }
                    else
                    {
                        print("not able to authenticate fail")
                        gameCenterEnabled2 = false
                        //self.PlayerIsLoggedInToGameCenter = false
                        
                        if (error != nil)
                        {
                        //    print("\(error!.description)")
                            print("SHould Show GCError View2")
                            
                            /*
                            
                            if !self.GCErrorViewShowing {
                                
                                print("should be showing now")
                                UIView.animateWithDuration(1.0, animations: { () -> Void in
                                    
                                    
                                    self.GameCenterErrorHolder.center.y = self.GameCenterErrorHolder.center.y - 1050
                                    
                                    self.GCErrorViewTOP.constant = -50
                                    
                                })
                                
                                
                                self.menuButton.enabled = false
                                self.revealViewController().panGestureRecognizer().enabled = false
                                self.helpBTN.enabled = false
                                
                                self.GCErrorViewShowing = true
                            }
                            
                            */
                            
                        }
                        else
                        {
                            print(    "error is nil")
                        }
                    }
                }
        }
        return gameCenterEnabled2
    }
    
    
    
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController!)
    {
        gameCenterViewController.dismiss(animated: true, completion: nil)
        
        IsPlayerLoggedInGC = LogIntoGameCenter()
        
        print("After GCVC Did Finish, is player logged in = \(IsPlayerLoggedInGC)")
        
    }
    

}



extension ConfirmPlayersViewController {
    
//}: GroupPickerViewControllerDelegate {
    func GroupPickerViewControllerFinished(_ grouppickerviewController: GroupPickerViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        self.GroupData = grouppickerviewController.GroupData
        
        
        //NameData = GroupData[0] as! [(NSString)]
        //println("Member Data Name = \(NameData)")
        //ContactData = GroupData[1] as! [(NSString)]
        //println("Member Data Contact = \(ContactData)")
        
        self.GroupSelected = grouppickerviewController.TheGroup
        print("The group \(GroupSelected) was selected")
        
        if self.GroupSelected != "" {
            self.DidSelectGroup = true
            
             GetGroupCoreData(GroupSelected)
            
        } else {
            self.DidSelectGroup = false
        }
        
        //self.performSegueWithIdentifier("Add_Quote", sender: self)
        //= // self.armorBTN.setImage(armorviewController.armorPKimage, forState:.Normal)
        
        
        //= settingsViewController.weaponPKimage
        
    }
}

extension ConfirmPlayersViewController {
    
//}: RepeatFriendsViewControllerDelegate {
    func RepeatFriendsViewControllerFinished(_ repeatfriendsviewController: RepeatFriendsViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        self.GCFriendName = repeatfriendsviewController.GCFriendName
        
        //self.GCFriendContact = repeatfriendsviewController.GCFriendContact
        self.GCFriendContact = "PUSH"
       // self.GCFriendID = "TBD"
        self.GCFriendID = repeatfriendsviewController.GCFriendID
        
        
        self.SelectedGCFriend = repeatfriendsviewController.SelectedGCFriend
       // self.replaceRow = repeatfriendsviewController.RowSelected
        
        
        
        self.NewGamePlayersName.remove(at: self.replaceRow);
        self.NewGamePlayersContact.remove(at: self.replaceRow);
        self.UNIDArray.remove(at: self.replaceRow);
       // self.NameInfo.removeAtIndex(self.replaceRow);
      //  self.EmailInfo.removeAtIndex(replaceRow);
        
        
        self.NewGamePlayersName.insert(self.GCFriendName, at: self.replaceRow);
        
        self.NewGamePlayersContact.insert(self.GCFriendContact, at: self.replaceRow);
        
        self.UNIDArray.insert(self.GCFriendID, at: self.replaceRow);
        
        print("Game Center replace at Row: \(self.replaceRow)")

       // self.NameInfo.insert(self.GCFriendName, atIndex: self.replaceRow);
       // self.EmailInfo.insert(self.GCFriendContact, atIndex: self.replaceRow);
        
        
        if self.SelectedGCFriend {
            self.DidSelectGCFriend = true
            
            
            //REPLACE REPEAT FRIEND with current NA
            
            //GetGroupCoreData(GroupSelected)
            
        } else {
            self.DidSelectGCFriend = false
        }
    
        
       /* self.GroupSelected = repeatfriendsviewController.TheGroup
        println("The group \(GroupSelected) was selected")
        
        if self.GroupSelected != "" {
            self.DidSelectGroup = true
            
            GetGroupCoreData(GroupSelected)
            
        } else {
            self.DidSelectGroup = false
        }
        */
        
        self.TableView.reloadData()
    
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
        
        var textFontAttributes: [NSAttributedString.Key : Any]?
        
        
        if let actualFont = font {
            textFontAttributes = [NSAttributedString.Key.font: actualFont, NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.paragraphStyle: textStyle]
            
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
    
}



extension ConfirmPlayersViewController {
    //}: FBFriendsViewControllerDelegate {
    func FBFriendsViewControllerFinished(_ fbfriendsviewController: FBFriendsViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        self.FBFriendName = fbfriendsviewController.FBFriendName
        
        self.FBFriendContact = fbfriendsviewController.FBFriendContact
        self.FBFriendID = fbfriendsviewController.FBFriendContact
        
        print("FaceBook friend:\(self.FBFriendName)")
        
        print("FaceBook friend ID:\(self.FBFriendContact)")
        
        self.SelectedFBFriend = fbfriendsviewController.FBSelected
        //self.replaceRow = fbfriendsviewController.RowSelected
        
        self.NewGamePlayersName.remove(at: self.replaceRow);
        
        self.NewGamePlayersContact.remove(at: self.replaceRow);
        
        self.UNIDArray.remove(at: self.replaceRow);
        print("Facebook replace at Row: \(self.replaceRow)")
        
     //   self.NameInfo.removeAtIndex(self.replaceRow);
        
     //   self.EmailInfo.removeAtIndex(replaceRow);
        //      NameInfo.removeAtIndex(sourceIndexPath.row);
        
        self.UNIDArray.insert(self.FBFriendID, at: self.replaceRow)
        
        self.NewGamePlayersName.insert(self.FBFriendName, at: self.replaceRow)
        self.NewGamePlayersContact.insert(self.FBFriendContact, at: self.replaceRow);
        
        self.TableView.reloadData()
        
      //  self.NameInfo.insert(self.FBFriendName, atIndex: self.replaceRow)
     //   self.EmailInfo.insert(self.FBFriendContact, atIndex: self.replaceRow)
        
        
        
        
        /* self.GroupSelected = repeatfriendsviewController.TheGroup
        println("The group \(GroupSelected) was selected")
        
        if self.GroupSelected != "" {
        self.DidSelectGroup = true
        
        GetGroupCoreData(GroupSelected)
        
        } else {
        self.DidSelectGroup = false
        }
        */
        
    }
}
