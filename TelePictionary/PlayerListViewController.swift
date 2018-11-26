//
//  PlayerListViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 9/3/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import AddressBookUI
import CoreData
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
import MessageUI

class PlayerListViewController: UIViewController, ABPeoplePickerNavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate, UIActionSheetDelegate, UIAlertViewDelegate, FBSDKAppInviteDialogDelegate, UIPopoverPresentationControllerDelegate, RepeatFriendsViewControllerDelegate, FBFriendsViewControllerDelegate, MFMessageComposeViewControllerDelegate, GKGameCenterControllerDelegate {
    
//}, EasyGameCenterDelegate {
    
    var IsPlayerLoggedInGC = Bool()
    var localPlayer = GKLocalPlayer.localPlayer()
    var GAMECENTERLOGGEDIN = Bool()
    var GCplayer = NSString()
    var GCplayerid = NSString()
    
    
    @IBOutlet weak var helpButton: UIButton!
    
    @IBOutlet weak var titleLBL: UILabel!
    let prefs = UserDefaults.standard
    var SelectedPlayer = NSString()
    var GCFriendID = NSString()
    var ViewHowTo = Bool()
    var SendingEmail = Bool()
    @IBOutlet var View1CloseBTN: UIButton!
    var ContentRating = NSString()
    @IBOutlet var ViewHolderTOP: NSLayoutConstraint!
    @IBOutlet var View1TOP: NSLayoutConstraint!
    @IBOutlet var View1: UIView!
    @IBOutlet var ViewHolder: UIView!
    @IBOutlet var ActInd: UIActivityIndicatorView!
    @IBOutlet weak var gameStatusLBL: UILabel!
    var JustViewingPlayers = Bool()
    @IBOutlet weak var statusSwitch: UISwitch!
    
    var Visibility = NSString()
    var PlayerIDs = [NSString]()
    var Replaced_New_Name = NSString()
    var Replaced_New_Contact = NSString()
    var NewUser = NSString()
    var UserSelected = NSString()
    var PlayerRowSelected = Int()
    var GameSelected = NSString()
    var GameSelected2 = NSString()
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
    var PlayerNames = [NSString]()
    var username = NSString()
    //var GameStyle = NSString()
     var currentTurn = String()
    var GameID = NSString()
    var UserSelectedID = NSString()
    
    var PlayerCount = ["1","2","3","4","5","6","7","8","9","10"]
    
    var PlayerTurnIndex = [Bool]()
    
    let OtherUserProfile = true
    var profileID = NSString()

    
    @IBOutlet weak var TableView: UITableView!
    
    
    
    //////
    
    var repeatfriendsviewcontroller: RepeatFriendsViewController = RepeatFriendsViewController()
    
    var fbfriendsviewcontroller: FBFriendsViewController = FBFriendsViewController()
    
    
    
    let index = 10
    var myemail = String(0)
    var groupName = NSString()
    
    //@IBOutlet weak var editBTN: UIBarButtonItem!
    
    
    
    var theFriends = [MyFriends]()
    
    var Friends = [NSManagedObject]()
    var FriendsName = [NSString]()
    var FriendsEmail = [NSString]()
    var NameTable = [NSString]()
    var FriendsInfo = [NSString]()
    var EmailTable = [NSString]()
    var NameInfo = [NSString]()
    var EmailInfo = [NSString]()
    var numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    var NumSelected = [Int]()
    
    var varNum = Int()
    var userIDSelected = NSString()
    var numPlayers = Int()
    var NumFriends = [Int]()
    var CurNum = Int()
    var NumMembers = Int()
    
    var dict = NSDictionary()
    
    var FBFriendID = NSString()
    var replaceRow = Int()
    
    var GCFriendName = NSString()
    var GCFriendContact = NSString()
    
    var FBFriendName = NSString()
    var FBFriendContact = NSString()
    
    var DidSelectGroup = Bool()
    var DidSelectGCFriend = Bool()
    var SelectedGCFriend = Bool()
    var DidSelectedFBFriend = Bool()
    var SelectedFBFriend = Bool()
    
    var ReloadView = NSString()
    
    var TurnUser = NSString()
    var GameData = [NSArray]()
    var Game_Data_Array = [NSString]()
    
    var GameIDInfo = NSString()
    
    var Player1Info  = NSString()
    
    var Player2Info = NSString()
    var Player3Info = NSString()
    var Player4Info = NSString()
    var Player5Info = NSString()
    var Player6Info = NSString()
    var Player7Info = NSString()
    var Player8Info = NSString()
    var Player9Info = NSString()
    var Player10Info = NSString()
    var Turn1Info = NSString()
    var Turn2Info = NSString()
    var Turn3Info = NSString()
    var Turn4Info = NSString()
    var Turn5Info = NSString()
    var Turn6Info = NSString()
    var Turn7Info = NSString()
    var Turn8Info = NSString()
    var Turn9Info = NSString()
    var Turn10Info = NSString()
    var TurnNumberInfo = NSString()
    var IsCompleteInfo = NSString()
    var UsersTurnInfo = NSString()
    var GameStyleInfo = NSString()
    
    var GameNameInfo = NSString()
    
    var TurnData = [NSString]()

    
    ////
    //var GameData = NSData()
    
