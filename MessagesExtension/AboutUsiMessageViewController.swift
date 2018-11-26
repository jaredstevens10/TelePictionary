//
//  AboutUsiMessageViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 11/9/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class AboutUsiMessageViewController: UIViewController {

    //
    //  AboutUsViewController.swift
    //  TelePictionary
    //
    //  Created by Jared Stevens on 10/27/15.
    //  Copyright © 2015 Claven Solutions. All rights reserved.
    //

        var AppVersion = String()
    
        @IBOutlet var rateBTN: UIButton!
        
        @IBOutlet var tosBTN: UIButton!
        
        @IBOutlet var rateView: UIView!
        
        @IBOutlet var privacyBTN: UIButton!
        
        @IBOutlet weak var CreditsView: UIView!
        @IBOutlet var TOSView: UIView!
        @IBOutlet var privacyView: UIView!
        
       // @IBOutlet weak var menuButton: UIBarButtonItem!
        let prefs = UserDefaults.standard
        
        @IBOutlet weak var versionLBL: UILabel!
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            
            
              print("AppVersion: \(prefs.value(forKey: "AppVersion"))")
            
            // rateBTN.layer.borderWidth = 1
            //    rateBTN.layer.borderColor = UIColor.whiteColor().CGColor
            //   rateBTN.layer.cornerRadius = 10
            
            //  tosBTN.layer.borderWidth = 1
            //  tosBTN.layer.borderColor = UIColor.whiteColor().CGColor
            //  tosBTN.layer.cornerRadius = 10
            
            //  privacyBTN.layer.borderWidth = 1
            //  privacyBTN.layer.borderColor = UIColor.whiteColor().CGColor
            //   privacyBTN.layer.cornerRadius = 10
            
            /*
            navigationController!.navigationBar.barTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
            
            self.title = "About"
            
            if let font = UIFont(name: "DK Cool Crayon", size: 25.0) {
                self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.white]
            }
            */
            
            /*
            if self.revealViewController() != nil {
                menuButton.target = self.revealViewController()
                menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
                
                //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            }
            
            */
        }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        
        if prefs.value(forKey: "AppVersion") != nil {
        
          let TestAppV = prefs.value(forKey: "AppVersion") as! String
            
           // print("Test App V = \(TestAppV)")
            
        AppVersion = "Pics & Quotes \(TestAppV)"
       // print("AppVersion: \(AppVersion)")
        
        versionLBL.text = AppVersion
            
        } else {
         
        versionLBL.text = ""
            
        }
        
    }
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        @IBAction func RateApp(_ sender: AnyObject) {
            
            //    UIApplication.sharedApplication().openURL(NSURL(string : "http://itunes.apple.com/us/app/pics%26quotes/id1023231287?mt=8")!)
            
            //  UIApplication.sharedApplication().openURL(NSURL(string : "itms-apps://itunes.apple.com/app/id1023231287")!)
            
         //   UIApplication.shared.openURL(URL(string : "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1023231287&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software")!)
           
            
            //open(scheme: "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1023231287&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software")
            
            /*
           UIApplication.shared.open(URL(string : "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1023231287&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software")!, options: [:], completionHandler: nil)
            */
            
            
            
        }
    
    /*
    func open(scheme: String) {
        if let url = URL(string: scheme) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                                            print("Open \(scheme): \(success)")
                })
            } else {
                let success = UIApplication.shared.openURL(url)
                print("Open \(scheme): \(success)")
            }
        }
    }
        */
        
        @IBAction func TOSbtn(_ sender: AnyObject) {
            
        }
        
        @IBAction func privacyBTN(_ sender: AnyObject) {
        }
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
    @IBAction func closeView(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeBTN(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
       
    }
    
    
    
}

