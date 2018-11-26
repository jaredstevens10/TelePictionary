//
//  FriendPickerViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/20/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import AddressBookUI
import CoreData
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class FriendPickerViewController: UIViewController, ABPeoplePickerNavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate, UIActionSheetDelegate, UIAlertViewDelegate, FBSDKAppInviteDialogDelegate, GroupPickerViewControllerDelegate, UIPopoverPresentationControllerDelegate {
    
     @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var grouppickerviewcontroller: GroupPickerViewController = GroupPickerViewController()
    
    let index = 10
    var username = String()
    var myemail = String(0)
    
    @IBOutlet weak var editBTN: UIBarButtonItem!
    @IBOutlet weak var TableView: UITableView!
    
    @IBOutlet weak var getgroupsBTN: UIBarButtonItem!
   
    @IBOutlet weak var GameLBL: UILabel!
    
    var theFriends = [MyFriends]()
    var DidSelectGroup = Bool()
    
    var Friends = [NSManagedObject]()
    var FriendsName = [NSString]()
    var FriendsEmail = [NSString]()
    var NameTable = [NSString]()
    var FriendsInfo = [NSString]()
    var EmailTable = [NSString]()
    var NameInfo = [NSString]()
    var SelectedGroup = NSString()
    var numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    var NumSelected = [Int]()
    var PlayerCount = [NSString]()
    var varNum = Int()
    
    var numPlayers = Int()
    var GroupData = [NSArray]()
    var NameData = [NSString]()
    var ContactData = [NSString]()
    
    var NewGameTitle: NSString?
    var NewGamePlayers: Int?
    var NewGameTurnTime: NSString?
    var NewGameFirstTurn: NSString?
    var NewGameQuote = NSString()
    var NewGameImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        grouppickerviewcontroller.adelegate=self
        
       // navigationController!.navigationBar.barTintColor = UIColor(red: 0.6, green: 1.0, blue: 0.6, alpha: 1.0)
        numPlayers = 1
        
        TableView.allowsMultipleSelection = true
        self.TableView.separatorStyle = UITableViewCellSeparatorStyle.none
      
        
        GameLBL.text = "Game Players : \(numPlayers)"
        
     //   TableView.registerClass(UITableView.self, forCellReuseIdentifier: "BasicCell")
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        let prefs:UserDefaults = UserDefaults.standard
        
        username = prefs.value(forKey: "USERNAME") as! NSString as String
        print("my gamecenter user name = \(username)")
        
        //need to add my email address default
        myemail = "jared.stevens@\(ServerInfo.sharedInstance)"
        //NameTable.append(username)
        //EmailTable.append(myemail)
        FriendsName.append(username as NSString)
        FriendsEmail.append(myemail as NSString)
        varNum = 1
        PlayerCount.append(varNum.description as NSString)
        
        TableView.dataSource = self
        TableView.delegate = self
        
        
       // self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: Selector("didTouchUpInsidePickButton:"))
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
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //let fetchRequest = NSFetchRequest(entityName: "Person")
         let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Person")
        let error: NSError?
        do {
        let fetchedResults = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
        
        
        
        if let results = fetchedResults {
            Friends = results
           print(Friends)
            
            
        
            for items in Friends as [NSManagedObject] {
                
                let FName = items.value(forKey: "name") as! String
                
                let EmailAdd = items.value(forKey: "email") as! String
                
                print(items)
                print(items.value(forKey: "name")!)
               
                NameTable.append(FName as NSString)
                EmailTable.append(EmailAdd as NSString)
                FriendsName.append("NA")
                FriendsEmail.append("NA")
               PlayerCount.append("NA")
             //   theFriends.append(MyFriends(name:FName,email:EmailAdd))
             
            }
        
        }
        else {
           // print("Could not fetch \(error), \(error!.userInfo)")
        }
        } catch {
            print(error)
        }
 print("Friends Now: \(NameTable)")
}
    
    
    @IBAction func AddPlayer(_ sender: AnyObject) {
        
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
    /*
    func didTouchUpInsidePickButton(item: UIBarButtonItem) {
        let picker = ABPeoplePickerNavigationController()
        picker.peoplePickerDelegate = self
        println("ADDING NEW PERSON")
        
        //picker.displayedProperties = [NSNumber(int: kABPersonEmailProperty)]
        //picker.displayedProperties = [NSNumber(int: kABPersonPhoneMainLabel)]
        
        if picker.respondsToSelector(Selector("predicateForEnablingPerson")) {
          //  picker.predicateForEnablingPerson = NSPredicate(format: "emailAddresses.@count > 0")
           // picker.predicateForEnablingPerson = NSPredicate
        }
        
        presentViewController(picker, animated: true, completion: nil)
    }
*/
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
        
        
        EmailTable.append(email as NSString)
        //NameInfo.append(email)
        NameTable.append(fullname)
        PlayerCount.append("NA")
        
        self.TableView.reloadData()
    
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
        return self.NameTable.count;
    }
    
    
    func removeObject<T : Equatable>(_ object: T, fromArray array: inout [T])
    {
    let index = array.index(of: object)
        array.remove(at: index!)
    }
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let row = (indexPath as NSIndexPath).row
        let selectedResult = (indexPath as NSIndexPath).item
        
        let FriendsRow = NameTable[row] as String
        
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
        /*
        if let index = find(self.FriendsInfo, note) {
            self.FriendsInfo.removeAtIndex(index)
        }
*/
      //  let cell2 = TableView.cellForRowAtIndexPath(indexPath)
        
      //  cell2?.backgroundColor = UIColor.whiteColor()
        

        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
        
      //  cell.numbers.hidden = true
       // cell.background = UIColor.clearColor()
        
     //    self.TableView.reloadData()
        
        if numPlayers == 1 {
            numPlayers = 1
        } else {
        numPlayers -= 1
        }
        
        GameLBL.text = "Game Players : \(numPlayers)"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = (indexPath as NSIndexPath).row
        let selectedResult = (indexPath as NSIndexPath).item
        
        print("Row selected: \(row)")
        print("Selected: \(selectedResult)")
        
        print("index path: \(indexPath)")
        
        
       let FriendsRow = NameTable[row]
        
        
       // cellForRowAtIndexPath(row)
        
 
        let EmailRow = EmailTable[row]
        print("before select: \(FriendsName)")
        
       // if row != 0 {
            
        let add = row + 1
        FriendsName[add] = FriendsRow
        FriendsEmail[add] = EmailRow
        varNum += 1
    print("var Number: \(varNum)", terminator: "")
     //   }
        
        PlayerCount[row] = varNum.description as NSString
        
        
      //  FriendsName.append(FriendsRow)
      //  println(FriendsInfo)
      //  FriendsEmail.append(FriendsRow)
        print("after select: \(FriendsName)")
        
        
        print("Friends Count: \(NameTable.count)")
        print("Index Count: \(NameTable[(indexPath as NSIndexPath).row])")
    //    let numberCount = FriendsNow.indexOf(FriendsNow[indexPath.row])
    //    println("Number Count: \(numberCount)")
        
        
        /*
        if indexPath.row != lastSelectedIndexPath?.row {
            if let lastSelectedIndexPath = lastSelectedIndexPath {
                let oldCell = TableView.cellForRowAtIndexPath(lastSelectedIndexPath)
                oldCell?.accessoryType = .None
            }
            let newCell = TableView.cellForRowAtIndexPath(indexPath)
            newCell?.accessoryType = .Checkmark
            lastSelectedIndexPath = indexPath
        
        }
    */
       // var NameRow = NameInfo[row]
      //  println(NameRow)
      //  var EmailRow = EmailInfo[row]
        
        
        
        print(FriendsRow)
        
        
               /*
        switch CurrentTurn
        {
        case "2","4","6","8","10":
            println("Picture Time")
            // GameSegue = "Add_Quote"
            self.performSegueWithIdentifier("Select_Game", sender: self)
        case "1","3","5","7","9":
            println("Quote Time")
            self.performSegueWithIdentifier("Select_Game", sender: self)
            // GameSegue = "Add_Picture"
        case "11":
            println("game over")
            self.performSegueWithIdentifier("Select_Game", sender: self)
        default:
            println("Error")
        }
       */
        
     //   self.TableView.reloadData()
        numPlayers += 1
         GameLBL.text = "Game Players : \(numPlayers)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
        
        if tableView == TableView {
            
      //  let friendrow = self.theFriends[indexPath.row]
        
      /*  if (NameTable.isEmpty ) {
            println("No Friends")
            
            // add message box here to say now friends and how to add them
            
            cell.titleLabel?.text = self.NameTable[indexPath.row] as String
            cell.subtitleLabel?.text = self.EmailTable[indexPath.row] as String
            //cell.accessoryType = (lastSelectedIndexPath?.row == indexPath.row) ? .CheckMark : .None
            
            //   cell.subtitleLabel?.text = self.EmailInfo[indexPath.row] as String
        } else {
            */
        
           // let person = FriendsNow[indexPath.row]
            
          //  cell.titleLabel!.text = person.valueForKey("name") as? String
            
            cell.titleLabel?.text = self.NameTable[(indexPath as NSIndexPath).row] as String
            cell.subtitleLabel?.text = self.EmailTable[(indexPath as NSIndexPath).row] as String
            
        }

            //    cell.subtitleLabel!.text = person.valueForKey("email") as? String
      //  }
        
               /*
        
        cell.titleLabel?.text = self.NameInfo[indexPath.row] as String
        
        cell.subtitleLabel?.text = self.EmailInfo[indexPath.row] as String
        */
      
        /*
        
        var row = indexPath.row
        var add = row + 1
        if PlayerCount[row] == "NA" {
            cell.numbers?.text = ""
        } else {
        
        cell.numbers?.text = self.PlayerCount[indexPath.row] as String
        
        }
        
      */
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Group Picker" {
            let GroupPickerViewController = segue.destination 
            GroupPickerViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            
            GroupPickerViewController.popoverPresentationController!.delegate = self
        }
        
        if let destination = segue.destination as? ConfirmPlayersViewController {
        //destination.NameInfo = NameInfo
        //destination.EmailInfo = FriendsEmail
        //destination.NameInfo = FriendsName
            destination.groupName = SelectedGroup
            destination.SelectedGroup = DidSelectGroup
            
            
        }
        /*
        if segue.identifier == " " {
            if let destination = segue.destinationViewController as? GameViewController {
                if let GameIndex = TableView.indexPathForSelectedRow()?.row {
                    destination.GameName = GameNameInfo[GameIndex]
                    destination.GameID = GameIDInfo[GameIndex]
                    println("Game Turn 1: \(TurnNumberInfo[GameIndex])")
                    
                    destination.CurrentTurn = TurnNumberInfo[GameIndex]
                    destination.IsComplete = IsCompleteInfo[GameIndex]
                    
                    
                }
            }
        }
*/
    }
    
    @IBAction func editTableView(_ sender: AnyObject) {
        
        if TableView.isEditing{
            TableView.setEditing(false, animated: false)
            editBTN.style = UIBarButtonItemStyle.plain;
            editBTN.title = "Edit";
            TableView.reloadData()
        } else {
            TableView.setEditing(true, animated: true)
            editBTN.title = "Done";
            editBTN.style = UIBarButtonItemStyle.done;
            TableView.reloadData()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            NameTable.remove(at: (indexPath as NSIndexPath).row)
           // EmailInfo.removeAtIndex(indexPath.row);
          //  NameInfo.removeAtIndex(indexPath.row)
            self.editTableView(editBTN)
            TableView.reloadData()
        } else if editingStyle == UITableViewCellEditingStyle.insert{
            //Friends.append("New Item")
            NameTable.append("New Item")
           // EmailInfo.append("New Item");
          //  NameInfo.append("New Name");
        }
    
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item : String = NameTable[(sourceIndexPath as NSIndexPath).row] as String;
      //  let item : String = EmailInfo[sourceIndexPath.row] as String;
      //  let item2 : String = NameInfo[sourceIndexPath.row] as String;
        NameTable.remove(at: (sourceIndexPath as NSIndexPath).row);
//        EmailInfo.removeAtIndex(sourceIndexPath.row);
  //      NameInfo.removeAtIndex(sourceIndexPath.row);
    
        NameTable.insert(item as NSString, at: (destinationIndexPath as NSIndexPath).row)
//        EmailInfo.insert(item, atIndex: destinationIndexPath.row)
  //      NameInfo.insert(item2, atIndex: destinationIndexPath.row)
    }
    
    @IBAction func AddQuoteBTN(_ sender: AnyObject) {
        
        var FriendsPlaying = [NSString]()
        FriendsPlaying = FriendsName
        print("Friends Playing Before: \(FriendsPlaying)")
        
        FriendsPlaying = FriendsPlaying.filter{$0 != "NA"}
        print("Friends Playing After: \(FriendsPlaying)")
        
        if (FriendsPlaying.count == 10) {
        
            FriendsName = FriendsName.filter{$0 != "NA"}
            FriendsEmail = FriendsEmail.filter{$0 != "NA"}
            
            self.performSegue(withIdentifier: "Add_Quote", sender: self)
            
        } else {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Uh Oh"
            alertView.message = "10 People are needed to play the game"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()

        }
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
                
                self.performSegue(withIdentifier: "Add_Quote", sender: self)
                
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
        //Add a text field
        //actionSheetController.addTextFieldWithConfigurationHandler { textField -> Void in
            //TextField configuration
          //  textField.textColor = UIColor.blueColor() }
        
        
        //Present the AlertController
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    

    @IBAction func GroupPicker(_ sender: AnyObject) {
        
        let groupinfoController = storyboard?.instantiateViewController(withIdentifier: "Group Picker") as! GroupPickerViewController
        
        //let savingsInformationViewController = WeaponsViewController(nibName: "WeaponsMenu", bundle: nil)
        //  savingsInformationViewController.delegate=self
        
        //   savingsInformationViewController.weaponPKLabel=weaponLabel.text
        
        groupinfoController.adelegate=self
        
        
       // groupinfoController.modalPresentationStyle = .Popover
        let popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "Group Picker") as! GroupPickerViewController
        //var nav = UINavigationController(rootViewController: popoverContent)
        let nav = storyboard?.instantiateViewController(withIdentifier: "Group Picker") as! GroupPickerViewController
        nav.adelegate=self
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover = nav.popoverPresentationController
        popoverContent.preferredContentSize = CGSize(width: 200, height: 300)
        popover!.delegate = self
        popover!.sourceView = self.view
        popover!.sourceRect = CGRect(x: 100,y: 100,width: 0,height: 0)
        
        self.present(nav, animated: true, completion: nil)
        
        /*
        //var popover = groupinfoController.popoverPresentationController
        popoverContent.popoverController.presentPopoverFromBarButtonItem(self, permittedArrowDirections: UIPopoverArrowDirection.Up, animated: true)
        
        if let popoverController = groupinfoController.popoverPresentationController {
            popoverController.sourceView = self.view
        
           // popoverController.sourceView = sender as! UIBarButtonItem
            
            popoverController.sourceRect = sender.bounds
            
            popoverController.permittedArrowDirections = .Any
            popoverController.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
            
            popoverController.delegate = self
        
        }
        presentViewController(groupinfoController, animated: true, completion: nil)
        
        */
        
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
            popoverController2.sourceRect = CGRect(x: 100,y: 100,width: 0,height: 0)
            
         //   popoverController2.permittedArrowDirections = nil
            popoverController2.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
            
            popoverController2.delegate = self
        }
        present(savingsInformationViewController, animated: true, completion: nil)
        
        
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
}


extension FriendPickerViewController {
    
//}: GroupPickerViewControllerDelegate {
    func GroupPickerViewControllerFinished(_ grouppickerviewController: GroupPickerViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        self.GroupData = grouppickerviewController.GroupData
        
        
        //NameData = GroupData[0] as! [(NSString)]
        //println("Member Data Name = \(NameData)")
        //ContactData = GroupData[1] as! [(NSString)]
        //println("Member Data Contact = \(ContactData)")
        
        self.SelectedGroup = grouppickerviewController.TheGroup
        print("The group \(SelectedGroup) was selected")
        
        if self.SelectedGroup != "" {
            self.DidSelectGroup = true
        } else {
            self.DidSelectGroup = false
        }
        
        //self.performSegueWithIdentifier("Add_Quote", sender: self)
        //= // self.armorBTN.setImage(armorviewController.armorPKimage, forState:.Normal)
        
        
            //= settingsViewController.weaponPKimage
        
    }
}
