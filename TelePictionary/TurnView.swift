//
//  TurnView.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 2/17/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation


class TurnView: UIView {
    
    @IBOutlet weak var gamebyView: UIView!
    
    @IBOutlet weak var gamebySubView: UIView!
    
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var titleSubView: UIView!
    @IBOutlet weak var nextPlayerView: UIView!
    @IBOutlet weak var nextPlayerSubView: UIView!
    
    
    
    @IBOutlet weak var pokeBTN: UIButton!
   // @IBOutlet weak var CollectionView: UICollectionView!
    var isOpen = Bool()
    
    @IBOutlet weak var pokeBGView: UIView!
    @IBOutlet weak var TurnImage: UIImageView!
    @IBOutlet weak var GameTitle: UILabel!
    @IBOutlet weak var turnBannerLBL: UILabel!
    @IBOutlet weak var currentTurnUserLBL: UILabel!
    
    @IBOutlet weak var turnTypeBannerView: UIView!
    @IBOutlet weak var GameByUser: UILabel!
   // @IBOutlet weak var theView: UIView!
    //@IBOutlet weak var pixieImage: UIImageView!
    
    //@IBOutlet weak var hideBTN: UIButton!
    //@IBOutlet weak var remindLBL: UILabel!
   // @IBOutlet weak var BGView: UIView!
    
    var buttonClicked = Bool()
    
    
    var title: String? {
        didSet {
           // remindLBL.text = text
          //  GameByUser.text = text
            GameTitle.text = title
        }
    }
    
    var byUser: String? {
        didSet {
            // remindLBL.text = text
            //  GameByUser.text = text
            GameByUser.text = byUser
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
        let view: UIView = UINib(nibName: "TurnView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        return view
    }
    
    
   
    
    override func awakeFromNib() {
        
      //  hideBTN.layer.cornerRadius = 10
       // hideBTN.layer.borderColor = UIColor.whiteColor().CGColor
        //hideBTN.layer.borderWidth = 1
        
    }
    
    
    
    
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
    
    
    class func instanceFromNib() -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = UIView()
        
        
        // let bounds = UIScreen.mainScreen().bounds
        let DeviceH = bounds.size.height
        //let halfH = DeviceH / 2;
        let DeviceW = bounds.size.width
        //let WLess10 = DeviceW - 10;
        let startX = (DeviceW / 2) - 125;
        let startY = (DeviceH / 2) - 125;
        
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        
        
        
        
        Nib = UINib(nibName: "TurnView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
}
