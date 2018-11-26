//
//  ContentRatingsViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 11/30/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import UIKit

class ContentRatingsViewController: UIViewController {
    
    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var image3: UIImageView!

    @IBOutlet weak var LBL1: UILabel!
    
    
    @IBOutlet weak var LBL2: UILabel!
    
    
    @IBOutlet weak var LBL3: UILabel!
    
    @IBOutlet weak var titleLBL: UILabel!
    
    
    @IBOutlet weak var LBLnotice: UILabel!
    
    
    
    var isFun = NSString()
    
    let prefs:UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        isFun = prefs.value(forKey: "ISFUN") as! NSString
        
        if isFun.isEqual(to: "no") {
            
            
            image1.image = UIImage(named: "ContentEasy.png")
            image2.image = UIImage(named: "ContentMedium.png")
            image3.image = UIImage(named: "ContentHard.png")
            LBL1.text = "Easy Game Content, turns easy enough for all ages"
            LBL2.text = "Medium Game Content, turns and hints with a medium difficulty level"
            LBL3.text = "Hard Game Content, turns and hints designed for more advanced players"
            titleLBL.text = "Content Difficulty Guide"
            LBLnotice.text = ""
            
        } else {
            
            image1.image = UIImage(named: "ContentE.png")
            image2.image = UIImage(named: "ContentT.png")
            image3.image = UIImage(named: "contentM.png")
            LBL1.text = "Game Content appropriate for all ages, including young children"
            LBL2.text = "Game Content appropriate for teenagers and adults.  May contain suggestive themes, but should not contain Mature Content"
            LBL3.text = "Game Content only appropriate for Adults.  May containt Adult themes, language, and other Adult content."
            titleLBL.text = "Content Rating Guide"
            LBLnotice.text = "Help make the players you add to your games aware of other players preferences by selecting an appropriate Game Rating"
            
        }

        // Do any additional setup after loading the view.
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

}
