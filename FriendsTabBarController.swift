//
//  FriendsTabBarController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 12/15/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import UIKit

class FriendsTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = UIColor.white
        
      //  UITabBar.appearance().tintColor.
        
        // Sets the default color of the background of the UITabBar
        UITabBar.appearance().barTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
        
        for item in self.tabBar.items! as [UITabBarItem]
        {
            item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray], for:UIControl.State())
            
        }
        
      //  UITabBarItem.appearance().setTitleTextAttributes({NSAttributedString.Key.foregroundColor;: UIColor.darkGrayColor()}, forState: .Normal)
     /*
        
        UITabBarItem.appearance().setTitleTextAttributes({NSAttributedString.Key.foregroundColor: UIColor.whiteColor()}, forState: .Selected)
*/
       // UITabBar.appearance().selectedImageTintColor = UIColor.darkGrayColor()
        
       // UITabBar.appearance().setItems(<#T##items: [UITabBarItem]?##[UITabBarItem]?#>, animated: <#T##Bool#>)
        
        // Sets the background color of the selected UITabBarItem (using and plain colored UIImage with the width = 1/5 of the tabBar (if you have 5 items) and the height of the tabBar)
        
        //UITabBar.appearance().selectionIndicatorImage = UIImage().makeImageWithColorAndSize(UIColor.blueColor(), size: CGSizeMake(tabBar.frame.width/5, tabBar.frame.height))
  
        
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
