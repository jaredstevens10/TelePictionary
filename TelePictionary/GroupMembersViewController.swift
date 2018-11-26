//
//  GroupMembersViewController.swift
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
    
class GroupMembersViewController: UIViewController, ABPeoplePickerNavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate, UIActionSheetDelegate, UIAlertViewDelegate, FBSDKAppInviteDialogDelegate, UIPopoverPresentationControllerDelegate, GroupGCViewControllerDelegate, FBFriendsViewControllerDelegate {
    
    //}, EasyGameCenterDelegate {
    

    var UNIDArray = [NSString]()
    var GCFriendID = NSString()
    var FBFriendID = NSString()
    var groupgcviewcontroller: GroupGCViewController = GroupGCViewController()
    
    var fbfriendsviewcontroller: FBFriendsViewController = FBFriendsViewController() 
        
    @IBOutlet weak var AddNotice: UILabel!
        
        @IBOutlet weak var toolbar: UIToolbar!
        
        @IBOutlet weak var toolbarbottom: UIToolbar!
        
        let index = 10
        var username = String()
        var myemail = String(0)
        var userID = String()
        var groupName = NSString()
        
        //@IBOutlet weak var editBTN: UIBarButtonItem!
        @IBOutlet weak var TableView: UITableView!
        
        
    @IBOutlet weak var groupLBL: UILabel!
        @IBOutlet weak var GameLBL: UILabel!
        
        @IBOutlet weak var EditBTN: UIButton!
        
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
        var PlayerCount = [NSString]()
        var varNum = Int()
        
        var numPlayers = Int()
        var NumFriends = [Int]()
        var CurNum = Int()
        var NumMembers = Int()
        
        var dict = NSDictionary()
        
        
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
    
    var localPlayer = GKLocalPlayer()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            
             self.TableView.separatorStyle = UITableViewCellSeparatorStyle.none
            
            self.TableView.backgroundColor = UIColor.clear

            numPlayers = 1
            
            print("Group Name: \(groupName)")
            
            groupLBL.text = groupName as String
            
            //   TableView.registerClass(UITableView.self, forCellReuseIdentifier: "BasicCell")
            
            let prefs:UserDefaults = UserDefaults.standard
            
            username = prefs.value(forKey: "USERNAME") as! NSString as String
            userID = prefs.value(forKey: "PLAYERID") as! NSString as String
            print("my gamecenter user name = \(username)")
            
            //need to add my email address default
            //myemail = "jared.stevens@\(ServerInfo.sharedInstance)"
            myemail = "PUSH"
            //NameTable.append(username)
            //EmailTable.append(myemail)
            FriendsName.append(username as NSString)
            FriendsEmail.append(myemail as NSString)
            UNIDArray.append(userID as NSString)
            varNum = 1
            PlayerCount.append(varNum.description as NSString)
            
            self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            
            TableView.dataSource = self
            TableView.delegate = self
            
           groupgcviewcontroller.nrdelegate=self
            
