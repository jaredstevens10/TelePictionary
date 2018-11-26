//
//  LeadersViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 9/13/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import GameKit

class LeadersViewController: UIViewController {
    
    
    
    let leaderboardID = "com.ClavenSolutions.TelePictionary.Likes"
    
    let gamesleaderboardID = "com.ClavenSolutions.TelePictionary.Likes"
    
    
    let achievementID = "com.ClavenSolutions.TelePictionary.HowToComplated"

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    
    var username = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Leaderboard"
        
        if let font = UIFont(name: "ChalkboardSE-Regular", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.white]
        }
        
        
        
        let prefs:UserDefaults = UserDefaults.standard
        
        username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
        
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)

        
        /*
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
      */
//EasyGameCenter.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //EasyGameCenter.delegate = self
        
    }
    
    /*
    
    @IBAction func GetLeaderBoard(sender: AnyObject) {
        /*
        EasyGameCenter.showGameCenterLeaderboard(leaderboardIdentifier: leaderboardID, completion: { (result) -> Void in
            if result {
                print("\n[leaderboardsActions] You openGame Center Achievements")
            }
        })
        
        */
        EasyGameCenter.getGKLeaderboard {
            (resultArrayGKLeaderboard) -> Void in
            if let resultArrayGKLeaderboardIsOK = resultArrayGKLeaderboard {
                for oneGKLeaderboard in resultArrayGKLeaderboardIsOK {
                    println("\n[LeaderboardActions Get Leaderboards (getGKLeaderboard)\n")
                    println("ID : \(oneGKLeaderboard.identifier)")
                    println("Loading ? : \(oneGKLeaderboard.loading)")
                }
            }
        }
        
    }

    @IBAction func reportScore(sender: AnyObject) {
        
        EasyGameCenter.reportScoreLeaderboard(leaderboardIdentifier: gamesleaderboardID, score: 1)
    }

    
    @IBAction func ShowGameCenterLeaderBoards(sender: AnyObject) {
        
        EasyGameCenter.showGameCenterLeaderboard(leaderboardIdentifier: leaderboardID) { (isShow) -> Void in
            println("showing leaderboards")
        }
        
    }
    
    
    @IBAction func ShowGameCenterChallenges(sender: AnyObject) {
        
        EasyGameCenter.showGameCenterChallenges { (result)  -> Void in
            
            if result {
            println("showing Challenges")
            }
        }
        
    }
*/
    
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

}
