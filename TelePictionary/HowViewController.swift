//
//  HowViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 11/4/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import UIKit

class HowViewController: UIViewController {

    @IBOutlet weak var CreateGameBTN: UIButton!
    var viewPlay = Bool()
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var playView: UIView!
    var html = String()
    
    @IBOutlet weak var playViewTOP: NSLayoutConstraint!
    
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var html1 = String()
    var htmlComingSoon = String()
    var htmlNewGame = String()
    
    var HTtopic = NSString()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController!.navigationBar.barTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
        
        self.title = "How To Play"
        
        if let font = UIFont(name: "DK Cool Crayon", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
         subView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        let DeviceH = self.view.frame.height
        //let halfH = DeviceH / 2;
        let DeviceW = self.view.frame.width
        let DeviceW2 = DeviceW - 20;
        //let WLess10 = DeviceW - 10;
        let WidthSize = (DeviceW / 2) - 10;
        let HeightSize = (DeviceH - 250) / 5;
        
        
        webView.allowsInlineMediaPlayback = true
        
        html1 = "<html><body><iframe src=\"http://www.youtube.com/embed/eZKcz11qhG8?playsinline=1\" width=\"\(DeviceW2)\" height=\"315\" frameborder=\"0\" allowfulscreen></iframe></body></html>"
        
        htmlComingSoon = "<html><body><iframe src=\"http://www.youtube.com/embed/rdp3Xy-vlbA?playsinline=1\" width=\"\(DeviceW2)\" height=\"315\" frameborder=\"0\" allowfulscreen></iframe></body></html>"
        
         htmlNewGame = "<html><body><iframe src=\"http://www.youtube.com/embed/NYYv6N4I7wU?playsinline=1\" width=\"\(DeviceW2)\" height=\"315\" frameborder=\"0\" allowfulscreen></iframe></body></html>"
        
        webView.loadHTMLString(html, baseURL: Bundle.main.bundleURL)
        
        
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var hideViewBTN: UIButton!
    
    
    @IBAction func hideViewBTN(_ sender: AnyObject) {
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
        //    self.subViewHolderTOP.constant = middleY
            
            self.playView.center.y = self.playView.center.y + 1000
            
            self.playViewTOP.constant = 1000
            //self.ViewShowing = true
            // ShowingInfo = true
            
            // self.ViewTransTOP.constant = 0
            self.viewPlay = true
        })

        
    }
    
    
    


    @IBAction func NewGame(_ sender: AnyObject) {
        html = htmlNewGame
        
        let AC = JSController("Creating a New Game", MyMessage: "Coming Soon",Color: "Green")
        self.present(AC, animated: true, completion: nil)
        
        
       // webView.loadHTMLString(html, baseURL: NSBundle.mainBundle().bundleURL)
        
        /*
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            //    self.subViewHolderTOP.constant = middleY
            
            self.playView.center.y = self.playView.center.y - 1000
            
            self.playViewTOP.constant = 0
            //self.ViewShowing = true
            // ShowingInfo = true
            
            // self.ViewTransTOP.constant = 0
            self.viewPlay = true
        })
      */
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func ViewGameBTN(_ sender: AnyObject) {
        
 
        html = htmlComingSoon
        
        HTtopic = "completedgames"
        
        self.performSegue(withIdentifier: "howtoVC", sender: self)

        
        /*
        webView.loadHTMLString(html, baseURL: NSBundle.mainBundle().bundleURL)
        
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            //    self.subViewHolderTOP.constant = middleY
            
            self.playView.center.y = self.playView.center.y - 1000
            
            self.playViewTOP.constant = 0
            //self.ViewShowing = true
            // ShowingInfo = true
            
            // self.ViewTransTOP.constant = 0
            self.viewPlay = true
        })
      */
       
        
    }
    
    @IBAction func ManageGroupBTN(_ sender: AnyObject) {
        html = htmlComingSoon
        
        
        HTtopic = "mygames"
        
        self.performSegue(withIdentifier: "howtoVC", sender: self)

        
        /*
        
        webView.loadHTMLString(html, baseURL: NSBundle.mainBundle().bundleURL)
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            //    self.subViewHolderTOP.constant = middleY
            
            self.playView.center.y = self.playView.center.y - 1000
            
            self.playViewTOP.constant = 0
            //self.ViewShowing = true
            // ShowingInfo = true
            
            // self.ViewTransTOP.constant = 0
            self.viewPlay = true
        })
       */
    }

   
    @IBAction func GroupBTN(_ sender: AnyObject) {
        html = htmlComingSoon
        
        HTtopic = "groups"
        
        self.performSegue(withIdentifier: "howtoVC", sender: self)
       // self.performSegueWithIdentifier("howtoVC", sender: nil)
        /*
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            //    self.subViewHolderTOP.constant = middleY
            
            self.playView.center.y = self.playView.center.y - 1000
            
            self.playViewTOP.constant = 0
            //self.ViewShowing = true
            // ShowingInfo = true
            
            // self.ViewTransTOP.constant = 0
            self.viewPlay = true
        })
        */
       
    }
    
    
    @IBAction func leadersBTN(_ sender: AnyObject) {
        
        html = htmlComingSoon
        
        HTtopic = "leaders"
        
        let AC = JSController("Leaderboards Explained", MyMessage: "Coming Soon",Color: "Green")
        self.present(AC, animated: true, completion: nil)

        
       // self.performSegueWithIdentifier("howtoVC", sender: self)
        
        
        
        
        
        /*
        webView.loadHTMLString(html, baseURL: NSBundle.mainBundle().bundleURL)
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            //    self.subViewHolderTOP.constant = middleY
            
            self.playView.center.y = self.playView.center.y - 1000
            
            self.playViewTOP.constant = 0
            //self.ViewShowing = true
            // ShowingInfo = true
            
            // self.ViewTransTOP.constant = 0
            self.viewPlay = true
        })
        */
        
    }
    
    @IBAction func toolboxBTN(_ sender: AnyObject) {
        html = htmlComingSoon
        
        
        HTtopic = "toolbox"
        
        let AC = JSController("Toolbox Explained", MyMessage: "Coming Soon",Color: "Green")
        self.present(AC, animated: true, completion: nil)

        
     //   self.performSegueWithIdentifier("howtoVC", sender: self)

        
        /*
        webView.loadHTMLString(html, baseURL: NSBundle.mainBundle().bundleURL)
        
        
   
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            //    self.subViewHolderTOP.constant = middleY
            
            self.playView.center.y = self.playView.center.y + 1000
            
            self.playViewTOP.constant = 1000
            //self.ViewShowing = true
            // ShowingInfo = true
            
            // self.ViewTransTOP.constant = 0
            self.viewPlay = true
        })
       */
       
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
        if segue.identifier == "howtoVC" {
        
        if let destination = segue.destination as? HowToViewController {
            // destination.GameName = GameNameInfo[GameIndex]
            destination.HTtopic = self.HTtopic
            //println("Game Turn 1: \(TurnNumberInfo[GameIndex])")
            
        }

     }
   
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
