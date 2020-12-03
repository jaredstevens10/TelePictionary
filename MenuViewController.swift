//
//  MenuViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/2/15.
//  Copyright (c) 2015 Jared Stevens. All rights reserved.
//

import UIKit
import Social

class MenuViewController: UIViewController, UIScrollViewDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var viewNew: UIView!
    @IBOutlet weak var viewLeaders: UIView!
    @IBOutlet weak var viewHome: UIView!
    @IBOutlet weak var viewHowTo: UIView!
    @IBOutlet weak var viewFriends: UIView!
    @IBOutlet weak var viewMyTurns: UIView!
    @IBOutlet weak var viewCT: UIView!
    
    
    var LevelUpdated = Bool()
    
    @IBOutlet var facebookBTN: UIButton!
    var userTokens = Int()
    var LikeBTN = FBSDKLikeControl()
    var userLevel = Int()
    var userLevelPoints = Int()
    var upgradePoints = Int()
    var nextTier = Int()
    
    @IBOutlet weak var FBBTN: UIButton!
    
    var timer = Timer()
    var level = Int()
    
    var Char1 = UIImage(named: "CharacterNormal.png")
    var Char2 = UIImage(named: "CharacterBum.png")
    var Char3 = UIImage(named: "CharacterPirate.png")
    var Char4 = UIImage(named: "CharacterScholar.png")
    var Char5 = UIImage(named: "CharacterEinstien.png")
    var Char6 = UIImage(named: "CharacterWizard.png")
    
    
    @IBOutlet weak var containerView: UIView!
    
    
    @IBOutlet weak var tokensBTN: UIButton!
    let prefs:UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var levelLBL: UILabel!
    @IBOutlet weak var levelpointsLBL: UILabel!
    @IBOutlet weak var nextUpgradeLBL: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var pixieBTN: UIButton!
    
    var fbURL: URL = URL(string: "fb://facebook.com/MyPicsAndQuotes")!
    var fbURLWeb: URL = URL(string: "https://www.facebook.com/MyPicsAndQuotes")!
    @IBOutlet weak var scrollView: UIScrollView!
    var pulse = CABasicAnimation()
    var rotate = CABasicAnimation()
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.viewMyTurns.layer.cornerRadius = 40
        self.viewMyTurns.layer.borderWidth = 2
        self.viewMyTurns.layer.borderColor = UIColor.white.cgColor
        
        self.viewHowTo.layer.cornerRadius = 40
        self.viewHowTo.layer.borderWidth = 2
        self.viewHowTo.layer.borderColor = UIColor.white.cgColor
        
        self.viewHome.layer.cornerRadius = 40
        self.viewHome.layer.borderWidth = 2
        self.viewHome.layer.borderColor = UIColor.white.cgColor
        self.viewHome.clipsToBounds = true
        self.viewHome.layer.masksToBounds = true
        
        self.viewNew.layer.cornerRadius = 40
        self.viewNew.layer.borderWidth = 2
        self.viewNew.layer.borderColor = UIColor.white.cgColor
        
        self.viewFriends.layer.cornerRadius = 40
        self.viewFriends.layer.borderWidth = 2
        self.viewFriends.layer.borderColor = UIColor.white.cgColor
        
        self.viewCT.layer.cornerRadius = 40
        self.viewCT.layer.borderWidth = 2
        self.viewCT.layer.borderColor = UIColor.white.cgColor
        
        self.viewLeaders.layer.cornerRadius = 40
        self.viewLeaders.layer.borderWidth = 2
        self.viewLeaders.layer.borderColor = UIColor.white.cgColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuViewController.updatePixie(_:)), name: NSNotification.Name(rawValue: "updatePixie"),  object: nil)

        
        
        self.progressView.setProgress(0 as Float, animated: false)
        LikeBTN.objectID = "https://www.facebook.com/MyPicsAndQuotes"
        
        //FBBTN.addSubview(LikeBTN)
        
       // FBBTN.objectID = "https://www.facebook.com/MyPicsAndQuotes"
        
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = false
        scrollView.delegate = self
       // scrollView.contentSize = CGSize(width: self.view.frame.width, height: 800)
       // scrollView.bounces = false
        
        scrollView.showsHorizontalScrollIndicator = false
        pulse = CABasicAnimation(keyPath: "opacity")
        pulse.duration = 2
        pulse.fromValue = 0.5
        pulse.toValue = 1
        pulse.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulse.autoreverses = true
        pulse.repeatCount = FLT_MAX
        
        rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.fromValue = 0.0
        rotate.toValue = CGFloat(M_PI * 2.0)
        rotate.duration = 2
        
