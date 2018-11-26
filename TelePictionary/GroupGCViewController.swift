//
//  GroupGCViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 9/14/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//


    import UIKit
    import CoreData
    
    protocol GroupGCViewControllerDelegate: class {
        func GroupGCViewControllerFinished(_ groupgcviewController: GroupGCViewController)
    }
    
    class GroupGCViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating {
        
        var nrdelegate: GroupGCViewControllerDelegate?
        
        
        var FriendStruct = [UserInfoData]()
        var FilteredFriends = [UserInfoData]()
        var resultSearchController = UISearchController()
        struct UserInfoData {
            var username: String
            var userid: String
        }
        
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
        
        var GCFriendID = NSString()
        var GroupName = NSString()
        var GCFriendName = NSString()
        var GCFriendContact = NSString()
        
        var FriendInfo = [NSArray]()
        var FriendData = [NSArray]()
        var repeatFriendNameArray = [NSString]()
        var repeatFriendIDArray = [NSString]()
        var repeatFriendContactArray = [NSString]()
        var FriendNameInfo = [NSString]()
        //var UnqFriendNameInfo = [NSString]()
        var FriendIDInfo = [NSString]()
        var RowSelected = Int()
        
        @IBOutlet weak var TableView: UITableView!
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            TableView.dataSource = self
            TableView.delegate = self
            self.TableView.separatorStyle = UITableViewCellSeparatorStyle.none        // Do any additional setup after loading the view.
            
            
            let prefs:UserDefaults = UserDefaults.standard
            
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString

            //println("Username value check: \(username)")
            
            
            if Reachability.isConnectedToNetwork() {
            let URLData = GetUserGameFriends(username, userid: userID, type: "mine")
            //println(test)
            FriendInfo = FilterGameFriends(URLData)
            
            FriendNameInfo = FriendInfo[0] as! [(NSString)]
            FriendIDInfo = FriendInfo[1] as! [(NSString)]
           // UnqFriendNameInfo = uniq(FriendNameInfo)
            //  UnqFriendNameInfo = uniq(FriendNameInfo)
           // UnqFriendNameID =
                
            } else {
                
            print("not connected to network")
            }
            
            self.resultSearchController = ({
                let controller = UISearchController(searchResultsController: nil)
                controller.searchResultsUpdater = self
                controller.dimsBackgroundDuringPresentation = false
                controller.searchBar.sizeToFit()
                controller.searchBar.scopeButtonTitles = ["All"]
                
                controller.searchBar.backgroundColor = UIColor.blue
                controller.searchBar.placeholder = "Search for a friend"
                
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
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if resultSearchController.isActive && resultSearchController.searchBar.text != "" {
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
        
        func filterContentForSearchText(_ searchText: String, scope: String = "All") {
            
            self.FilteredFriends = self.FriendStruct.filter({( infotype: UserInfoData) -> Bool in
                
                
                print("Searching for friends with text")
                
                let categoryMatch = (scope == "All") || (infotype.username == scope)
                let stringMatch = infotype.username.range(of: searchText)
                
                return infotype.username.lowercased().contains(searchText.lowercased())

                
            })
            
            
            print("Filtered friends text filter = \(FilteredFriends)")
            
            self.TableView.reloadData()
        }
        
        func updateSearchResults(for searchController: UISearchController) {
            let searchBar = searchController.searchBar
            let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
            
            //  FilteredGames.removeAll(keepCapacity: false)
            //  let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
            //  let resultArray = (self.GameNameInfo as NSArray).filteredArrayUsingPredicate(searchPredicate)
            
            //filterContentForSearchText(searchController.searchBar.text!, scope: scope)
               filterContentForSearchText(searchController.searchBar.text!)
            
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
            
           //selectedScope = "All"
            
            filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
            
            print("Filtered friends = \(FilteredFriends)")
            
            self.TableView.reloadData()
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           // let row = indexPath.row
           // let selectedResult = indexPath.item
            
            var infotype : UserInfoData
            
          if resultSearchController.isActive && resultSearchController.searchBar.text != "" {
                infotype = FilteredFriends[(indexPath as NSIndexPath).row]
            } else {
                infotype = FriendStruct[(indexPath as NSIndexPath).row]
            }
            

            
            // let row = indexPath.row
            // let selectedResult = indexPath.item
            //var GroupsRow = Groups[row]
            //println(GroupsRow)
            
            //TheGroup = (GroupsRow.valueForKey("groupname") as? String)!
            
            GCFriendName = infotype.username as String as NSString;
            GCFriendID = infotype.userid as String as NSString;
            
            //GroupSelected = true
            //self.performSegueWithIdentifier("goto_groupmembers", sender: self)
            
            
            // GroupData = GetGroupMembers(GroupsRow)
            // println("GroupData (from popover) = \(GroupData)")
            
            // self.dismissViewControllerAnimated(true, completion: nil)
            
            //self.performSegueWithIdentifier("group_selected", sender: self)
            
            
            
            self.dismiss(animated: true, completion: nil)
            
            self.nrdelegate?.GroupGCViewControllerFinished(self)
            
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
            
            if tableView == TableView {
                
                var infotype : UserInfoData
                
                if (self.resultSearchController.isActive && resultSearchController.searchBar.text != "") {
                    infotype = FilteredFriends[(indexPath as NSIndexPath).row]
                } else {
                    infotype = FriendStruct[(indexPath as NSIndexPath).row]
                }
                
                
                cell.titleLabel?.text = infotype.username as String
                
                
              //  cell.titleLabel?.text = self.FriendNameInfo[indexPath.row] as String
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
                        let group = Groups[FriendIndex]
                       
                        destination.GCFriendName = GCFriendName
                        destination.GCFriendID = GCFriendID
                        
                      //  destination.GCFriendName = self.FriendNameInfo[FriendIndex] as String
                      //  destination.GCFriendID = self.FriendIDInfo[FriendIndex] as String
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
            
          //  var traits = [NSString]()
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            
            var json = JSON(jsonData)
            
            //println("Json value: \(jsonData)")
            // println("Json valueJSON: \(json)")
            
            for result in json["Data"].arrayValue {
                
                if ( result["User"] != "NA") {
                    if ( result["User"] != "-") {
                        if ( result["User"] != " ") {
                            
                            let repeatFriendName = result["User"].stringValue
                            //  var repeatFriendContact = result["TurnNumber"].stringValue
                            let repeatFriendID = result["UserID"].stringValue
                            //result["UserID"].stringValue
                            
                             FriendStruct.append(UserInfoData(username: repeatFriendName, userid: repeatFriendID))
                            
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
        
        
        
        
}
