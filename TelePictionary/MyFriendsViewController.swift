//
//  MyFriendsViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/20/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import AddressBookUI
import CoreData
import GameKit
import FBSDKShareKit
import FBSDKCoreKit
import FBSDKLoginKit
import MessageUI
import iAd


class MyFriendsViewController: UIViewController, ABPeoplePickerNavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, FBSDKAppInviteDialogDelegate, MFMessageComposeViewControllerDelegate, ADInterstitialAdDelegate {
    
    var interAd: ADInterstitialAd?
    var interAdView = UIView()
    var closeButton = UIButton(type: UIButtonType.system)
    
    let prefs:UserDefaults = UserDefaults.standard
    
    var ViewHowTo = Bool()
    @IBOutlet var ViewHolder: UIView!
    var userID = NSString()
    @IBOutlet var View1: UIView!
    
    @IBOutlet var ViewHolderTOP: NSLayoutConstraint!
    
    @IBOutlet var View1TOP: NSLayoutConstraint!
    
    @IBOutlet var View1CloseBTN: UIButton!
    
    @IBOutlet var HowToMyGamesLBL: UILabel!
    @IBOutlet var HowToMyGamesLBL2: UILabel!
    @IBOutlet var HowToMyGamesLBL3: UILabel!
    @IBOutlet var HowToMyGamesLBL4: UILabel!
    
    @IBOutlet weak var closeView1: UIButton!
    @IBOutlet weak var closeView2: UIButton!
    @IBOutlet weak var closeView3: UIButton!
    
    @IBOutlet var subViewHolder: UIView!

    @IBOutlet var subViewHolderTOP: NSLayoutConstraint!
    
    @IBOutlet var View4: UIView!
    @IBOutlet var View3: UIView!
    
    @IBOutlet var View2: UIView!

    @IBOutlet var View2BTN: UIButton!
    
    @IBOutlet var View1BTN: UIButton!
    
    @IBOutlet var View3BTN: UIButton!
    @IBOutlet var View4BTN: UIButton!
    // @IBOutlet weak var lblView: UIView!
    @IBOutlet var View2TOP: NSLayoutConstraint!
    
    @IBOutlet var View3TOP: NSLayoutConstraint!
    
    @IBOutlet var View4TOP: NSLayoutConstraint!
    
    
    
    @IBOutlet var AddPlayerInfoLBL: UILabel!
    //@IBOutlet var View1TOP: NSLayoutConstraint!
    @IBOutlet var GroupInfoLBL: UILabel!
    
    @IBOutlet weak var tablegroupsBottom: NSLayoutConstraint!
    
    @IBOutlet weak var tablefriendsBottom: NSLayoutConstraint!
    
    @IBOutlet weak var EditBTN: UIButton!
    @IBOutlet weak var toolbar: UIToolbar!
    
    //@IBOutlet weak var EditBTn: UIBarButtonItem!
    
    var localPlayer = GKLocalPlayer.localPlayer()
    var AddGroupName = NSString()
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    //@IBOutlet weak var EditBTN: UIBarButtonItem!
    
    let index = 10
    var username = String()
    var myemail = String(0)
    
 
    //@IBOutlet weak var View: UIView!

    @IBOutlet weak var inviteView: UIView!
    @IBOutlet weak var facebookBTN: UIButton!
    //@IBOutlet weak var TableView: UITableView!
    
    @IBOutlet weak var AddGroupBTN: UIButton!
    
    var Friends = [NSManagedObject]()
    var Groups = [NSManagedObject]()
    var GCFriends = [NSString]()
    
    var GroupMemberName = [NSString]()
    var GroupMemberEmail = [NSString]()
    var GroupName = [NSString]()
    
    var EmailInfo = [NSString]()
    var NameInfo = [NSString]()
    
    
    var EmailName = NSString()
    var EmailAddress = NSString()
    
    var numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    var NumFriends = [Int]()
    var NumGroups = [Int]()
    var CurNum = Int()
    var CurNumGroups = Int()
    
    @IBOutlet weak var myFriendsBTN: UIButton!
    
    @IBOutlet weak var myGroupsBTN: UIButton!
    
    @IBOutlet weak var tableViewGroups: UITableView!
    
    
    @IBOutlet weak var turntimeBTN: UIButton!
    
