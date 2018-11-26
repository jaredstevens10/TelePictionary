//
//  GamesTabViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 2/17/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

open class GamesTabViewController: UITabBarController, UITabBarControllerDelegate {
    
    var button: UIButton = UIButton()
    
    var isHighLighted:Bool = false

    override open func viewDidLoad() {
        
        
       
        super.viewDidLoad()
        
        self.selectedIndex = 2
        
        /*
        var tabBar: UITabBarController = self.window?.rootViewController as! UITabBarController
        tabBar.selectedIndex = 1

        self.delegate = self
        */
        //println("aaa")
      //  let middleImage:UIImage = UIImage(named:"sofa (1).png")!
      //  let highlightedMiddleImage:UIImage = UIImage(named:"MapButtonHighlighted")!
        
        let middleImage:UIImage = UIImage(named:"SofaWhite.png")!
        let highlightedMiddleImage:UIImage = UIImage(named:"SofaBlue.png")!
        
        
        UITabBar.appearance().tintColor = UIColor.white
        
        
        for item in self.tabBar.items! as [UITabBarItem]
        {
            if tabBarItem.title == "Gallery" {
                tabBarItem.title = ""
            }
            item.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "DK Cool Crayon", size: 8.0)!], for:UIControlState())
            
            if let image = item.image {
                item.image = image.withRenderingMode(.alwaysOriginal)
            }
            
            if tabBarItem.title == "Following" {
                //item.
            }


            
        }
        
        
        UITabBar.appearance().selectionIndicatorImage = UIImage().makeImageWithColorAndSize(UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0), size: CGSize(width: tabBar.frame.width/5, height: tabBar.frame.height))
        
        // Uses the original colors for your images, so they aren't not rendered as grey automatically.
        
        
        
        addCenterButtonWithImage(middleImage, highlightImage: highlightedMiddleImage)
        self.tabBar.barTintColor = UIColor(red: 71.0/255, green: 75.0/255, blue: 84.0/255, alpha: 1.0)
        //self.tabBarItem.ba  .ba = UIColor.whiteCOlor()
        changeTabToMiddleTab(button)

        
        
    }
    
    
    
    open func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if !viewController.isKind(of: GalleryViewController.self)
        {
            button.isUserInteractionEnabled = true
            button.isHighlighted = false
            button.isSelected = false
            isHighLighted = false
        }
        else {
            button.isUserInteractionEnabled = false
        }
    }
    
    open func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if  self.selectedViewController == viewController {
            print("Select one controller in tabbar twice")
            return false
        }
        
        return true
    }
    
    //MARK: MIDDLE TAB BAR HANDLER
    
    func addCenterButtonWithImage(_ buttonImage: UIImage, highlightImage:UIImage?)
    {
        
        let imageW:CGFloat = 60.0
        let imageH:CGFloat = 60.0
        let frame = CGRect(x: 0.0, y: 0.0, width: imageW, height: imageH)
       // let frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height)
        button = UIButton(frame: frame)
        button.setBackgroundImage(buttonImage, for: UIControlState())
        button.setBackgroundImage(highlightImage, for: UIControlState.highlighted)
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        
    //let heightDifference:CGFloat = buttonImage.size.height - self.tabBar.frame.size.height
        
        let heightDifference:CGFloat = imageW - self.tabBar.frame.size.height
        if heightDifference < 0 {
            button.center = self.tabBar.center;
        }
        else
        {
            var center:CGPoint = self.tabBar.center;
            center.y = center.y - heightDifference/2.0;
            button.center = center;
        }
        
        button.addTarget(self, action: #selector(GamesTabViewController.changeTabToMiddleTab(_:)), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(button)
    }
    
    
    func changeTabToMiddleTab(_ sender:UIButton)
    {
        
        let selectedIndex = Int(self.viewControllers!.count/2)
        print("Selected Index = \(selectedIndex)")
        self.selectedIndex = selectedIndex
        self.selectedViewController = (self.viewControllers as [AnyObject]?)?[selectedIndex] as? UIViewController
        DispatchQueue.main.async(execute: {
            
            if self.isHighLighted == false{
                sender.isHighlighted = true;
                self.isHighLighted = true
            }else{
                sender.isHighlighted = false;
                self.isHighLighted = false
            }
        });
        
        sender.isUserInteractionEnabled = false
        
    }
    
    
    
    open func insertEmptyTabItem(_ title: String, atIndex: Int) {
        let vc = UIViewController()
        vc.tabBarItem = UITabBarItem(title: title, image: nil, tag: 0)
        vc.tabBarItem.isEnabled = false
        
        self.viewControllers?.insert(vc, at: atIndex)
    }
    
    open func addRaisedButton(_ buttonImage: UIImage?, highlightImage: UIImage?) {
        if let buttonImage = buttonImage {
            let button = UIButton(type: UIButtonType.custom)
            button.autoresizingMask = [UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleBottomMargin, UIViewAutoresizing.flexibleTopMargin]
            
            button.frame = CGRect(x: 0.0, y: 0.0, width: buttonImage.size.width, height: buttonImage.size.height)
            button.setBackgroundImage(buttonImage, for: UIControlState())
            button.setBackgroundImage(highlightImage, for: UIControlState.highlighted)
            button.layer.cornerRadius = 30
            button.layer.borderWidth = 1
            button.clipsToBounds = true
            button.layer.masksToBounds = true
            
            let heightDifference = buttonImage.size.height - self.tabBar.frame.size.height
            
            if (heightDifference < 0) {
                button.center = self.tabBar.center
            }
            else {
                var center = self.tabBar.center
                center.y -= heightDifference / 2.0
                
                button.center = center
            }
            
            button.addTarget(self, action: #selector(GamesTabViewController.onRaisedButton(_:)), for: UIControlEvents.touchUpInside)
            self.view.addSubview(button)
        }
    }
    
    open func onRaisedButton(_ sender: UIButton!) {
        
    }
}

extension UIImage {
    func makeImageWithColorAndSize(_ color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
    
    /*


UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0)
            //UIColor.whiteColor()
        
        // Sets the default color of the background of the UITabBar
        
        UITabBar.appearance().barTintColor = UIColor.whiteColor()
        //UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0)
        
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

*/
