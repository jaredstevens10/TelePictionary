//
//  ViewMyFriendsViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 12/14/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import UIKit

class ViewMyFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GroupGCViewControllerDelegate, UIPopoverPresentationControllerDelegate {

    
    @IBOutlet var ActInd: UIActivityIndicatorView!
    let prefs:UserDefaults = UserDefaults.standard
    var groupgcviewcontroller: GroupGCViewController = GroupGCViewController()
    
    @IBOutlet var groupLBL: UILabel!
    @IBOutlet var AddNotice: UILabel!
    @IBOutlet var EditBTN: UIButton!
    
    var username = NSString()
    var userID = NSString()
    var FriendInfo = [NSArray]()
    var FriendData = [NSArray]()
    var repeatFriendNameArray = [NSString]()
    var repeatFriendIDArray = [NSString]()
    var repeatFriendContactArray = [NSString]()
    var FriendNameInfo = [NSString]()
    var FriendIDInfo = [NSString]()
    var RowSelected = Int()
    var NumbersInfo = [NSString]()
    var NumbersCount = Int()
    
    let OtherUserProfile = true
    var profileID = NSString()
    
    @IBOutlet weak var addFriendBTN: UIButton!
    var GCFriendName = NSString()
    var GCFriendID = NSString()
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
    self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    groupgcviewcontroller.nrdelegate=self

