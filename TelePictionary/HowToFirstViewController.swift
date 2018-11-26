//
//  HowToFirstViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 12/23/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import UIKit
import CoreData

class HowToFirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating {

    //let HTtitles = ["New Game", "Taking A Turn","Friends", "My Games", "Completed Games", "Leaderboards", "My ToolBox","Who is Pixie?"]
    var isFun = NSString()
    
  //  let IMGNames = ["newGame.png","AboutUsIcon.png","myFriendsIcon.png","myGamesIcon.png","completedGamesIcon.png","TopPlaces40.png","toolBoxIcon.png","CharacterNormal.png"]
    
 //   let descriptions = ["new game start time turn content add players","take turn","friends best groups","games complete view poke comment","complete share games like fail","leader most likes fail games","purchase buy tools add no ads","pixie points tokens character settings"]
    
    
    var HTtitles = [String]()
    //["New Game", "Taking A Turn","Friends", "My Games", "Completed Games", "Leaderboards"]
    
    var IMGNames = [String]()
    //["newGame.png","AboutUsIcon.png","myFriendsIcon.png","myGamesIcon.png","completedGamesIcon.png","TopPlaces40.png"]
    
    var descriptions = [String]()
    
    //["new game start time turn content add players","take turn","friends best groups","games complete view poke comment","complete share games like fail","leader most likes fail games"]
    
    var theTopics = [HowGroup]()
    var FilteredTopics = [HowGroup]()
    
           var resultSearchController = UISearchController()
 
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var theTopic = String()
    
    let prefs:UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var TableView: UITableView!
    // @IBOutlet weak var TableView: UITableView!
    
    /*
    override func awakeFromNib() {
    super.awakeFromNib()
    
    }
    */
    
    func AddTitlesToGroup() {
        
        theTopics.removeAll()
        
        var theIndex = 0
        
        for theTitle in HTtitles {
            
            print("adding items to topics")
            theTopics.append(HowGroup(title: theTitle, imageName: IMGNames[theIndex], topics: descriptions[theIndex]))
            theIndex += 1
            
            
        }
        
        print("the Topics are \(theTopics)")
        
        DispatchQueue.main.async(execute: {
            
            self.TableView.reloadData()
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isFun = prefs.value(forKey: "ISFUN") as! NSString
        
        
        if isFun.isEqual(to: "no") {
            
            
            HTtitles = ["Taking A Turn","Friends", "Completed Games", "Leaderboards"]
            
            IMGNames = ["AboutUsIcon.png","myFriendsIcon.png","completedGamesIcon.png","TopPlaces40.png"]
            
            descriptions = ["take turn","friends best groups","complete share games like fail","leader most likes fail games"]
            
        } else {
            
            HTtitles = ["New Game", "Taking A Turn","Friends", "My Games", "Completed Games", "Leaderboards"]
            
      IMGNames = ["newGame.png","AboutUsIcon.png","myFriendsIcon.png","myGamesIcon.png","completedGamesIcon.png","TopPlaces40.png"]
            
            descriptions = ["new game start time turn content add players","take turn","friends best groups","games complete view poke comment","complete share games like fail","leader most likes fail games"]

            
        }
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            //   controller.delegate = self
            controller.dimsBackgroundDuringPresentation = false
            // controller.searchBar.showsScopeBar = true
            //  controller.searchBar.
            controller.searchBar.sizeToFit()
            //controller.searchBar.scopeButtonTitles = ["All", "Complete", "In Process"]
            controller.definesPresentationContext = true
            controller.searchBar.backgroundColor = UIColor.blue
            controller.searchBar.placeholder = "Search for a Topic"
            controller.searchBar.tintColor = UIColor.darkGray
            controller.searchBar.layer.backgroundColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0).cgColor
            // controller.s
            
            self.TableView.tableHeaderView = controller.searchBar
            // self.view.addSubview(controller.searchBar)
            
            return controller
        })()
        
