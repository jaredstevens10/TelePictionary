//
//  HowToContentViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/19/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit

class HowToContentViewController: UIViewController {
    
    @IBOutlet weak var IMGfullH: NSLayoutConstraint!
    
    @IBOutlet weak var IMGfullW: NSLayoutConstraint!
    
    @IBOutlet weak var IMG2h: NSLayoutConstraint!
    
    @IBOutlet weak var IMG2w: NSLayoutConstraint!
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!

    var pageIndex = Int()
    var titleText = String()
    var imageName = String()
    var LBL1text = String()
    var LBL2text = String()
    
    var imageTOP = UIImage()
    var imageBOTTOM = UIImage()
    var imageTOPname = NSString()
    var imageBOTTOMname = NSString()
    var IMGfullname = NSString()
    var IMG1hidden = Bool()
    var IMG2hidden = Bool()
    var IMGfullHidden = Bool()
    
    @IBOutlet weak var LBL1: UILabel!
    
    @IBOutlet weak var LBL2: UILabel!
    
    @IBOutlet weak var IMGfull: UIImageView!
    
    @IBOutlet weak var IMG1: UIImageView!
    
    @IBOutlet weak var IMG2: UIImageView!
    
       var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let DeviceH = self.view.frame.height
        //let halfH = DeviceH / 2;
        let DeviceW = self.view.frame.width
        let DeviceW2 = DeviceW - 20;
        //let WLess10 = DeviceW - 10;
        let WidthSize = (DeviceW / 2) - 10;
        let HeightSize = (DeviceH - 250) / 5;
        
        print("Device Wideth - 20 =\(DeviceW2)")
        
        let FH = UIImage(named: self.IMGfullname as String)?.size.height
        let FW = UIImage(named: self.IMGfullname as String)?.size.width
        
        let OH = UIImage(named: self.imageTOPname as String)?.size.height
        let OW = UIImage(named: self.imageTOPname as String)?.size.width

        let TH = UIImage(named: self.imageBOTTOMname as String)?.size.height
        let TW = UIImage(named: self.imageBOTTOMname as String)?.size.width

        var FR = CGFloat()
        var OR = CGFloat()
        var TR = CGFloat()
        
        var IMGfullWidth = CGFloat()
        var IMGfullHeight = CGFloat()
        
        var IMGTwoWidth = CGFloat()
        var IMGTwoHeight = CGFloat()
        
        
        if FW != nil {
            
        // if FW > FH {
            FR = FW! / FH!
      //  } else {
      //          FR = FH! / FW!
      //    }
            if FR < 0.7 {
            print("it's over 0.6")
                IMGfullWidth = (DeviceW2 - 115)
                IMGfullHeight = (DeviceW2 - 115) / FR

            } else {
               print("it's under 0.6")
                IMGfullWidth = (DeviceW2 - 50)
                IMGfullHeight = (DeviceW2 - 50) / FR
 
                
            }
            

            self.IMGfullW.constant = IMGfullWidth
            self.IMGfullH.constant = IMGfullHeight

            
        }
        
        if OW != nil {
            OR = OH! / OW!
        }


        if TW != nil {
 
            TR = TH! / TW!

            IMGTwoWidth = (DeviceW2 - 10)
            IMGTwoHeight = (DeviceW2 - 10) / TR
            
            self.IMG2w.constant = IMGTwoWidth
            self.IMG2h.constant = IMGTwoHeight
        }

        
        
        

        
        print("full height = \(FH)")
        print("full width = \(FW)")
        print("full ratio = \(FR)")
        
        print("1 height = \(OH)")
        print("1 width = \(OW)")
        print("one ratio = \(OR)")
        
        print("2 height = \(TH)")
        print("2 width = \(TW)")
        print("2 ratio = \(TR)")
        
    //    webView.allowsInlineMediaPlayback = true
        
    //    let html = "<html><body><iframe src=\"http://www.youtube.com/embed/eZKcz11qhG8?playsinline=1\" width=\"\(DeviceW2)\" height=\"315\" frameborder=\"0\" allowfulscreen></iframe></body></html>"
    //    webView.loadHTMLString(html, baseURL: NSBundle.mainBundle().bundleURL)     // self.image.image = UIImage(named: imageName)
        
        IMG1.layer.masksToBounds = true
        IMG1.layer.cornerRadius = 5
        IMG1.layer.borderWidth = 1
        IMG1.layer.borderColor = UIColor.white.cgColor
        IMG1.clipsToBounds = true
        
        IMG2.layer.masksToBounds = true
        IMG2.layer.cornerRadius = 5
        IMG2.layer.borderWidth = 1
        IMG2.layer.borderColor = UIColor.white.cgColor
        IMG2.clipsToBounds = true
        
        IMGfull.layer.masksToBounds = true
        IMGfull.layer.cornerRadius = 5
        IMGfull.layer.borderWidth = 1
        IMGfull.layer.borderColor = UIColor.white.cgColor
        IMGfull.clipsToBounds = true

        
        self.label.text = self.titleText
        self.LBL1.text = self.LBL1text
        self.LBL2.text = self.LBL2text
        self.IMG1.image = UIImage(named: imageTOPname as String)
        self.IMG2.image = UIImage(named: imageBOTTOMname as String)
        self.IMG1.isHidden = self.IMG1hidden
        self.IMG2.isHidden = self.IMG2hidden
        self.IMGfull.image = UIImage(named: self.IMGfullname as String)
        self.IMGfull.isHidden = IMGfullHidden
       // self.label.alpha = 0.1
        
       // self.label.text = "coming soon"
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in //self.label.alpha = 1.0
        })
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBTN(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
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
