//
//  GameStartedViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 12/19/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import UIKit
import MessageUI
import FBSDKShareKit
import FBSDKLoginKit
import FBSDKCoreKit

class GameStartedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMessageComposeViewControllerDelegate, FBSDKSharingDelegate {

    @IBOutlet weak var tapLBL: UILabel!
    @IBOutlet weak var doneBTN: UIButton!
    @IBOutlet weak var topView: UIView!
    
    var AlreadyLoaded = Bool()
    
    @IBOutlet weak var bottomView: UIView!
    var TextPlayerTurnNumber = [NSString]()
    var PlayerTurnIndex = [Bool]()
    var userIDSelected = NSString()
    var PlayerIDs = [NSString]()
    var UserSelected = NSString()
    var UserSelectedID = NSString()
    var SelectedPlayer = NSString()
    let prefs:UserDefaults = UserDefaults.standard
    var GameStyleInfo = NSString()
    var TurnData = [NSString]()
    var profileID = NSString()
    var SendToPhone = String()
    var TextPlayerContact = [NSString]()
    var Turn1MediaType = NSString()
    
    var GameID = NSString()
    
    @IBOutlet weak var TableView: UITableView!
    
    var PlayerNames = [NSString]()
    var PlayerRowSelected = Int()
    var username = NSString()
    var userID = NSString()
    