    TableView.dataSource = self
    TableView.delegate = self
    self.TableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    // Do any additional setup after loading the view.
        
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
        } else  {
            print("username Error")
            
            username = ""
            userID = ""
            
        }
        
    //username = prefs.valueForKey("USERNAME") as! NSString as String
    //userID = prefs.valueForKey("PLAYERID") as! NSString as String

   
    
        self.title = "Friends"
        
        if let font = UIFont(name: "DK Cool Crayon", size: 25.0) {
          //  self.navigationController!.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.whiteColor()]
            
           // self.ta
        }
    
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
    ActInd.startAnimating()
    //ActInd.startAnimating()
        
        if username.isEqual(to: "") || userID.isEqual(to: "") {
            addFriendBTN.isEnabled = false
            DispatchQueue.main.async(execute: {
                
                
                let Alert2 = SCLAlertView()
                
                // if WasProfileUpdated {
                Alert2.addButton("Ok", action: {
                    
                    
                })
                
                Alert2.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Center", subTitle: "We're having trouble verifying your username.  Please try logging into game center from the home menu", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
        } else {
    
    if Reachability.isConnectedToNetwork() {
    addFriendBTN.isEnabled = true
    
   let URLData = GetMyFriends(userID, Type: "friends")
    //println(test)
    FriendInfo = FilterMyFriends(URLData)
    
    FriendNameInfo = FriendInfo[0] as! [(NSString)]
    FriendIDInfo = FriendInfo[1] as! [(NSString)]
    NumbersInfo = FriendInfo[2] as! [(NSString)]
    //        UnqFriendNameInfo = uniq(FriendNameInfo)
    // UnqFriendNameInfo = FriendNameInfo
        
        if FriendNameInfo.count == 0 {
            AddNotice.isHidden = false
        } else {
            AddNotice.isHidden = true
        }
    
    self.TableView.reloadData()
    
    } else {
    
    print("not connected to network")
    }
        
        
        
    }
    
    ActInd.stopAnimating()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.FriendNameInfo.count;
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func uniq<S: Sequence, E: Hashable>(_ source: S) -> [E] where E==S
    .Iterator.Element {
    var seen : [E:Bool] = [:]
    return source.filter { seen.updateValue(true, forKey: $0) == nil }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if FriendIDInfo[(indexPath as NSIndexPath).row] != "" {
            // cell.contentBTN?.imageView?.image = UIImage(named: "YouIcon.png")
            //  cell.contentBTN?.tag = indexPath.row
            profileID = FriendIDInfo[(indexPath as NSIndexPath).row]
            self.performSegue(withIdentifier: "ShowProfile", sender: self)
            
        }
        
    }

    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {

            let RemoveName: NSString = self.FriendNameInfo[(indexPath as NSIndexPath).row]
            let RemoveID: NSString = self.FriendIDInfo[(indexPath as NSIndexPath).row]
            
           // DeleteGameData(self.GameIDInfo[indexPath.row].description)
            
           //self.GameNameInfo.removeAtIndex(indexPath.row)
            
            self.FriendNameInfo.remove(at: (indexPath as NSIndexPath).row)
            self.FriendIDInfo.remove(at: (indexPath as NSIndexPath).row)
           // self.NumbersInfo.removeLast()
            //repeatFriendNameArray.removeAll()
            //repeatFriendIDArray.removeAll()
            //FriendData.removeAll()
            
            
            
            
            DeleteMyFriend(self.userID, FriendType: "friends", NewID: RemoveID, NewName: RemoveName)
            
            self.TableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
    
    if tableView == TableView {
    
    
    cell.titleLabel?.text = self.FriendNameInfo[(indexPath as NSIndexPath).row] as String
    //  cell.subtitleLabel?.text = self.EmailTable[indexPath.row] as String
    
    }
    
    
    return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowProfile" {
            
            
            if let destination = segue.destination as? LevelInfoViewController {
                
                destination.OtherUserProfile = self.OtherUserProfile
                
                destination.playerID = self.profileID
                print("Profile show segue")
            }
        }
        
    }

    
    func FilterMyFriends(_ urlData: Data) -> ([NSArray]) {
    repeatFriendNameArray.removeAll()
    repeatFriendIDArray.removeAll()
    FriendData.removeAll()
     var NumbersTempArray = [NSString]()
        var theNumber = Int()
    // var traits = [NSString]()
    
    let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
    
    
    
    var json = JSON(jsonData)
    
    //println("Json value: \(jsonData)")
    // println("Json valueJSON: \(json)")
    theNumber = 0
        
        for result in json["Data"].arrayValue {
            
            if ( result["name"] != "NA") {
                if ( result["name"] != "-") {
                    if ( result["name"] != " ") {
                        
                        let repeatFriendName = result["name"].stringValue
                        let repeatFriendID = result["playerid"].stringValue
                        theNumber += 1
                        //  var repeatFriendContact = result["TurnNumber"].stringValue
                        // let tempUserData = UserInfoData.init(username: repeatFriendName, userid: repeatFriendNameID)
                        
                        repeatFriendNameArray.append(repeatFriendName as NSString)
                        repeatFriendIDArray.append(repeatFriendID as NSString)
                        NumbersTempArray.append(theNumber.description as NSString)
                        //repeatFriendContactArray.append(repeatFriendContact)
                    }
                }
            }
            
        }

    
    FriendData.append(repeatFriendNameArray as NSArray)
    FriendData.append(repeatFriendIDArray as NSArray)
    FriendData.append(NumbersTempArray as NSArray)
    
    return (FriendData)
    
    }
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

    
    
@IBAction func AddFriendTapped(_ sender: AnyObject) {
        
        //replaceRow = sender.tag
      //  print("the gamecenter tag: \(sender.tag)")
        
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ViewMyFriendsViewController {
    func GroupGCViewControllerFinished(_ groupgcviewController: GroupGCViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        self.GCFriendName = groupgcviewController.GCFriendName
        
        self.GCFriendID = groupgcviewController.GCFriendID
        
        AddMyFriend(self.userID, FriendType: "friends", NewID: GCFriendID, NewName: self.GCFriendName)
        
        DispatchQueue.main.async(execute: {
            
            
            if Reachability.isConnectedToNetwork() {
                
                
                let URLData = GetMyFriends(self.userID, Type: "friends")
                //println(test)
                self.FriendInfo = self.FilterMyFriends(URLData)
                
                self.FriendNameInfo = self.FriendInfo[0] as! [(NSString)]
                self.FriendIDInfo = self.FriendInfo[1] as! [(NSString)]
                
                //        UnqFriendNameInfo = uniq(FriendNameInfo)
                // UnqFriendNameInfo = FriendNameInfo
                DispatchQueue.main.async(execute: {

                self.TableView.reloadData()
                
                })
            } else {
                
                print("not connected to network")
            }
            
        })

        //self.GCFriendContact = repeatfriendsviewController.GCFriendContact
        /*
        self.GCFriendContact = "PUSH"
        
        self.SelectedGCFriend = groupgcviewController.SelectedGCFriend
        // self.replaceRow = repeatfriendsviewController.RowSelected
        
        
        
        self.NameInfo.removeAtIndex(self.replaceRow);
        self.EmailInfo.removeAtIndex(self.replaceRow);
        self.UNIDArray.removeAtIndex(self.replaceRow)
        // self.NameInfo.removeAtIndex(self.replaceRow);
        //  self.EmailInfo.removeAtIndex(replaceRow);
        
        
        self.NameInfo.insert(self.GCFriendName, atIndex: self.replaceRow);
        self.EmailInfo.insert(self.GCFriendContact, atIndex: self.replaceRow);
        self.UNIDArray.insert(self.GCFriendID, atIndex: self.replaceRow)
        
        print("Game Center replace at Row: \(self.replaceRow)")
        
        
        
        //editingPerson.setValue(self.GCFriendName, forKey: "name")
        //editingPerson.setValue(self.GCFriendContact, forKey: "email")
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)
        
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
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
        */
        
    }

}
