//
//  FBFriendsViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 8/23/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import CoreData
import GameKit
    
    protocol FBFriendsViewControllerDelegate: class {
        func FBFriendsViewControllerFinished(_ fbfriendsviewController: FBFriendsViewController)
    }
    
class FBFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    
    @IBOutlet var ActInd: UIActivityIndicatorView!
    
        
        var fdelegate: FBFriendsViewControllerDelegate?
        
        var GroupData = [NSArray]()
        
        var dict = NSDictionary()
        
        var theGroups = [MyFriends]()
    
    var FBNameArray = [NSString]()
    var FBidArray = [NSString]()
        
        var Groups = [NSManagedObject]()
        var GroupsName = [NSString]()
        //var FriendsEmail = [NSString]()
        var NameTable = [NSString]()
        var GroupsInfo = [NSString]()
        //var EmailTable = [NSString]()
        var NameInfo = [NSString]()
        var numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        
        var NumSelected = [Int]()
        var GroupCount = [NSString]()
        var varNumGroups = Int()
        var TheGroup = NSString()
        var GroupSelected = Bool()
        
        var numGroups = Int()
        
        var GroupName = NSString()
        var FBFriendName = NSString()
        var FBFriendID = NSString()
        var FBFriendContact = NSString()
        var FBSelected = false
        
        var FriendInfo = [NSArray]()
        var FriendData = [NSArray]()
        var repeatFriendNameArray = [NSString]()
        var repeatFriendContactArray = [NSString]()
    
        var FBUserName = [NSString]()
        var FBUserId = [NSString]()
    
        var RowSelected = Int()
        var ProfileImages = [UIImage]()
        var ProfileImagesString = [String]()

    //GAME CENTER VARIABLES
        var localPlayer = GKLocalPlayer.local
        //var GCFriends = [NSString]()
    
        var gcEnabled = Bool()
        var player = NSString()
        var playerid = NSString()
    
    let prefs:UserDefaults = UserDefaults.standard
        @IBOutlet weak var TableView: UITableView!
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
         
            
           // var FBArray = getFBUserData()
            
            
            
            self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            
            TableView.dataSource = self
            //TableView.delegate = self
            self.TableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            
            if Reachability.isConnectedToNetwork() {
            print("about to perform GC login")
         // GameLogin()
                
            } else {
                print("network not connected")
            }
            
            //sendGameInvitenew()
            
          
        }
    
    override func viewDidAppear(_ animated: Bool) {
        ActInd.startAnimating()
        
        //NameTable = GameLogin()
        
        //print("GC Friends = \(NameTable)")
        
        if Reachability.isConnectedToNetwork() {
        
          //  self.localPlayer.loadFriendPlayers(completionHandler: { GCFriends -> Void in
            
            /*
        self.localPlayer.loadFriendPlayers(completionHandler: { (GCFriends) -> Void in
            print("GCFriend = \(GCFriends)")
            for myFriend in GCFriends.0! {
                let myFriendAlias = myFriend.alias
                let myFriendID2 = myFriend.playerID
                let myFriendID = myFriendID2!.replacingOccurrences(of: ":", with: "")
                
                // var myFriend = myFriend?.first
                print("my friend ID = \(myFriend.playerID)")
                print("my friend alias = \(myFriend.alias)")
                print("my friend name = \(myFriend.displayName)")
                
                self.NameTable.append(myFriendAlias! as NSString)
                self.FBidArray.append(myFriendID as NSString)
                // GCFriendsTemp.append(myFriendName!)
            }
            /*
            for GCUsers in NameTable {
                
                self.FBidArray.append("TEMP")
            }
            */
            self.TableView.reloadData()
        })
            */
            
            
            } else {
            
            print("not connected to network")
            
            }
        //self.TableView.reloadData()
        ActInd.stopAnimating()
    }
    
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.NameTable.count;
        }
    
        
        func ParseJSON(_ jsonData: NSDictionary) -> [NSArray] {
            
            var ParsedArray = [NSArray]()
            
            var json = JSON(jsonData)
            
            print("FB json: \(json)")
            
       

            for result in json["data"].arrayValue {
                
                
                if ( 1 == 1 ) {
                    
                    
                    let FBName = result["first_name"].stringValue
                    
                    let FBid = result["id"].stringValue
                    let FBProfile = result["picture"]["data"]["url"].stringValue

                    
                    FBNameArray.append(FBName as NSString)
                    self.NameTable.append(FBName as NSString)
                    self.ProfileImagesString.append(FBProfile)
                    FBidArray.append(FBid as NSString)
                        
                        //ParsedArray.append(FBName)
                    
                }
                ParsedArray.append(FBNameArray as NSArray)
                ParsedArray.append(FBidArray as NSArray)
                
            }
            
            //Adding Profile Images
            FBProfilePicArray(self.ProfileImagesString)
            self.TableView.reloadData()
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
        //func getFBUserData() -> NSDictionary
        func getFBUserData() -> [NSArray]
        {
            var FBData = [NSArray]()
            
            if((FBSDKAccessToken.current()) != nil) {
                FBSDKGraphRequest(graphPath: "me/friends", parameters: ["fields": "id, name, friends, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                    if (error == nil) {
                        self.dict = result as! NSDictionary
                        print(result)
                        print(self.dict)
                        
                        FBData = self.ParseJSON(self.dict)
                        
                        print("Test JSON: \(FBData)")


                        //  NSLog(self.dict.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as! String)
                        //NSLog(self.dict.objectForKey("email")?!)
                        
                    }
                })
            }
            
            
          //  var TestDict = self.ParseJSON(dict)
            
                   return FBData
         //   return self.dict
    }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let row = (indexPath as NSIndexPath).row
            let selectedResult = (indexPath as NSIndexPath).item
            
            
            // let row = indexPath.row
            // let selectedResult = indexPath.item
           // var GroupsRow = Groups[row]
           // println(GroupsRow)
            
            //SWIFT 3 ERROR
