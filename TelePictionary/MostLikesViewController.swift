//
//  MostLikesViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 9/16/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import CoreData

class MostLikesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    var IsGameCenter = Bool()
    var profileName = NSString()
    var FriendStruct = [UserInfoData]()
    var FilteredFriends = [UserInfoData]()

    var rdelegate: RepeatFriendsViewControllerDelegate?
    
    var resultSearchController = UISearchController()
    struct UserInfoData {
        var username: String
        var userid: String
        var count: String
        var place: Int
    }

 //  var LikesArray = ["1", "2", "3"]
    @IBOutlet weak var View1BGimage: UIImageView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var menuButtonRight: UIBarButtonItem!

    
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    
    @IBOutlet weak var CloseBTN: UIButton!
    @IBOutlet weak var ViewHolder2: UIView!
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var View1TOP: NSLayoutConstraint!
    
    @IBOutlet weak var ViewHolder2TOP: NSLayoutConstraint!
    
    var ViewHowTo = Bool()
    var username = NSString()
    var userID = NSString()
    
    var LNamesArray = [NSString]()
    var LCountArray = [NSString]()
    var LUserIDArray = [NSString]()
    var IsFriend = [Bool]()
    
    var LNumbers = [NSString]()
    var LvarNum = 0
    
    var FriendInfo = [NSArray]()
    var FriendData = [NSArray]()
    var repeatFriendNameArray = [NSString]()
    var repeatFriendIDArray = [NSString]()
    var repeatFriendContactArray = [NSString]()
    var FriendNameInfo = [NSString]()
    var FriendIDInfo = [NSString]()

    let prefs:UserDefaults = UserDefaults.standard
    
    var refreshControl:UIRefreshControl!
    @IBOutlet weak var TableView: UITableView!
    
    let OtherUserProfile = true
    var profileID = NSString()
    var replaceRow = Int()
    
    @IBAction func ShowProfile(_ sender: AnyObject) {
        
        replaceRow = sender.tag
        //profileID = LUserIDArray[replaceRow]
        
      
        
        var infotype : UserInfoData
        
        if (self.resultSearchController.isActive) {
            infotype = FilteredFriends[replaceRow]
        } else {
            infotype = FriendStruct[replaceRow]
        }
        
        profileID = infotype.userid as NSString
        
        self.performSegue(withIdentifier: "ShowProfile", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowProfile" {
            
            
            if let destination = segue.destination as? LevelInfoViewController {
                
                destination.OtherUserProfile = self.OtherUserProfile
                
                destination.playerID = self.profileID
              
                print("Profile show segue")
            }
        }
        
        
        if segue.identifier == "ViewTurns" {
            
            
            if let destination = segue.destination as? LIkeFailCollectionViewController {
                
              //  destination.OtherUserProfile = self.OtherUserProfile
                
                print("Preparing for segue")
                destination.TurnType = "like"
                destination.PlayerName = self.profileName
                destination.playerID = self.profileID
                print("Profile show segue")
            }
        }
        
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        CloseBTN.layer.cornerRadius = 10

        self.View1BGimage.layer.cornerRadius = 5
        self.View1BGimage.layer.masksToBounds = true
        View1.layer.cornerRadius = 5
        View1.layer.masksToBounds = true
        self.refreshControl = UIRefreshControl()
        UITabBar.appearance().barTintColor = UIColor.black
        // UITabBar.appearance().tintColor = UIColor.whiteColor()
        UITabBar.appearance().selectedImageTintColor = UIColor.white
        
        self.TableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.TableView.backgroundColor = UIColor.clear
        
        self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        TableView.dataSource = self
        TableView.delegate = self
        
        self.title = "Most Likes"
        
        if let font = UIFont(name: "DK Cool Crayon", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        
     
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
        } else  {
            print("username Error")
            
            username = "guest"
            userID = "guest"
            
        }
        
      //  username = prefs.valueForKey("USERNAME") as! NSString as String
      //  userID = prefs.valueForKey("PLAYERID") as! NSString as String
        
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            menuButtonRight.target = self.revealViewController()  //revealViewController()
            menuButtonRight.action = #selector(SWRevealViewController.rightRevealToggle(_:))
        }
        self.refreshControl.addTarget(self, action: #selector(MostLikesViewController.RefreshCommentData(_:)), for: UIControl.Event.valueChanged)
        self.TableView.addSubview(refreshControl)
  
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            //controller.searchBar.scopeButtonTitles = ["All", "Complete", "In Process"]
            controller.searchBar.tintColor = UIColor.darkGray
            controller.searchBar.backgroundColor = UIColor.clear
            controller.searchBar.placeholder = "Search for someone Liked"
            
            let image = UIImage(named: "woodenShelfBG.png")
            controller.searchBar.setBackgroundImage(image, for: .any, barMetrics: .default)
            controller.searchBar.scopeBarBackgroundImage = image
            controller.searchBar.layer.backgroundColor = UIColor.clear.cgColor
            
            self.TableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        self.resultSearchController.searchBar.showsScopeBar = true
        
        if #available(iOS 9.0, *) {
            self.resultSearchController.loadViewIfNeeded()
        } else {
            // Fallback on earlier versions
        }
        
