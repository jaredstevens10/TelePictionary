//
//  LoadingViews.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 11/2/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation
import UIKit

class LoadingViewOne: UIView {
    
    var isOpen = Bool()
    
    @IBOutlet weak var theView: UIView!
    
    @IBOutlet weak var remindLBL: UILabel!
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    
    var buttonClicked = Bool()
    
    
    var text: String? {
        didSet {
            remindLBL.text = "Loading..."
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let subView: UIView = loadViewFromNib()
        let bounds = UIScreen.main.bounds
        
        
        let DeviceH = bounds.size.height
        //let halfH = DeviceH / 2;
        let DeviceW = bounds.size.width
        //let WLess10 = DeviceW - 10;
        let startX = (DeviceW / 2) - 125;
        let startY = (DeviceH / 2) - 125;
        print("Start x = \(startX)")
        //subView.layer.masksToBounds = true
        // subView.clipsToBounds = true
        // subView.layer.cornerRadius = 10
        
        // myRemindView.alpha = 0.0
        // myRemindView.frame = CGRectMake(startX, startY, 250, 250)
        //subView.frame = CGRectMake(startX, startY, 250, 250)
        subView.frame = self.bounds
        //label1.text = "123" //would cause error
        addSubview(subView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadViewFromNib() -> UIView {
        let view: UIView = UINib(nibName: "LoadingView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        return view
    }
    
    
    
    
    /*
     var text: String? {
     didSet {
     remindLBL.text = text
     }
     }
     
     
     init(text: String) {
     self.text = text
     //self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blurEffect))
     // super.init(effect: blurEffect)
     super.init()
     self.setup()
     }
     
     required init?(coder aDecoder: NSCoder) {
     
     self.text = ""
     fatalError("init(coder:) has not been implemented")
     self.setup()
     }
     
     func setup() {
     
     }
     */
    
    override func awakeFromNib() {
        
        //hideBTN.layer.cornerRadius = 10
        //hideBTN.layer.borderColor = UIColor.white.cgColor
        //hideBTN.layer.borderWidth = 1
        
    }
    
    
    /*
     
     override func awakeFromNib() {
     theView.layer.cornerRadius = 10
     theView.clipsToBounds = true
     theView.layer.masksToBounds = true
     
     hideBTN.layer.cornerRadius = 10
     hideBTN.layer.borderColor = UIColor.whiteColor().CGColor
     hideBTN.layer.borderWidth = 1
     
     BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).CGColor
     
     var bounds = UIScreen.mainScreen().bounds
     let DeviceH = bounds.size.height
     //let halfH = DeviceH / 2;
     let DeviceW = bounds.size.width
     //let WLess10 = DeviceW - 10;
     let startX = (DeviceW / 2) - 125;
     let startY = (DeviceH / 2) - 125;
     
     self.frame = CGRectMake(startX, startY, 250, 250)
     
     }
     */
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    
    
    /*
     override init (frame : CGRect) {
     super.init(frame : frame)
     addBehavior()
     }
     
     convenience init () {
     self.init(frame:CGRect.zero)
     }
     
     required init(coder aDecoder: NSCoder) {
     fatalError("This class does not support NSCoding")
     }
     
     func addBehavior (){
     print("Add all the behavior here")
     }
     
     */
    /*
     required public init?(coder aDecoder: NSCoder) {
     fatalError("NSCoding not supported")
     }
     */
    /*
     @IBAction func hideBTN(_ sender: AnyObject) {
     
     UIView.animate(withDuration: 0.75, animations: {
     self.alpha = 0.0
     })
     
     self.isHidden = true
     
     //self.removeFromSuperview()
     }
     
     
     @IBAction func theButton(_ sender: AnyObject) {
     if buttonClicked {
     //self.Off()
     buttonClicked = false
     } else {
     //self.On()
     buttonClicked = true
     }
     
     }
     */
    
    class func instanceFromNib() -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = UIView()
        
        
        // let bounds = UIScreen.mainScreen().bounds
        let DeviceH = bounds.size.height
        //let halfH = DeviceH / 2;
        let DeviceW = bounds.size.width
        //let WLess10 = DeviceW - 10;
        //    let startX = (DeviceW / 2) - 125;
        //    let startY = (DeviceH / 2) - 125;
        
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        
        
        
        
        Nib = UINib(nibName: "LoadingView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
}



class LoadingCameraView: UIView {
    
    var isOpen = Bool()
    
    @IBOutlet weak var BGView: UIView!
    
    // @IBOutlet weak var theView: UIView!
    
    //  @IBOutlet weak var remindLBL: UILabel!
    
    // @IBOutlet weak var actInd: UIActivityIndicatorView!
    
  
    @IBOutlet weak var usePhoto_BTN: UIButton!
    
    
    @IBOutlet weak var retakePhoto_BTN: UIButton!
    
    
    @IBOutlet weak var imagePreview: UIImageView!
    
    
    
    
    // @IBOutlet weak var theView: UIView!
    
    
    @IBOutlet weak var buttonsView: UIView!
    
    
    @IBOutlet weak var previewView: UIView!
    
    
    
    
    var buttonClicked = Bool()
    
    
    /*
     var text: String? {
     didSet {
     // remindLBL.text = "Loading..."
     }
     }
     
     */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        let subView: UIView = loadViewFromNib()
        
        let bounds = UIScreen.main.bounds
        
        
        let DeviceH = bounds.size.height
        //let halfH = DeviceH / 2;
        let DeviceW = bounds.size.width
        //let WLess10 = DeviceW - 10;
        let startX = (DeviceW / 2) - 125;
        let startY = (DeviceH / 2) - 125;
        print("Start x = \(startX)")
        //subView.layer.masksToBounds = true
        // subView.clipsToBounds = true
        // subView.layer.cornerRadius = 10
        
        // myRemindView.alpha = 0.0
        // myRemindView.frame = CGRectMake(startX, startY, 250, 250)
        //subView.frame = CGRectMake(startX, startY, 250, 250)
        subView.frame = self.bounds
        //label1.text = "123" //would cause error
        
        addSubview(subView)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //  Bundle.main.loadNibNamed("PreviewView", owner: self, options: nil)
        //   self.addSubview(self.view);
    }
    
    func loadViewFromNib() -> UIView {
        
        let view: UIView = UINib(nibName: "LoadingCameraView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        return view
        
    }
    
    
    
    
    /*
     var text: String? {
     didSet {
     remindLBL.text = text
     }
     }
     
     
     init(text: String) {
     self.text = text
     //self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blurEffect))
     // super.init(effect: blurEffect)
     super.init()
     self.setup()
     }
     
     required init?(coder aDecoder: NSCoder) {
     
     self.text = ""
     fatalError("init(coder:) has not been implemented")
     self.setup()
     }
     
     func setup() {
     
     }
     */
    
    override func awakeFromNib() {
        
        retakePhoto_BTN.layer.cornerRadius = 10
        usePhoto_BTN.layer.cornerRadius = 10
        
        //hideBTN.layer.cornerRadius = 10
        //hideBTN.layer.borderColor = UIColor.white.cgColor
        //hideBTN.layer.borderWidth = 1
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    
    
    
    @IBAction func UsePhotoBTN(_ sender: AnyObject) {
        
        
    }
    
    @IBAction func RetakePhotoBTN(_ sender: AnyObject) {
        
        self.isHidden = true
        
    }
    
    
    
    class func instanceFromNib() -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = UIView()
        
        
        // let bounds = UIScreen.mainScreen().bounds
        let DeviceH = bounds.size.height
        //let halfH = DeviceH / 2;
        let DeviceW = bounds.size.width
        //let WLess10 = DeviceW - 10;
        //    let startX = (DeviceW / 2) - 125;
        //    let startY = (DeviceH / 2) - 125;
        
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        
        
        
        
        Nib = UINib(nibName: "LoadingCameraView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
}



/*
class LoadingCameraView: UIView {
    
    
    var nibName = "LoadingCameraView"
    var view: UIView!
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    
    override init(frame: CGRect) {
        
        print("ini frame cameraOverview")
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
}


extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}

*/
    
    /*
class CustomCameraOverlay: UIView {
    
    var isOpen = Bool()
    
   // @IBOutlet weak var theView: UIView!
    
  //  @IBOutlet weak var remindLBL: UILabel!
   
   // @IBOutlet weak var actInd: UIActivityIndicatorView!
    
    
    @IBOutlet weak var usePhoto_BTN: UIButton!
    
    
    @IBOutlet weak var retakePhoto_BTN: UIButton!
   
    
    @IBOutlet weak var imagePreview: UIImageView!
    
    @IBOutlet weak var BGView: UIView!
  
    
    // @IBOutlet weak var theView: UIView!
    
  
    @IBOutlet weak var buttonsView: UIView!
    
    
    @IBOutlet weak var previewView: UIView!
    
    
   
    
    var buttonClicked = Bool()
    
    
    /*
    var text: String? {
        didSet {
           // remindLBL.text = "Loading..."
        }
    }
    
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        let subView: UIView = loadViewFromNib()
        
        let bounds = UIScreen.main.bounds
        
        
        let DeviceH = bounds.size.height
        //let halfH = DeviceH / 2;
        let DeviceW = bounds.size.width
        //let WLess10 = DeviceW - 10;
        let startX = (DeviceW / 2) - 125;
        let startY = (DeviceH / 2) - 125;
        print("Start x = \(startX)")
        //subView.layer.masksToBounds = true
        // subView.clipsToBounds = true
        // subView.layer.cornerRadius = 10
        
        // myRemindView.alpha = 0.0
        // myRemindView.frame = CGRectMake(startX, startY, 250, 250)
        //subView.frame = CGRectMake(startX, startY, 250, 250)
        subView.frame = self.bounds
        //label1.text = "123" //would cause error
       
        addSubview(subView)
        
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
      //  Bundle.main.loadNibNamed("PreviewView", owner: self, options: nil)
     //   self.addSubview(self.view);
    }
    
    func loadViewFromNib() -> UIView {
        
        let view: UIView = UINib(nibName: "PreviewView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        return view
        
    }
    
    
    
    
    /*
     var text: String? {
     didSet {
     remindLBL.text = text
     }
     }
     
     
     init(text: String) {
     self.text = text
     //self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blurEffect))
     // super.init(effect: blurEffect)
     super.init()
     self.setup()
     }
     
     required init?(coder aDecoder: NSCoder) {
     
     self.text = ""
     fatalError("init(coder:) has not been implemented")
     self.setup()
     }
     
     func setup() {
     
     }
     */
    
    override func awakeFromNib() {
        
        //hideBTN.layer.cornerRadius = 10
        //hideBTN.layer.borderColor = UIColor.white.cgColor
        //hideBTN.layer.borderWidth = 1
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
  
    
    
    @IBAction func UsePhotoBTN(_ sender: AnyObject) {
        
        
    }
    
    @IBAction func RetakePhotoBTN(_ sender: AnyObject) {
        
        
    }
    
    class func instanceFromNib() -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = UIView()
        
        
        // let bounds = UIScreen.mainScreen().bounds
        let DeviceH = bounds.size.height
        //let halfH = DeviceH / 2;
        let DeviceW = bounds.size.width
        //let WLess10 = DeviceW - 10;
        //    let startX = (DeviceW / 2) - 125;
        //    let startY = (DeviceH / 2) - 125;
        
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        
        
        
        
        Nib = UINib(nibName: "PreviewView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
}
*/

