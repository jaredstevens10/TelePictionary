//
//  RepeatFriendsViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 8/23/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import CoreData

protocol RepeatFriendsViewControllerDelegate: class {
    func RepeatFriendsViewControllerFinished(_ repeatfriendsviewController: RepeatFriendsViewController)
}

class RepeatFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate, UISearchResultsUpdating {
    
    var ServerURL = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/"
    var SegmentValueString = NSString()
    @IBOutlet weak var segment: ADVSegmentedControl!
    
    var FriendStruct = [UserInfoData]()
    var FilteredFriends = [UserInfoData]()
    
    @IBOutlet var ActInd: UIActivityIndicatorView!
    var rdelegate: RepeatFriendsViewControllerDelegate?
    
    var resultSearchController = UISearchController()
    struct UserInfoData {
        var username: String
        var userid: String
        var imageURL: String
    }
    
    //var repeatTest = [UserInfoData]()
    var username = NSString()
    var userID = NSString()
    var GroupData = [NSArray]()
    
    var theGroups = [MyFriends]()
    
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
    var SelectedGCFriend = Bool()
    
    var numGroups = Int()
    
    var GroupName = NSString()
    var GCFriendName = NSString()
    var GCFriendContact = NSString()
    
    var GCFriendID = NSString()
    
    var FriendInfo = [NSArray]()
    var FriendData = [NSArray]()
    var repeatFriendNameArray = [NSString]()
    var repeatFriendIDArray = [NSString]()
    var repeatFriendContactArray = [NSString]()
    var FriendNameInfo = [NSString]()
    var FriendIDInfo = [NSString]()
   // var UnqFriendNameInfo = [NSString]()
    var RowSelected = Int()
    
    @IBOutlet weak var TableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SegmentValueString = "mine"
        self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        TableView.dataSource = self
        TableView.delegate = self
        self.TableView.separatorStyle = UITableViewCell.SeparatorStyle.none        // Do any additional setup after loading the view.
        
        GCFriendID = "PUSHID"
        let prefs:UserDefaults = UserDefaults.standard
        
        username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
        userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
        