           fbfriendsviewcontroller.fdelegate=self
            

        }
        
        
        @IBAction func FBLogin(_ sender: AnyObject) {
            
            // GetFBFriends()
            
            
            
            sendGameInvite()
            
            
        }
        
        @IBAction func AddContact(_ sender: AnyObject) {
            
           // let CurrentCount = NumFriends.count
            
            
            if NumFriends.count > 10 {
                
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Max Members Reached"
                alertView.message = "You can only have 10 players in a group."
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
                
            } else {
            
            let picker = ABPeoplePickerNavigationController()
            picker.peoplePickerDelegate = self
            
            picker.displayedProperties = [NSNumber(value: kABPersonEmailProperty as Int32)]
            
            //  picker.displayedProperties = [NSNumber(int: kABPersonFirstNameProperty)]
            
            if picker.responds(to: #selector(getter: ABPeoplePickerNavigationController.predicateForEnablingPerson)) {
                picker.predicateForEnablingPerson = NSPredicate(format: "emailAddresses.@count > 0")
            }
            
            present(picker, animated: true, completion: nil)
        }
        
        }
        
        @IBAction func backBTN(_ sender: AnyObject) {
            self.dismiss(animated: true, completion: nil)
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
            
            /*
            if ReloadView != "no"{
            GetGroupCoreData()
            }
            
            if NameInfo.count > 1 {
                AddNotice.hidden = true
            } else {
                AddNotice.hidden = false
            }
            */
 
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if ReloadView != "no"{
            GetGroupCoreData()
        }
        
        if NameInfo.count > 1 {
            AddNotice.isHidden = true
        } else {
            AddNotice.isHidden = false
        }
    //    EasyGameCenter.delegate = self
    
    }
    
    
        func GetGroupCoreData() {
            
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext!
             let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Person")
           // let fetchRequest = NSFetchRequest(entityName: "Person")
            //let error: NSError?
            
            do {
            let fetchedResults = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            
            
            
            if let results = fetchedResults {
                Friends = results
                print(Friends)
                
                
                
                for items in Friends as [NSManagedObject] {
                    
                    let FName = items.value(forKey: "name") as! String
                    print("Fname = \(FName)")
                    let EmailAdd = items.value(forKey: "email") as! String
                    print("EmailAdd = \(EmailAdd)")
                    let FID = items.value(forKey: "id") as! String
                    print("FID = \(FID)")
                    let GroupNameObject = items.value(forKey: "group") as! String
                    
                    print(items)
                    print(items.value(forKey: "name")!)
                    
                    if GroupNameObject == groupName as String {
                        
                        NameInfo.append(FName as NSString)
                        EmailInfo.append(EmailAdd as NSString)
                        FriendsName.append("NA")
                        FriendsEmail.append("NA")
                        UNIDArray.append(FID as NSString)
                        
                        // NumMembers++
                        // PlayerCount.append(NumMembers.description)
                        
                        
                        CurNum = NumFriends.count
                        CurNum += 1
                        NumFriends.append(CurNum)
                        
                    }
                    //   theFriends.append(MyFriends(name:FName,email:EmailAdd))
                    
                }
                
            }
            else {
               // print("Could not fetch \(error), \(error!.userInfo)")
            }
                
        } catch {
                print(error)
            }
            print("Friends Now: \(NameInfo)")
        }
        
        
        func didTouchUpInsidePickButton(_ sender: Int) {
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
            let multivalue: ABMultiValue = ABRecordCopyValue(person, property).takeRetainedValue()
            let index = ABMultiValueGetIndexForIdentifier(multivalue, identifier)
            let email = ABMultiValueCopyValueAtIndex(multivalue, index).takeRetainedValue() as! String
            let fullnameString : CFString = ABRecordCopyCompositeName(person).takeRetainedValue()
            let fullname : NSString = fullnameString as NSString
            
            savename(fullname, emailaddress: email, group: groupName)
            
            print("MultiValue: \(multivalue)")
            print("Email: \(email)")
            print("Name: \(fullname)")
            
            let emailParse1 = email.replacingOccurrences(of: "(", with: "")
            let emailParse2 = emailParse1.replacingOccurrences(of: ")", with: "")
            let emailParse3 = emailParse2.replacingOccurrences(of: " ", with: "")
            let emailParse4 = emailParse3.replacingOccurrences(of: "+", with: "")
            print("PARSED CONTACT: \(emailParse4)")
            
            EmailInfo.append(emailParse4 as NSString)
            NameInfo.append(fullname)
            
            // savename(email)
            
            self.TableView.reloadData()
            
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
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.NameInfo.count;
        }
        
        
        func removeObject<T : Equatable>(_ object: T, fromArray array: inout [T])
        {
            

            let index = array.index(of: object)
            
            if index! == 0 {
                print("Can't remove player1, at index 0")
            } else {
            
            array.remove(at: index!)
            
            }
        }
        
        
        func ContactsClicked(_ sender: UIButton!) {
            print("the Contacts tag: \(sender.tag)")
            
            replaceRow = sender.tag
            didTouchUpInsidePickButton(sender.tag)
            
            
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "GC Friends2" {
            
            let GroupGC2ViewController = segue.destination 
            GroupGC2ViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            
            GroupGC2ViewController.popoverPresentationController!.delegate = self
            
            if let destination = segue.destination as? GroupGCViewController {
                
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
    
    func GameCenterClicked(_ sender: UIButton!) {
      //  EasyGameCenter.findMatchWithMinPlayers(2, maxPlayers: 2)
        
        
        /*
        var GCFriends = [NSString]()
        
        localPlayer.loadFriendPlayersWithCompletionHandler({ (GCFriends) -> Void in
            println("TEST")
            println("GCFriend = \(GCFriends)")
        })
*/
        
        //EasyGameCenter.match(self)
        
       // EasyGameCenter.getPlayerInMatch()
       /*
        
        if let match = EasyGameCenter.getMatch() {
            println(match, terminator: "")
        }
*/
        
        /*
        var gcVC: GKGameCenterViewController = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = GKGameCenterViewControllerState.Leaderboards
        gcVC.leaderboardIdentifier = "LeaderboardID"
        self.presentViewController(gcVC, animated: true, completion: nil)
*/
        
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController!) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    
    /*
    func easyGameCenterMatchStarted() {
        print("match started")
        if let players = EasyGameCenter.getPlayerInMatch() {
            for player in players {
                print(player.alias, terminator: "")
            }
        }
    }
    
    func easyGameCenterMatchRecept(match: GKMatch, didReceiveData data: NSData, fromPlayer playerID: String) {
        
        let autre = Packet.unarchive(data)
        print("player id = \(playerID)")
        print("packet name = \(autre.name)")
        print("packet.index = \(autre.index)")
    }
*/
    
        func FacebookClicked(_ sender: UIButton!) {
            replaceRow = sender.tag
            
            print("replace row selected: \(replaceRow)")
            
            
            let FBFriendViewController2 = self.storyboard?.instantiateViewController(withIdentifier: "FB Friends") as! FBFriendsViewController
            

            FBFriendViewController2.fdelegate = self
            
            
            FBFriendViewController2.modalPresentationStyle = .popover
            
            
            
            if FBSDKAccessToken.current() != nil {
                
 
                if let popoverControllerFB = FBFriendViewController2.popoverPresentationController {
          
                    popoverControllerFB.sourceView = self.view
      
                    let DeviceW = self.view.frame.width
                    let middleScreenW = DeviceW / 2
                    let middleX = middleScreenW - 100
                    
                    popoverControllerFB.sourceRect = CGRect(x: middleX,y: 150,width: 0,height: 0)
                    
                  //  popoverControllerFB.permittedArrowDirections = nil
                    popoverControllerFB.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
                    
                    popoverControllerFB.delegate = self
                }
                self.present(FBFriendViewController2, animated: true, completion: nil)
                
            
            
            } else {
    
            let loginManager = FBSDKLoginManager()
            let Permission = ["public_profile", "email", "user_friends"]
            loginManager.logIn(withReadPermissions: Permission, handler: { (result, error) -> Void in
                
                if (error == nil) {
                    let fbloginresult: FBSDKLoginManagerLoginResult = result!
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                    

                        if let popoverControllerFB = FBFriendViewController2.popoverPresentationController {
                       
                            popoverControllerFB.sourceView = self.view
                 
                            popoverControllerFB.sourceRect = CGRect(x: 100,y: 100,width: 0,height: 0)
                            
                          //  popoverControllerFB.permittedArrowDirections = nil
                            popoverControllerFB.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
                            
                            popoverControllerFB.delegate = self
                        }
                        self.present(FBFriendViewController2, animated: true, completion: nil)
                        
                    } else {
                        print("Facebook not authorized")
                    }
                    
                    /*
                    
                    println("the facebook tag: \(sender.tag)")
                    
                    let loginManager = FBSDKLoginManager()
                    let Permission = ["public_profile", "email", "user_friends"]
                    loginManager.logInWithReadPermissions(Permission, handler: { (result, error) -> Void in
                    
                    if (error == nil) {
                    var fbloginresult: FBSDKLoginManagerLoginResult = result
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                    var tempDict = self.getFBUserData()
                    //fbLoginManager.logOut()
                    
                    var TestDict = self.ParseJSON(tempDict)
                    
                    println("Test JSON: \(TestDict)")
                    
                    sendGameInvitenew()
                    }
                    }
                    })
                    */
                    
                }
                
            })
        }
            
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
        /*
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
        println("FB Already logged in")
        
        } else
        {
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        // self.view.addSubview(loginView)
        // loginView.center = self.view.center
        loginView.readPermissions = ["public_profile", "email", "user_friends"]
        //  loginView.delegate = self
        println("reading facebook permissions")
        }
        
        
        
        FBFriends()
        
        self.TableView.reloadData()
        }
        
        */
        
        /* FBSDKGraphRequest(graphPath: "/me/friends", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
        */
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
        
        
    func PreviousFriendsClicked(_ sender: UIButton!) {
        
        replaceRow = sender.tag
        print("the gamecenter tag: \(sender.tag)")
        
        
        let GCFriendViewController = storyboard?.instantiateViewController(withIdentifier: "GC Friends2") as! GroupGCViewController
        
        //let savingsInformationViewController = WeaponsViewController(nibName: "WeaponsMenu", bundle: nil)
        //  savingsInformationViewController.delegate=self
        
        //   savingsInformationViewController.weaponPKLabel=weaponLabel.text
        GCFriendViewController.nrdelegate = self
        
        
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
            
         //   popoverControllerGC.permittedArrowDirections = nil
            popoverControllerGC.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
            
            popoverControllerGC.delegate = self
        }
        present(GCFriendViewController, animated: true, completion: nil)
        
        
        
        // self.TableView.reloadData()
    }
        
        
        @IBAction func AddPlayer(_ sender: AnyObject) {
            //self.TableView.reloadData()
            
print("Current Number = \(CurNum)")
            
            
            if NumFriends.count > 1 {
                AddNotice.isHidden = true
            } else {
                AddNotice.isHidden = false
            }
            
                if CurNum > 9 {
                    
                    
                    let AC = JSController("Group Members Limit", MyMessage: "You cannot have more than 10 players in a group",Color: "Red")
                    self.present(AC, animated: true, completion: nil)
                    
                } else {
                    CurNum += 1
                    NameInfo.append("NA")
                    print("Current Friends # = \(CurNum)")
                    EmailInfo.append("NA")
                    NumFriends.append(CurNum)
                    print("Number of friends: \(NumFriends.count)")
                    FriendsName.append("NA")
                    FriendsEmail.append("NA")
                    UNIDArray.append("NA")
                    
                    self.TableView.reloadData()
                }
            
        }
        
        @IBAction func DeletePlayer(_ sender: AnyObject) {
            
            let tempNum = (NameInfo.count) - 1
            let tempNameLast = NameInfo[tempNum]
            
            
            if tempNameLast == "NA" {

                    CurNum -= 1
                    NameInfo.removeLast()
                    EmailInfo.removeLast()
                    NumFriends.removeLast()
                    UNIDArray.removeLast()
                    self.TableView.reloadData()
            } else  {
                print("Last user is saved in coredata")
                
                let AC = JSController("Error", MyMessage: "To Delete already Saved group members click the edit button below then Delete.",Color: "Red")
                self.present(AC, animated: true, completion: nil)
                
                
            }
            
            if NumFriends.count > 1 {
                AddNotice.isHidden = true
            } else {
                AddNotice.isHidden = false
            }

        }
    
    /*
    @IBAction func SendData(sender: AnyObject) {
        
        print("sending data to GC Players")
        
        let myStruct = Packet(name: "My Data to send!", index: 1234567890, numberOfPackets: 1)
            
      //  EasyGameCenter.sendDataToAllPlayers(myStruct.archive(), modeSend: .Reliable)
    }
    */
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

        
        
        @IBAction func editTableView(_ sender: AnyObject) {
            
            if TableView.isEditing{
                TableView.setEditing(false, animated: false)
                //EditBTN.style = UIBarButtonItemStyle.Plain;
                EditBTN.setTitle("Edit", for: UIControlState())
                
                
                
                TableView.reloadData()
            } else {
                TableView.setEditing(true, animated: true)
                EditBTN.setTitle("Done", for: UIControlState())
                
                
                //EditBTN.style = UIBarButtonItemStyle.Done;
                TableView.reloadData()
            }
            
            
        }
        
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
            
            
            if (indexPath as NSIndexPath).row == 0 {
            
                let AC = JSController("Error", MyMessage: "You cannot delete yourself from the group",Color: "Red")
                self.present(AC, animated: true, completion: nil)
                
            } else {
            
            
            if tableView == TableView {
                switch editingStyle {
                case .delete:
                    
                    /*
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    
                    let managedContext = appDelegate.managedObjectContext!
                    
                    let fetchRequest = NSFetchRequest(entityName: "Person")
                    var error: NSError?
                    let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
                    
                     var EditPersonName = NSString()
                     var EditPersonGroup = NSString()
                    
                    if let results = fetchedResults {
                        Friends = results
                        println(Friends)
                    
                        for items in Friends as [NSManagedObject] {
                            
                            EditPersonName = items.valueForKey("name") as! String
                            
                            EditPersonGroup = items.valueForKey("group") as! String
                        }
                        
                    
                    }
                    */
                    
                    
                    ///
                    
                    let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    let context:NSManagedObjectContext = appDel.managedObjectContext!
                    
                    //context.deleteObject(Friends[indexPath.row] as NSManagedObject)
                    
                    let editingPerson = Friends[(indexPath as NSIndexPath).row] as NSManagedObject
                    
                    print("Editing \(Friends[(indexPath as NSIndexPath).row]) in group \(groupName)")
                    
                    editingPerson.setValue("", forKey: "group")
                    
                    
              
                    
                    //Friends.removeAtIndex(indexPath.row)
                    NameInfo.remove(at: (indexPath as NSIndexPath).row)
                    
                    do {
                        try context.save()
                    } catch _ {
                    }
                    
                    CurNum = NumFriends.count
                    CurNum -= 1
                    NumFriends.append(CurNum)
                    
                    self.TableView.deleteRows(at: [indexPath], with: .fade)
                 ///
                    
                    
                    
                    
                default:
                    return
                }
            }
            /*
            if editingStyle == UITableViewCellEditingStyle.Delete {
            Friends.removeAtIndex(indexPath.row);
            //   EmailInfo.removeAtIndex(indexPath.row);
            //   NameInfo.removeAtIndex(indexPath.row)
            self.editTableView(EditBTN)
            TableView.reloadData()
            } else if editingStyle == UITableViewCellEditingStyle.Insert{
            //  Friends.append();
            //   EmailInfo.append("New Item");
            //   NameInfo.append("New Name");
            }
            */
        }
            
    }
        
        
        func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
            if tableView == TableView {
                return true;
            } else {
                //GROUP EDITING
                return true;
            }
        }
        
        
        func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            
            if (sourceIndexPath as NSIndexPath).row == 0 || (destinationIndexPath as NSIndexPath).row == 0 {
                
                let AC = JSController("Error", MyMessage: "You cannot move yourself from the first player slot",Color: "Red")
                self.present(AC, animated: true, completion: nil)
            } else {
            
            if tableView == TableView {
                //  let item : String = EmailInfo[sourceIndexPath.row] as String;
                //  let item2 : String = NameInfo[sourceIndexPath.row] as String;
                let item3 : NSManagedObject = Friends[(sourceIndexPath as NSIndexPath).row]
                //  EmailInfo.removeAtIndex(sourceIndexPath.row);
                //  NameInfo.removeAtIndex(sourceIndexPath.row);
                Friends.remove(at: (sourceIndexPath as NSIndexPath).row);
                //  EmailInfo.insert(item, atIndex: destinationIndexPath.row)
                //  NameInfo.insert(item2, atIndex: destinationIndexPath.row)
                Friends.insert(item3, at: (destinationIndexPath as NSIndexPath).row)
            }
        }
        
    }
 
    
  
    
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            cell.backgroundColor = UIColor.clear
           // cell.cellViewBG?.layer.cornerRadius = 10
           //   cell.cellViewBG?.layer
            
            if (Friends.isEmpty ) {
                print("No Friends")
                
                //  cell.titleLabel?.text = self.NameInfo[indexPath.row] as String
                cell.titleLabel?.text = "Select Player Info"
                //cell.numbers?.text =
                //   cell.subtitleLabel?.text = self.EmailInfo[indexPath.row] as String
            } else {
                
                //let person = Friends[indexPath.row]
                
                //cell.titleLabel!.text = person.valueForKey("name") as? String
                
            //if indexPath.row == 0 {
            
                
                if NameInfo[(indexPath as NSIndexPath).row] == NameInfo[0] {
                    
                    cell.TableImageFB.isHidden = true
                    cell.TableImageCTs.isHidden = true
                    cell.TableImageGC.isHidden = true
                    
                } else {
                    
                    cell.TableImageFB.isHidden = false
                    cell.TableImageCTs.isHidden = false
                    cell.TableImageGC.isHidden = false
                    

                    cell.TableImageFB?.imageView?.image = UIImage(named: "GameFriends_blue3.png")
                    cell.TableImageCTs?.imageView?.image = UIImage(named: "contacts.png")
                    
                    cell.TableImageCTs?.addTarget(self, action: #selector(GroupMembersViewController.ContactsClicked(_:)), for: .touchUpInside)
                    
                    cell.TableImageCTs?.tag = (indexPath as NSIndexPath).row
                    
                    cell.TableImageFB?.addTarget(self, action: #selector(GroupMembersViewController.PreviousFriendsClicked(_:)), for: .touchUpInside)
                    cell.TableImageFB?.tag = (indexPath as NSIndexPath).row
                    
                    cell.TableImageGC?.addTarget(self, action: #selector(GroupMembersViewController.GameCenterClicked(_:)), for: .touchUpInside)
                    cell.TableImageGC?.tag = (indexPath as NSIndexPath).row
                    
                    
                    cell.TableImageGC?.imageView?.image = UIImage(named: "GameCenter.png")

                    
                }
                
                
                if NameInfo[(indexPath as NSIndexPath).row] == "NA" {
                   cell.titleLabel!.text = "Select Friend ->"
                } else {
                
                cell.titleLabel!.text = NameInfo[(indexPath as NSIndexPath).row] as String
                
                }
               // cell.subtitleLabel!.text = person.valueForKey("email") as? String
                cell.numbers?.text = NumFriends[(indexPath as NSIndexPath).row].description as String
               // cell.numbers?.text = self.NumFriends[indexPath.row].description
                
               
                


            }
            
                    //       cell.titleLabel?.text = self.NameTable[indexPath.row] as String
         //       cell.numbers?.text = self.NumFriends[indexPath.row].description
          
            
            return cell
        }

    
    func savename(_ name: NSString, emailaddress: String, group: NSString) {
        
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext!
            
            let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)
            
            let person = NSManagedObject(entity: entity!, insertInto: managedContext)
            
            let FID = "FIND"
            
            person.setValue(name, forKey: "name")
            person.setValue(emailaddress, forKey: "email")
            person.setValue(groupName, forKey: "group")
            person.setValue(FID, forKey: "id")
            
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

        

        
        
        @IBAction func showAlertTapped(_ sender: AnyObject) {
            
            var FriendsPlaying = [NSString]()
            FriendsPlaying = self.FriendsName
            
            print("Friends Playing Before: \(FriendsPlaying)")
            
            FriendsPlaying = FriendsPlaying.filter{$0 != "NA"}
            
            
            print("Friends Playing After: \(FriendsPlaying)")
            
            var Message = NSString()
            
            
            if FriendsPlaying.count == 1 {
                Message = "You are starting a New Game with only \(FriendsPlaying.count) person.  I think you should add more players...or do you not have any friends, that's sad." as NSString}
            if FriendsPlaying.count == 10 {
                Message = "Alright! You have \(FriendsPlaying.count) people playing.  You ready?" as NSString }
            if FriendsPlaying.count >= 4 && FriendsPlaying.count <= 9 {
                Message = "Ok...that's enough people, You have \(FriendsPlaying.count) people playing.  Start Game?" as NSString}
            if FriendsPlaying.count > 1 && FriendsPlaying.count <= 3 {
                Message = "Only \(FriendsPlaying.count) people playing.  This Game will be short.  You and ALL your friends ready?" as NSString
            }
            if FriendsPlaying.count > 10 {
                Message = "Uh Oh! You have more than 10 people playing.  Right now this game only goes up to 10 people sorry." }
            //Create the AlertController
            let actionSheetController: UIAlertController = UIAlertController(title: "New Game", message: Message as String, preferredStyle: .alert)
            
            //Create and add the Cancel action
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                //Do some stuff
            }
            actionSheetController.addAction(cancelAction)
            //Create and an option action
            let nextAction: UIAlertAction = UIAlertAction(title: "Let's Go", style: .default) { action -> Void in
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
                

                
                
            }
            if FriendsPlaying.count > 10 { print("oops. more than 10 people")
            } else {
                actionSheetController.addAction(nextAction)
            }
      
            self.present(actionSheetController, animated: true, completion: nil)
        }
    
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

        
}


