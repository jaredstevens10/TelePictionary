//
//  HowToSecondViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 12/23/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import UIKit
import CoreData

class HowToSecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var theTopic = String()
    var HTtopic  = String()
    
    var HTtitles = [String]()
    var IMGNames = [String]()
    
    
    
    var NewGameTitles = ["First Step", "Start with Audio Clip", "Turn Times?", "Content Rating?", "Adding Players", "Custom Groups"]
    var NewGameImages = ["newGame.png","musicIcon.png","TopPlaces40.png","AboutUsIcon.png","addPlayer.png","addGroup.png"]
    
    var MyGamesTitles = ["Edit My Game","Taking A Turn", "Delete A Game", "View Game Players", "Adding A Comment", "Poke Another Player", "Public Games"]
    var MyGamesImages = ["myGamesIcon.png","myGamesIcon.png","deleteGameIcon.png","FriendsIcon2.png","commentsIcon White.png","pokeIconWhite.png","myGamesIcon.png"]
    
    var MyFriendsTitles = ["Invite My Friends", "Add A Friend", "My Best Friends", "Creating A Group"]
    var MyFriendsImages = ["myFriendsIcon.png","friendsIconWhite.png","BestFriendsIconWhite.png","addGroup.png"]
    
    var MyToolsTitles = ["My Toolbox"]
    var MyToolsImages = ["toolBoxIcon.png"]
    
    var LeadersTitles = ["Most Likes", "Most Fails", "Most Games Played"]
    var LeadersImages = ["heartIconwhite.png","failedIconWhite.png","trophyIcon.png"]
    
    var CompletedGamesTitles = ["Viewing A Game","Liking A Turn", "Failing A Turn", "Sharing", "Content Settings"]
    var CompletedGamesImages = ["completedGamesIcon.png","likeButton.png","failedIconWhite.png","uploadButton.png","toolBoxIcon.png"]
    
    var PixieTitles = ["My Pixie"]
    var PixieImages = ["CharacterNormal.png"]
    
    var TurnTitles = ["Draw A Picture","Insert Quote","Add Image","Add Audio"]
//      var TurnTitles = ["Draw A Picture","Insert Quote","Add Image","Add Audio","Web Audio"]
   // var TurnImages = ["Photo Album Image white.png","AboutUsIcon.png","Photo Album Image white.png","musicIcon.png","musicIcon.png"]
    
    var TurnImages = ["Photo Album Image white.png","AboutUsIcon.png","Photo Album Image white.png","musicIcon.png"]

    
    @IBOutlet weak var TableView: UITableView!
    // @IBOutlet weak var TableView: UITableView!
    
    /*
    override func awakeFromNib() {
    super.awakeFromNib()
    
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loading HOW TO")
        
        if let font = UIFont(name: "DK Cool Crayon", size: 20.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        
        self.TableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.TableView.backgroundColor = UIColor.clear
        
        self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        TableView.dataSource = self
        TableView.delegate = self
        
        switch theTopic {
        case "New Game":
            HTtitles = NewGameTitles
            IMGNames = NewGameImages
        case "My Games":
            HTtitles = MyGamesTitles
            IMGNames = MyGamesImages
        case "Leaderboards":
            HTtitles = LeadersTitles
            IMGNames = LeadersImages
            
        case "My ToolBox":
            HTtitles = MyToolsTitles
            IMGNames = MyToolsImages
            
        case "Friends":
            HTtitles = MyFriendsTitles
            IMGNames = MyFriendsImages
            
        case "Completed Games":
            HTtitles = CompletedGamesTitles
            IMGNames = CompletedGamesImages
            
        case "Who is Pixie?":
            HTtitles = PixieTitles
            IMGNames = PixieImages
        
        case "Taking A Turn":
            HTtitles = TurnTitles
            IMGNames = TurnImages
            
        default:
            print("error")
        }
        self.TableView.reloadData()

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
    
    // MARK: - Table view data source
    
    /*
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 0
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return HTtitles.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        HTtopic = HTtitles[(indexPath as NSIndexPath).row]
        self.performSegue(withIdentifier: "ShowHowTo", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.backgroundColor = UIColor.clear
        
        cell.titleLabel?.text = HTtitles[(indexPath as NSIndexPath).row]
        
        cell.heartIMG?.image = UIImage(named: IMGNames[(indexPath as NSIndexPath).row])
        // Configure the cell...
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowHowTo" {
            
            
            if let destination = segue.destination as? HowToViewController {
                // destination.GameName = GameNameInfo[GameIndex]
                destination.HTtopic = self.HTtopic as NSString
                //println("Game Turn 1: \(TurnNumberInfo[GameIndex])")
                
            }
        }
        
        
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
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
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
