//
//  LeadersTabBarController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 12/15/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import UIKit

class LeadersTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        UITabBar.appearance().tintColor = UIColor.white
        
        // Sets the default color of the background of the UITabBar
        UITabBar.appearance().barTintColor = UIColor.black
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