        segment.items = ["My Friends", "All Players"]
        segment.font = UIFont(name: "DK Cool Crayon", size: 12)
       // segment.borderColor = UIColor(white: 1.0, alpha: 0.3)
        segment.borderColor = UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0)
        segment.selectedIndex = 0
        segment.backgroundColor = UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0)
        segment.thumbColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
        segment.selectedLabelColor = UIColor.white
        segment.addTarget(self, action: #selector(RepeatFriendsViewController.segmentValueChanged(_:)), for: .valueChanged)
        
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            //controller.searchBar.scopeButtonTitles = ["All", "Complete", "In Process"]
            
            controller.searchBar.backgroundColor = UIColor.blue
            controller.searchBar.placeholder = "Search for a Friend"
            
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
        //println("Username value check: \(username)")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
        ActInd.startAnimating()
        //ActInd.startAnimating()
        
        if Reachability.isConnectedToNetwork() {
        
        
            let URLData = GetUserGameFriends(username, userid: userID, type: self.SegmentValueString)
        //println(test)
        FriendInfo = FilterGameFriends(URLData)
        
        FriendNameInfo = FriendInfo[0] as! [(NSString)]
        FriendIDInfo = FriendInfo[1] as! [(NSString)]
            
//        UnqFriendNameInfo = uniq(FriendNameInfo)
       // UnqFriendNameInfo = FriendNameInfo
            
        self.TableView.reloadData()
            
        } else {
            
            print("not connected to network")
        }
        
        ActInd.stopAnimating()
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
     //   let row = indexPath.row
     //   let selectedResult = indexPath.item
        
        
        // let row = indexPath.row
        // let selectedResult = indexPath.item
        //var GroupsRow = Groups[row]
        //println(GroupsRow)
        
        //TheGroup = (GroupsRow.valueForKey("groupname") as? String)!
        
        var infotype : UserInfoData
        
        if resultSearchController.isActive && resultSearchController.searchBar.text != "" {
            infotype = FilteredFriends[(indexPath as NSIndexPath).row]
        } else {
            infotype = FriendStruct[(indexPath as NSIndexPath).row]
        }
        
        
        GCFriendName = infotype.username as String as NSString
        GCFriendID = infotype.userid as String as NSString
        
       //GroupSelected = true
        //self.performSegueWithIdentifier("goto_groupmembers", sender: self)
        
        
        // GroupData = GetGroupMembers(GroupsRow)
        // println("GroupData (from popover) = \(GroupData)")
        
        // self.dismissViewControllerAnimated(true, completion: nil)
        
        //self.performSegueWithIdentifier("group_selected", sender: self)
        
        
        
        self.dismiss(animated: true, completion: nil)
        
        self.rdelegate?.RepeatFriendsViewControllerFinished(self)
        
        
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
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
        
        if tableView == TableView {
            
            
            
            var infotype : UserInfoData
            
       if resultSearchController.isActive && resultSearchController.searchBar.text != "" {
                infotype = FilteredFriends[(indexPath as NSIndexPath).row]
            } else {
                infotype = FriendStruct[(indexPath as NSIndexPath).row]
            }
            

            cell.titleLabel?.text = infotype.username as String
            cell.Turn1Image?.isHidden = true
            /*
            if !self.fileExists(NSURL(string: "\(infotype.imageURL).jpg)")!) {
                print("file DOES NOT exists - \(infotype.imageURL).jpg)")
                cell.Turn1Image?.image = UIImage(named: "noImage.png")
                
            } else {
            
            let URL = NSURL(string: "\(infotype.imageURL).jpg)")!
            cell.Turn1Image?.hnk_setImageFromURL(URL)
            cell.Turn1Image?.contentMode = UIView.ContentMode.ScaleAspectFit
                
            }
            
            cell.Turn1Image?.layer.cornerRadius = 15
            cell.Turn1Image?.layer.borderWidth = 1
            cell.Turn1Image?.layer.borderColor = UIColor.whiteColor().CGColor
            cell.Turn1Image?.layer.masksToBounds = true
            cell.Turn1Image?.contentMode = UIView.ContentMode.ScaleAspectFit
            cell.Turn1Image?.clipsToBounds = true
            
            */
            //  cell.subtitleLabel?.text = self.EmailTable[indexPath.row] as String
            
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
        } else if segue.identifier == "friend_selected" {
            
            if let destination = segue.destination as? ConfirmPlayersViewController {
                
                if let FriendIndex = (TableView.indexPathForSelectedRow as NSIndexPath?)?.row {
                    _ = Groups[FriendIndex]
                    destination.GCFriendName = GCFriendName
                    destination.GCFriendID = GCFriendID
                   // destination.SelectedGroup = true
                    
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
    
    
    func FilterGameFriends(_ urlData: Data) -> ([NSArray]) {
        
       // var traits = [NSString]()
        FriendStruct.removeAll()
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
                 let idtemp = result["MemberID}.stringValue"]
                 let profileURL = "\(ServerURL)player\(idtemp)"
              //  var repeatFriendContact = result["TurnNumber"].stringValue
 // let tempUserData = UserInfoData.init(username: repeatFriendName, userid: repeatFriendNameID)
                        FriendStruct.append(UserInfoData(username: repeatFriendName, userid: repeatFriendID, imageURL: profileURL))
                        
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
    
    func RemoveFriendArrayData () {
        
        self.FriendInfo.removeAll()
        self.FriendNameInfo.removeAll()
        self.FriendIDInfo.removeAll()
        self.repeatFriendNameArray.removeAll()
        self.repeatFriendIDArray.removeAll()
        self.repeatFriendContactArray.removeAll()
    }
    
    func RefreshMyFriends() {
        
        if Reachability.isConnectedToNetwork() {
            
            
            let URLData = GetUserGameFriends(username, userid: userID, type: self.SegmentValueString)
            //println(test)
            FriendInfo = FilterGameFriends(URLData)
            
            FriendNameInfo = FriendInfo[0] as! [(NSString)]
            FriendIDInfo = FriendInfo[1] as! [(NSString)]
            
            //        UnqFriendNameInfo = uniq(FriendNameInfo)
            // UnqFriendNameInfo = FriendNameInfo
            
            self.TableView.reloadData()
            
        } else {
            
            print("not connected to network")
        }
        
    }
    
    func RefreshAllPlayers() {
        
        
        if Reachability.isConnectedToNetwork() {
            
            
            let URLData = GetUserGameFriends(username, userid: userID, type: self.SegmentValueString)
            //println(test)
            FriendInfo = FilterGameFriends(URLData)
            
            FriendNameInfo = FriendInfo[0] as! [(NSString)]
            FriendIDInfo = FriendInfo[1] as! [(NSString)]
            
            //        UnqFriendNameInfo = uniq(FriendNameInfo)
            // UnqFriendNameInfo = FriendNameInfo
            
            self.TableView.reloadData()
            
        } else {
            
            print("not connected to network")
        }
        
        
    }
    
    @objc func segmentValueChanged(_ sender: AnyObject?){
        
        if segment.selectedIndex == 0 {
            
            self.ActInd.isHidden = false
            self.ActInd.startAnimating()
            self.SegmentValueString = "mine"
            
            self.RemoveFriendArrayData()
            
            print("Segment = \(self.SegmentValueString)")
            
            
            
              DispatchQueue.main.async(execute: {
           self.RefreshMyFriends()
            // })
            //salesValue.text = "$23,399"
            
            DispatchQueue.main.async(execute: {
                self.ActInd.isHidden = true
                self.ActInd.stopAnimating()
            })
                
            })
            
            //filterContentForSearchText("", scope: "All")
            
        } else {
            
            
        //}else if segment.selectedIndex == 1{
            
            self.ActInd.isHidden = false
            self.ActInd.startAnimating()
            self.SegmentValueString = "all"
            self.RemoveFriendArrayData()
            print("Segment = \(self.SegmentValueString)")
            
            
            
            /*
            //   dispatch_async(dispatch_get_main_queue(), {
            if !self.pickerItem {
                self.refreshMyGames()
            } else {
                self.refreshPublicGames()
            }
            
            */
            //  })
            
            
            DispatchQueue.main.async(execute: {
                self.RefreshAllPlayers()
                
            DispatchQueue.main.async(execute: {
                self.ActInd.isHidden = true
                self.ActInd.stopAnimating()
            })
                
            })
            //filterContentForSearchText("", scope: "Complete")
            //salesValue.text = "$81,295"
        }
        
        
        /*
        else {
            
            self.ActInd.hidden = false
            self.ActInd.startAnimating()
            
            self.SegmentValueString = "Completed"
            self.RemoveFriendArrayData()
            print("Segment = \(self.SegmentValueString)")
            
            //actInd.hidden = false
            
            
            /*
            //   dispatch_async(dispatch_get_main_queue(), {
            if !self.pickerItem {
                self.refreshMyGames()
            } else {
                self.refreshPublicGames()
            }
            */
            
            dispatch_async(dispatch_get_main_queue(), {
                self.ActInd.hidden = true
                self.ActInd.stopAnimating()
            })
            //   })
            // filterContentForSearchText("", scope: "In Process")
            //salesValue.text = "$199,392"
        }
        
        */
    }
    
    func fileExists(_ url : URL!) -> Bool {
        
        let req = NSMutableURLRequest(url: url)
        req.httpMethod = "HEAD"
        req.timeoutInterval = 1.0 // Adjust to your needs
        
        var response : URLResponse?
        var responseError: NSError?
        
        do {
            try NSURLConnection.sendSynchronousRequest(req as URLRequest, returning:&response)
        } catch let error as NSError {
            responseError = error
            // urlData = nil
        }
        
        //NSURLConnection.sendSynchronousRequest(req, returningResponse: &response, error: nil)
        
        return ((response as? HTTPURLResponse)?.statusCode ?? -1) == 200
    }
    
    

}
