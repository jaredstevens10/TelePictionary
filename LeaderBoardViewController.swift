//
//  LeaderBoardViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 9/14/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit

class LeaderBoardViewController: UIViewController {
    //}, EasyGameCenterDelegate {
    
    
    let leaderboardID = "com.ClavenSolutions.TelePictionary.Likes"
    
    let gamesleaderboardID = "com.ClavenSolutions.TelePictionary.Likes"
    
    
    let achievementID = "com.ClavenSolutions.TelePictionary.HowToComplated"
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
        var username = NSString()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Accomplishments"
        
        if let font = UIFont(name: "ChalkboardSE-Regular", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        
        
        let prefs:UserDefaults = UserDefaults.standard
        
        username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
        
        
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)

        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        

      //  EasyGameCenter.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func reportScore(_ sender: AnyObject) {
        
   //     EasyGameCenter.reportScoreLeaderboard(leaderboardIdentifier: gamesleaderboardID, score: 1)
    }
    
    @IBAction func hostedMatch(_ sender: AnyObject) {
        
      
        
    }
    
  
    
    @IBAction func ShowGameCenterLeaderBoards(_ sender: AnyObject) {
        
      //  EasyGameCenter.showGameCenterLeaderboard(leaderboardIdentifier: leaderboardID) { (isShow) -> Void in
            print("showing leaderboards")
        }
        
    }


/*
    
    @IBAction func ShowGameCenterChallenges(sender: AnyObject) {
        
  //      EasyGameCenter.showGameCenterAchievements { (result)  -> Void in
            
            if result {
                print("showing Challenges")
            }
        }
        
    }
    
    
    @IBAction func findturnPlayers(sender: AnyObject) {
       // EasyGameCenter.findTurnMatchWithMinPlayers(2, maxPlayers: 2)
        
        print("finding Turn Players")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
*/

//}