    override func viewDidAppear(_ animated: Bool) {
        
        ActInd.startAnimating()
        let URLData = CompleteGameData(GameID, username: username)
        
        var GameInfo = FilterGameData(URLData)
        
        print("Game Info: \(GameInfo)")
        
        //QuoteBox.append(QBoxImage!)
        
        GameNameInfo = GameInfo[0] as NSString
        GameIDInfo = GameInfo[1] as NSString
        Player1Info = GameInfo[2] as NSString
        Player2Info = GameInfo[3] as NSString
        Player3Info = GameInfo[4] as NSString
        Player4Info = GameInfo[5] as NSString
        Player5Info = GameInfo[6] as NSString
        Player6Info = GameInfo[7] as NSString
        Player7Info = GameInfo[8] as NSString
        Player8Info = GameInfo[9] as NSString
        Player9Info = GameInfo[10] as NSString
        Player10Info = GameInfo[11] as NSString
        Turn1Info = GameInfo[12] as NSString
        Turn2Info = GameInfo[13] as NSString
        Turn3Info = GameInfo[14] as NSString
        Turn4Info = GameInfo[15] as NSString
        Turn5Info = GameInfo[16] as NSString
        Turn6Info = GameInfo[17] as NSString
        Turn7Info = GameInfo[18] as NSString
        Turn8Info = GameInfo[19] as NSString
        Turn9Info = GameInfo[20] as NSString
        Turn10Info = GameInfo[21] as NSString
        GameStyleInfo = GameInfo[22] as NSString
        
        
        PlayerNames.append(Player1Info)
        PlayerNames.append(Player2Info)
        PlayerNames.append(Player3Info)
        PlayerNames.append(Player4Info)
        PlayerNames.append(Player5Info)
        PlayerNames.append(Player6Info)
        PlayerNames.append(Player7Info)
        PlayerNames.append(Player8Info)
        PlayerNames.append(Player9Info)
        PlayerNames.append(Player10Info)
        
        TurnData.append(Turn1Info)
        TurnData.append(Turn2Info)
        TurnData.append(Turn3Info)
        TurnData.append(Turn4Info)
        TurnData.append(Turn5Info)
        TurnData.append(Turn6Info)
        TurnData.append(Turn7Info)
        TurnData.append(Turn8Info)
        TurnData.append(Turn9Info)
        TurnData.append(Turn10Info)
        
        
        self.TableView.reloadData()
        ActInd.stopAnimating()
        
        GAMECENTERLOGGEDIN = UserDefaults.standard.bool(forKey: "GameCenterEnabled")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if JustViewingPlayers {
            titleLBL.text = ""
            helpButton.isHidden = true
        } else {
            //titleLBL.text = ""
            helpButton.isHidden = true
            
        }
        
        print("Game ID = \(GameID)")
        
        repeatfriendsviewcontroller.rdelegate=self
        
        fbfriendsviewcontroller.fdelegate=self

        
        
        TableView.backgroundColor = UIColor.clear
       
        self.TableView.separatorStyle = UITableViewCellSeparatorStyle.none

        TableView.delegate = self
        TableView.dataSource = self
 
        self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let prefs:UserDefaults = UserDefaults.standard
        
        username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
        
        
        
        print("Game selected was \(GameSelected)")
        
        if Visibility == "Private" {
            statusSwitch.setOn(true, animated: false)
            gameStatusLBL.text = "Game Status: Private"
        } else {
        statusSwitch.setOn(false, animated: false)
            gameStatusLBL.text = "Game Status: Public"
        }
        
   
        View1.layer.cornerRadius = 10
        View1CloseBTN.layer.cornerRadius = 10
        
        
        ViewHolder.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
      
            let AlreadySeenHowTo = prefs.bool(forKey: "DidShowHowTo_PlayersList")
        
            if !AlreadySeenHowTo {
            
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            self.View1TOP.constant = middleY
            
            self.ViewHolder.center.y = self.ViewHolder.center.y - 1000
            
            self.ViewHolderTOP.constant = 0
            //self.ViewShowing = true
            // ShowingInfo = true
            
            // self.ViewTransTOP.constant = 0
            self.ViewHowTo = true
        })
      }
       // println("Game selected2 was \(GameSelected2)")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func statusSwitch(_ sender: UISwitch) {
        
        if statusSwitch.isOn {
            gameStatusLBL.text = "Game Status: Private"
            
            let results = GameStatusChange(GameIDInfo, status: "Private")
            
            if results {
            let AC = JSController("Game Status Change", MyMessage: "You have set your Game Status to Private",Color: "Green")
            
            self.present(AC, animated: true, completion: nil)
                
                
            } else {
                let AC = JSController("Error", MyMessage: "There was an error changing your game status, please try again",Color: "Red")
                
                self.present(AC, animated: true, completion: nil)
                statusSwitch.setOn(false, animated: false)
            
            }
            
        } else {
            gameStatusLBL.text = "Game Status: Public"
            
            let results = GameStatusChange(GameIDInfo, status: "Public")
            
            if results {
                let AC = JSController("Game Status Change", MyMessage: "You have set your Game Status to Public",Color: "Green")
                
                self.present(AC, animated: true, completion: nil)
            } else {
                let AC = JSController("Error", MyMessage: "There was an error changing your game status, please try again",Color: "Red")
                
                self.present(AC, animated: true, completion: nil)
                statusSwitch.setOn(true, animated: false)
            }
        }
        
    }

    
    @IBAction func StatusExplained(_ sender: AnyObject) {
        
        let AC = JSController("Game Status", MyMessage: "You can set your game status to Public or Private.  Private games will not be shown on the Favorite Games Leaderboard.",Color: "Blue")
        
        self.present(AC, animated: true, completion: nil)

    }
    
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        switch (result.rawValue) {
        case MessageComposeResult.cancelled.rawValue:
            self.dismiss(animated: true, completion:nil)
        case MessageComposeResult.failed.rawValue:
            self.dismiss(animated: true, completion: nil)
            
        case MessageComposeResult.sent.rawValue:
            self.dismiss(animated: true, completion: nil)
            
        default:
            break;
        }
        
    }

    @IBAction func backBTN(_ sender: AnyObject) {
        
    self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.PlayerNames.count
        // return self.GameNameInfo.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
 //       let row = indexPath.row
        //var isTurnAvailable = CanTakeTurnInfo[row]
        
              let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        
        selectedCell.contentView.backgroundColor = UIColor.clear
        
print("PlayerIDs[indexPath.row] = \(PlayerIDs[(indexPath as NSIndexPath).row])")
        
        if (PlayerIDs[(indexPath as NSIndexPath).row] != "") || (PlayerIDs[(indexPath as NSIndexPath).row] != "OPEN") {
            // cell.contentBTN?.imageView?.image = UIImage(named: "YouIcon.png")
            //  cell.contentBTN?.tag = indexPath.row
            profileID = PlayerIDs[(indexPath as NSIndexPath).row]
            
            if profileID.isEqual(to: "OPEN") {
                
            } else {
            
            self.performSegue(withIdentifier: "ShowProfile", sender: self)
            }
            
        }

        
        
    }
    
    
    func EditPlayerClicked(_ sender: UIButton!) {
        
        
        PlayerRowSelected = sender.tag
        print("the game rowselected: \(sender.tag)")
        
        
        
        //let row = indexPath.row
        
                //let selectedResult = indexPath.item
        let SelectedPlayer = PlayerNames[PlayerRowSelected]

        var PlayerCountTemp = PlayerCount[PlayerRowSelected]
        
        UserSelected = "User\(String(PlayerCountTemp))" as NSString
        UserSelectedID = "User\(String(PlayerCountTemp))ID" as NSString
       // UserSelected = "User\(String(describing: PlayerCount[PlayerRowSelected]))"
      //  UserSelectedID = "User\(String(describing: PlayerCount[PlayerRowSelected]))ID"
        
        print("Selected Player = \(SelectedPlayer)")
        print("UserSelected = \(UserSelected)")
        
 
                let actionSheetController: UIAlertController = UIAlertController(title: "Replace User: \(SelectedPlayer)?", message: "", preferredStyle: .alert)
                
                //Create and add the Cancel action
                let FBAction: UIAlertAction = UIAlertAction(title: "Select From Game Center", style: .default) { action -> Void in
                    
                    
                    self.FacebookClicked()
                    
                   // EasyGameCenter.findMatchWithMinPlayers(2, maxPlayers: 4)

                   
                    
                }
                actionSheetController.addAction(FBAction)
                
                let GCAction: UIAlertAction = UIAlertAction(title: "Select Previous Players", style: .default) { action -> Void in
                    self.GameCenterClicked()
  
                }
                
                actionSheetController.addAction(GCAction)
                
                //Create and an option action
                let ContactsAction: UIAlertAction = UIAlertAction(title: "Select From Contacts", style: .default) { action -> Void in
                    
                  self.ContactsClicked(self.PlayerRowSelected)
                }
                
                actionSheetController.addAction(ContactsAction)
                
        
                let CancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                    
                    //save to images
                    
                }
                
                actionSheetController.addAction(CancelAction)
        //CHANGE ERROR
        /*
        var subView = actionSheetController.view.subviews.first as! UIView
        var contentView = subView.subviews.first as! UIView
        var contentView2 = subView.subviews.last as! UIView
        
        
        
        contentView.backgroundColor = UIColor(red: 0.249, green: 0.549, blue: 0.674, alpha: 0.5)
        contentView.tintColor = UIColor(red: 0.572, green: 0.882, blue: 0.949, alpha: 1.0)
        // contentView.
        contentView2.tintColor = UIColor(red: 0.572, green: 0.882, blue: 0.949, alpha: 1.0)
*/
                self.present(actionSheetController, animated: true, completion: nil)
        
        }
    
    //func sh
    
    
    func SendPlayerNotice(_ sender: UIButton!) {
        
        
        PlayerRowSelected = sender.tag
        print("the game rowselected: \(sender.tag)")
        
        
        
        //let row = indexPath.row
        
        //let selectedResult = indexPath.item
        SelectedPlayer = PlayerNames[PlayerRowSelected]
        var PlayerCountTemp = PlayerCount[PlayerRowSelected]
        
        UserSelected = "User\(String(PlayerCountTemp))" as NSString
        UserSelectedID = "User\(String(PlayerCountTemp))ID" as NSString
        
     //   UserSelected = "User\(String(describing: PlayerCount[PlayerRowSelected]))"
     //   UserSelectedID = "User\(String(describing: PlayerCount[PlayerRowSelected]))ID"
        userIDSelected = PlayerIDs[PlayerRowSelected]
        
        //GameStyle = GameStyleInfo[PlayerRowSelected]
        
        
        print("Selected Player = \(SelectedPlayer)")
        print("UserSelected = \(UserSelected)")
        
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Send \(SelectedPlayer) a Game Notice?", message: "", preferredStyle: .alert)
        
        //Create and add the Cancel action
        let FBAction: UIAlertAction = UIAlertAction(title: "Send Facebook Messenger", style: .default) { action -> Void in
            
            print("trying to send invite")
            
          //  self.sendFBMessage()
            
            let inviteDialog:FBSDKMessageDialog = FBSDKMessageDialog()
            if(inviteDialog.canShow()){
                let appLinkUrl:URL = URL(string: "https://fb.me/675432082558667")!
                // let appLinkUrl:NSURL = NSURL(string: "TelePictionary://article/FacebookInvite?")!
                let previewImageUrl:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/Images/PicsQuotesLogo.png")!
                
                let inviteContent: FBSDKShareLinkContent = FBSDKShareLinkContent()
                //appLinkURL: appLinkUrl)
                // (appLinkURL: appLinkUrl)
                print("app invite should be shown here")
             //   inviteContent.contentURL = NSURL(string: "http://\(ServerInfo.sharedInstance)/Apps/Pics&Quotes/GoToApp.php?gameid=\(self.GameID)&turn=\(self.UserSelected)&name=\(self.SelectedPlayer)&id=\(self.UserSelectedID)&gamestyle=\(self.GameStyleInfo)")
                
                inviteContent.imageURL = previewImageUrl
                inviteDialog.shareContent = inviteContent
//                inviteContent.appLinkURL = appLinkUrl
                
                // inviteContent.
                //inviteContent.s
                
            //    inviteContent.appInvitePreviewImageURL = previewImageUrl
                
          //      inviteDialog.content = inviteContent
                //inviteDialog
           //     inviteDialog.delegate = self
                inviteDialog.show()
                //FBSDKShareDialog.s
                
            } else {
                UIApplication.shared.openURL(URL(string: "https://itunes.apple.com/en/app/messenger/id454638411?mt=8")!)
            }
            
            
            /*
            let inviteDialog:FBSDKAppInviteDialog = FBSDKAppInviteDialog()
            if(inviteDialog.canShow()){
                let appLinkUrl:NSURL = NSURL(string: "https://fb.me/675432082558667")!
                // let appLinkUrl:NSURL = NSURL(string: "TelePictionary://article/FacebookInvite?")!
                let previewImageUrl:NSURL = NSURL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/Images/PicsQuotesLogo.png")!
                
                let inviteContent: FBSDKAppInviteContent = FBSDKAppInviteContent()
                //appLinkURL: appLinkUrl)
                // (appLinkURL: appLinkUrl)
                print("app invite should be shown here")
                inviteContent.appLinkURL = appLinkUrl
                
                // inviteContent.
                //inviteContent.s
                    
                inviteContent.appInvitePreviewImageURL = previewImageUrl
                
                inviteDialog.content = inviteContent
                //inviteDialog
                inviteDialog.delegate = self
                inviteDialog.show()
                
                
            }
*/
           // self.sendGameInvite()
        }
        
        actionSheetController.addAction(FBAction)
        
        //Create and add the Cancel action
        let textAction: UIAlertAction = UIAlertAction(title: "Send Text Message", style: .default) { action -> Void in
            
           // let library = ALAssetsLibrary()
            // let imageToSave = filter.outputImage
           // var orientation = theimage.imageOrientation
          //  var imageData = UIImageJPEGRepresentation(theimage, 1.0)
          //  var compressedJPGImage = UIImage(data: imageData)
            
            let messageVC = MFMessageComposeViewController()
         //   var messageTo = "Jared"
            
          //  messageVC.body = "PQ://article/EmailInvite?gameid=\(self.GameID)&turn=\(self.UserSelected)&name=\(messageTo)";
          //  self.FBFriendID = FBFriendID2.stringByReplacingOccurrencesOfString(" //", withString: "")
            
            let SelectedPlayerC: NSString = "contact"
            
            messageVC.body = "You're invited to play Pics & quotes.  Click the link to join.  http://\(ServerInfo.sharedInstance)/Apps/Pics&Quotes/GoToApp.php?gameid=\(self.GameID)&turn=\(self.UserSelected)&name=\(SelectedPlayerC)&id=\(self.UserSelectedID)&gamestyle=\(self.GameStyleInfo)"
            
            //messageVC.recipients = [""]
            messageVC.messageComposeDelegate = self;
          //  messageVC.addAttachmentData(imageData!, typeIdentifier: "image/jpeg", filename: "GamePhoto.jpeg")
            
            self.present(messageVC, animated: false, completion: nil)
            
            
        }
        actionSheetController.addAction(textAction)

        //Create and add the Cancel action
        let PushAction: UIAlertAction = UIAlertAction(title: "Send Push Notification", style: .default) { action -> Void in
            

            if self.userIDSelected == "NONE" {
                
                let AC = JSController("Invalid Player ID", MyMessage: "This player was added from your contacts and does not have a valid player ID, please send them an email or text message ",Color: "Red")
                self.present(AC, animated: true, completion: nil)
                
            } else {
            
            
            let PushSent = SendGameNotice(self.SelectedPlayer, gameid: self.GameID, turninfo: self.UserSelected, alertType: "newGame", gameType: self.GameStyleInfo, turninfoID: self.UserSelectedID, playerid: self.userIDSelected)
            
            if PushSent {
                
                let AC = JSController("Push Notification", MyMessage: "We have attempted to send a Push Notification to \(self.SelectedPlayer) regarding this game",Color: "Green")
                self.present(AC, animated: true, completion: nil)

                
            } else {
                
                let AC = JSController("Push Notification", MyMessage: "There has been an error sending the Push Notification",Color: "Red")
                self.present(AC, animated: true, completion: nil)

                
            }
          }
            
        }
        actionSheetController.addAction(PushAction)

        //Create and add the Cancel action
        let emailAction: UIAlertAction = UIAlertAction(title: "Send Email", style: .default) { action -> Void in
            
            self.SendingEmail = true
            self.SelectEmail()
            
        }
        actionSheetController.addAction(emailAction)
        
              
        
        let CancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            
            //save to images
            
        }
        
        actionSheetController.addAction(CancelAction)
        
        //CHANGE ERROR
        /*
        var subView = actionSheetController.view.subviews.first as! UIView
        var contentView = subView.subviews.first as! UIView
        var contentView2 = subView.subviews.last as! UIView
        
    
 
            contentView.backgroundColor = UIColor(red: 0.249, green: 0.549, blue: 0.674, alpha: 0.5)
            contentView.tintColor = UIColor(red: 0.572, green: 0.882, blue: 0.949, alpha: 1.0)
            // contentView.
            contentView2.tintColor = UIColor(red: 0.572, green: 0.882, blue: 0.949, alpha: 1.0)
        */
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
                //        }
    
  //  }
    
    func SaveNewUser(){
        
        
      //  MergeWithGame(GameID, NewUser, UserSelected)
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
       
        
        cell.backgroundColor = UIColor.clear
       
        if PlayerTurnIndex[(indexPath as NSIndexPath).row] as Bool {
            cell.backgroundColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)

 
        }

        cell.titleLabel?.text = PlayerNames[(indexPath as NSIndexPath).row] as String
        cell.numbers?.text = PlayerCount[(indexPath as NSIndexPath).row] as String
        
        if TurnData[(indexPath as NSIndexPath).row].isEqual(to: "") {
        
        cell.TableImageFB?.isHidden = false

        cell.TableImageFB?.tag = (indexPath as NSIndexPath).row
        
        cell.TableImageFB?.layer.cornerRadius = 10
        cell.TableImageFB?.layer.borderWidth = 2
        
        cell.TableImageFB?.layer.borderColor = UIColor.white.cgColor
        
        cell.TableImageFB?.addTarget(self, action: #selector(PlayerListViewController.EditPlayerClicked(_:)), for: .touchUpInside)
            
         
            cell.sendMailBTN?.isHidden = false
            
            cell.sendMailBTN?.tag = (indexPath as NSIndexPath).row
            
            cell.sendMailBTN?.imageView?.image = UIImage(named: "sendMail.png")
            
                        
            cell.sendMailBTN?.addTarget(self, action: #selector(PlayerListViewController.SendPlayerNotice(_:)), for: .touchUpInside)
   
            
            
            if JustViewingPlayers {
                cell.TableImageFB?.isHidden = true
                cell.sendMailBTN?.isHidden = true
            }
            
            
            
        } else {
            cell.TableImageFB?.isHidden = true
            cell.sendMailBTN?.isHidden = true
            
            
            
            if JustViewingPlayers {
                cell.TableImageFB?.isHidden = true
                cell.sendMailBTN?.isHidden = true
            }
            
        }
        
        //  cell.TurnLabel!.text = self.UsersTurnInfo[indexPath.row] as String
        
               //TableView.rowHeight = 85
        return cell
        
    }
 
    
    @IBAction func FBLogin(_ sender: AnyObject) {
        
        // GetFBFriends()
        
        
        
        sendGameInvite()
        
        
    }
    

    
    
    
    func appInviteDialog(_ appInviteDialog: FBSDKAppInviteDialog!, didCompleteWithResults results: [AnyHashable: Any]!) {
        print("did complete")
    }
    
    func appInviteDialog(_ appInviteDialog: FBSDKAppInviteDialog!, didFailWithError error: Error!) {
        print("did not complete: error = \(error)")
    }
    
    func sendGameInvite() {
        
        print("trying to send invite")
        let inviteDialog:FBSDKAppInviteDialog = FBSDKAppInviteDialog()
        if(inviteDialog.canShow()){
            let appLinkUrl:URL = URL(string: "https://fb.me/675432082558667")!
            // let appLinkUrl:NSURL = NSURL(string: "TelePictionary://article/FacebookInvite?")!
            //let previewImageUrl:NSURL = NSURL(string: "http://\(ServerInfo.sharedInstance)imagescsletterfinal3d.png")!
            
            let inviteContent: FBSDKAppInviteContent = FBSDKAppInviteContent()
            //appLinkURL: appLinkUrl)
            // (appLinkURL: appLinkUrl)
            print("app invite should be shown here")
            inviteContent.appLinkURL = appLinkUrl
            // inviteContent.
            // inviteContent.appInvitePreviewImageURL = previewImageUrl
            
            inviteDialog.content = inviteContent
            //inviteDialog
            inviteDialog.delegate = self
            inviteDialog.show()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.TableView.reloadData()
        
        if ReloadView != "no"{
           // GetGroupCoreData()
        }
        
    }
    
    
    
    
    func ContactsClicked(_ sender: Int) {
        let picker = ABPeoplePickerNavigationController()
        picker.peoplePickerDelegate = self
        print("EDITING PLAYER WITH NEW CONTACT")
        
        //picker.displayedProperties = [NSNumber(int: kABPersonEmailProperty)]
        //picker.displayedProperties = [NSNumber(int: kABPersonPhoneMainLabel)]
        
        if picker.responds(to: #selector(getter: ABPeoplePickerNavigationController.predicateForEnablingPerson)) {
            //  picker.predicateForEnablingPerson = NSPredicate(format: "emailAddresses.@count > 0")
            // picker.predicateForEnablingPerson = NSPredicate
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func peoplePickerNavigationController(_ peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord, property: ABPropertyID, identifier: ABMultiValueIdentifier) {
        
        print("Contacts Picked - Row Selected = \(PlayerRowSelected)")
        
        if SendingEmail {
            print("Sending email = true")
            let multivalue: ABMultiValue = ABRecordCopyValue(person, property).takeRetainedValue()
            let index = ABMultiValueGetIndexForIdentifier(multivalue, identifier)
            let email = ABMultiValueCopyValueAtIndex(multivalue, index).takeRetainedValue() as! String
            let fullnameString : CFString = ABRecordCopyCompositeName(person).takeRetainedValue()
            let fullname : NSString = fullnameString as NSString
            
            //savename(fullname, emailaddress: email)
            
            print("MultiValue: \(multivalue)")
            print("Email: \(email)")
            print("Name: \(fullname)")
            
            let emailParse1 = email.replacingOccurrences(of: "(", with: "")
            let emailParse2 = emailParse1.replacingOccurrences(of: ")", with: "")
            let emailParse3 = emailParse2.replacingOccurrences(of: " ", with: "")
            let emailParse4 = emailParse3.replacingOccurrences(of: "+", with: "")
            print("PARSED CONTACT: \(emailParse4)")
            
            // EmailInfo.append(emailParse4)
            // NameInfo.append(fullname)
            
            // EmailName = fullname
            // EmailAddress = emailParse4
            print("will show emailcontroller")
            EmailController(fullname, address: emailParse4 as NSString)
            
            
            
        
        
    } else  {
     print("Sending email = false")
            
        let multivalue: ABMultiValue = ABRecordCopyValue(person, property).takeRetainedValue()
        let index = ABMultiValueGetIndexForIdentifier(multivalue, identifier)
        let email = ABMultiValueCopyValueAtIndex(multivalue, index).takeRetainedValue() as! String
        let fullnameString : CFString = ABRecordCopyCompositeName(person).takeRetainedValue()
        let fullname : NSString = fullnameString as NSString
        
     //   savename(fullname, emailaddress: email, group: groupName)
        
        print("new user MultiValue: \(multivalue)")
        print("new user Email: \(email)")
        print("new user Name: \(fullname)")
        
        let emailParse1 = email.replacingOccurrences(of: "(", with: "")
        let emailParse2 = emailParse1.replacingOccurrences(of: ")", with: "")
        let emailParse3 = emailParse2.replacingOccurrences(of: " ", with: "")
        let emailParse4 = emailParse3.replacingOccurrences(of: "+", with: "")
        print("PARSED CONTACT: \(emailParse4)")
        
      //  EmailInfo.append(emailParse4)
      //  NameInfo.append(fullname)
        
        Replaced_New_Name = fullname
        Replaced_New_Contact = emailParse4 as NSString
        
        print("merging with Game data")
        MergeWithGame(self.GameID, username: fullname, turninfo: UserSelected, status: "accept", userID: "NONE")
        // savename(email)
        
        
        self.PlayerNames.remove(at: self.PlayerRowSelected);
        self.PlayerNames.insert(fullname, at: self.PlayerRowSelected)
        
        self.PlayerIDs.remove(at: self.PlayerRowSelected);
        
        self.PlayerIDs.insert("NONE", at: self.PlayerRowSelected)

        
        self.TableView.reloadData()
        
        
        
        
    }
    
        
        
        
        //savename(email)
        
    }
    
    func condenseWhitespace(_ string: String) -> String {
        let components = string.components(separatedBy: CharacterSet.whitespacesAndNewlines).filter({!$0.characters.isEmpty})
        return components.joined(separator: " ")
    }
    

    
    
    func peoplePickerNavigationController(_ peoplePicker: ABPeoplePickerNavigationController, shouldContinueAfterSelectingPerson person: ABRecord, property: ABPropertyID, identifier: ABMultiValueIdentifier) -> Bool {
        peoplePickerNavigationController(peoplePicker, shouldContinueAfterSelectingPerson: person, property: property, identifier: identifier)
        peoplePicker.dismiss(animated: true, completion: nil)
        return false;
    }

    func peoplePickerNavigationControllerDidCancel(_ peoplePicker: ABPeoplePickerNavigationController) {
        peoplePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func removeObject<T : Equatable>(_ object: T, fromArray array: inout [T])
    {
        let index = array.index(of: object)
        array.remove(at: index!)
    }
    
    
    func ContactsClicked2(_ sender: UIButton!) {
        print("the Contacts tag: \(sender.tag)")
        
        replaceRow = sender.tag
        //didTouchUpInsidePickButton(sender.tag)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "GC Friends" {
            
            let RepeatFriendViewController = segue.destination 
            RepeatFriendViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            
            RepeatFriendViewController.popoverPresentationController!.delegate = self
            
            if let destination = segue.destination as? RepeatFriendsViewController {
                
                destination.RowSelected = replaceRow
                print("Segue replace row = \(replaceRow)")
                
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
        
        if segue.identifier == "ShowProfile" {
            
            
            if let destination = segue.destination as? LevelInfoViewController {
                
                destination.OtherUserProfile = self.OtherUserProfile
                destination.ShowB2 = true
                destination.playerID = self.profileID
                print("Profile show segue")
            }
        }
        

        
    }
    
    
    override func canPerformUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, withSender sender: Any) -> Bool {
        return true
    }
    
        
    func FacebookClicked() {
        
        
       if GAMECENTERLOGGEDIN {
       // replaceRow = sender.tag
        
      //  println("replace row selected: \(replaceRow)")
       // replaceRow = sender.tag
        
        let FBFriendViewController2 = self.storyboard?.instantiateViewController(withIdentifier: "FB Friends") as! FBFriendsViewController

        FBFriendViewController2.fdelegate = self
        
        
        FBFriendViewController2.modalPresentationStyle = .popover
        
        
        
      //  if FBSDKAccessToken.currentAccessToken() != nil {
            

            if let popoverControllerFB = FBFriendViewController2.popoverPresentationController {
                // popoverController2.sourceView = sender as! UIView
                popoverControllerFB.sourceView = self.view
                // popoverController2.sourceView = getgroupsBTN.self as! UIView
                //popoverController2.sourceRect = sender.bounds
                
                let DeviceW = self.view.frame.width
                let middleScreenW = DeviceW / 2
                let middleX = middleScreenW - 100
                
                popoverControllerFB.sourceRect = CGRect(x: middleX,y: 150,width: 0,height: 0)
                
           //     popoverControllerFB.permittedArrowDirections = nil
                popoverControllerFB.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
                
                popoverControllerFB.delegate = self
            }
            self.present(FBFriendViewController2, animated: true, completion: nil)
            
            
        } else {
            
            
            DispatchQueue.main.async(execute: {
                
                
                let theAlert = SCLAlertView()
                
                theAlert.addButton("Ok", action: {
                    DispatchQueue.main.async(execute: {
                        self.LogIntoGameCenter()
                    })
                })
                
                theAlert.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Center", subTitle: "Login to Game Center", duration: nil, completeText: "Cancel", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
        }
        /*
      
        } else {
            
            let loginManager = FBSDKLoginManager()
            let Permission = ["public_profile", "email", "user_friends"]
            loginManager.logInWithReadPermissions(Permission, handler: { (result, error) -> Void in
                
                if (error == nil) {
                    var fbloginresult: FBSDKLoginManagerLoginResult = result
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {

                        if let popoverControllerFB = FBFriendViewController2.popoverPresentationController {
                            // popoverController2.sourceView = sender as! UIView
                            popoverControllerFB.sourceView = self.view
                            // popoverController2.sourceView = getgroupsBTN.self as! UIView
                            //popoverController2.sourceRect = sender.bounds
                            var DeviceW = self.view.frame.width
                            var middleScreenW = DeviceW / 2
                            var middleX = middleScreenW - 100
                            
                            popoverControllerFB.sourceRect = CGRectMake(middleX,150,0,0)
                            
                            popoverControllerFB.permittedArrowDirections = nil
                            popoverControllerFB.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
                            
                            popoverControllerFB.delegate = self
                        }
                        self.presentViewController(FBFriendViewController2, animated: true, completion: nil)
                        
                    } else {
                        println("Facebook not authorized")
                    }
                    
                    
                }
                
            })
        }
    */
        
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
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, friends, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil) {
                    self.dict = result as! NSDictionary
                    print(result)
                    print(self.dict)
                    //  NSLog(self.dict.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as! String)
                    //NSLog(self.dict.objectForKey("email")?!)
                    
                }
            })
        }
        return self.dict
    }
    
    
    func GameCenterClicked() {
        print("GC Clicked")
        
      //  if GAMECENTERLOGGEDIN {
      
      //  println("the gamecenter tag: \(sender.tag)")
        
       // replaceRow = sender.tag
      //  println("the gamecenter tag: \(sender.tag)")
        
        
        let GCFriendViewController2 = storyboard?.instantiateViewController(withIdentifier: "GC Friends") as! RepeatFriendsViewController
        
        //let savingsInformationViewController = WeaponsViewController(nibName: "WeaponsMenu", bundle: nil)
        //  savingsInformationViewController.delegate=self
        
        //   savingsInformationViewController.weaponPKLabel=weaponLabel.text
        GCFriendViewController2.rdelegate = self
        
        
        GCFriendViewController2.modalPresentationStyle = .popover
        if let popoverControllerGC = GCFriendViewController2.popoverPresentationController {
            // popoverController2.sourceView = sender as! UIView
            popoverControllerGC.sourceView = self.view
            // popoverController2.sourceView = getgroupsBTN.self as! UIView
            //popoverController2.sourceRect = sender.bounds
            let DeviceW = self.view.frame.width
            let middleScreenW = DeviceW / 2
            let middleX = middleScreenW - 100
            
            popoverControllerGC.sourceRect = CGRect(x: middleX,y: 150,width: 0,height: 0)
            
          //  popoverControllerGC.permittedArrowDirections = nil
            popoverControllerGC.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
            
            popoverControllerGC.delegate = self
        }
        present(GCFriendViewController2, animated: true, completion: nil)
        
        
   
    }
    
    
    

    
    func savename(_ name: NSString, emailaddress: String, group: NSString) {
        
        //if #available(iOS 9.0, *) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)
        
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        person.setValue(name, forKey: "name")
        person.setValue(emailaddress, forKey: "email")
        person.setValue(groupName, forKey: "group")
        
        var error: NSError?
        
        do {
            try managedContext.save()
        } catch let error1 as NSError {
            error = error1
            print("Could not save \(error), \(error!.userInfo)")
        }
        Friends.append(person)
        CurNum = NumFriends.count
        CurNum += 1
        NumFriends.append(CurNum)
    }
    
    
    
    
    /*
    @IBAction func showAlertTapped(sender: AnyObject) {
        
        var FriendsPlaying = [NSString]()
        FriendsPlaying = self.FriendsName
        
        print("Friends Playing Before: \(FriendsPlaying)")
        
        FriendsPlaying = FriendsPlaying.filter{$0 != "NA"}
        
        
        print("Friends Playing After: \(FriendsPlaying)")
        
        var Message = NSString()
        
        
        if FriendsPlaying.count == 1 {
            Message = "You are starting a New Game with only \(FriendsPlaying.count) person.  I think you should add more players...or do you not have any friends, that's sad."}
        if FriendsPlaying.count == 10 {
            Message = "Alright! You have \(FriendsPlaying.count) people playing.  You ready?" }
        if FriendsPlaying.count >= 4 && FriendsPlaying.count <= 9 {
            Message = "Ok...that's enough people, You have \(FriendsPlaying.count) people playing.  Start Game?"}
        if FriendsPlaying.count > 1 && FriendsPlaying.count <= 3 {
            Message = "Only \(FriendsPlaying.count) people playing.  This Game will be short.  You and ALL your friends ready?"
        }
        if FriendsPlaying.count > 10 {
            Message = "Uh Oh! You have more than 10 people playing.  Right now this game only goes up to 10 people sorry." }
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "New Game", message: Message as String, preferredStyle: .Alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Do some stuff
        }
        actionSheetController.addAction(cancelAction)
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Let's Go", style: .Default) { action -> Void in
            /*
            var FriendsPlaying = [NSString]()
            FriendsPlaying = self.FriendsName
            println("Friends Playing Before: \(FriendsPlaying)")
            
            FriendsPlaying = FriendsPlaying.filter{$0 != "NA"}
            println("Friends Playing After: \(FriendsPlaying)")
            */
            //    if (FriendsPlaying.count == 10) {
            
            self.FriendsName = self.FriendsName.filter{$0 != "NA"}
            self.FriendsEmail = self.FriendsEmail.filter{$0 != "NA"}
            
            // self.performSegueWithIdentifier("Add_Quote", sender: self)
            
            /*
            
            } else {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Uh Oh"
            alertView.message = "10 People are needed to play the game"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            */
            // }
            
            
        }
        if FriendsPlaying.count > 10 { print("oops. more than 10 people")
        } else {
            actionSheetController.addAction(nextAction)
        }
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    */
    
    func sendFBInvite() {
        
        print("trying to send invite")
        let inviteDialog:FBSDKAppInviteDialog = FBSDKAppInviteDialog()
        if(inviteDialog.canShow()){
            let appLinkUrl:URL = URL(string: "https://fb.me/675432082558667")!
            // let appLinkUrl:NSURL = NSURL(string: "TelePictionary://article/FacebookInvite?")!
            //let previewImageUrl:NSURL = NSURL(string: "http://\(ServerInfo.sharedInstance)imagescsletterfinal3d.png")!
            
            let inviteContent: FBSDKAppInviteContent = FBSDKAppInviteContent()
            //appLinkURL: appLinkUrl)
            // (appLinkURL: appLinkUrl)
            print("app invite should be shown here")
            inviteContent.appLinkURL = appLinkUrl
            // inviteContent.
            // inviteContent.appInvitePreviewImageURL = previewImageUrl
            
            inviteDialog.content = inviteContent
            //inviteDialog
            inviteDialog.delegate = self
            inviteDialog.show()
        }
    }
   
    func sendFBMessage() {
        
        print("trying to send message")
      //  let inviteDialog:FBSDKAppInviteDialog = FBSDKAppInviteDialog()
        
        let inviteDialog: FBSDKMessageDialog = FBSDKMessageDialog()
        
        if(inviteDialog.canShow()){
            let appLinkUrl:URL = URL(string: "https://fb.me/675432082558667")!
            // let appLinkUrl:NSURL = NSURL(string: "TelePictionary://article/FacebookInvite?")!
            //let previewImageUrl:NSURL = NSURL(string: "http://\(ServerInfo.sharedInstance)imagescsletterfinal3d.png")!
            
            let inviteContent: FBSDKShareLinkContent = FBSDKShareLinkContent()
            //appLinkURL: appLinkUrl)
            // (appLinkURL: appLinkUrl)
            print("app invite should be shown here")
            //inviteContent.appLinkURL = appLinkUrl
            inviteContent.contentURL = URL(string: "http://\(ServerInfo.sharedInstance)")
           // var content = inviteDialog.
            // inviteContent.
            // inviteContent.appInvitePreviewImageURL = previewImageUrl
          //  inviteDialog.shareContent = "Test Link"
//            inviteDialog.content = inviteContent
            //inviteDialog.description = "Test Link"
           // inviteContent.description = "Test LInk"
            //inviteDialog
            //inviteDialog.delegate = self
            inviteDialog.shareContent = inviteContent
            inviteDialog.show()
        }
    }
    
    
    func FilterGameData(_ urlData: Data) -> [NSString] {
        
       // var traits = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
     //   print("Json valueJSON: \(json)")
        
        
        
        for result in json["Data"].arrayValue {
            
            
            if ( result["id"] != "0") {
                let gname = result["GameName"].stringValue
                
                let gameID = result["id"].stringValue
                let player1 = result["User1"].stringValue
                
                let player2 = result["User2"].stringValue
                
                let player3 = result["User3"].stringValue
                let player4 = result["User4"].stringValue
                let player5 = result["User5"].stringValue
                
                let player6 = result["User6"].stringValue
                
                let player7 = result["User7"].stringValue
                
                let player8 = result["User8"].stringValue
                let player9 = result["User9"].stringValue
                let player10 = result["User10"].stringValue
                
                let player1ID = result["User1ID"].stringValue
                
                let player2ID = result["User2ID"].stringValue
                
                let player3ID = result["User3ID"].stringValue
                let player4ID = result["User4ID"].stringValue
                let player5ID = result["User5ID"].stringValue
                
                let player6ID = result["User6ID"].stringValue
                
                let player7ID = result["User7ID"].stringValue
                
                let player8ID = result["User8ID"].stringValue
                let player9ID = result["User9ID"].stringValue
                let player10ID = result["User10ID"].stringValue
                
                
                let turn1 = result["Turn1"].stringValue
                
                let turn2 = result["Turn2"].stringValue
                
                let turn3 = result["Turn3"].stringValue
                let turn4 = result["Turn4"].stringValue
                let turn5 = result["Turn5"].stringValue
                
                let turn6 = result["Turn6"].stringValue
                
                let turn7 = result["Turn7"].stringValue
                
                let turn8 = result["Turn8"].stringValue
                let turn9 = result["Turn9"].stringValue
                let turn10 = result["Turn10"].stringValue
                
                let gamestyle = result["gamestyle"].stringValue
                
         
                
                if turn10 == "" {
                    
                    if turn9 == "" {
                        
                        if turn8 == "" {
                            
                            if turn7 == "" {
                                
                                if turn6 == "" {
                                    
                                    if turn5 == "" {
                                        
                                        if turn4 == "" {
                                            
                                            if turn3 == "" {
                                                
                                                if turn2 == "" {
                                                   
                                                    PlayerTurnIndex = [false, true, false, false, false, false, false, false, false, false]
                                                    
                                                     print("is turn 2")
                                                    
                                                } else {
                                                    
                                                   // currentTurn = "Turn2"
                                                    PlayerTurnIndex = [false, false, true, false, false, false, false, false, false, false]
                                                   
                                                }

                                                
                                            } else {
                                                
                                               // currentTurn = "Turn3"
                                                 PlayerTurnIndex = [false, false, false, true, false, false, false, false, false, false]
                                            }

                                            
                                        } else {
                                            
                                          //  currentTurn = "Turn4"
                                             PlayerTurnIndex = [false, false, false, false, true, false, false, false, false, false]
                                        }

                                        
                                    } else {
                                        
                                        //currentTurn = "Turn5"
                                         PlayerTurnIndex = [false, false, false, false, false, true, false, false, false, false]
                                    }

                                    
                                } else {
                                    
                                    //currentTurn = "Turn6"
                                     PlayerTurnIndex = [false, false, false, false, false, false, true, false, false, false]
                                }

                                
                            } else {
                                
                             //   currentTurn = "Turn7"
                                 PlayerTurnIndex = [false, false, false, false, false, false, false, true, false, false]
                            }

                            
                        } else {
                            
                           // currentTurn = "Turn8"
                             PlayerTurnIndex = [false, false, false, false, false, false, false, false, true, false]
                        }

                        
                        
                    } else {
                        
                        currentTurn = "Turn9"
                        PlayerTurnIndex = [false, false, false, false, false, false, false, false, false, true]
                    }
                } else {
                     PlayerTurnIndex = [false, false, false, false, false, false, false, false, false, false]
                }
                
                Game_Data_Array.append(gname as NSString)
                Game_Data_Array.append(gameID as NSString)
                Game_Data_Array.append(player1 as NSString)
                Game_Data_Array.append(player2 as NSString)
                Game_Data_Array.append(player3 as NSString)
                Game_Data_Array.append(player4 as NSString)
                Game_Data_Array.append(player5 as NSString)
                Game_Data_Array.append(player6 as NSString)
                Game_Data_Array.append(player7 as NSString)
                Game_Data_Array.append(player8 as NSString)
                Game_Data_Array.append(player9 as NSString)
                Game_Data_Array.append(player10 as NSString)
                Game_Data_Array.append(turn1 as NSString)
                Game_Data_Array.append(turn2 as NSString)
                Game_Data_Array.append(turn3 as NSString)
                Game_Data_Array.append(turn4 as NSString)
                Game_Data_Array.append(turn5 as NSString)
                Game_Data_Array.append(turn6 as NSString)
                Game_Data_Array.append(turn7 as NSString)
                Game_Data_Array.append(turn8 as NSString)
                Game_Data_Array.append(turn9 as NSString)
                Game_Data_Array.append(turn10 as NSString)
                Game_Data_Array.append(gamestyle as NSString)
                
                PlayerIDs.append(player1ID as NSString)
                PlayerIDs.append(player2ID as NSString)
                PlayerIDs.append(player3ID as NSString)
                PlayerIDs.append(player4ID as NSString)
                PlayerIDs.append(player5ID as NSString)
                PlayerIDs.append(player6ID as NSString)
                PlayerIDs.append(player7ID as NSString)
                PlayerIDs.append(player8ID as NSString)
                PlayerIDs.append(player9ID as NSString)
                PlayerIDs.append(player10ID as NSString)
            }
            
        }

        return Game_Data_Array
        
    }
  
    
    @IBAction func View1CloseBTN(_ sender: AnyObject) {
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if ViewHowTo {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.View1TOP.constant = middleY
                
                self.ViewHolder.center.y = self.ViewHolder.center.y + 1000
                
                self.ViewHolderTOP.constant = 1000
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            
            ViewHowTo = false
        }
        
        self.prefs.set(true, forKey: "DidShowHowTo_PlayersList")
       
        
    }
    
    @IBAction func ViewHowTo(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if !ViewHowTo {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.View1TOP.constant = middleY
                
                self.ViewHolder.center.y = self.ViewHolder.center.y - 1000
                
                self.ViewHolderTOP.constant = 0
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            
            ViewHowTo = true
        }
        
    }
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    
    func SelectEmail() {
        let picker = ABPeoplePickerNavigationController()
        picker.peoplePickerDelegate = self
        
        //  picker.displayedProperties = [NSNumber(int: kABPersonEmailProperty)]
        
        //  picker.displayedProperties = [NSNumber(int: kABPersonFirstNameProperty)]
        
        if picker.responds(to: #selector(getter: ABPeoplePickerNavigationController.predicateForEnablingPerson)) {
            //   picker.predicateForEnablingPerson = NSPredicate(format: "emailAddresses.@count > 0")
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    
    
    
    
    func EmailController(_ name: NSString, address: NSString) {
        
        print("creating email controller")
        
        let alertController = UIAlertController(title: "Email Game Invite", message: "Send \(SelectedPlayer) an Email Now?", preferredStyle: .alert)
        var EmailField: UITextField?
        
        
        let CancelAction = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction) in
            print("Cancel button pressed")
            
        }
        
        alertController.addAction(CancelAction);
        
        
        alertController.addTextField { (textField) -> Void in
            
            EmailField = textField
            EmailField?.text = address as String
            EmailField?.textAlignment = .center
            
            //EmailField?.placeholder
            
        }
        
        let OkAction = UIAlertAction(title: "Send Email", style: .default) { (action:UIAlertAction) in
            print("OK button pressed")
            let SaveProgressHUD = ProgressHUD(text: "Sending Email...")
            self.view.addSubview(SaveProgressHUD)
            
            let SentResult = EmailGameInvite(EmailField!.text! as NSString, username: self.username, ToUser: name, turn: self.UserSelectedID, gamestyle: self.GameStyleInfo, gameid: self.GameIDInfo)
 
            
            if SentResult {
                print("Email Sent")
                self.SendingEmail = false
            }
            
            SaveProgressHUD.removeFromSuperview()
        }
        
        
        
        alertController.addAction(OkAction);
        
        alertController.view.tintColor = UIColor.black;
        //alertController.view.backgroundColor = UIColor(red: 0.4, green: 1, blue: 0.69, alpha: 1.0)
        
        //CHANGE ERROR
        /*
        var subView = alertController.view.subviews.first as! UIView
        var contentView = subView.subviews.first as! UIView
        var contentView2 = subView.subviews.last as! UIView
        
        contentView.backgroundColor = UIColor(red: 0.249, green: 0.549, blue: 0.674, alpha: 0.5)
        contentView.tintColor = UIColor(red: 0.572, green: 0.882, blue: 0.949, alpha: 1.0)
        // contentView.
        contentView2.tintColor = UIColor(red: 0.572, green: 0.882, blue: 0.949, alpha: 1.0)
        */
        print("about to show alertController")
        
        DispatchQueue.main.async(execute: {
            
            self.present(alertController, animated: true, completion: nil)
            print("should have shown alert controller")
            
        })
        
        
        
    }
    
  
    func LogIntoGameCenter() -> Bool {
        
        print("Logging into game center")
        var gameCenterEnabled2 = Bool()
        
        //REVIEW BELOW
        //var localPlayer = getLocalPlayer() // see GKLocalPlayerHack.h
        print("Local Player = \(localPlayer)")
        // print("GCError ViewShowing = \(GCErrorViewShowing)")
        
        
        self.localPlayer.authenticateHandler =
            { (viewController: UIViewController?, error: Error?) -> Void in
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
                        self.GCplayerid = self.localPlayer.playerID! as NSString
                        self.GCplayer = self.localPlayer.alias! as NSString
                        
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
                       // self.prefs.setValue(self.GCplayer, forKey: "USERNAME")
                     //   let PlayerIDEdit = self.GCplayerid.stringByReplacingOccurrencesOfString(":", withString: "")
                        
                     //   self.prefs.setValue(PlayerIDEdit, forKey: "PLAYERID")
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
                         //   print("\(error!.description)")
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





extension PlayerListViewController {
    
//}: RepeatFriendsViewControllerDelegate {
    func RepeatFriendsViewControllerFinished(_ repeatfriendsviewController: RepeatFriendsViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        self.GCFriendName = repeatfriendsviewController.GCFriendName
        //self.GCFriendID = repeatfriendsviewController.GCFriendID
        //self.GCFriendContact = repeatfriendsviewController.GCFriendContact
        self.GCFriendContact = "PUSH"
        
        self.SelectedGCFriend = repeatfriendsviewController.SelectedGCFriend
        // self.replaceRow = repeatfriendsviewController.RowSelected
        
 let GCFriendID2 = repeatfriendsviewController.GCFriendID
        
        print("Game Center replace at Row: \(self.PlayerRowSelected)")
        self.GCFriendID = GCFriendID2.replacingOccurrences(of: ":", with: "") as NSString
    
        // self.NameInfo.insert(self.GCFriendName, atIndex: self.replaceRow);
        // self.EmailInfo.insert(self.GCFriendContact, atIndex: self.replaceRow);
        
        
        if self.SelectedGCFriend {
            self.DidSelectGCFriend = true
            
            
            //REPLACE REPEAT FRIEND with current NA
            
            //GetGroupCoreData(GroupSelected)
            
        } else {
            self.DidSelectGCFriend = false
        }
        
print("merging new player with game")
        
        MergeWithGame(GameID, username: GCFriendName, turninfo: UserSelected, status: "accept", userID: GCFriendID)
        
        self.PlayerNames.remove(at: self.PlayerRowSelected);
        self.PlayerNames.insert(self.GCFriendName, at: self.PlayerRowSelected)

        self.PlayerIDs.remove(at: self.PlayerRowSelected);
        
        

        
        self.PlayerIDs.insert(self.GCFriendID, at: self.PlayerRowSelected)
        //self.ReloadView = "no"
        self.TableView.reloadData()
        
    }
    
}

extension PlayerListViewController {
//: FBFriendsViewControllerDelegate {
    func FBFriendsViewControllerFinished(_ fbfriendsviewController: FBFriendsViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        self.FBFriendName = fbfriendsviewController.FBFriendName
        
        self.FBFriendContact = fbfriendsviewController.FBFriendContact
        
        let FBFriendID2 = fbfriendsviewController.FBFriendContact
        self.FBFriendID = FBFriendID2.replacingOccurrences(of: ":", with: "") as NSString
        
        print("FaceBook friend:\(self.FBFriendName)")
        print("Facebook Player ID: \(FBFriendContact)")
        
        self.SelectedFBFriend = fbfriendsviewController.FBSelected
        //self.replaceRow = fbfriendsviewController.RowSelected
        

        //self.Num
        
        print("Facebook replace at Row: \(self.replaceRow)")


        
        MergeWithGame(self.GameID, username: FBFriendName, turninfo: self.UserSelected, status: "accept", userID: self.FBFriendID)
        
        
        self.PlayerNames.remove(at: self.PlayerRowSelected);
        self.PlayerIDs.remove(at: self.PlayerRowSelected);
       
        
        self.PlayerNames.insert(self.FBFriendName, at: self.PlayerRowSelected)
        
        self.PlayerIDs.insert(self.FBFriendID, at: self.PlayerRowSelected)
        
        
      

        
        //self.ReloadView = "no"
        self.TableView.reloadData()
        
        // self.savename(self.FBFriendName, emailaddress: self.FBFriendContact as String, group: groupName)

        
    }
}