//extension GroupMembersViewController : GroupGCViewControllerDelegate {
 extension GroupMembersViewController {
    func GroupGCViewControllerFinished(_ groupgcviewController: GroupGCViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        self.GCFriendName = groupgcviewController.GCFriendName
        
        self.GCFriendID = groupgcviewController.GCFriendID
        //self.GCFriendContact = repeatfriendsviewController.GCFriendContact
        self.GCFriendContact = "PUSH"
        
        self.SelectedGCFriend = groupgcviewController.SelectedGCFriend
        // self.replaceRow = repeatfriendsviewController.RowSelected
        
        
        
        self.NameInfo.remove(at: self.replaceRow);
        self.EmailInfo.remove(at: self.replaceRow);
        self.UNIDArray.remove(at: self.replaceRow)
        // self.NameInfo.removeAtIndex(self.replaceRow);
        //  self.EmailInfo.removeAtIndex(replaceRow);
        
        
        self.NameInfo.insert(self.GCFriendName, at: self.replaceRow);
        self.EmailInfo.insert(self.GCFriendContact, at: self.replaceRow);
        self.UNIDArray.insert(self.GCFriendID, at: self.replaceRow)
        
        print("Game Center replace at Row: \(self.replaceRow)")
        
        
        
        //editingPerson.setValue(self.GCFriendName, forKey: "name")
        //editingPerson.setValue(self.GCFriendContact, forKey: "email")
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)
        
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        person.setValue(self.GCFriendName, forKey: "name")
        person.setValue(self.GCFriendContact, forKey: "email")
        person.setValue(groupName, forKey: "group")
        person.setValue(self.GCFriendID, forKey: "id")
        
        var error: NSError?
        
        do {
            try managedContext.save()
        } catch let error1 as NSError {
            error = error1
            print("Could not save \(error), \(error!.userInfo)")
        }
        Friends.append(person)
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
        self.ReloadView = "no"
        self.TableView.reloadData()
        
    }
}

