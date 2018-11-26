//
//  AllPlayersViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 2/16/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class AllPlayersViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UISearchResultsUpdating {
    
    @IBOutlet weak var viewHome: UIView!
    
    @IBOutlet weak var viewFriends: UIView!
    
    let serverAddress = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/"
    var DeviceW = CGFloat()
    var replyUserID = NSString()
    
    @IBOutlet weak var noticeLBL: UILabel!
    var pickerItem = Bool()
    var SegmentValueString = NSString()
    @IBOutlet weak var CollectionHeaderViewText: UILabel!
    
    @IBOutlet weak var searchBarPlaceholder: UIView!
    
     @IBOutlet var segmentControl : ADVSegmentedControl!
    
    var username = NSString()
    var userID = NSString()
    var FilteredGames = [GameUserInfo]()
    var GameUserInfoArray = [GameUserInfo]()
    @IBOutlet weak var backBTN: UIButton!
    @IBOutlet weak var CollectionHeaderView: UIView!
    
    var resultSearchController = UISearchController()
    
    @IBOutlet weak var empSearchBar: UISearchBar!
    
    var ISLOGGEDIN = Bool()
    @IBOutlet weak var collectionView: UICollectionView!
    
    var employeeNameSelected = NSString()
    var employeeImageSelected = UIImage()
    
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    
    var refreshControl:UIRefreshControl!
    let prefs:UserDefaults = UserDefaults.standard
    fileprivate let reuseIdentifier = "BasicCollectionCell"
    
    var Photos = [UIImage]()
    var EmployeeName = [NSString]()
    var EmployeeST = [GameUserInfo]()
    
    
    var theTopics = [HowGroup]()
    var FilteredTopics = [HowGroup]()
    
    struct HowGroup {
        let title : String
        let imageName : String
        let topics : String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.viewHome.layer.cornerRadius = 40
        self.viewHome.layer.borderWidth = 2
        self.viewHome.layer.borderColor = UIColor.white.cgColor
        self.viewHome.clipsToBounds = true
        self.viewHome.layer.masksToBounds = true
        
        self.viewFriends.layer.cornerRadius = 20
        self.viewFriends.layer.borderWidth = 2
        self.viewFriends.layer.borderColor = UIColor.white.cgColor
        self.viewFriends.clipsToBounds = true
        self.viewFriends.layer.masksToBounds = true
        
        DeviceW = self.view.frame.width
        
        self.Photos.removeAll()
        self.noticeLBL.isHidden = true
        self.viewHome.isHidden = true
        if self.prefs.value(forKey: "USERNAME") != nil {
            //GamesAvailable = true
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
           // NoGamesLBL.hidden = true
           // restartMyGames.hidden = true
            
        } else  {
          //  GamesAvailable = false
            username = "temp"
          //  NoGamesLBL.hidden = false
            userID = "temp"
            
           // self.restartMyGames.hidden = false
            //restartMyGames.hidden = true
        }
        
        self.view.backgroundColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
            //UIColor.whiteColor()
        //UIColor.NewColors.primaryColor
        
        self.refreshControl = UIRefreshControl()
        self.CollectionHeaderView.backgroundColor = UIColor.lightGray
            //UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
        //UIColor.NewColors.ColorCellBG
        self.CollectionHeaderViewText.textColor =   UIColor.white
        //UIColor.NewColors.ColorFontTwo
        self.actInd.color = UIColor.white
        //UIColor.NewColors.ColorCellBG
        
        if self.revealViewController() != nil {
            print("Is reveal view controller enabled")
            // backBTN.target = self.revealViewController()
            // rightmenuButton.target = self.revealViewController()
            //backBTN.addTarget(<#T##target: AnyObject?##AnyObject?#>, action: <#T##Selector#>, forControlEvents: <#T##UIControlEvents#>)
            // backBTN.addTarget(self.revealViewController().frontViewController, action: "revealToggle:", forControlEvents: .TouchUpInside)
            
            //    button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            //  backBTN.action = "revealToggle:"
            //  rightmenuButton.action = "rightRevealToggle:"
            
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            // self.revealViewController().rightViewRevealWidth = self.view.frame.width-5
            
            // self.revealViewController().rearViewRevealWidth = self.view.frame.width-10
            
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AllPlayersViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            //controller.searchBar = empSearchBar
            controller.searchResultsUpdater = self
            //   controller.delegate = self
            controller.dimsBackgroundDuringPresentation = false
            // controller.searchBar.showsScopeBar = true
            //  controller.searchBar.
            controller.searchBar.sizeToFit()
            //controller.searchBar.scopeButtonTitles = ["All", "Complete", "In Process"]
            controller.definesPresentationContext = true
            controller.searchBar.backgroundColor = UIColor.blue
            controller.searchBar.placeholder = "Search for a player..."
            controller.searchBar.tintColor = UIColor.darkGray
            controller.searchBar.layer.backgroundColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0).cgColor
//            controller.searchBar.bounds = searchBarPlaceholder.bounds
            /*
            controller.searchBar.translatesAutoresizingMaskIntoConstraints = false
            
            let leftConstraint = NSLayoutConstraint(item: controller.searchBar, attribute: .Leading, relatedBy: .Equal, toItem: navigationController?.navigationBar, attribute: .Leading, multiplier: 1, constant: 20) // add margin
            
            let bottomConstraint = NSLayoutConstraint(item: controller.searchBar, attribute: .Bottom, relatedBy: .Equal, toItem: navigationController?.navigationBar, attribute: .Bottom, multiplier: 1, constant: 1)
            
            let topConstraint = NSLayoutConstraint(item: controller.searchBar, attribute: .Top, relatedBy: .Equal, toItem: navigationController?.navigationBar, attribute: .Top, multiplier: 1, constant: 1)
            
            let widthConstraint = NSLayoutConstraint(item: controller.searchBar, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: self.view.frame.size.width - 40) // - margins from both sides
*/
            // controller.s
            //   self.collectionView.
            //   self.collectionView.tableHeaderView = controller.searchBar
            // self.view.addSubview(controller.searchBar)
            self.searchBarPlaceholder.addSubview(controller.searchBar)
            controller.searchBar.sizeToFit()
            var frame = controller.searchBar.frame
            //frame.origin.x = 20
            frame.origin.x = 0
           // frame.size.width -= 100
            frame.size.width = DeviceW - 60
            controller.searchBar.frame = frame
            //  self.collectionView.ad
            return controller
        })()
        
        if #available(iOS 9.0, *) {
            self.resultSearchController.loadViewIfNeeded()
        } else {
            // Fallback on earlier versions
        }
        
        empSearchBar = self.resultSearchController.searchBar
        
        
        self.collectionView.backgroundColor = UIColor.clear
        
        self.refreshControl.addTarget(self, action: #selector(AllPlayersViewController.RefreshCommentData(_:)), for: UIControlEvents.valueChanged)
        self.collectionView!.addSubview(refreshControl)
        
        
        collectionView!.dataSource = self
        collectionView!.delegate = self
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        
        self.Photos.removeAll()
        /*
        self.Photos.append(UIImage(named: "noImage.png")!)
        self.Photos.append(UIImage(named: "noImage.png")!)
        self.Photos.append(UIImage(named: "noImage.png")!)
        self.Photos.append(UIImage(named: "noImage.png")!)
        self.Photos.append(UIImage(named: "noImage.png")!)
        self.Photos.append(UIImage(named: "noImage.png")!)
        self.Photos.append(UIImage(named: "noImage.png")!)
        self.Photos.append(UIImage(named: "noImage.png")!)
        self.Photos.append(UIImage(named: "noImage.png")!)
        self.Photos.append(UIImage(named: "noImage.png")!)
        
        self.EmployeeName.append("Jared Stevens")
        self.EmployeeName.append("Mike Clayton")
        self.EmployeeName.append("Person")
        self.EmployeeName.append("Person")
        self.EmployeeName.append("Person")
        self.EmployeeName.append("Person")
        self.EmployeeName.append("Person")
        self.EmployeeName.append("Person")
        self.EmployeeName.append("Person")
        self.EmployeeName.append("Person")
        
        */
        
        
        /*
        dispatch_async(dispatch_get_main_queue(),{
            self.collectionView?.reloadData()
            print("done animating")
            self.actInd.stopAnimating()
        })
        
        */
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
        } else  {
            print("username Error")
            
            username = ""
            userID = ""
            
        }
        
        segmentControl.items = ["All", "Followers", "Following"]
        segmentControl.font = UIFont(name: "DK Cool Crayon", size: 12)
        segmentControl.borderColor = UIColor(white: 1.0, alpha: 0.3)
        segmentControl.selectedIndex = 0
        segmentControl.thumbColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
            //UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
        segmentControl.selectedLabelColor = UIColor.white
        segmentControl.addTarget(self, action: #selector(AllPlayersViewController.segmentValueChanged(_:)), for: .valueChanged)
        
    }
    
    @IBAction func GoBackBTN(_ sender: AnyObject) {
        print("Back button tapped")
        
        self.revealViewController().setFrontViewPosition(FrontViewPosition.left, animated: true)
        //self.revealViewController()
        // self.navigationController?.popToRootViewControllerAnimated(true)
        // self.revealViewController().setFrontViewController(revealViewController().frontViewController, animated: true)
        
        //self.revealViewController().presentViewController(revealViewController().frontViewController, animated: true, completion: nil)
        //  self.revealViewController()
        //self.revealViewController().frontViewController
        // self.revealController(revealViewController(), willMoveToPosition: .Left)
    }
    
    
    func revealController(_ revealController: SWRevealViewController!, willMoveToPosition position: FrontViewPosition)
    {
        if position == FrontViewPosition.left     // if it not statisfy try this --> if revealController.frontViewPosition == FrontViewPosition.Left
        {
            self.view.isUserInteractionEnabled = false
        }
        else
        {
            self.view.isUserInteractionEnabled=true
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Should search and load my team pictures")
        segmentControl.selectedIndex == 0
        
        ISLOGGEDIN = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
        print("ISLOGGEDIN from All Players = \(ISLOGGEDIN)")
        
        if ISLOGGEDIN {
            
            
            if prefs.value(forKey: "USERNAME") != nil {
                
                username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
                userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
            } else  {
                username = "guest"
                userID = "guest"
            }
            
            
            /*
            let numBadges = self.prefs.integerForKey("numTurns")
            let completedGames = self.prefs.integerForKey("comGames")
            // navigationController!.tabBarItem.badgeValue = numBadges.description
            let tabArray = self.tabBarController?.tabBar.items as NSArray!
            let TurnItem = tabArray.objectAtIndex(0) as! UITabBarItem
            let CompletedItem = tabArray.objectAtIndex(3) as! UITabBarItem
            
            print("NUMBER OF TURNS = \(numBadges)")
            
            if numBadges > 0 {
                TurnItem.badgeValue = numBadges.description
            }
            
            if completedGames > 0 {
                CompletedItem.badgeValue = completedGames.description
            }
            */
            
        }
        /*
        self.Photos.removeAll()
        
        self.Photos.append(UIImage(named: "JaredTemp.jpg")!)
        self.Photos.append(UIImage(named: "MikeTemp.jpeg")!)
        self.Photos.append(UIImage(named: "profileIcon.png")!)
        self.Photos.append(UIImage(named: "ShadowCircleLeaderIcon.png")!)
        self.Photos.append(UIImage(named: "YouIcon.png")!)
        self.Photos.append(UIImage(named: "ShadowCircleLeaderIcon.png")!)
        self.Photos.append(UIImage(named: "profileIcon.png")!)
        self.Photos.append(UIImage(named: "Hertz Puzzle - Together.png")!)
        self.Photos.append(UIImage(named: "profileIcon.png")!)
        self.Photos.append(UIImage(named: "profileIcon.png")!)
        
        self.EmployeeName.append("Jared Stevens")
        self.EmployeeName.append("Mike Clayton")
        self.EmployeeName.append("Employee")
        self.EmployeeName.append("Employee")
        self.EmployeeName.append("Employee")
        self.EmployeeName.append("Employee")
        self.EmployeeName.append("Employee")
        self.EmployeeName.append("Employee")
        self.EmployeeName.append("Employee")
        self.EmployeeName.append("Employee")
        
        
        dispatch_async(dispatch_get_main_queue(),{
        self.collectionView?.reloadData()
        print("done animating")
        self.actInd.stopAnimating()
        })
        
        */
        
        
        if Reachability.isConnectedToNetwork() {
            
         
        let URLData = GetUserGameFriends(username, userid: userID, type: "all")
        //println(test)
        GameUserInfoArray = FilterGameUserData(URLData)
        
        DispatchQueue.main.async(execute: {
            self.collectionView?.reloadData()
            print("done animating")
            self.actInd.stopAnimating()
        })
            
            
        }
            
        else
            
        {
            
            
            
            
            SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Network Error", subTitle: "Please Confirm Your Network Settings", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
            
        }

        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "ViewUserStats" {
            
            
            if segue.destination is LevelInfoViewController {
                
           //     destination.employeeName = self.employeeNameSelected
           //     destination.employeeImage = self.employeeImageSelected
                
                // destination.playerID = self.profileID
                print("Profile show segue")
            }
        }
        
        if segue.identifier == "ShowProfile" {
            
            
            if let destination = segue.destination as? LevelInfoViewController {
                
                destination.OtherUserProfile = true
                destination.ShowB2 = true
                
                destination.playerID = self.replyUserID
                print("Profile show segue")
            }
        }
        
        if segue.identifier == "login" {
            if let destination = segue.destination as? LoginViewController {
                destination.FromAllPlayers = true
            }
        }
        
        
    }
    
    
    
    func RefreshCommentData(_ sender:AnyObject) {
        print("Refresh Comment Data")
        ISLOGGEDIN = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
        
        
        if ISLOGGEDIN {
            
            switch self.SegmentValueString {
                
                case "followers":
                 refreshFollowerPlayers()
                
                case "following":
                 refreshFollowingPlayers()
                
                case "all":
                refreshAllPlayers()
                
                
            default:
                break
            }
            
            
            
        }
        
        DispatchQueue.main.async(execute: {
            self.refreshControl.endRefreshing()
            
        })
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let PersonSelected = (indexPath as NSIndexPath).row
        //print("the person rowselected: \(sender.tag)")
        
        let gametype : GameUserInfo
        
        if (self.resultSearchController.isActive && resultSearchController.searchBar.text != "") {
            gametype = FilteredGames[PersonSelected]
        } else {
            gametype = GameUserInfoArray[PersonSelected]
        }
        
        _ = gametype.username
        _ = gametype.userid
        
        replyUserID = gametype.userid as NSString
        
        
        print("Selecting employee")
        
        DispatchQueue.main.async(execute: {
            
         self.performSegue(withIdentifier: "ShowProfile", sender: self)
            
        })
        
        
        /*
        var string = PhotoID[indexPath.row] as String
        
        // var word = "Apple"
        // var string = "Hello Swift"
        if let range = string.rangeOfString("Turn") {
        let firstPart = string[string.startIndex..<range.startIndex]
        print(firstPart) // print Hello
        let lastPart = string[range.startIndex..<string.endIndex]
        print("last part = \(lastPart)")
        
        switch lastPart {
        case "Turn1":
        NewTurnNumber = ""
        case "Turn2":
        NewTurnNumber = "\(firstPart)Turn1"
        case "Turn3":
        NewTurnNumber = "\(firstPart)Turn2"
        case "Turn4":
        NewTurnNumber = "\(firstPart)Turn3"
        case "Turn5":
        NewTurnNumber = "\(firstPart)Turn4"
        case "Turn6":
        NewTurnNumber = "\(firstPart)Turn5"
        case "Turn7":
        NewTurnNumber = "\(firstPart)Turn6"
        case "Turn8":
        NewTurnNumber = "\(firstPart)Turn7"
        case "Turn9":
        NewTurnNumber = "\(firstPart)Turn8"
        case "Turn10":
        NewTurnNumber = "\(firstPart)Turn9"
        default:
        NewTurnNumber = ""
        }
        
        
        //   let CTF: Character = "n"
        
        //   if let index = find(string, CTF) {
        
        //    NewTurnNumber = string.substringFromIndex(advance(firstPart, 1))
        //     print("new Turn Number = \(NewTurnNumber)")
        //  }
        }
        
        theAudioData = AudioClips[indexPath.row]
        MainImage = Photos[indexPath.row]
        MediaType = MediaTypeArray[indexPath.row]
        TurnInfo = PhotoID[indexPath.row]
        self.performSegueWithIdentifier("showImage", sender: self)
        
        */
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        print("Update search bar")
        _ = searchController.searchBar
        // let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        
        // print("Search Scope1 = \(scope)")
        
        //  FilteredGames.removeAll(keepCapacity: false)
        //  let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        //  let resultArray = (self.GameNameInfo as NSArray).filteredArrayUsingPredicate(searchPredicate)
        
        // filterContentForSearchText(searchController.searchBar.text!, scope: scope)
        filterContentForSearchText(searchController.searchBar.text!)
        //filterContentForSearchText(searchController.searchBar.text!)
        
        self.collectionView.reloadData()
    }
    
    func filterContentForSearchText(_ searchText: String) {
        //  print("Search Scope = \(scope)")
        // self.TableViewTOP.constant = 50
        self.FilteredGames = self.GameUserInfoArray.filter({( howtype: GameUserInfo) -> Bool in
            
            //GameUserInfoArray = [GameUserInfo]()
            //       print("game names = \(gametype.GameName)")
            
            //    print("game Category = \(gametype.GameCategory)")
            // return gametype.GameName.lowercaseString.containsString(searchText.lowercaseString)
            //     let categoryMatch = gametype.GameCategory == scope
            
            
            /*
            let categoryMatch = (scope == "All") || (gametype.GameCategory == scope)
            if categoryMatch
            {
            //       print("category: \(gametype.GameCategory) matched \(scope)")
            }
            let stringMatch = gametype.GameName.rangeOfString(searchText)
            return categoryMatch && (stringMatch != nil)
            
            */
            //  let stringMatch2 = howtype.topics.NSPredicate(format: "name contains[c] %@", searchText)
            // self.filteredArray = self.array.filteredArrayUsingPredicate(searchPredicate)
            
            // let stringMatch3 = howtype.topics.
            let stringMatch = howtype.SearchString.lowercased().range(of: searchText.lowercased())
            
            return (stringMatch != nil ? true : false)
            
            
        })
        
        
        //   print("Filtered Games = \(FilteredGames)")
        
        self.collectionView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancel Button Clicked")
    }
    
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        //   print("Scope index changed: \(selectedScope)")
        
        //   print("Scope index changed: \(searchBar.selectedScopeButtonIndex)")
        
        
        //filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
        filterContentForSearchText(searchBar.text!)
        print("Filtered Games, from selected scope index change = \(FilteredGames)")
        
        self.collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print("Number of Users Found = \(GameUserInfoArray.count)")
        
        if (self.resultSearchController.isActive && resultSearchController.searchBar.text != "") {
            
            return self.FilteredGames.count
        } else {
            return GameUserInfoArray.count
        }
        
        
        
        //return GameUserInfoArray.count
        //return Photos.count
    }
    
    func ViewStats(_ sender: UIButton!) {
        let EmployeeRowSelected = sender.tag
        
        print(EmployeeName)
        
        print("Employee Row Selected = \(EmployeeRowSelected)")
        let gametype : GameUserInfo
        
        if (self.resultSearchController.isActive && resultSearchController.searchBar.text != "") {
            gametype = FilteredGames[EmployeeRowSelected]
        } else {
            gametype = GameUserInfoArray[EmployeeRowSelected]
        }

        
        replyUserID = gametype.userid as NSString
        
        
       // employeeNameSelected = EmployeeName[EmployeeRowSelected].description as NSString
       // employeeImageSelected = Photos[EmployeeRowSelected]
        
        employeeNameSelected = gametype.username as NSString
      //  employeeImageSelected = Photos[EmployeeRowSelected]
        
        self.performSegue(withIdentifier: "ShowProfile", sender: self)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        // Configure the cell
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasicCollection", for: indexPath) as! BasicCollectionViewCell
        
        let gametype : GameUserInfo
        
        if (self.resultSearchController.isActive && resultSearchController.searchBar.text != "") {
            gametype = FilteredGames[(indexPath as NSIndexPath).row]
        } else {
            gametype = GameUserInfoArray[(indexPath as NSIndexPath).row]
        }
        
        
        cell.foloowView?.layer.cornerRadius = 10
        cell.foloowView?.layer.masksToBounds = true
        cell.foloowView?.clipsToBounds = true
        
        if ISLOGGEDIN {
            /*
            cell.foloowView?.hidden = false
            
            
        } else {
            cell.foloowView?.hidden = true
        }
        
        
        */
        
        
        switch self.SegmentValueString {
            
        case "followers":
            
            cell.foloowView.isHidden = true
            
            if gametype.isFollowing {
                cell.followLBL?.text = "Following"
                cell.foloowView?.layer.backgroundColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).cgColor
            } else {
                cell.followLBL?.text = "Follower"
                cell.foloowView?.layer.backgroundColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0).cgColor
            }
            
            
            cell.followBTN?.tag = (indexPath as NSIndexPath).row
            cell.followBTN?.addTarget(self, action: #selector(AllPlayersViewController.FollowerClicked(_:)), for: .touchUpInside)
            print("Cell Player Username = \(gametype.username)")
            
            
        case "following":
            
            cell.foloowView.isHidden = false
            
            if gametype.isFollowing {
                cell.followLBL?.text = "Following"
                cell.foloowView?.layer.backgroundColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).cgColor
            } else {
                cell.followLBL?.text = "Follow"
                cell.foloowView?.layer.backgroundColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0).cgColor
            }
            
            
            
            cell.followBTN?.tag = (indexPath as NSIndexPath).row
            cell.followBTN?.addTarget(self, action: #selector(AllPlayersViewController.FollowClicked(_:)), for: .touchUpInside)
            print("Cell Player Username = \(gametype.username)")
            
            
            
        case "all":
            
            cell.foloowView.isHidden = false
            
            if gametype.isFollowing {
                cell.followLBL?.text = "Following"
                cell.foloowView?.layer.backgroundColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).cgColor
            } else {
                cell.followLBL?.text = "Follow"
                cell.foloowView?.layer.backgroundColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0).cgColor
            }
            
            
            cell.followBTN?.tag = (indexPath as NSIndexPath).row
            cell.followBTN?.addTarget(self, action: #selector(AllPlayersViewController.FollowClicked(_:)), for: .touchUpInside)
            print("Cell Player Username = \(gametype.username)")
            
            
        default:
            
            cell.foloowView.isHidden = false
            
            if gametype.isFollowing {
                cell.followLBL?.text = "Following"
                cell.foloowView?.layer.backgroundColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).cgColor
            } else {
                cell.followLBL?.text = "Follow"
                cell.foloowView?.layer.backgroundColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0).cgColor
            }
            
            
            cell.followBTN?.tag = (indexPath as NSIndexPath).row
            cell.followBTN?.addTarget(self, action: #selector(AllPlayersViewController.FollowClicked(_:)), for: .touchUpInside)
            print("Cell Player Username = \(gametype.username)")
            
        }
        
        
    } else {
    
    cell.foloowView?.isHidden = false
    
    }
    
        /*
        if gametype.isFollowing {
         cell.followLBL?.text = "Following"
         cell.foloowView?.layer.backgroundColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).CGColor
        } else {
        cell.followLBL?.text = "Follow"
        cell.foloowView?.layer.backgroundColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0).CGColor
        }
        
        */
        
        
        cell.cellBG?.layer.cornerRadius = 5
        cell.cellBG?.clipsToBounds = true
        cell.cellBG?.layer.masksToBounds = true
        
       
        cell.profileImage?.image = UIImage(named: "noImage.png")!
       // cell.profileImage?.image = Photos[indexPath.item] as UIImage
        cell.profileImage?.layer.cornerRadius = cell.profileImage.frame.height / 2
        cell.profileImage?.clipsToBounds = true
        cell.profileImage?.layer.masksToBounds =  true
        cell.profileImage?.layer.borderColor = UIColor.darkGray.cgColor
        //UIColor.NewColors.HeaderText.CGColor
        
        //UIColor.whiteColor().CGColor
        cell.profileImage?.layer.borderWidth = 1
        cell.profileImage?.contentMode = UIViewContentMode.scaleAspectFit
        
        cell.theButton?.tag = (indexPath as NSIndexPath).row
        cell.theButton?.addTarget(self, action: #selector(AllPlayersViewController.ViewStats(_:)), for: .touchUpInside)
        
        cell.employeeName?.text = gametype.username as String
        cell.employeeName?.textColor = UIColor.black
        
        
        
        
        print("Turn1 URL String = \(gametype.ImageURL)")
        let request = URLRequest(url: URL(string: gametype.ImageURL)!)
        let mainQueue = OperationQueue.main
        NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
            if error == nil {
                // Convert the downloaded data in to a UIImage object
                let image = UIImage(data: data!)
                // Store the imge in to our cache
                //  self.imageCache[urlString] = image
                // Update the cell
                DispatchQueue.main.async(execute: {
                    if collectionView.cellForItem(at: indexPath) != nil {
                    //if let cellToUpdate = TableView.cel
                    //if let cellToUpdate = self.TableView.cellForRowAtIndexPath(indexPath) {
                        
                        cell.profileImage?.image = image
                        //let GIFData = NSData
                        
                        // cell.TurnImage?.image = UIImage.animatedImageWithAnimatedGIFData(data!)
                        //cellToUpdate.TurnImage?.image = image
                    }
                })
            }
            else {
                
               cell.profileImage?.image = UIImage(named: "noImage.png")!
                
                print("Error: \(error!.localizedDescription)")
            }
        })
        
        
        
        
        //UIColor.NewColors.HeaderText
        
        // cell.profileButton.addTarget(self, action: "PlayAudioClicked:", forControlEvents: .TouchUpInside)
        //2
        
        /*
        // cell.myLabel.text = self.items[indexPath.item]
        cell.TurnImage?.image = Photos[indexPath.row] as UIImage
        cell.TurnImage?.layer.cornerRadius = 5
        cell.TurnImage?.layer.masksToBounds = true
        
        cell.playBTN?.addTarget(self, action: "PlayAudioClicked:", forControlEvents: .TouchUpInside)
        
        cell.playBTN?.tag = indexPath.row
        cell.playBTN?.hidden = HideAudioArray[indexPath.row]
        
        if NumFails[indexPath.row] as String == "1" {
        cell.CellLBL?.text = "\(NumFails[indexPath.row] as String) \(TurnType)"
        } else {
        cell.CellLBL?.text = "\(NumFails[indexPath.row] as String) \(TurnType)s"
        }
        
        */
        //cell.TurnImage?.image = PhotoST[indexPath.row].theImage as UIImage
        //let LikeFailPhoto = photoForIndexPath(indexPath)
        // cell.backgroundColor = UIColor.blackColor()
        //3
        //  cell.imageView.image = LIkeFailPhoto.thumbnail
        
        return cell
    }
    
    func FilterGameUserData(_ urlData: Data) -> [GameUserInfo] {
        
        var EmployeeDataTemp = [GameUserInfo]()
        
        /*
        self.Photos.removeAll()
        self.PhotoID.removeAll()
        self.NumFails.removeAll()
        self.AudioStringArray.removeAll()
        self.HideAudioArray.removeAll()
        
        var PhotoData = [PhotoInfo]()
        */
        
        // var Game_ID_Array = [NSString]()
        //  var Game_CountArray = [NSString]()
        //  var GameUserIDArray = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        print("Json valueJSON: \(json)")
        
        for result in json["Data"].arrayValue {
            
            if ( result["User"].stringValue != "NA")  {
                
                if ( result["UserID"].stringValue != "") {
                    
                  if ( result["UserID"].stringValue != self.userID as String) {
                    
                var follow_temp = Bool()
                
                let game_username = result["User"].stringValue
                let game_userID = result["UserID"].stringValue
                let first_name = result["firstname"].stringValue
                let last_name = result["lastname"].stringValue
                let total_temp = result["total"].stringValue
                let level_temp = result["level"].stringValue
                print("username = \(game_username)")
                let following_temp = result["isfollowing"].stringValue
                let id_temp = result["id"].stringValue
                    
                let tempURL = "\(serverAddress)player\(id_temp).jpg"
                    
                let searchStringTemp: String = "\(game_username) \(first_name) \(last_name)"
                
                if following_temp == "true" {
                    follow_temp = true
                } else {
                    follow_temp = false
                }
                
                EmployeeDataTemp.append(GameUserInfo(firstname: first_name, lastname: last_name, username: game_username, userid: game_userID, ImageURL: tempURL, total: total_temp, level: level_temp, isFollowing: follow_temp, SearchString: searchStringTemp))
                
            }
           }
          }
            //}
            
        }
        print("PhotoData Struct = \(EmployeeDataTemp)")
       // print("Photos Count = \(Photos.count)")
        return EmployeeDataTemp
        
    }
    
    
    @IBAction func filterArea(_ sender: AnyObject) {
        
        let theAlert = SCLAlertView()
        theAlert.addButton("Branch", action: {
            
        })
        
        theAlert.addButton("Area", action: {
            
        })
        
        theAlert.addButton("Zone", action: {
            
        })
        
        theAlert.addButton("Region", action: {
            
        })
        
        theAlert.addButton("All", action: {
            
        })
        
        //YELLOW - UIColor(red: 0.91372549, green: 0.90196078, blue: 0.01058824, alpha: 1.0)
        
        //    theAlert.showCustomOK(UIImage(named: "filterIconWhite.png")!, color: UIColor(red: 0.91372549, green: 0.90196078, blue: 0.01058824, alpha: 1.0), title: "Filter Groups", subTitle: "Select A Group", duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
        
        theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0), title: "Filter Groups", subTitle: "Select A Group", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
        
    }
    
    
    func DismissKeyboard(){
        
        /*
        if GameTitleTXT.text.isEmpty {
        GameTitleBTN.layer.backgroundColor = UIColor(red: 0.99, green: 0.69, blue: 0.35, alpha: 1.0).CGColor
        
        } else  {
        GameTitleBTN.layer.backgroundColor = UIColor.greenColor().CGColor
        }
        */
        
        view.endEditing(true)
    }
    
    /*
    
    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var excBannerLBL: UILabel!
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var usernameLBL: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var topViewLEAD: NSLayoutConstraint!
    
    @IBOutlet weak var bottomViewTRAIL: NSLayoutConstraint!
    
    @IBOutlet weak var topViewTOP: NSLayoutConstraint!
    
    @IBOutlet weak var bottomViewBOTTOM: NSLayoutConstraint!
    
    var CatTitle = NSString()
    @IBOutlet weak var workstyleView: UIView!
    @IBOutlet weak var excView: UIView!
    @IBOutlet weak var leaderView: UIView!
    @IBOutlet weak var helpView: UIView!
    
    
    
    @IBOutlet weak var workstyleH: NSLayoutConstraint!
    @IBOutlet weak var workstyleW: NSLayoutConstraint!
    @IBOutlet weak var excH: NSLayoutConstraint!
    @IBOutlet weak var excW: NSLayoutConstraint!
    @IBOutlet weak var leaderH: NSLayoutConstraint!
    @IBOutlet weak var leaderW: NSLayoutConstraint!
    @IBOutlet weak var helpH: NSLayoutConstraint!
    @IBOutlet weak var helpW: NSLayoutConstraint!
    
    @IBOutlet weak var helpLEAD: NSLayoutConstraint!
    @IBOutlet weak var leaderTRAIL: NSLayoutConstraint!
    @IBOutlet weak var excTRAIL: NSLayoutConstraint!
    @IBOutlet weak var styleLEAD: NSLayoutConstraint!
    
    @IBOutlet weak var topViewH: NSLayoutConstraint!
    @IBOutlet weak var topViewW: NSLayoutConstraint!
    
    
    @IBOutlet weak var bottomViewH: NSLayoutConstraint!
    
    @IBOutlet weak var bottomViewW: NSLayoutConstraint!
    
    var DeviceH = CGFloat()
    var middleY = CGFloat()
    var DeviceW = CGFloat()
    var middleX = CGFloat()
    
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
    excBannerLBL.layer.cornerRadius = 11
    excBannerLBL.layer.masksToBounds = true
    scrollView.scrollEnabled = true
    scrollView.pagingEnabled = false
    scrollView.delegate = self
    // scrollView.contentSize = CGSize(width: self.view.frame.width, height: 800)
    // scrollView.bounces = false
    
    scrollView.showsHorizontalScrollIndicator = false
    
    DeviceH = self.view.frame.height
    middleY = DeviceH / 2
    DeviceW = self.view.frame.width
    middleX = DeviceW / 2
    
    
    self.topViewTOP.constant = 0
    self.bottomViewBOTTOM.constant = 0
    self.topViewW.constant = DeviceW
    self.topViewH.constant = middleY - 40
    self.bottomViewH.constant = middleY - 40
    self.bottomViewW.constant = DeviceW
    
    self.helpLEAD.constant = (DeviceW / 2) + 2
    self.styleLEAD.constant = (DeviceW / 2) + 2
    self.excTRAIL.constant = (DeviceW / 2) + 2
    self.leaderTRAIL.constant = (DeviceW / 2) + 2
    
    
    /*
    self.title = "My Profile"
    
    
    if let font = UIFont(name: "Marker Felt", size: 25.0) {
    self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.darkGrayColor()]
    }
    
    if self.revealViewController() != nil {
    menuButton.target = self.revealViewController()
    menuButton.action = "revealToggle:"
    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    navigationController!.navigationBar.barTintColor = UIColor(red: 0.96470588, green: 0.94117647, blue: 0.10980392, alpha: 1.0)
    */
    
    // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
    scrollView.contentSize = CGSize(width: self.view.frame.width, height: 600)
    self.containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 600)
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
    // self.topViewLEAD.constant = -600
    self.topViewLEAD.constant = DeviceW + 10
    // self.bottomViewTRAIL.constant = (DeviceW * -1)
    self.bottomViewTRAIL.constant = (DeviceW * -1) - 10
    
    //self.bottomViewTRAIL.constant = -600
    self.workstyleH.constant = (DeviceW / 2)
    self.workstyleW.constant = (DeviceW / 2)
    self.excH.constant = (DeviceW / 2)
    self.excW.constant = (DeviceW / 2)
    self.leaderH.constant = (DeviceW / 2)
    self.leaderW.constant = (DeviceW / 2)
    self.helpH.constant = (DeviceW / 2)
    self.helpW.constant = (DeviceW / 2)
    
    }
    
    
    override func viewDidAppear(animated: Bool) {
    
    
    
    UIView.animateWithDuration(0.5, animations: { () -> Void in
    
    self.topView.center.x = self.topView.center.x + self.DeviceW + 10
    self.bottomView.center.x = self.bottomView.center.x + ((self.DeviceW * -1) - 10)
    
    self.topViewLEAD.constant = 0
    self.bottomViewTRAIL.constant = 0
    
    //    self.viewBTN4_height.constant = 80
    //    self.viewBTN4_width.constant = 80
    })
    
    
    
    
    }
    
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    scrollView.alpha = 1.0
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    
    /*
    if scrollView.contentOffset.x == 0 {
    scrollView.scrollRectToVisible(CGRect(x: 2304.0, y: 0.0, width: 768, height: 365), animated: false)
    }
    else if scrollView.contentOffset.x == 3072 {
    scrollView.scrollRectToVisible(CGRect(x: 768.0, y: 0.0, width: 768, height: 365), animated: false)
    }
    */
    scrollView.alpha = 1
    }
    
    
    @IBAction func workstyleBTN(sender: AnyObject) {
    //  CatTitle = "Hertz Work Style Notes"
    self.performSegueWithIdentifier("showMyStats", sender: self)
    
    }
    
    @IBAction func helpingBTN(sender: AnyObject) {
    //  CatTitle = "How did they help?"
    self.performSegueWithIdentifier("showMyStats", sender: self)
    
    }
    
    @IBAction func leaderBTN(sender: AnyObject) {
    
    //  CatTitle = "Tell us how they were a leader"
    
    self.performSegueWithIdentifier("showMyStats", sender: self)
    
    }
    
    @IBAction func excellenceBTN(sender: AnyObject) {
    // CatTitle = "Excellence Comments"
    self.performSegueWithIdentifier("showMyStats", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == "showMyStats" {
    
    
    if let destination = segue.destinationViewController as? MyStatsViewController {
    
    //  destination.CatTitle = self.CatTitle
    
    //destination.playerID = self.profileID
    print("Profile show segue")
    }
    }
    
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
    
    */
    
    
    func segmentValueChanged(_ sender: AnyObject?){
        
        if segmentControl.selectedIndex == 0 {
            self.actInd.isHidden = false
            self.actInd.startAnimating()
            //self.title = "My Games"
            self.SegmentValueString = "all"

           // self.RemoveGameArrayData()
            
            print("All People")
            //segmentControl.items = ["My Turns", "All", "Completed"]
           // self.TableView.reloadData()
             self.collectionView.reloadData()
            /*
            if pickerIsAllGames {
                pickerIsAllGames = false
                UIView.animateWithDuration(1.0, animations: {
                    self.segmentControl.center.y = self.segmentControl.center.y + 40
                    self.TableView.center.y = self.TableView.center.y + 40
                    self.segmentControlTOP.constant = 0
                })
                */
                
                pickerItem = false
                ISLOGGEDIN = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
                refreshAllPlayers()
                
                
          //  }
            
            DispatchQueue.main.async(execute: {
                self.actInd.isHidden = true
                self.actInd.stopAnimating()
                self.collectionView.reloadData()

            })
            
       // }
            //filterContentForSearchText("", scope: "All")
            
        } else if segmentControl.selectedIndex == 1 {
            
            self.actInd.isHidden = false
            self.actInd.startAnimating()
            
         //   self.RemoveGameArrayData()
            self.SegmentValueString = "followers"
            //self.title = "Followers"
            self.collectionView.reloadData()
            
            /*
            if !pickerIsAllGames {
                pickerIsAllGames = true
                UIView.animateWithDuration(1.0, animations: {
                    self.segmentControl.center.y = self.segmentControl.center.y - 40
                    self.TableView.center.y = self.TableView.center.y - 40
                    self.segmentControlTOP.constant = -40
                })
                
            }
            */
            
            print("all games")
            
            pickerItem = true
            ISLOGGEDIN = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
            refreshFollowerPlayers()
            
            
            DispatchQueue.main.async(execute: {
                self.actInd.isHidden = true
                self.actInd.stopAnimating()
                self.collectionView.reloadData()

            })
            
        } else {
            
            self.actInd.isHidden = false
            self.actInd.startAnimating()
            
            //self.RemoveGameArrayData()
            self.SegmentValueString = "following"
            //self.title = "Followers"
            self.collectionView.reloadData()

            /*
            if !pickerIsAllGames {
            pickerIsAllGames = true
            UIView.animateWithDuration(1.0, animations: {
            self.segmentControl.center.y = self.segmentControl.center.y - 40
            self.TableView.center.y = self.TableView.center.y - 40
            self.segmentControlTOP.constant = -40
            })
            
            }
            */
            
            print("Following")
            
            pickerItem = true
            ISLOGGEDIN = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
           refreshFollowingPlayers()
            
            DispatchQueue.main.async(execute: {
                self.actInd.isHidden = true
                self.actInd.stopAnimating()
                self.collectionView.reloadData()

            })
            
            
        }
    }
    
    func RemovePlayerArrayData() {
        
       self.GameUserInfoArray.removeAll()
        
    }
    
    func refreshAllPlayers() {
        self.RemovePlayerArrayData()
        
        DispatchQueue.main.async(execute: {

            if Reachability.isConnectedToNetwork() {

                if self.prefs.value(forKey: "USERNAME") != nil {

                    DispatchQueue.main.async(execute: {
                        
                        //  let URLData = GetUserGameDataPublic(self.username, userID: self.userID, gameSetting: "public")
                        
                        let URLData = GetUserGameFriends(self.username, userid: self.userID, type: "all")
                        //println(test)
                        //self.GameUserInfoArray = FilterGameUserData(URLData)

                        
                        //self.NumTurnsLoaded = self.NumTurnsLoaded + 50
                        
                        DispatchQueue.main.async(execute: {
                            self.GameUserInfoArray = self.FilterGameUserData(URLData)
                            self.noticeLBL.isHidden = true
                            self.viewHome.isHidden = true
                            //})
                            
                            
                            DispatchQueue.main.async(execute: {
                                
                               // self.AddGameArrayInfo(self.GameInfo)
                                
                                DispatchQueue.main.async(execute: {
                                    self.collectionView.reloadData()
                                    
                                    if (self.refreshControl!.isRefreshing) {
                                        self.refreshControl!.endRefreshing()
                                       // print("Users turn info =\(self.GameNameInfo)")
                                        
                                        self.collectionView.reloadData()
                                        self.actInd.stopAnimating()
                                        self.actInd.isHidden = true
                                        print("reloading TableView at the End")
                                      //  print("Users turn info =\(self.GameNameInfo)")
                                        
                                    }
                                })
                                
                            })
                            
                            
                            print("REFRESHING TABLE TEST 1 PULLED")
                            
                        })
                       
                        print("REFRESHING TABLE, REFRESH WAS PULLED")
                        // self.TableView.reloadData()
                        
                    })
                    
                } else {
                    
                    print("no games available")
                    
                }
                
                
            }
                
            else
                
            {
                
                SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Network Error", subTitle: "Please Confirm Your Network Settings", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            }
            
           
        })
    }
    
    func refreshFollowingPlayers() {
        self.RemovePlayerArrayData()
        
       // let ISLOGGEDIN = NSUserDefaults.standardUserDefaults().boolForKey("ISLOGGEDIN")
        
        DispatchQueue.main.async(execute: {
            
            if Reachability.isConnectedToNetwork() {
                
                if self.prefs.value(forKey: "USERNAME") != nil {
                    
                     if self.ISLOGGEDIN {
                    
                    DispatchQueue.main.async(execute: {
                        
                        //  let URLData = GetUserGameDataPublic(self.username, userID: self.userID, gameSetting: "public")
                        
                        let URLData = GetUserGameFriends(self.username, userid: self.userID, type: "following")
                        //println(test)
                        //self.GameUserInfoArray = FilterGameUserData(URLData)
                        
                        
                        //self.NumTurnsLoaded = self.NumTurnsLoaded + 50
                        
                        DispatchQueue.main.async(execute: {
                            self.GameUserInfoArray = self.FilterGameUserData(URLData)
                            
                            
                            if self.GameUserInfoArray.count == 0 {
                                if !self.ISLOGGEDIN {
                                   // self.noticeLBL.hidden = false
                                    self.viewHome.isHidden = false
                                    self.noticeLBL.text = "please login"
                                } else {
                                self.noticeLBL.isHidden = false
                                self.viewHome.isHidden = true
                                self.noticeLBL.text = "You're not following anyone"
                                }
                            } else {
                                self.noticeLBL.isHidden = true
                                self.viewHome.isHidden = true
                            }
                            //})
                            
                            
                            DispatchQueue.main.async(execute: {
                                self.collectionView.reloadData()
                                // self.AddGameArrayInfo(self.GameInfo)
                                
                                DispatchQueue.main.async(execute: {
                                    
                                    if (self.refreshControl!.isRefreshing) {
                                        self.refreshControl!.endRefreshing()
                                        // print("Users turn info =\(self.GameNameInfo)")
                                        
                                        self.collectionView.reloadData()
                                        self.actInd.stopAnimating()
                                        self.actInd.isHidden = true
                                        print("reloading TableView at the End")
                                        //  print("Users turn info =\(self.GameNameInfo)")
                                        
                                    }
                                })
                                
                            })
                            
                            
                            print("REFRESHING TABLE TEST 1 PULLED")
                            
                        })
                        
                        print("REFRESHING TABLE, REFRESH WAS PULLED")
                        // self.TableView.reloadData()
                        
                    })
                        
                     } else {
                        
                        self.noticeLBL.text = "please login"
                        self.viewHome.isHidden = false
                        
                        
                        
                        DispatchQueue.main.async(execute: {
                            
                            // self.AddGameArrayInfo(self.GameInfo)
                            
                            DispatchQueue.main.async(execute: {
                                self.collectionView.reloadData()
                                
                                if (self.refreshControl!.isRefreshing) {
                                    self.refreshControl!.endRefreshing()
                                    // print("Users turn info =\(self.GameNameInfo)")
                                    
                                    self.collectionView.reloadData()
                                    self.actInd.stopAnimating()
                                    self.actInd.isHidden = true
                                    print("reloading TableView at the End")
                                    //  print("Users turn info =\(self.GameNameInfo)")
                                    
                                }
                            })
                            
                        })
                        
                    }
                    
                } else {
                    
                    print("no games available")
                    
                }
                
                
            }
                
            else
                
            {
                
                SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Network Error", subTitle: "Please Confirm Your Network Settings", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            }
            
            
            /*
            dispatch_async(dispatch_get_main_queue(), {
            
            if (self.refreshControl!.refreshing) {
            self.refreshControl!.endRefreshing()
            
            self.TableView.reloadData()
            print("reloading TableView at the End")
            }
            */
            
            
            // Masquer l'icône de chargement dans la barre de status
            // UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            // })
        })
    }
    
    func refreshFollowerPlayers() {
        self.RemovePlayerArrayData()
        
        DispatchQueue.main.async(execute: {
            
            if Reachability.isConnectedToNetwork() {
                
                if self.prefs.value(forKey: "USERNAME") != nil {
                    
                     if self.ISLOGGEDIN {
                    
                    DispatchQueue.main.async(execute: {
                        
                        //  let URLData = GetUserGameDataPublic(self.username, userID: self.userID, gameSetting: "public")
                        
                        let URLData = GetUserGameFriends(self.username, userid: self.userID, type: "followers")
                        //println(test)
                        //self.GameUserInfoArray = FilterGameUserData(URLData)
                        
                        
                        //self.NumTurnsLoaded = self.NumTurnsLoaded + 50
                        
                        DispatchQueue.main.async(execute: {
                            self.GameUserInfoArray = self.FilterGameUserData(URLData)
                            
                            //})
                            
                            if self.GameUserInfoArray.count == 0 {
                                
                                if !self.ISLOGGEDIN {
                                  //  self.noticeLBL.hidden = false
                                    self.noticeLBL.text = "please login"
                                    self.viewHome.isHidden = false
                                } else {
                                    self.noticeLBL.isHidden = false
                                    self.viewHome.isHidden = true
                                    self.noticeLBL.text = "You don't have any followers"
                                }
                                
                            } else {
                                self.noticeLBL.isHidden = true
                                self.viewHome.isHidden = true
                            }
                            
                            
                            DispatchQueue.main.async(execute: {
                                
                                // self.AddGameArrayInfo(self.GameInfo)
                                
                                DispatchQueue.main.async(execute: {
                                    self.collectionView.reloadData()
                                    
                                    if (self.refreshControl!.isRefreshing) {
                                        self.refreshControl!.endRefreshing()
                                        // print("Users turn info =\(self.GameNameInfo)")
                                        
                                        self.collectionView.reloadData()
                                        self.actInd.stopAnimating()
                                        self.actInd.isHidden = true
                                        print("reloading TableView at the End")
                                        //  print("Users turn info =\(self.GameNameInfo)")
                                        
                                    }
                                })
                                
                            })
                            
                            
                            print("REFRESHING TABLE TEST 1 PULLED")
                            
                        })
                        
                        print("REFRESHING TABLE, REFRESH WAS PULLED")
                        // self.TableView.reloadData()
                        
                    })
                    
                     } else {
                        
                        self.noticeLBL.text = "please login"
                        self.viewHome.isHidden = false
                        
                        
                        
                        DispatchQueue.main.async(execute: {
                            
                            // self.AddGameArrayInfo(self.GameInfo)
                            
                            DispatchQueue.main.async(execute: {
                                self.collectionView.reloadData()
                                
                                if (self.refreshControl!.isRefreshing) {
                                    self.refreshControl!.endRefreshing()
                                    // print("Users turn info =\(self.GameNameInfo)")
                                    
                                    self.collectionView.reloadData()
                                    self.actInd.stopAnimating()
                                    self.actInd.isHidden = true
                                    print("reloading TableView at the End")
                                    //  print("Users turn info =\(self.GameNameInfo)")
                                    
                                }
                            })
                            
                        })
                        
                    }
                
                } else {
                    
                    print("no games available")
                    
                }
                
                
            }
                
            else
                
            {
                
                SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Network Error", subTitle: "Please Confirm Your Network Settings", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            }
            
            
            /*
            dispatch_async(dispatch_get_main_queue(), {
            
            if (self.refreshControl!.refreshing) {
            self.refreshControl!.endRefreshing()
            
            self.TableView.reloadData()
            print("reloading TableView at the End")
            }
            */
            
            
            // Masquer l'icône de chargement dans la barre de status
            // UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            // })
        })
    }
    
     func FollowerClicked(_ sender: UIButton!) {
        
        print("this is your follower")
        
    }
    
    
    func FollowClicked(_ sender: UIButton!) {
        
        
        
       
            /*
            switch self.SegmentValueString {
                
            case "followers":
                refreshFollowerPlayers()
                
            case "following":
                refreshFollowingPlayers()
                
            case "all":
                refreshAllPlayers()
                
                
            default:
                break
            }
        */
        
        
        if self.SegmentValueString != "followers" {
        
        
        
        
        let PersonSelected = sender.tag
        print("the person rowselected: \(sender.tag)")
        
        var isFiltered = Bool()
        
        let gametype : GameUserInfo
        
        if (self.resultSearchController.isActive && resultSearchController.searchBar.text != "") {
            gametype = FilteredGames[PersonSelected]
            isFiltered = true
        } else {
            gametype = GameUserInfoArray[PersonSelected]
            isFiltered = false
        }
        
        let NameSelected = gametype.username
        let IDSelected = gametype.userid
        
        print("Name Selected = \(NameSelected)")
        print("ID Selected = \(IDSelected)")
        
        let firstnameTemp = gametype.firstname
        let lastnameTemp = gametype.lastname
        let usernameTemp = gametype.username
        let useridTemp = gametype.userid
        let imageurlTemp = gametype.ImageURL
        let totalTemp = gametype.total
        let levelTemp = gametype.level
        let searchStringTemp = gametype.SearchString
        
        
        if gametype.isFollowing {
            
            
            
            let theAlert = SCLAlertView()
            
            
            theAlert.addButton("Yes") {
                
                FollowRequestAction(self.userID, username: self.username, followuserid: IDSelected as NSString, followuser: NameSelected as NSString, action: "delete")
                
                if isFiltered {
                    self.FilteredGames.remove(at: PersonSelected)
                    self.FilteredGames.insert(GameUserInfo(firstname: firstnameTemp, lastname: lastnameTemp, username: usernameTemp, userid: useridTemp, ImageURL: imageurlTemp, total: totalTemp, level: levelTemp, isFollowing: false, SearchString: searchStringTemp), at: PersonSelected)
                } else {
                   self.GameUserInfoArray.remove(at: PersonSelected)
                    self.GameUserInfoArray.insert(GameUserInfo(firstname: firstnameTemp, lastname: lastnameTemp, username: usernameTemp, userid: useridTemp, ImageURL: imageurlTemp, total: totalTemp, level: levelTemp, isFollowing: false, SearchString: searchStringTemp), at: PersonSelected)
                }
                
                DispatchQueue.main.async(execute: {
                
                    self.collectionView.reloadData()
                    
                })
                
                
                print("this item is \(gametype)")
            }
            
            //   theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Unhide All Games?", subTitle: "Are you sure you want to unhide all hidden games?")
            
            theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0), title: "Unfollow?", subTitle: "Do you want to unfollow \(NameSelected)?", duration: nil, completeText: "Cancel", style: .custom, colorStyle: 1, colorTextButton: 1)
            
            
            
            
            
        
        
        } else {
            
            
            let theAlert = SCLAlertView()
            
            
            theAlert.addButton("Yes") {
                
                 FollowRequestAction(self.userID, username: self.username, followuserid: IDSelected as NSString, followuser: NameSelected as NSString, action: "add")
                
                
                if isFiltered {
                    self.FilteredGames.remove(at: PersonSelected)
                    self.FilteredGames.insert(GameUserInfo(firstname: firstnameTemp, lastname: lastnameTemp, username: usernameTemp, userid: useridTemp, ImageURL: imageurlTemp, total: totalTemp, level: levelTemp, isFollowing: true, SearchString: searchStringTemp), at: PersonSelected)
                } else {
                    self.GameUserInfoArray.remove(at: PersonSelected)
                    self.GameUserInfoArray.insert(GameUserInfo(firstname: firstnameTemp, lastname: lastnameTemp, username: usernameTemp, userid: useridTemp, ImageURL: imageurlTemp, total: totalTemp, level: levelTemp, isFollowing: true, SearchString: searchStringTemp), at: PersonSelected)
                }
                
                DispatchQueue.main.async(execute: {
                    
                    self.collectionView.reloadData()
                    
                })
                
                
            }
            
            //   theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Unhide All Games?", subTitle: "Are you sure you want to unhide all hidden games?")
            
            theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Follow?", subTitle: "Do you want to follow \(NameSelected)?", duration: nil, completeText: "Cancel", style: .custom, colorStyle: 1, colorTextButton: 1)
            
            
            
       
        
        }
        

      }
            
        
    }
    
    
    @IBAction func login(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "login", sender: self)
    }
    
    
}

struct GameUserInfo {
    var firstname: String
    var lastname: String
    var username: String
    var userid: String
    var ImageURL: String
    //var theImage: UIImage
    var total: String
    var level: String
    var isFollowing: Bool
    var SearchString: String
    init(firstname: String, lastname: String, username: String, userid: String, ImageURL: String, total: String, level: String, isFollowing: Bool, SearchString: String) {
    self.firstname = firstname
    self.lastname = lastname
    self.username = username
    self.userid = userid
    self.ImageURL = ImageURL
    self.total = total
    self.level = level
    self.isFollowing = isFollowing
    self.SearchString = SearchString
    }
}