//self.TableView.reloadData()
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        actInd.startAnimating()
        self.refreshControl.isEnabled = false
        
        /*
        
        self.IsGameCenter = NSUserDefaults.standardUserDefaults().boolForKey("GameCenterEnabled")
        
        if !self.IsGameCenter {
            
            actInd.stopAnimating()
            //self.resultSearchController.
            
            let Alert = SCLAlertView()
            Alert.addButton("Log in Now", action: {
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    LogIntoGameCenterNew()
                    
                })
                
            })
            
            Alert.addButton("Later", action: {
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    SCLAlertView().showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Center", subTitle: "Without being logged into Game Center many of this games features are disabled.", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                    
                })
                
                
            })
            
            Alert.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Game Center", subTitle: "You need to be logged into Game Center to view your games.  Please log in now", duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
            
            
            
        } else {

        */
        
        if Reachability.isConnectedToNetwork() {
            
            let URLData = GetUserGameFriends(username, userid: userID, type: "mine")
            //println(test)
            FriendInfo = FilterGameFriends(URLData)
            
            FriendNameInfo = FriendInfo[0] as! [(NSString)]
            FriendIDInfo = FriendInfo[1] as! [(NSString)]
    
            
            
        let LURLData = LeadersLikesData(username)
        (LNamesArray, LCountArray, LUserIDArray) = FilterMostLikesData(LURLData)
        
        print("Count Array = \(LCountArray)")
        
            
            
        
        self.TableView.reloadData()
        
        } else {
            
            print("not connected to netowrk")
        }
        
        actInd.stopAnimating()
        
        
        
        ViewHolder2.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        let AlreadySeenHowTo = prefs.bool(forKey: "DidShowHowTo_Leader")
        
        if !AlreadySeenHowTo {
            
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.View1TOP.constant = middleY
                
                self.ViewHolder2.center.y = self.ViewHolder2.center.y - 1000
                
                self.ViewHolder2TOP.constant = 0
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
                self.ViewHowTo = true
                
             //   self.howtoPaintBTN.enabled = true
                
            })
            
        }

        
   // }
        
        
    
    }
    
    @IBAction func View1CloseBTN(_ sender: AnyObject) {
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if ViewHowTo {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.View1TOP.constant = middleY
                
                self.ViewHolder2.center.y = self.ViewHolder2.center.y + 1000
                
                self.ViewHolder2TOP.constant = 1000
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            
            ViewHowTo = false
        }
        
        
        self.prefs.set(true, forKey: "DidShowHowTo_Leader")
        
    }
    
    
    @objc func RefreshCommentData(_ sender:AnyObject) {
        print("removing array data")
        LNamesArray.removeAll()
        LCountArray.removeAll()
        FriendStruct.removeAll()
        
        print("adding array data")
        let LURLData = LeadersLikesData(username)
        (LNamesArray, LCountArray, LUserIDArray) = FilterMostLikesData(LURLData)
        
        
        self.TableView.reloadData()
        
        self.refreshControl.endRefreshing()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.resultSearchController.isActive && resultSearchController.searchBar.text != "") {
            return self.FilteredFriends.count
        } else {
            return self.FriendStruct.count;
            //            return self.GameNameInfo.count;
            //return self.GameSearchInfo.count;
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var infotype : UserInfoData
        
        if (self.resultSearchController.isActive) {
            infotype = FilteredFriends[(indexPath as NSIndexPath).row]
        } else {
            infotype = FriendStruct[(indexPath as NSIndexPath).row]
        }

        
        
        if infotype.userid != "" {
            // cell.contentBTN?.imageView?.image = UIImage(named: "YouIcon.png")
            //  cell.contentBTN?.tag = indexPath.row
            profileID = infotype.userid as NSString
            profileName = infotype.username as NSString
          //  self.performSegueWithIdentifier("ShowProfile", sender: self)
            
            
             DispatchQueue.main.async(execute: {
            self.performSegue(withIdentifier: "ViewTurns", sender: self)
            })
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.backgroundColor = UIColor.clear
        
          cell.contentBTN?.tag = (indexPath as NSIndexPath).row
        // cell.cellViewBG?.layer.cornerRadius = 10
        
        var infotype : UserInfoData
        
        if (self.resultSearchController.isActive && resultSearchController.searchBar.text != "")  {
            infotype = FilteredFriends[(indexPath as NSIndexPath).row]
        } else {
            infotype = FriendStruct[(indexPath as NSIndexPath).row]
        }

        
        //   cell.cellViewBG?.layer
        if infotype.username != "" {
            // cell.contentBTN?.imageView?.image = UIImage(named: "YouIcon.png")
            // cell.contentBTN?.tag = indexPath.row
            // cell.contentBTN?.addTarget(self, action: "ShowProfile:", forControlEvents: .TouchUpInside)
            
        }
        
        cell.titleLabel?.text = infotype.username as String
        //cell.titleLabel?.text = "Select Player Info"
        cell.numbers?.text = (infotype.place).description as String
        
        cell.subtitleLabel?.text = infotype.count as String
        
        if infotype.userid as String == userID as String {
            cell.contentBTN?.isHidden = false
            //cell.contentBTN?.imageView?.image = UIImage(named: "YouIcon.png")
            
            cell.contentBTN?.setImage(UIImage(named: "YouIcon.png"), for: UIControl.State())
        } else if FriendIDInfo.contains(infotype.userid as NSString) {
            cell.contentBTN?.isHidden = false
            cell.contentBTN?.setImage(UIImage(named: "FriendsIcon2.png"), for: UIControl.State())
            // cell.contentBTN?.imageView?.image = UIImage(named: "FriendsIcon2.png")
        } else {
            cell.contentBTN?.isHidden = true
        }
        
        /*
        //   cell.cellViewBG?.layer
        if infotype.username != "" {
           // cell.contentBTN?.imageView?.image = UIImage(named: "YouIcon.png")
           // cell.contentBTN?.tag = indexPath.row
           // cell.contentBTN?.addTarget(self, action: "ShowProfile:", forControlEvents: .TouchUpInside)
            
        }
        
        cell.titleLabel?.text = infotype.username as String
        //cell.titleLabel?.text = "Select Player Info"
        cell.numbers?.text = self.LNumbers[indexPath.row] as String
        
        cell.subtitleLabel?.text = infotype.count as String
        
        if infotype.userid as String == userID {
            cell.contentBTN?.hidden = false
            //cell.contentBTN?.imageView?.image = UIImage(named: "YouIcon.png")
            
            cell.contentBTN?.setImage(UIImage(named: "YouIcon.png"), forState: .Normal)
        } else if FriendIDInfo.contains(infotype.userid) {
            cell.contentBTN?.hidden = false
            cell.contentBTN?.setImage(UIImage(named: "FriendsIcon2.png"), forState: .Normal)
           // cell.contentBTN?.imageView?.image = UIImage(named: "FriendsIcon2.png")
        } else {
            cell.contentBTN?.hidden = true
        }
        
        
        */
                //if LNamesArray[indexPath.row] ==
        
        return cell
    }

    
    func FilterMostLikesData(_ urlData: Data) -> ([NSString], [NSString], [NSString]) {
        FriendStruct.removeAll()
        var Game_ID_Array = [NSString]()
        var Game_CountArray = [NSString]()
        var GameUserIDArray = [NSString]()
        
        LvarNum = 0
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        print("Json valueJSON: \(json)")
        
        for result in json["Data"].arrayValue {
            
            if ( result["username"] != "NA") {
                
                let game_username = result["username"].stringValue
                let game_userID = result["userid"].stringValue
                print("username = \(game_username)")
                
                LvarNum += 1
                LNumbers.append(LvarNum.description as NSString)
                
                
                
                let game_likes = result["totallikes"].stringValue
                
                FriendStruct.append(UserInfoData(username: game_username, userid: game_userID, count: game_likes, place: LvarNum))
                
                
                
                Game_ID_Array.append(game_username as NSString)
                Game_CountArray.append(game_likes as NSString)
                GameUserIDArray.append(game_userID as NSString)
                
                
            }
            
        }
        return (Game_ID_Array, Game_CountArray, GameUserIDArray)
        
    }
    
    
    func FilterGameFriends(_ urlData: Data) -> ([NSArray]) {
        
        // var traits = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        // println("Json valueJSON: \(json)")
        
        for result in json["Data"].arrayValue {
            
            if ( result["User"] != "NA") {
                if ( result["User"] != "-") {
                    if ( result["User"] != " ") {
                        
                        let repeatFriendName = result["User"].stringValue
                        
                        let repeatFriendID = result["UserID"].stringValue
                        //  var repeatFriendContact = result["TurnNumber"].stringValue
                        // let tempUserData = UserInfoData.init(username: repeatFriendName, userid: repeatFriendNameID)
                   //     FriendStruct.append(UserInfoData(username: repeatFriendName, userid: repeatFriendID))
                        
                        repeatFriendNameArray.append(repeatFriendName as NSString)
                        repeatFriendIDArray.append(repeatFriendID as NSString)
                        //repeatFriendContactArray.append(repeatFriendContact)
                    }
                }
            }
            
        }
        
        FriendData.append(repeatFriendNameArray as NSArray)
        FriendData.append(repeatFriendIDArray as NSArray)
        // FriendData.append(repeatFriendContactArray)
        
        return (FriendData)
        
    }
    
   
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        //   func filterContentForSearchText(searchText: String) {
        self.FilteredFriends = self.FriendStruct.filter({( infotype: UserInfoData) -> Bool in
            
            // return gametype.GameName.lowercaseString.containsString(searchText.lowercaseString)
            
            let categoryMatch = (scope == "All") || (infotype.username == scope)
            let stringMatch = infotype.username.range(of: searchText)
            
            return infotype.username.lowercased().contains(searchText.lowercased())
            
        })
        
        
        print("Filtered Games = \(FilteredFriends)")
        
        self.TableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        //  let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        
        //  FilteredGames.removeAll(keepCapacity: false)
        //  let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        //  let resultArray = (self.GameNameInfo as NSArray).filteredArrayUsingPredicate(searchPredicate)
        
        //filterContentForSearchText(searchController.searchBar.text!, scope: "All")
        //  filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
        filterContentForSearchText(searchController.searchBar.text!)
        //   filterContentForSearchText(searchController.searchBar.text!)
        
        self.TableView.reloadData()
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        print("Scope index changed: \(selectedScope)")
        
        /*
        switch selectedScope {
        
        case 0:
        self.selectedScope = "All"
        //self.endEditing = yes
        self.view.endEditing(true)
        break
        case 1:
        self.selectedScope = "Complete"
        self.view.endEditing(true)
        break
        case 2:
        self.selectedScope = "In Process"
        self.view.endEditing(true)
        break
        
        
        default:
        self.selectedScope = "All"
        self.view.endEditing(true)
        break
        
        }
        */
        
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
        
        print("Filtered Games = \(FilteredFriends)")
        
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