        if #available(iOS 9.0, *) {
            self.resultSearchController.loadViewIfNeeded()
        } else {
            // Fallback on earlier versions
        }
        
        print("Loading HOW TO")
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
        
        self.title = "How To?"
        
        if let font = UIFont(name: "DK Cool Crayon", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.white]
        }
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        self.TableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.TableView.backgroundColor = UIColor.clear
        
        self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        TableView.dataSource = self
        TableView.delegate = self
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        // self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.AddTitlesToGroup()
        
        
        
        
    }
    
    //func filterContentForSearchText(searchText: String, scope: String = "All") {
    func filterContentForSearchText(_ searchText: String) {
      //  print("Search Scope = \(scope)")
        // self.TableViewTOP.constant = 50
        self.FilteredTopics = self.theTopics.filter({( howtype: HowGroup) -> Bool in
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
            let stringMatch = howtype.topics.lowercased().range(of: searchText.lowercased())

            return (stringMatch != nil ? true : false)
 
            
        })
        
        
        //   print("Filtered Games = \(FilteredGames)")
        
        self.TableView.reloadData()
    }
    
    /*
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        FilteredTopics.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (theTopics[topics] as NSArray).filteredArrayUsingPredicate(searchPredicate)
        FilteredTopics = array as! [String]
        
        self.TableView.reloadData()
    }
    */
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
       // let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        
        // print("Search Scope1 = \(scope)")
        
        //  FilteredGames.removeAll(keepCapacity: false)
        //  let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        //  let resultArray = (self.GameNameInfo as NSArray).filteredArrayUsingPredicate(searchPredicate)
        
       // filterContentForSearchText(searchController.searchBar.text!, scope: scope)
         filterContentForSearchText(searchController.searchBar.text!)
        //filterContentForSearchText(searchController.searchBar.text!)
        
        self.TableView.reloadData()
    }
    
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancel Button Clicked")
    }
    
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        //   print("Scope index changed: \(selectedScope)")
        
        //   print("Scope index changed: \(searchBar.selectedScopeButtonIndex)")
        
        
        //filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
         filterContentForSearchText(searchBar.text!)
        print("Filtered Games, from selected scope index change = \(FilteredTopics)")
        
        self.TableView.reloadData()
    }

    // MARK: - Table view data source
    
   /*
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
*/
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if resultSearchController.isActive && resultSearchController.searchBar.text != "" {
            
            //    if (self.resultSearchController.active) {
            return self.FilteredTopics.count
        } else {
            return self.theTopics.count;
            //            return self.GameNameInfo.count;
            //return self.GameSearchInfo.count;
            
        }
        
        // return self.GameNameInfo.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var howtype : HowGroup
        
        if (self.resultSearchController.isActive && resultSearchController.searchBar.text != "") {
            howtype = FilteredTopics[(indexPath as NSIndexPath).row]
        } else {
            howtype = theTopics[(indexPath as NSIndexPath).row]
        }

        
        theTopic = howtype.title
        self.performSegue(withIdentifier: "ShowHowTo", sender: self)
    }
    
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
    
    var howtype : HowGroup
    
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.backgroundColor = UIColor.clear
    
    if (self.resultSearchController.isActive && resultSearchController.searchBar.text != "") {
        howtype = FilteredTopics[(indexPath as NSIndexPath).row]
    } else {
        howtype = theTopics[(indexPath as NSIndexPath).row]
    }
    
    
      //  cell.titleLabel?.text = HTtitles[indexPath.row]
        cell.titleLabel?.text = howtype.title
        cell.heartIMG?.image = UIImage(named: howtype.imageName)
        // Configure the cell...
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowHowTo" {
            
            
            if let destination = segue.destination as? HowToSecondViewController {
                
                destination.theTopic = self.theTopic
                // destination.playerID = self.profileID
                
            }
        }
        
        
    }
    
    struct HowGroup {
        let title : String
        let imageName : String
        let topics : String
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

}