    @IBAction func MyGroupsBTN(_ sender: AnyObject) {

        if tableViewGroups.isHidden == true {
            if inviteView.isHidden == true {
                /*
            UIView.animateWithDuration(0.3, animations: {
                self.myGroupsBTN.center.y = (self.toolbar.frame.origin.y) - 130
                
         self.AddGroupBTN.center.y = (self.toolbar.frame.origin.y) - 130
                
            })
            tableViewGroups.hidden = false
*/
            tableViewGroups.isHidden = false
                
            } else {
              
                UIView.animate(withDuration: 0.3, animations: {
                    self.myGroupsBTN.center.y = (self.toolbar.frame.origin.y) - 120
                    
                    self.AddGroupBTN.center.y = (self.toolbar.frame.origin.y) - 120
                    
                    self.view.layoutIfNeeded()
                })
                tableViewGroups.isHidden = false
                
            }
            
                
      } else if tableViewGroups.isHidden == false {
            
            if inviteView.isHidden == true {
                /*
                UIView.animateWithDuration(0.3, animations: {
                self.myGroupsBTN.center.y = (self.toolbar.frame.origin.y) - 130
                
                self.AddGroupBTN.center.y = (self.toolbar.frame.origin.y) - 130
                
                })
                tableViewGroups.hidden = false
                */
                tableViewGroups.isHidden = true
                
            } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.myGroupsBTN.center.y = (self.toolbar.frame.origin.y) - 30
                self.AddGroupBTN.center.y = (self.toolbar.frame.origin.y) - 30
                self.tablefriendsBottom.constant = 0
                //self.TableView.layoutIfNeeded()
                self.view.layoutIfNeeded()
                
            })
        