//extension GroupMembersViewController : FBFriendsViewControllerDelegate {
    
    extension GroupMembersViewController {
    func FBFriendsViewControllerFinished(_ fbfriendsviewController: FBFriendsViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        self.FBFriendName = fbfriendsviewController.FBFriendName
        
        self.FBFriendContact = fbfriendsviewController.FBFriendContact
        self.FBFriendID = fbfriendsviewController.FBFriendID
        
        print("FaceBook friend:\(self.FBFriendName)")
        print("Facebook Player ID: \(FBFriendContact)")
        
        self.SelectedFBFriend = fbfriendsviewController.FBSelected
        //self.replaceRow = fbfriendsviewController.RowSelected
        
        self.NameInfo.remove(at: self.replaceRow);
        self.EmailInfo.remove(at: self.replaceRow);
        self.UNIDArray.remove(at: self.replaceRow);
        //self.Num
        
        print("Facebook replace at Row: \(self.replaceRow)")
        
        //   self.NameInfo.removeAtIndex(self.replaceRow);
        
        //   self.EmailInfo.removeAtIndex(replaceRow);
        //      NameInfo.removeAtIndex(sourceIndexPath.row);
        
        
        self.NameInfo.insert(self.FBFriendName, at: self.replaceRow)
        self.EmailInfo.insert(self.FBFriendContact, at: self.replaceRow);
        self.UNIDArray.insert(self.FBFriendID, at: self.replaceRow)
        
        //self.TableView.reloadData()
        
        //  self.NameInfo.insert(self.FBFriendName, atIndex: self.replaceRow)
        //   self.EmailInfo.insert(self.FBFriendContact, atIndex: self.replaceRow)
        
        
        /*
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        
        //context.deleteObject(Friends[indexPath.row] as NSManagedObject)
        
        let editingPerson = Friends[self.replaceRow] as NSManagedObject
        
        editingPerson.setValue(self.FBFriendName, forKey: "name")
        editingPerson.setValue(self.FBFriendContact, forKey: "email")
        
        context.save(nil)
        */
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)
        
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        person.setValue(self.FBFriendName, forKey: "name")
        person.setValue(self.FBFriendContact, forKey: "email")
        person.setValue(self.FBFriendID, forKey: "id")
        person.setValue(groupName, forKey: "group")
        
        var error: NSError?
        
        do {
            try managedContext.save()
        } catch let error1 as NSError {
            error = error1
            print("Could not save \(error), \(error!.userInfo)")
        }
        Friends.append(person)
        
        self.ReloadView = "no"
        self.TableView.reloadData()
        
       // self.savename(self.FBFriendName, emailaddress: self.FBFriendContact as String, group: groupName)
        
        
     

        
        
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
