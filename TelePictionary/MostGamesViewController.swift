//
//  MostGamesViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 9/16/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit

class MostGamesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    
    var IsGameCenter = Bool()
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
        
    @IBOutlet weak var actInd: UIActivityIndicatorView!
        
    var NamesArray = [NSString]()
    var CountArray = [NSString]()
    var UserIDArray = [NSString]()
    var Numbers = [NSString]()
    var varNum = 0
    var FriendInfo = [NSArray]()
    var FriendData = [NSArray]()
    var repeatFriendNameArray = [NSString]()
    var repeatFriendIDArray = [NSString]()
    var repeatFriendContactArray = [NSString]()
    var FriendNameInfo = [NSString]()
    var FriendIDInfo = [NSString]()
 
  
    var refreshControl:UIRefreshControl!
    
  

    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var menuButtonRight: UIBarButtonItem!

    
    var username = NSString()
    var userID = NSString()
    
    @IBOutlet weak var TableView: UITableView!
    
    
    let OtherUserProfile = true
    var profileID = NSString()
    var replaceRow = Int()
    
    @IBAction func ShowProfile(_ sender: AnyObject) {
        
        replaceRow = sender.tag
        profileID = UserIDArray[replaceRow]
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
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()

        UITabBar.appearance().barTintColor = UIColor.black
       // UITabBar.appearance().tintColor = UIColor.whiteColor()
        UITabBar.appearance().selectedImageTintColor = UIColor.white
       // UITabBarItem.appearance()
        
        //UITabBar.appearance().
        self.TableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.TableView.backgroundColor = UIColor.clear
        
        self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        TableView.dataSource = self
        TableView.delegate = self
        self.title = "Most Games"
        
        if let font = UIFont(name: "DK Cool Crayon", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.white]
        }
        
        
        
        let prefs:UserDefaults = UserDefaults.standard
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
        } else  {
            print("username Error")
            
            username = ""
            userID = ""
            
        }
        
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            menuButtonRight.target = self.revealViewController()  //revealViewController()
            menuButtonRight.action = #selector(SWRevealViewController.rightRevealToggle(_:))
        }
        
        self.refreshControl.addTarget(self, action: #selector(MostGamesViewController.RefreshCommentData(_:)), for: UIControlEvents.valueChanged)
        self.TableView.addSubview(refreshControl)
        
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            //controller.searchBar.scopeButtonTitles = ["All", "Complete", "In Process"]
            controller.searchBar.tintColor = UIColor.darkGray
            controller.searchBar.backgroundColor = UIColor.clear
            controller.searchBar.placeholder = "Search for a Gamer"
            
            let image = UIImage(named: "woodenShelfBG.png")
            controller.searchBar.setBackgroundImage(image, for: .any, barMetrics: .default)
            controller.searchBar.scopeBarBackgroundImage = image
            controller.searchBar.layer.backgroundColor = UIColor.clear.cgColor
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func RefreshCommentData(_ sender:AnyObject) {
        print("removing array data")
        NamesArray.removeAll()
        CountArray.removeAll()
        FriendStruct.removeAll()
        
        print("adding array data")
        let URLData = LeadersGamesCompletedData(username)
        (NamesArray, CountArray, UserIDArray) = FilterMostGamesData(URLData)

        
        
        self.TableView.reloadData()
        
        self.refreshControl.endRefreshing()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        actInd.startAnimating()
        
        /*
        
        self.IsGameCenter = NSUserDefaults.standardUserDefaults().boolForKey("GameCenterEnabled")
        
        if !self.IsGameCenter {
            
            actInd.startAnimating()
            self.refreshControl.enabled = false
            
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
   
            
        let URLData2 = LeadersGamesCompletedData(username)
        (NamesArray, CountArray, UserIDArray) = FilterMostGamesData(URLData2)
        
        print("Count Array = \(CountArray)")
        
    
        self.TableView.reloadData()
        } else {
            print("not connected to network")
        }
            
     //   }
        
        actInd.stopAnimating()
        
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
              self.performSegue(withIdentifier: "ShowProfile", sender: self)
            
          //  self.performSegueWithIdentifier("ViewTurns", sender: self)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.backgroundColor = UIColor.clear
        
        cell.contentBTN?.tag = (indexPath as NSIndexPath).row
       // cell.cellViewBG?.layer.cornerRadius = 10
        //   cell.cellViewBG?.layer
     
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
            
            cell.contentBTN?.setImage(UIImage(named: "YouIcon.png"), for: UIControlState())
        } else if FriendIDInfo.contains(infotype.userid as NSString) {
            cell.contentBTN?.isHidden = false
            cell.contentBTN?.setImage(UIImage(named: "FriendsIcon2.png"), for: UIControlState())
            // cell.contentBTN?.imageView?.image = UIImage(named: "FriendsIcon2.png")
        } else {
            cell.contentBTN?.isHidden = true
        }
        
        
        /*
        if UserIDArray[indexPath.row] != "" {
           // cell.contentBTN?.imageView?.image = UIImage(named: "YouIcon.png")
         //   cell.contentBTN?.tag = indexPath.row
         //   cell.contentBTN?.addTarget(self, action: "ShowProfile:", forControlEvents: .TouchUpInside)
            
        }

        
            cell.titleLabel?.text = self.NamesArray[indexPath.row] as String
            //cell.titleLabel?.text = "Select Player Info"
            cell.numbers?.text = self.Numbers[indexPath.row] as String
        
            cell.subtitleLabel?.text = self.CountArray[indexPath.row] as String
        
        if UserIDArray[indexPath.row] as String == userID {
            cell.contentBTN?.hidden = false
            //cell.contentBTN?.imageView?.image = UIImage(named: "YouIcon.png")
            
            cell.contentBTN?.setImage(UIImage(named: "YouIcon.png"), forState: .Normal)
        } else if FriendIDInfo.contains(UserIDArray[indexPath.row]) {
            cell.contentBTN?.hidden = false
            cell.contentBTN?.setImage(UIImage(named: "FriendsIcon2.png"), forState: .Normal)
            // cell.contentBTN?.imageView?.image = UIImage(named: "FriendsIcon2.png")
        } else {
            cell.contentBTN?.hidden = true
        }

        */

        return cell
    }
    
    func FilterMostGamesData(_ urlData: Data) -> ([NSString], [NSString], [NSString]) {
        FriendStruct.removeAll()
        varNum = 0
        var Game_ID_Array = [NSString]()
        var Game_CountArray = [NSString]()
        var GameUserIDArray = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        print("Json valueJSON: \(json)")
        
        for result in json["Data"].arrayValue {
            
            if ( result["username"] != "0") {
                
                let game_username = result["username"].stringValue
                let game_userID = result["userid"].stringValue
                print("username = \(game_username)")
                
                varNum += 1
                Numbers.append(varNum.description as NSString)
                
                let game_likes = result["totalgames"].stringValue
                
                 FriendStruct.append(UserInfoData(username: game_username, userid: game_userID, count: game_likes, place: varNum))
                
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
            
            _ = (scope == "All") || (infotype.username == scope)
            _ = infotype.username.range(of: searchText)
            
            return infotype.username.lowercased().contains(searchText.lowercased())
            
        })
        
        
        print("Filtered Games = \(FilteredFriends)")
        
        self.TableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        _ = searchController.searchBar
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
    }/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