            tableViewGroups.isHidden = true
            
                
            }
     }
    }
    
    
    
    @IBAction func MyFriendsBTN(_ sender: AnyObject) {
        
       // tablegroupsBottom.constant = 0
       // tableViewGroups.frame.size.height > 600
       
        
        if inviteView.isHidden == true {
           

            UIView.animate(withDuration: 0.3, animations: {
                
                
                
                
                self.myGroupsBTN.center.y = (self.inviteView.frame.origin.y) + 70
                self.AddGroupBTN.center.y = (self.inviteView.frame.origin.y) + 70
                
                self.tableViewGroups.center.y = (self.myGroupsBTN.frame.origin.y) + 80
                
               // self.view.layoutIfNeeded()
                
                self.inviteView.isHidden = false
                
                self.inviteView.center.y = (self.myFriendsBTN.frame.origin.y) + 170
        
               self.view.layoutIfNeeded()
                
                           // self.TableView.frame.size.height = 200
                
            })
            /*
            UIView.animateWithDuration(0.3, animations: {
                self.tableViewGroups.center.y = (self.myGroupsBTN.frame.origin.y) + 80
                
                self.view.layoutIfNeeded()
            })
*/
            
            // turntimeBTN.center.y = turntimeBTN.center.y + 65
        } else if inviteView.isHidden == false {
            // QuoteBox.hidden = true
            

            UIView.animate(withDuration: 0.3, animations: {
             //   self.TableView.hidden = true
             //   self.tablegroupsBottom.constant = 0
                self.inviteView.center.y = self.myFriendsBTN.center.y - 600
                self.inviteView.isHidden = true
                
             //   self.TableView.frame.size.height = 0
                
                self.myGroupsBTN.center.y = (self.view.frame.origin.y) + 120
                self.AddGroupBTN.center.y = (self.view.frame.origin.y) + 120
                self.tableViewGroups.center.y = self.AddGroupBTN.center.y + 60
                
               // self.tableViewGroups.frame.size.height = 600
                self.inviteView.layoutIfNeeded()
              //  self.myGroupsBTN.setNeedsDisplay()
                
            })
            
            UIView.animate(withDuration: 0.3, animations: {
               // self.tableViewGroups.center.y = (self.view.frame.origin.y) + 135
               

            })
        }
    }
    
    
    @IBAction func AddGroupBTN(_ sender: AnyObject) {
        
        
        /*
        print("adding group")
        var groupTextField: UITextField?
        
        let actionSheetController: UIAlertController = UIAlertController(title: "New Group", message: "Enter Group Name", preferredStyle: .Alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            
        }
        actionSheetController.addAction(cancelAction)
        let nextAction: UIAlertAction = UIAlertAction(title: "Done", style: .Default) { action -> Void in
            self.AddGroupName = groupTextField!.text!
        print("Group name entered \(self.AddGroupName)")
            //saveGroup(textField.text)
            self.savegroup(self.AddGroupName)
            self.tableViewGroups.reloadData()
        }
        actionSheetController.addAction(nextAction)
        
        actionSheetController.addTextFieldWithConfigurationHandler { textField -> Void in
            //textField.textColor = UIColor.blueColor()
            textField.textAlignment = .Center
            textField.autocorrectionType = UITextAutocorrectionType.Yes
            textField.autocapitalizationType = UITextAutocapitalizationType.Words
            groupTextField = textField
        }
        
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
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        */
        
        
        
        let alert = SCLAlertView()
        let txt = alert.addTextField("Enter Group Name Here")
        txt.textAlignment = .center
        txt.autocorrectionType = UITextAutocorrectionType.yes
        txt.autocapitalizationType = UITextAutocapitalizationType.words
        
        alert.addButton("Submit") {
            
            //self.AddGroupName = alert.
            self.AddGroupName = txt.text! as NSString
            print("Group name entered \(self.AddGroupName)")
            //saveGroup(textField.text)
            self.savegroup(self.AddGroupName)
            self.tableViewGroups.reloadData()
        }
        
      
        
      //  alert.showEdit("New Group", subTitle:"Enter Group Name")
        
        alert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "New Group", subTitle: "Enter Group Name", duration: nil, completeText: "Cancel", style: .custom, colorStyle: 1, colorTextButton: 1)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        /*
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName: "Person")

        var error: NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            Friends = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
       
        for items in Friends as [NSManagedObject] {
            
            CurNum++
            NumFriends.append(CurNum)
            
                      //   theFriends.append(MyFriends(name:FName,email:EmailAdd))
            
        }

*/
        
        let managedContextGroups = appDelegate.managedObjectContext
       // let fetchGroups = NSFetchRequest(entityName: "Group")
         let fetchGroups: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Group")
        let errorGroups: NSError?
        
        do {
        let fetchedResultsGroups =  try managedContextGroups!.fetch(fetchGroups) as? [NSManagedObject]
        
        if let resultsGroups = fetchedResultsGroups {
            Groups = resultsGroups
        } else {
            //println("Could not fetch\(errorGroups), \(errorGroups!.userInfo)")
        }
        
        for itemsGroups in Groups as [NSManagedObject] {
            CurNumGroups += 1
            NumGroups.append(CurNumGroups)
            
        }
        
        if self.Groups.count > 0 {
            GroupInfoLBL.isHidden = true
        } else {
            GroupInfoLBL.isHidden = false
        }
        
        
        } catch {
            print(error)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My Friends"
    /*
        if let font = UIFont(name: "ChalkboardSE-Regular", size: 20.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: font]
        }
     */
        
        HowToMyGamesLBL.layer.masksToBounds = true
        
        HowToMyGamesLBL.roundCorners([.topLeft, .topRight], radius: 10)
        
        HowToMyGamesLBL2.layer.masksToBounds = true
        
        HowToMyGamesLBL2.roundCorners([.topLeft, .topRight], radius: 10)
        
        HowToMyGamesLBL3.layer.masksToBounds = true
        
        HowToMyGamesLBL3.roundCorners([.topLeft, .topRight], radius: 10)
        
        HowToMyGamesLBL4.layer.masksToBounds = true
        
        HowToMyGamesLBL4.roundCorners([.topLeft, .topRight], radius: 10)
        
        
        View1BTN.layer.cornerRadius = 10
        View2BTN.layer.cornerRadius = 10
        View3BTN.layer.cornerRadius = 10
        subViewHolder.layer.cornerRadius = 10
        
        View1.layer.cornerRadius = 10
        View2.layer.cornerRadius = 10
        View3.layer.cornerRadius = 10
        View4.layer.cornerRadius = 10
        
        if let font = UIFont(name: "DK Cool Crayon", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.white]
        }        //self.
        
            //self.TableView.backgroundColor = UIColor.clearColor()
        
       // self.TableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.tableViewGroups.backgroundColor = UIColor.clear
        
        self.tableViewGroups.separatorStyle = UITableViewCellSeparatorStyle.none
        
 //navigationController!.navigationBar.barTintColor = UIColor(red: 0.0, green: 0.941, blue: 0.6078, alpha: 0.1)
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
        
        self.navigationController!.toolbar.barTintColor = UIColor(red: 0.572, green: 0.882, blue: 0.949, alpha: 0.1)
        
        
       
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
       // let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        if prefs.value(forKey: "USERNAME")  != nil {
        username = prefs.value(forKey: "USERNAME") as! NSString as String
        userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
    
        } else {
            username = ""
            userID = ""
        }
        
        myemail = "jared.stevens@\(ServerInfo.sharedInstance)"
        NameInfo.append(username as NSString)
        EmailInfo.append(myemail as NSString)
        
       // TableView.dataSource = self
       // TableView.delegate = self
        tableViewGroups.dataSource = self
        tableViewGroups.dataSource = self
        
        View1.layer.cornerRadius = 10
        //View1CloseBTN.layer.cornerRadius = 10
        View4BTN.layer.cornerRadius = 10
        
        
        ViewHolder.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        
        let AlreadySeenHowTo = prefs.bool(forKey: "DidShowHowTo_MyFriends")
        
        if !AlreadySeenHowTo {
            closeView1.isHidden = true
            closeView2.isHidden = true
            closeView3.isHidden = true
            
            View1TOP.constant = 0
            View2TOP.constant = 0
            View3TOP.constant = 0
            View4TOP.constant = 0
            subViewHolderTOP.constant = middleY
            
           // ViewHolderTOP.constant = 0
            
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            self.subViewHolderTOP.constant = middleY
            
            self.ViewHolder.center.y = self.ViewHolder.center.y - 1000
            
            self.ViewHolderTOP.constant = 0
            //self.ViewShowing = true
            // ShowingInfo = true
            
            // self.ViewTransTOP.constant = 0
            self.ViewHowTo = true
        })
      }
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: Selector("didTouchUpInsidePickButton:"))
        self.interstitialPresentationPolicy = ADInterstitialPresentationPolicy.automatic
    }
    
    
    func AddPlayer1Name(_ name: NSString) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)
        
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        person.setValue(self.username, forKey: "name")
        person.setValue("PUSH", forKey: "email")
        person.setValue(name, forKey: "group")
        person.setValue(self.userID, forKey: "id")
        
        var error: NSError?
        
        do {
            try managedContext.save()
        } catch let error1 as NSError {
            error = error1
            print("Could not save \(error), \(error!.userInfo)")
        }
        //Friends.append(person)
        //CurNum = NumFriends.count
        //CurNum++
        //NumFriends.append(CurNum)
    }
    
    func savegroup(_ name: NSString) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entity(forEntityName: "Group", in: managedContext)
        
        let group = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        group.setValue(name, forKey: "groupname")
        //person.setValue(emailaddress, forKey: "email")
        
        var error: NSError?
        
        do {
            try managedContext.save()
        } catch let error1 as NSError {
            error = error1
            print("Could not save \(error), \(error!.userInfo)")
        }
        Groups.append(group)
        CurNumGroups = NumGroups.count
        CurNumGroups += 1
        NumGroups.append(CurNumGroups)
        
        AddPlayer1Name(name)
    }
    
  func AddContact() {
        let picker = ABPeoplePickerNavigationController()
        picker.peoplePickerDelegate = self
        
        picker.displayedProperties = [NSNumber(value: kABPersonEmailProperty as Int32)]
        
        //  picker.displayedProperties = [NSNumber(int: kABPersonFirstNameProperty)]
        
        if picker.responds(to: #selector(getter: ABPeoplePickerNavigationController.predicateForEnablingPerson)) {
            picker.predicateForEnablingPerson = NSPredicate(format: "emailAddresses.@count > 0")
        }
        
        present(picker, animated: true, completion: nil)
        
    }
    
    var result: NSDictionary!
    
    
    @IBAction func FBfriendsBTN(_ sender: AnyObject) {
        //FACEBOOK FUNCTIONS
        //GetFBFriends()
    sendGameInvite()
    }
    
    func sendGameInvite() {
       
        print("trying to send invite")
        let inviteDialog:FBSDKAppInviteDialog = FBSDKAppInviteDialog()
        if(inviteDialog.canShow()){
            //let appLinkUrl:NSURL = NSURL(string: "TelePictionary://article/FacebookInvite?")!
            
             let appLinkUrl:URL = URL(string: "https://fb.me/675432082558667")!
            
            //let appLinkUrl:NSURL = NSURL(string: "https://fb.me/669563119812230")!
            
            let previewImageUrl:URL = URL(string: "https://\(ServerInfo.sharedInstance)/Apps/TelePictionary/Images/PicsQuotesLogo.png")!
            
            let inviteContent: FBSDKAppInviteContent = FBSDKAppInviteContent()
            //appLinkURL: appLinkUrl)
            // (appLinkURL: appLinkUrl)
            inviteContent.appLinkURL = appLinkUrl
            // inviteContent.
                        inviteContent.appInvitePreviewImageURL = previewImageUrl
            
            print("app invite should be shown here")
            inviteDialog.content = inviteContent
            //inviteDialog
            inviteDialog.delegate = self
            inviteDialog.show()
        }
    }
    
    func appInviteDialog(_ appInviteDialog: FBSDKAppInviteDialog!, didCompleteWithResults results: [AnyHashable: Any]!) {
        print("did complete")
    }
    
    func appInviteDialog(_ appInviteDialog: FBSDKAppInviteDialog!, didFailWithError error: Error!) {
    print("did not complete: error = \(error)")
    }
    
    
    func SelectEmail() {
        let picker = ABPeoplePickerNavigationController()
        picker.peoplePickerDelegate = self
        
      //  picker.displayedProperties = [NSNumber(int: kABPersonEmailProperty)]
        
      //  picker.displayedProperties = [NSNumber(int: kABPersonFirstNameProperty)]
        
        if picker.responds(to: #selector(getter: ABPeoplePickerNavigationController.predicateForEnablingPerson)) {
            picker.predicateForEnablingPerson = NSPredicate(format: "emailAddresses.@count > 0")
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    
    func peoplePickerNavigationController(_ peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord, property: ABPropertyID, identifier: ABMultiValueIdentifier) {
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
 
    }
    
    
    func EmailController(_ name: NSString, address: NSString) {
        
     print("creating email controller")
    
    let alertController = UIAlertController(title: "Email Invite", message: "Send Email Now?", preferredStyle: .alert)
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
        
        
        let SentResult = EmailInvite(EmailField!.text! as NSString, username: self.username as NSString, ToUser: name)
        
        if SentResult {
            print("Email Sent")
        }
        
        
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

    
    /*        let emails: ABMultiValueRef = ABRecordCopyValue(person, kABPersonEmailProperty).takeRetainedValue()
    if (ABMultiValueGetCount(emails) > 0) {
    let index = 0 as CFIndex
    let email = ABMultiValueCopyValueAtIndex(emails, index).takeRetainedValue() as! String
    
    println("first email for selected contact = \(email)")
    } else {
    println("No email address")
    }
    
    */
    
    @IBAction func SentTextBTN(_ sender: AnyObject) {
        
        let messageVC = MFMessageComposeViewController()
        //var messageTo = " "
        
       // messageVC.body = "TelePictionary://article/EmailInvite?gameid=\(self.GameID)&turn=\(self.UserSelected)&name=\(messageTo)";
        
       // messageVC.body = "       http://appstore.com/Pics&Quotes"
        messageVC.body = "       http://itunes.apple.com/us/app/pics%26quotes/id1023231287?mt=8"
        //messageVC.recipients = [""]
        messageVC.messageComposeDelegate = self;
        //  messageVC.addAttachmentData(imageData!, typeIdentifier: "image/jpeg", filename: "GamePhoto.jpeg")
        
        self.present(messageVC, animated: false, completion: nil)
        
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
      //  if tableView == TableView {
      //  return self.Friends.count;
      //  } else {
        
        if self.Groups.count > 0 {
            GroupInfoLBL.isHidden = true
            
            if self.Groups.count > 1 {
                AddPlayerInfoLBL.isHidden = true
            } else {
                AddPlayerInfoLBL.isHidden = false
            }
            
        } else {
            GroupInfoLBL.isHidden = false
            AddPlayerInfoLBL.isHidden = true
        }
        
                    return self.Groups.count;
      //  }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      //  if tableView == TableView {
      //  let row = indexPath.row
     //   let selectedResult = indexPath.item
     //   var FriendsRow = Friends[row]
     //   println(FriendsRow)
     //   } else {
        let row = (indexPath as NSIndexPath).row
        _ = (indexPath as NSIndexPath).item
        let GroupsRow = Groups[row]
        print(GroupsRow)
        self.performSegue(withIdentifier: "goto_groupmembers", sender: self)
     //   }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cell = TableView.dequeueReusableCellWithIdentifier("BasicCell", forIndexPath: indexPath) as! BasicCell
        
        
        
        var cell = BasicCell()
        

            
            cell = tableViewGroups.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
            
             cell.selectionStyle = UITableViewCellSelectionStyle.none
            
             cell.backgroundColor = UIColor.clear
            
            if (Groups.isEmpty ) {
                print("No Groups")
                
                //  cell.titleLabel?.text = self.NameInfo[indexPath.row] as String
                cell.titleLabel?.text = "Add A Group"
                //cell.numbers?.text =
                //   cell.subtitleLabel?.text = self.EmailInfo[indexPath.row] as String
            } else {
                
                let group = Groups[(indexPath as NSIndexPath).row]
                
               // cell.cellViewBG?.layer.cornerRadius = 10
                
                cell.titleLabel!.text = group.value(forKey: "groupname") as? String
              //  cell.subtitleLabel!.text = group.valueForKey("email") as? String
                
                cell.numbers?.text = self.NumGroups[(indexPath as NSIndexPath).row].description
                cell.TableImage?.image = UIImage(named: "right arrow white.png")

            }
 
            
       // }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "HowTo" {
            
            if let destination = segue.destination as? HowToSecondViewController {
                // let AudioBrowseViewController = segue.destinationViewController
                destination.theTopic = "Friends"
                //PQ2ViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
                
                // PQ2ViewController.popoverPresentationController!.delegate = self
                //  PQ2ViewController.presentationController?.delegate = self
            }
            
        }
        
        if segue.identifier == "goto_groupmembers" {
            if let destination = segue.destination as? GroupMembersViewController {
                
                if let GroupIndex = (tableViewGroups.indexPathForSelectedRow as NSIndexPath?)?.row {
                    let group = Groups[GroupIndex]
                    destination.groupName = (group.value(forKey: "groupname") as? String)! as NSString

              }
            }
        } else {
        
        if segue.destination is NewGameViewController {
          //  destination.NameInfo = NameInfo
          //  destination.EmailInfo = EmailInfo
            
          }
        }

    }
    
  //  var friendsRequest : FBRequest = FBRequest.requestForMyFriends()
    
    @IBAction func editTableView(_ sender: AnyObject) {
       
        /*
        if TableView.editing{
            TableView.setEditing(false, animated: false)
            EditBTN.style = UIBarButtonItemStyle.Plain;
            EditBTN.title = "Edit";
            TableView.reloadData()
        } else {
            TableView.setEditing(true, animated: true)
            EditBTN.title = "Done";
            EditBTN.style = UIBarButtonItemStyle.Done;
            TableView.reloadData()
        }
*/
        
        if tableViewGroups.isEditing{
            tableViewGroups.setEditing(false, animated: false)
            //EditBTN.style = UIBarButtonItemStyle.Plain;
            //EditBTN.title = "Edit";
            tableViewGroups.reloadData()
        } else {
            tableViewGroups.setEditing(true, animated: true)
            //EditBTN.title = "Done";
            //EditBTN.style = UIBarButtonItemStyle.Done;
            tableViewGroups.reloadData()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        /*
        if tableView == TableView {
        switch editingStyle {
        case .Delete:
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext!
            context.deleteObject(Friends[indexPath.row] as NSManagedObject)
            Friends.removeAtIndex(indexPath.row)
            context.save(nil)
            
            CurNum = NumFriends.count
            CurNum--
            NumFriends.append(CurNum)
            
            self.TableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            return
        }
        } else {
*/
            
            print("group editing")
            
            switch editingStyle {
            case .delete:
                
               
                
                
                let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                let context:NSManagedObjectContext = appDel.managedObjectContext!
                
                context.delete(Groups[(indexPath as NSIndexPath).row] as NSManagedObject)
                
                
                let groupname = (Groups[(indexPath as NSIndexPath).row] as NSManagedObject).description
                
                print("Deleting Group member Data Function Start, group name = \(groupname)")
                DeleteGroupMemberData(groupname as NSString)

                Groups.remove(at: (indexPath as NSIndexPath).row)
                do {
                    try context.save()
                } catch _ {
                }
                
                CurNumGroups = NumGroups.count
                CurNumGroups -= 1
                NumGroups.append(CurNumGroups)
                
                self.tableViewGroups.deleteRows(at: [indexPath], with: .fade)

            default:
                return
            
                     //  }
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
    
    func DeleteGroupMemberData(_ GroupName: NSString) {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
      //  let fetchRequest = NSFetchRequest(entityName: "Person")
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Person")
        let error: NSError?
        
        do {
        let fetchedResults =  try managedContext.fetch(fetchRequest) as? [NSManagedObject]
        
        
        
        if let results = fetchedResults {
            Friends = results
            print(Friends)
            
            
            
            for items in Friends as [NSManagedObject] {
                
                let FName = items.value(forKey: "name") as! String
                
                let EmailAdd = items.value(forKey: "email") as! String
                
                let GroupNameObject = items.value(forKey: "group") as! String
                let FID = items.value(forKey: "id") as! String
                
                print(items)
                print(items.value(forKey: "name")!)
                
                if GroupNameObject == GroupName as String {
                    
                   print("Deleting User: \(FName) in group \(GroupName)")
                    
                    managedContext.delete(items)
                    
                    do {
                        try managedContext.save()
                    } catch _ {
                    }
                    
                    // NumMembers++
                    // PlayerCount.append(NumMembers.description)
                }
                //   theFriends.append(MyFriends(name:FName,email:EmailAdd))
                
            }
            
        }
        else {
            //print("Could not fetch \(error), \(error!.userInfo)")
        }
       // println("Friends Now: \(NameInfo)")
        } catch {
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     //   if tableView == TableView {
      //  return true;
      //  } else {
            //GROUP EDITING
            return true;
      //  }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        
        /*
        if tableView == TableView {
      //  let item : String = EmailInfo[sourceIndexPath.row] as String;
      //  let item2 : String = NameInfo[sourceIndexPath.row] as String;
        let item3 : NSManagedObject = Friends[sourceIndexPath.row]
      //  EmailInfo.removeAtIndex(sourceIndexPath.row);
      //  NameInfo.removeAtIndex(sourceIndexPath.row);
        Friends.removeAtIndex(sourceIndexPath.row);
      //  EmailInfo.insert(item, atIndex: destinationIndexPath.row)
      //  NameInfo.insert(item2, atIndex: destinationIndexPath.row)
        Friends.insert(item3, atIndex: destinationIndexPath.row)
        } else {
        
            
            */
            //  let item : String = EmailInfo[sourceIndexPath.row] as String;
            //  let item2 : String = NameInfo[sourceIndexPath.row] as String;
            let item3 : NSManagedObject = Groups[(sourceIndexPath as NSIndexPath).row]
            //  EmailInfo.removeAtIndex(sourceIndexPath.row);
            //  NameInfo.removeAtIndex(sourceIndexPath.row);
            Groups.remove(at: (sourceIndexPath as NSIndexPath).row);
            //  EmailInfo.insert(item, atIndex: destinationIndexPath.row)
            //  NameInfo.insert(item2, atIndex: destinationIndexPath.row)
            Groups.insert(item3, at: (destinationIndexPath as NSIndexPath).row)
  
            
      //  }
    }
    
    
    @IBAction func FacebookInvite(_ sender: AnyObject) {
       
      //  if((FBSDKAccessToken.currentAccessToken()) != nil) {

       // getFBPermission()
        
        let inviteDialog:FBSDKAppInviteDialog = FBSDKAppInviteDialog()
        if(inviteDialog.canShow()){
            
            
           // let appLinkUrl:NSURL = NSURL(string: "https://fb.me/669563119812230")!
            let appLinkUrl:URL = URL(string: "https://fb.me/675432082558667")!
            
            // let appLinkUrl:NSURL = NSURL(string: "TelePictionary://article/FacebookInvite?")!
            let previewImageUrl:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/Images/PicsQuotesLogo.png")!
            
            let inviteContent: FBSDKAppInviteContent = FBSDKAppInviteContent()
            //appLinkURL: appLinkUrl)
            // (appLinkURL: appLinkUrl)
            print("app invite should be shown here")
            inviteContent.appLinkURL = appLinkUrl
           // inviteContent.
            // inviteContent.
             inviteContent.appInvitePreviewImageURL = previewImageUrl
            
            inviteDialog.content = inviteContent
            //inviteDialog
            inviteDialog.delegate = self
            inviteDialog.show()
        }
        
        
    }
    
    
    
    @IBAction func EmailBTN(_ sender: AnyObject) {
        
        SelectEmail()

    }
    
 
    
    @IBAction func ViewHowTo(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if !ViewHowTo {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                //self.View1TOP.constant = middleY
                
                
                self.subViewHolderTOP.constant = middleY
                
                self.ViewHolderTOP.constant = 0

                
                
                self.ViewHolder.center.y = self.ViewHolder.center.y - 1000
                
                self.ViewHolderTOP.constant = 0
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            
            ViewHowTo = true
        }
        
    }
    
    
    //localPlayer = GKLocalPlayer.localPlayer()
    func GetGCFriends () -> [NSString] {
        print("login called")
        //localPlayer = GKLocalPlayer.localPlayer()
        
      //friendPlayers = [NSString]()
       _ = NSArray()
        
       if self.localPlayer.isAuthenticated {
        
        
        
      //  localPlayer.loadFriendPlayersWithCompletionHandler(localPlayer)
        
        //GCFriends = localPlayer.loadFriendPlayersWithCompletionHandler()
        
        
    //    GCFriends = localPlayer.loadFriendPlayersWithCompletionHandler()
        
       
        
        
            }
        return GCFriends
        }
    
    @IBAction func View2NextBTN(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        

        subViewHolderTOP.constant = middleY
        
        ViewHolderTOP.constant = 0
        
        let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromRight, UIViewAnimationOptions.showHideTransitionViews]
        
        UIView.transition(from: self.View1, to: self.View2, duration: 0.8, options: animationOptions, completion: nil)
    }
    
    @IBAction func View2BackBTN(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
/*
        View1TOP.constant = 0
        View2TOP.constant = 0
        View3TOP.constant = 0
        View4TOP.constant = 0
*/
        subViewHolderTOP.constant = middleY
        
        ViewHolderTOP.constant = 0
        
        
        let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromLeft, UIViewAnimationOptions.showHideTransitionViews]
        
        UIView.transition(from: self.View2, to: self.View1, duration: 0.8, options: animationOptions, completion: nil)
    }
    @IBAction func View3NextBTN(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200

 
        subViewHolderTOP.constant = middleY
        
        ViewHolderTOP.constant = 0
        
        
        let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromRight, UIViewAnimationOptions.showHideTransitionViews]
        
        UIView.transition(from: self.View2, to: self.View3, duration: 0.8, options: animationOptions, completion: nil)
    }
    
    @IBAction func View3BackBTN(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
 /*
        View1TOP.constant = 0
        View2TOP.constant = 0
        View3TOP.constant = 0
        View4TOP.constant = 0
*/
        subViewHolderTOP.constant = middleY
        ViewHolderTOP.constant = 0
        
        let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromLeft, UIViewAnimationOptions.showHideTransitionViews]
        
        UIView.transition(from: self.View3, to: self.View2, duration: 0.8, options: animationOptions, completion: nil)
    }
    @IBAction func View4NextBTN(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        

        subViewHolderTOP.constant = middleY
        ViewHolderTOP.constant = 0
        
        
        let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromRight, UIViewAnimationOptions.showHideTransitionViews]
        
        UIView.transition(from: self.View3, to: self.View4, duration: 0.8, options: animationOptions, completion: nil)
    }
    
    @IBAction func View4BackBTN(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
 
        subViewHolderTOP.constant = middleY
        ViewHolderTOP.constant = 0
        
        
        let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromLeft, UIViewAnimationOptions.showHideTransitionViews]
        
        UIView.transition(from: self.View4, to: self.View3, duration: 0.8, options: animationOptions, completion: nil)
    }
    
    
    @IBAction func View1CloseBTN(_ sender: AnyObject) {
        
        
        
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
      
        subViewHolderTOP.constant = middleY
        
        //if ViewHowTo {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.subViewHolderTOP.constant = middleY
                
                self.ViewHolder.center.y = self.ViewHolder.center.y + 1000
                
                self.ViewHolderTOP.constant = 1000
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
        
        
     //   let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.TransitionFlipFromLeft, UIViewAnimationOptions.ShowHideTransitionViews]
        
      //  UIView.transitionFromView(self.View4, toView: self.View1, duration: 0.8, options: animationOptions, completion: nil)
        
            ViewHowTo = false
       // }
        
        print("my friends - how to - Bool set to true")
        self.prefs.set(true, forKey: "DidShowHowTo_MyFriends")
        
        
    }
    
    
    @IBAction func manageFriendsBTN(_ sender: AnyObject) {
        print("button pressed")
        
    }
    
    
    
    
    
    func prepareAd() {
        print(" --- AD: Try Load ---")
        // Attempt to load a new ad:
        interAd = ADInterstitialAd()
        interAd?.delegate = self
    }
    
    func showAd() -> Bool {
        if interAd != nil && interAd!.isLoaded {
            interAdView = UIView()
            interAdView.frame = self.view!.bounds
            self.view?.addSubview(interAdView)
            
            interAd!.present(in: interAdView)
            UIViewController.prepareInterstitialAds()
            
            interAdView.addSubview(closeButton)
        }
        
        // Return true if we're showing an ad, false if an ad can't be displayed:
        return interAd?.isLoaded ?? false
    }
    
    // When the user clicks the close button, route to the adFinished function:
    func closeAd(_ sender: UIButton) {
        adFinished()
    }
    
    // A function of common functionality to run when the user returns to your app:
    func adFinished() {
        closeButton.removeFromSuperview()
        interAdView.removeFromSuperview()
        // (Do whatever is next in your app)
    }
    
    // The ad loaded successfully (we don't need to do anything for the basic implementation)
    func interstitialAdDidLoad(_ interstitialAd: ADInterstitialAd!) {
        print(" --- AD: Load Success ---")
    }
    
    // The ad unloaded (we don't need to do anything for the basic implementation)
    func interstitialAdDidUnload(_ interstitialAd: ADInterstitialAd!) {
        print(" --- AD: Unload --- ")
    }
    
    // This is called if the user clicks into the interstitial, and then finishes interacting with the ad
    // We'll call our adFinished function since we're returning to our app:
    func interstitialAdActionDidFinish(_ interstitialAd: ADInterstitialAd!) {
        print(" --- ADD: Action Finished --- ")
        adFinished()
    }
    
    func interstitialAdActionShouldBegin(_ interstitialAd: ADInterstitialAd!, willLeaveApplication willLeave: Bool) -> Bool {
        return true
    }
    
    // Error in the ad load, print out the error
    func interstitialAd(_ interstitialAd: ADInterstitialAd!, didFailWithError error: Error!) {
        print(" --- AD: Error --- ")
        print(error.localizedDescription)
    }
    
    fileprivate func showIntersitialAd() { //call this method whenever you want to show an interstitial
        self.requestInterstitialAdPresentation()
    }
    
    
    
    }