pixieBTN.layer.add(rotate, forKey: nil)
pixieBTN.layer.add(pulse, forKey: nil)
        // Do any additional setup after loading the view.
        level = 0
        userLevel = prefs.integer(forKey: "USERLEVEL")
        userTokens = prefs.integer(forKey: "USERTOKENS")
        userLevelPoints = prefs.integer(forKey: "USERLEVELPOINTS")
    tokensBTN.setTitle(userTokens.description, for: UIControl.State())
        
        print("UserLevel = \(userLevel)")
        
        switch userLevel {
        case 1:
            pixieBTN.setImage(Char1, for: UIControl.State())
            nextTier = 200
        case 2:
            pixieBTN.setImage(Char2, for: UIControl.State())
            nextTier = 300
        case 3:
            pixieBTN.setImage(Char3, for: UIControl.State())
            nextTier = 400
        case 4:
            pixieBTN.setImage(Char4, for: UIControl.State())
            nextTier = 500
        case 5:
           pixieBTN.setImage(Char5, for: UIControl.State())
           nextTier = 600
        case 6:
            pixieBTN.setImage(Char5, for: UIControl.State())
            nextTier = 700
        case 7:
            pixieBTN.setImage(Char5, for: UIControl.State())
            nextTier = 800
        case 8:
            pixieBTN.setImage(Char5, for: UIControl.State())
            nextTier = 900
        case 9:
            pixieBTN.setImage(Char5, for: UIControl.State())
            nextTier = 1000
        case 10:
            pixieBTN.setImage(Char6, for: UIControl.State())
             nextTier = 1100
        default:
            pixieBTN.setImage(Char1, for: UIControl.State())
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func updatePixie(_ notification:Notification) {
        print("Updating Pixie")
        
        userLevel = prefs.integer(forKey: "USERLEVEL")
        userTokens = prefs.integer(forKey: "USERTOKENS")
        userLevelPoints = prefs.integer(forKey: "USERLEVELPOINTS")
        tokensBTN.setTitle(userTokens.description, for: UIControl.State())

        print("UserLevel = \(userLevel)")
        
        switch userLevel {
        case 1:
            pixieBTN.setImage(Char1, for: UIControl.State())
            nextTier = 200
        case 2:
            pixieBTN.setImage(Char2, for: UIControl.State())
            nextTier = 300
        case 3:
            pixieBTN.setImage(Char3, for: UIControl.State())
            nextTier = 400
        case 4:
            pixieBTN.setImage(Char4, for: UIControl.State())
            nextTier = 500
        case 5:
            pixieBTN.setImage(Char5, for: UIControl.State())
            nextTier = 600
        case 6:
            pixieBTN.setImage(Char5, for: UIControl.State())
            nextTier = 700
        case 7:
            pixieBTN.setImage(Char5, for: UIControl.State())
            nextTier = 800
        case 8:
            pixieBTN.setImage(Char5, for: UIControl.State())
            nextTier = 900
        case 9:
            pixieBTN.setImage(Char5, for: UIControl.State())
            nextTier = 1000
        case 10:
            pixieBTN.setImage(Char6, for: UIControl.State())
            nextTier = 1100
        default:
            pixieBTN.setImage(Char1, for: UIControl.State())
        }

        
        /*
levelpointsLBL.text = "Points: \(userLevelPoints.description)"


upgradePoints = nextTier - userLevelPoints

if upgradePoints == 1 {
nextUpgradeLBL.text = "\(upgradePoints) Point To Next Level Up"

} else if upgradePoints < 0 {
nextUpgradeLBL.text = ""
} else {
nextUpgradeLBL.text = "\(upgradePoints) Points To Next Level Up"
}

*/

       // self.performSegueWithIdentifier("select_newgame", sender: self)
    }
    override func viewDidLayoutSubviews() {
          scrollView.contentSize = CGSize(width: self.view.frame.width, height: 600)
        self.containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 600)
    }

    override func viewWillAppear(_ animated: Bool) {
        userLevel = prefs.integer(forKey: "USERLEVEL")
        userTokens = prefs.integer(forKey: "USERTOKENS")
        userLevelPoints = prefs.integer(forKey: "USERLEVELPOINTS")
        tokensBTN.setTitle(userTokens.description, for: UIControl.State())
        
        levelpointsLBL.text = "Points: \(userLevelPoints.description)"
        
        
        upgradePoints = nextTier - userLevelPoints
        
        if upgradePoints == 1 {
            nextUpgradeLBL.text = "\(upgradePoints) Point To Next Level Up"
  
        } else if upgradePoints < 0 {
            nextUpgradeLBL.text = ""
        } else {
        nextUpgradeLBL.text = "\(upgradePoints) Points To Next Level Up"
        }
        //Points: \(userLevelPoints.description)"


    }
    @objc func updateLevel() {
        
        
        
        
        
        if level == userLevel {
            timer.invalidate()
            levelLBL.text = "Level: \(userLevel.description)"
        
            //let proglevel = userLevel / 10
            
            print("User Level Points = \(userLevelPoints)")
            
             let proglevel = ((round(1000 * Double((userLevelPoints / 100))) / 1000) / 10)
            print("proglevel = \(proglevel)")

        self.progressView.setProgress(Float(proglevel), animated: true)
   
            
            
        } else {
        
            let proglevel = level / 10
         //   let proglevel = (levelpoints / 100) / 10


        levelLBL.text = "Level: \(String(describing: level += 1))"
         
            print("proglevel = \(proglevel)")
            
        self.progressView.setProgress(Float(proglevel), animated: true)

            
            
        }
        
        LevelUpdated = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("Menu Did appear, updating level bar")
        
        if !LevelUpdated {
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(MenuViewController.updateLevel), userInfo: nil, repeats: true)
            
        }

        // self.progressView.setProgress(0.3 as Float, animated: false)
      //  self.progressView.setProgress(0.7, animated: true)
    }
    
    @IBAction func MyGames(_ sender: AnyObject) {
        
        //loading.startAnimating()
self.performSegue(withIdentifier: "Select_MyGames", sender: self)
        
       // loading.stopAnimating()
    }
    
    @IBAction func facebookBTN(_ sender: AnyObject) {
        
      //  UIApplication.tryURL(["fb://facebook.com/MyPicsAndQuotes","http://www.facebook.com/MyPicsAndQuotes"])
          UIApplication.tryURL(["","http://www.facebook.com/MyPicsAndQuotes"])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //<#code#>
      //  scrollView.alpha = 0.5
      //   centerScrollViewContents()
        
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if (bottomEdge >= scrollView.contentSize.height) {
            print("we are at the bottom")
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
       scrollView.alpha = 1.0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       
        /*
        if scrollView.contentOffset.x == 0 {
            scrollView.scrollRectToVisible(CGRect(x: 2304.0, y: 0.0, width: 768, height: 365), animated: false)
        }
        else if scrollView.contentOffset.x == 3072 {
            scrollView.scrollRectToVisible(CGRect(x: 768.0, y: 0.0, width: 768, height: 365), animated: false)
        }
*/
        scrollView.alpha = 1
    }
    
    
    
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = containerView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        containerView.frame = contentsFrame
    }
    
    @IBAction func twitterBTN(_ sender: AnyObject) {
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            // 2
            let tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            // 3
            tweetSheet?.setInitialText("@MyPicsAndQuotes ")
          //  tweetSheet.addImage(imageView.image)
            
            // 4
            self.present(tweetSheet!, animated: true, completion: nil)
        } else {
            // 5
            print("error")
        }
        
    }
    
    @IBAction func igBTN(_ sender: AnyObject) {
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

extension UIApplication {
    class func tryURL(_ urls: [String]) {
        let application = UIApplication.shared
        for url in urls {
            if application.canOpenURL(URL(string: url)!) {
                application.openURL(URL(string: url)!)
                return
            }
        }
    }
}