    var PlayerCount = ["1","2","3","4","5","6","7","8","9","10"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doneBTN.layer.cornerRadius = 10
       self.doneBTN.layer.borderWidth = 1
        self.doneBTN.layer.borderColor = UIColor.white.cgColor
        TableView.backgroundColor = UIColor.clear
        
        self.TableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        TableView.delegate = self
        TableView.dataSource = self
        
        self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        print("Text Player names = \(PlayerNames)")
        print("Text Player Contacts = \(TextPlayerContact)")
        if self.PlayerNames.count < 1 {

            self.TableView.isHidden = true
            self.topView.isHidden = true
            self.bottomView.isHidden = true
            self.tapLBL.isHidden = true
        } else {
            self.topView.isHidden = false
            self.TableView.isHidden = false
            self.bottomView.isHidden = false
            self.tapLBL.isHidden = false
        }
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func SendPlayerNotice(_ sender: UIButton!) {
        
        
        PlayerRowSelected = sender.tag
        print("the game rowselected: \(sender.tag)")
        
        SendToPhone = TextPlayerContact[PlayerRowSelected] as String
        
        //let row = indexPath.row
        
        //let selectedResult = indexPath.item
        SelectedPlayer = PlayerNames[PlayerRowSelected]
        
        var PlayerCountTemp = PlayerCount[PlayerRowSelected]
        
        UserSelected = "User\(String(PlayerCountTemp))" as NSString
        UserSelectedID = "User\(String(PlayerCountTemp))ID" as NSString
        
      //  UserSelected = "User\(PlayerCount[PlayerRowSelected])"
       // UserSelected = "User\(String(describing: TextPlayerTurnNumber[PlayerRowSelected]))"
        //UserSelectedID = "User\(PlayerCount[PlayerRowSelected])ID"
        
       // UserSelectedID = "User\(String(describing: TextPlayerTurnNumber[PlayerRowSelected]))ID"
        
     //   userIDSelected = PlayerIDs[PlayerRowSelected]
        
        //GameStyle = GameStyleInfo[PlayerRowSelected]
        
        
        print("Selected Player = \(SelectedPlayer)")
        print("UserSelected = \(UserSelected)")
        
        /*
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Send \(SelectedPlayer) a Game Notice?", message: "", preferredStyle: .Alert)
        
        //Create and add the Cancel action
      
        
        //Create and add the Cancel action
        let textAction: UIAlertAction = UIAlertAction(title: "Send Text Message", style: .Default) { action -> Void in
            
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
            //messageVC.
            messageVC.recipients = [self.SendToPhone]
            messageVC.body = "You're invited to play Pics & quotes.  Click the link to join.  http://\(ServerInfo.sharedInstance)/Apps/Pics&Quotes/GoToApp.php?gameid=\(self.GameID)&turn=\(self.UserSelected)&name=\(SelectedPlayerC)&id=\(self.UserSelectedID)&gamestyle=\(self.GameStyleInfo)"
            
            //messageVC.recipients = [""]
            messageVC.messageComposeDelegate = self;
            //  messageVC.addAttachmentData(imageData!, typeIdentifier: "image/jpeg", filename: "GamePhoto.jpeg")
            
            self.presentViewController(messageVC, animated: false, completion: nil)
            
            
        }
        actionSheetController.addAction(textAction)
        

        let CancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            
            //save to images
            
        }
        
        actionSheetController.addAction(CancelAction)
        
        */
        
        
        let theAlert =  SCLAlertView()
        
        theAlert.addButton("Send Message", action: {
            
            
            let messageVC = MFMessageComposeViewController()
            //   var messageTo = "Jared"
            
            //  messageVC.body = "PQ://article/EmailInvite?gameid=\(self.GameID)&turn=\(self.UserSelected)&name=\(messageTo)";
            //  self.FBFriendID = FBFriendID2.stringByReplacingOccurrencesOfString(" //", withString: "")
            
            let SelectedPlayerC: NSString = "contact"
            //messageVC.
            messageVC.recipients = [self.SendToPhone]
            messageVC.body = "You're invited to play Pics & quotes.  Click the link to join.  http://\(ServerInfo.sharedInstance)/Apps/Pics&Quotes/GoToApp.php?gameid=\(self.GameID)&turn=\(self.UserSelected)&name=\(SelectedPlayerC)&id=\(self.UserSelectedID)&gamestyle=\(self.GameStyleInfo)"
            
            //messageVC.recipients = [""]
            messageVC.messageComposeDelegate = self;
            //  messageVC.addAttachmentData(imageData!, typeIdentifier: "image/jpeg", filename: "GamePhoto.jpeg")
            
            self.present(messageVC, animated: false, completion: nil)
            
            
        })
            
            theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Message", subTitle: "Send \(SelectedPlayer) a Game Notice?", duration: nil, completeText: "Cancel", style: .custom, colorStyle: 1, colorTextButton: 1)
        
        
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
       // self.presentViewController(actionSheetController, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
        
        
        cell.backgroundColor = UIColor.clear
        
        /*
        if PlayerTurnIndex[indexPath.row] as Bool {
            cell.backgroundColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
   
        }
        
        */
        
        
        
        cell.titleLabel?.text = PlayerNames[(indexPath as NSIndexPath).row] as String
        cell.numbers?.text = ""
       // cell.numbers?.text = PlayerCount[indexPath.row] as String
        
       // if TurnData[indexPath.row].isEqualToString("") {
            if 1 == 1 {
            cell.TableImageFB?.isHidden = true
            
                /*
            cell.TableImageFB?.tag = indexPath.row
            cell.TableImageFB?.layer.cornerRadius = 10
            cell.TableImageFB?.layer.borderWidth = 2
            
            cell.TableImageFB?.layer.borderColor = UIColor.whiteColor().CGColor
            
            cell.TableImageFB?.addTarget(self, action: "EditPlayerClicked:", forControlEvents: .TouchUpInside)
            */
            
            cell.sendMailBTN?.isHidden = false
            
            cell.sendMailBTN?.tag = (indexPath as NSIndexPath).row
            
            cell.sendMailBTN?.imageView?.image = UIImage(named: "sendMail.png")
            
            
            cell.sendMailBTN?.addTarget(self, action: #selector(GameStartedViewController.SendPlayerNotice(_:)), for: .touchUpInside)
            
            
            
           
            
            
            
        } else {
            cell.TableImageFB?.isHidden = true
            cell.sendMailBTN?.isHidden = true
            
            
            
            
        }
        
        //  cell.TurnLabel!.text = self.UsersTurnInfo[indexPath.row] as String
        
        //TableView.rowHeight = 85
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.PlayerNames.count
        // return self.GameNameInfo.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        PlayerRowSelected = (indexPath as NSIndexPath).row
        print("the game rowselected: \((indexPath as NSIndexPath).row)")
        
        SendToPhone = TextPlayerContact[PlayerRowSelected] as String
        
        //let row = indexPath.row
        
        //let selectedResult = indexPath.item
        SelectedPlayer = PlayerNames[PlayerRowSelected]
        var PlayerCountTemp = PlayerCount[PlayerRowSelected]
        
        UserSelected = "User\(String(PlayerCountTemp))" as NSString
        UserSelectedID = "User\(String(PlayerCountTemp))ID" as NSString
        //  UserSelected = "User\(PlayerCount[PlayerRowSelected])"
      //  UserSelected = "User\(String(describing: TextPlayerTurnNumber[PlayerRowSelected]))"
        //UserSelectedID = "User\(PlayerCount[PlayerRowSelected])ID"
        
      //  UserSelectedID = "User\(String(describing: TextPlayerTurnNumber[PlayerRowSelected]))ID"
        
        //   userIDSelected = PlayerIDs[PlayerRowSelected]
        
        //GameStyle = GameStyleInfo[PlayerRowSelected]
        
        
        print("Selected Player = \(SelectedPlayer)")
        print("UserSelected = \(UserSelected)")
        
        /*
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Send \(SelectedPlayer) a Game Notice?", message: "", preferredStyle: .Alert)
        
        //Create and add the Cancel action
        
        
        //Create and add the Cancel action
        let textAction: UIAlertAction = UIAlertAction(title: "Send Text Message", style: .Default) { action -> Void in
        
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
        //messageVC.
        messageVC.recipients = [self.SendToPhone]
        messageVC.body = "You're invited to play Pics & quotes.  Click the link to join.  http://\(ServerInfo.sharedInstance)/Apps/Pics&Quotes/GoToApp.php?gameid=\(self.GameID)&turn=\(self.UserSelected)&name=\(SelectedPlayerC)&id=\(self.UserSelectedID)&gamestyle=\(self.GameStyleInfo)"
        
        //messageVC.recipients = [""]
        messageVC.messageComposeDelegate = self;
        //  messageVC.addAttachmentData(imageData!, typeIdentifier: "image/jpeg", filename: "GamePhoto.jpeg")
        
        self.presentViewController(messageVC, animated: false, completion: nil)
        
        
        }
        actionSheetController.addAction(textAction)
        
        
        let CancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
        
        //save to images
        
        }
        
        actionSheetController.addAction(CancelAction)
        
        */
        
        
        let theAlert =  SCLAlertView()
        
        theAlert.addButton("Send Message", action: {
            
            
            let messageVC = MFMessageComposeViewController()
            //   var messageTo = "Jared"
            
            //  messageVC.body = "PQ://article/EmailInvite?gameid=\(self.GameID)&turn=\(self.UserSelected)&name=\(messageTo)";
            //  self.FBFriendID = FBFriendID2.stringByReplacingOccurrencesOfString(" //", withString: "")
            
            let SelectedPlayerC: NSString = "contact"
            //messageVC.
            messageVC.recipients = [self.SendToPhone]
            messageVC.body = "You're invited to play Pics & quotes.  Click the link to join.  http://\(ServerInfo.sharedInstance)/Apps/Pics&Quotes/GoToApp.php?gameid=\(self.GameID)&turn=\(self.UserSelected)&name=\(SelectedPlayerC)&id=\(self.UserSelectedID)&gamestyle=\(self.GameStyleInfo)"
            
            //messageVC.recipients = [""]
            messageVC.messageComposeDelegate = self;
            //  messageVC.addAttachmentData(imageData!, typeIdentifier: "image/jpeg", filename: "GamePhoto.jpeg")
            
            self.present(messageVC, animated: false, completion: nil)
            
            
        })
        
        theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Message", subTitle: "Send \(SelectedPlayer) a Game Notice?", duration: nil, completeText: "Cancel", style: .custom, colorStyle: 1, colorTextButton: 1)
        
        
        
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
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        
        
        
        
        
        
      
        
        if !AlreadyLoaded {
            

       DispatchQueue.main.async(execute: {
    
    var numPoints = Int()
    var LevelUpTime = Bool()
    (numPoints, LevelUpTime) = UPData(self.username, userid: self.userID, type: "add", points: "5", levelpoints: "5")
    //numPoints = FilterUPData(UPurldata)
    print("number of points = \(numPoints)")
    
    // let AC = JSController("Pixie Points!", MyMessage: "You earn Points to level up your Pixie by Liking Turns.  You just earned one!",Color: "Green")
    
        
        
        let theAlert = SCLAlertView()
        theAlert.addButton("Ok") {
            print("Ok pushed")
            
            
            
            
            if LevelUpTime {
                var PointsNew = NSInteger()
                var LevelNew = NSInteger()
                
                (PointsNew, LevelNew) = UserLevelUp(self.username, userid: self.userID, type: "add", level: "1")
                
                 DispatchQueue.main.async(execute: {
                
                    var Char1 = UIImage(named: "CharacterNormal.png")
                    let Char2 = UIImage(named: "CharacterBum.png")
                    let Char3 = UIImage(named: "CharacterPirate.png")
                    let Char4 = UIImage(named: "CharacterScholar.png")
                    let Char5 = UIImage(named: "CharacterEinstien.png")
                    let Char6 = UIImage(named: "CharacterWizard.png")
                    
                    var newLevelImage = UIImage()
                    switch LevelNew {
                    case 2:
                        newLevelImage = Char2!
                    case 3:
                        newLevelImage = Char3!
                    case 4:
                        newLevelImage = Char4!
                    case 5:
                        newLevelImage = Char4!
                    case 6:
                        newLevelImage = Char4!
                    case 7:
                        newLevelImage = Char4!
                    case 8:
                        newLevelImage = Char5!
                    case 9:
                        newLevelImage = Char5!
                    case 10:
                        newLevelImage = Char6!
                    default:
                        newLevelImage = UIImage(named: "CharacterNormal.png")!
                        
                        
                    
                    }
                    
                SCLAlertView().showCustomOK(newLevelImage, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Level Up!", subTitle: "You just got a Level up on your Pixie! Congrats", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                
                })
                
              //  let AC = JSController("Level \(LevelNew.description) - Level Up!", MyMessage: "You just got a Level up on your Pixie! Congrats",Color: "Green")
              //  self.presentViewController(AC, animated: true, completion:
                    DispatchQueue.main.async(execute: {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "updatePixie"), object: nil)
                    })
                    
               // )
                
                //  self.LevelPlayer?.play()
                
                
            }
            DispatchQueue.main.async(execute: {
                
                
                if self.PlayerNames.count < 1 {
                
              //  self.performSegueWithIdentifier("Turn_Complete", sender: self)
                self.performSegue(withIdentifier: "unwind", sender: self)
                    
                    
                } else {
                    
                    
                    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "New Players!", subTitle: "Some of your players are not set up, send them each a Game Invite to join the game", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                    
                    self.TableView.reloadData()
                    
                }
                
            })
            
            
        }
        //, target:self, selector:Selector("Settings"))
       // theAlert.addButton("Cancel") {
       //     print("Cancel pushed")
       // }
    //theAlert.showCustom(UIImage(named: "SadPixie.png")!, color: UIColor.greenColor(), title: "Pixie Points!", subTitle: "You just earned 5 Pixie points for starting a new game!")
        
        
        theAlert.showCustomOK(UIImage(named: "SillyPixie.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Pixie Points!", subTitle: "You just earned 5 Pixie points for starting a new game!", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
        
        
      /*
        
    
    let alertController = UIAlertController(title: "Pixie Points!", message: "You just earned 5 Pixie points for starting a new game!", preferredStyle: .Alert)
    
    let OkAction = UIAlertAction(title: "Ok", style: .Default) { (action:UIAlertAction) in
        print("Ok button pressed")
        
        
        if LevelUpTime {
            var PointsNew = NSInteger()
            var LevelNew = NSInteger()
            
            (PointsNew, LevelNew) = UserLevelUp(self.username, userid: self.userID, type: "add", level: "1")
            
            let AC = JSController("Level \(LevelNew.description) - Level Up!", MyMessage: "You just got a Level up on your Pixie! Congrats",Color: "Green")
            self.presentViewController(AC, animated: true, completion:
                {
                    NSNotificationCenter.defaultCenter().postNotificationName("updatePixie", object: nil)
                }
                
            )
            
            //  self.LevelPlayer?.play()
            
            
        }
        dispatch_async(dispatch_get_main_queue(),{
            
        self.performSegueWithIdentifier("Turn_Complete", sender: self)

        })
        
    }
    
    
    
    alertController.addAction(OkAction);
    
    self.presentViewController(alertController, animated: true, completion: nil)
        
        
        
        */
    
  })
      AlreadyLoaded = true
 }

  }
    
    
    @IBAction func doneBTN(_ sender: AnyObject) {
        
   
        self.performSegue(withIdentifier: "Turn_Complete", sender: self)
        
        
    }
    
    
    func AddToFaceBook (_ gameid: NSString, theMediaType: NSString) {
        
        var MediaSuf = NSString()
        let theTurnNumber = "1"
        
        switch theMediaType {
        case "picture":
            MediaSuf = "jpg"
        case "audio":
            MediaSuf = "jpg"
        case "quote":
            MediaSuf = "jpg"
        case "gif":
            MediaSuf = "gif"
            
        default:
            break
        }
        
        
    let linkContent : FBSDKShareLinkContent = FBSDKShareLinkContent()
    
    //  let photo : FBSDKSharePhoto = FBSDKSharePhoto()
    linkContent.contentURL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(gameid)Turn\(theTurnNumber).php")
    
    linkContent.contentTitle = "Pics & Quotes"
    linkContent.contentDescription = "Join this game!"
    linkContent.imageURL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(gameid)Turn(self.theTurnNumber).\(MediaSuf)")

    
    let Share : FBSDKShareDialog = FBSDKShareDialog()
    Share.mode = .native
    Share.fromViewController = self
    //Share.shareContent = content
    Share.shareContent = linkContent
    Share.delegate = self
    //Share.show()
    
    if (FBSDKAccessToken.current() != nil) {
    
    if !Share.canShow() {
    
    } else {
    Share.show()
    }
    } else {
    
        getFBPermission(myView: self)
    print("FB Token = \(FBSDKAccessToken.current())")
    print("Getting permission")
    if !Share.canShow() {
    
    } else {
    Share.show()
    }
    
    
    }

}
    
    
    func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable: Any])
    {
        print("sharer didCompleteWithResults, results.count\(results.count)")
        print(results)
        // still cannot get post id from photo upload
    }
    
    
    func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {
        
        print("sharer NSError")
        //print(error.description)
        
    }
    
    func sharerDidCancel(_ sharer: FBSDKSharing!) {
        
        print("sharerDidCancel")
        
    }

}