//            FBFriendName = NameTable[(indexPath as NSIndexPath).row] as NSString
  //          FBFriendContact = FBidArray[(indexPath as NSIndexPath).row] as NSString
            
            //(GroupsRow.valueForKey("groupname") as? String)!
            
            
            FBSelected = true
            //self.performSegueWithIdentifier("goto_groupmembers", sender: self)
            
            
            // GroupData = GetGroupMembers(GroupsRow)
            // println("GroupData (from popover) = \(GroupData)")
            
            // self.dismissViewControllerAnimated(true, completion: nil)
            
            //self.performSegueWithIdentifier("group_selected", sender: self)
            
            
            
            self.dismiss(animated: true, completion: nil)
            
            self.fdelegate?.FBFriendsViewControllerFinished(self)
            
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
            
            if tableView == TableView {
                
                
                
                cell.titleLabel?.text = self.NameTable[(indexPath as NSIndexPath).row] as String
                
                //FACEBOOK PROFILE PIC INFO
                
               // cell.TableImage?.image = self.ProfileImages[indexPath.row] as UIImage
                
              //  cell.TableImage?.layer.cornerRadius = 10
            
                
            }
            
            
            return cell
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "goto_groupmembers" {
                
                if let destination = segue.destination as? GroupMembersViewController {
                    
                    if let GroupIndex = (TableView.indexPathForSelectedRow as NSIndexPath?)?.row {
                        let group = Groups[GroupIndex]
                        destination.groupName = (group.value(forKey: "groupname") as? String)! as NSString
                        
                        
                        
                    }
                }
            } else if segue.identifier == "group_selected" {
                
                if let destination = segue.destination as? ConfirmPlayersViewController {
                    
                    if let GroupIndex = (TableView.indexPathForSelectedRow as NSIndexPath?)?.row {
                        let group = Groups[GroupIndex]
                        destination.groupName = (group.value(forKey: "groupname") as? String)! as NSString
                        destination.SelectedGroup = true
                        
                    }
                }
            }
                
            else {
                
                if let destination = segue.destination as? GroupMembersViewController {
                    
                    if let GroupIndex = (TableView.indexPathForSelectedRow as NSIndexPath?)?.row {
                        let group = Groups[GroupIndex]
                        destination.groupName = (group.value(forKey: "groupname") as? String)! as NSString
                    }
                }
                
            }
            
        }
        
        
        
        func FilterFBFriends(_ urlData: Data) -> ([NSArray]) {
            
           // var traits = [NSString]()
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            
            var json = JSON(jsonData)
            
            //println("Json value: \(jsonData)")
            // println("Json valueJSON: \(json)")
            
            for result in json["Data"].arrayValue {
                
                // if ( result["id"] != "0") {
                
                
                let repeatFriendName = result["User"].stringValue
                //  var repeatFriendContact = result["TurnNumber"].stringValue
                
                repeatFriendNameArray.append(repeatFriendName as NSString)
                //repeatFriendContactArray.append(repeatFriendContact)
                
                //   }
                
            }
            
            FriendData.append(repeatFriendNameArray as NSArray)
            // FriendData.append(repeatFriendContactArray)
            
            return (FriendData)
            
        }
    
    
    func FBProfilePicArray(_ ProfileURL: [String]) {
        
        var imageURL = UIImage()
        
        for url in ProfileURL {
          //  if let url =
            if let url = URL(string: url) {
                if let data = try? Data(contentsOf: url) {
                    //imageURL.contentMode = UIView.ContentMode.ScaleAspectFit
                    imageURL = UIImage(data: data)!
                    let tempimage = UIImage(data: data)
                    ProfileImages.append(tempimage!)
                }
            }
            
        }
       
        //return
    }
    
    
 
    
    func GameLogin () {
        print("login called")
        //localPlayer = GKLocalPlayer.local
         var GCFriendsTemp = [NSString]()
        
        
        print("still in login")
        localPlayer.authenticateHandler = {(ViewController: UIViewController?, error: Error?) -> Void in
            if ((ViewController) != nil) {
                print("VC True")
                self.present(ViewController!, animated: true, completion: nil)
                
                
            } else if self.localPlayer.isAuthenticated {
                self.gcEnabled = true
                print("Player authenticated")
                
                //self.player = localPlayer.displayName
                self.playerid = self.localPlayer.playerID as NSString
                self.player = self.localPlayer.alias as NSString
                
                print("player: \(self.player)")
                print("playerid: \(self.playerid)")
                
                var sameuserTest = false
                
                if (self.prefs.value(forKey: "USERNAME") != nil) {
                    if (self.player.description == (self.prefs.value(forKey: "USERNAME") as AnyObject).description) {
                        sameuserTest = true
                    } else {
                        sameuserTest = false
                    }
                }
                
                self.prefs.setValue(self.player, forKey: "USERNAME")
                self.prefs.setValue(self.playerid, forKey: "PLAYERID")
                
                
            
                
                
              //JARED 11-26-2020 - FIX BELOW
            /*
                self.localPlayer.loadFriendPlayers(completionHandler: { (GCFriends) -> Void in

                    print("GCFriend = \(GCFriends)")
                    
                    
                    for myFriend in GCFriends.0! {
                        
                        let myFriendAlias = myFriend.alias
                        let myFriendID = myFriend.playerID
                        
                        // var myFriend = myFriend?.first
                        print("my friend ID = \(myFriend.playerID)")
                        print("my friend alias = \(myFriend.alias)")
                        print("my friend name = \(myFriend.displayName)")
                        
                        self.NameTable.append(myFriendAlias! as NSString)
                       // GCFriendsTemp.append(myFriendName!)
                        
                    }

                    
                    
                    
                })
                */
                
                
                
                if sameuserTest {
                    print("SameuserTest: Same user is playing")
                } else {
                    // self.performSegueWithIdentifier("goto_login", sender: self)
                    print("SameuserTest: New User is playing")
                   // self.SearchForMember(self.player as String, PlayerID: self.playerid as String)
                    
                }
                
                
                
            } else {
                self.gcEnabled = false
                print("Local player could not be authenticated, disableing game")
                print("Authentifcate error: \(error)")
                print("Player NOT authenticated")
                
                //self.player = ""
                
                
                
            }
            
        }
       // return GCFriendsTemp
        print("leaving login")
        self.TableView.reloadData()
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
