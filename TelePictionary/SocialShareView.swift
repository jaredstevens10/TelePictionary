//
//  SocialShareView.swift
//  TelePictionary
//
//  Created by Jared Stevens on 10/12/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import Foundation
import UIKit

class SocialShare: UIVisualEffectView {
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    let label: UILabel = UILabel()
    let FaceBook: UIButton = UIButton()
    let Message: UIButton = UIButton()
    let Twitter: UIButton = UIButton()
    let Email: UIButton = UIButton()
    let Instagram: UIButton = UIButton()
    let closeBTN: UIButton = UIButton()
    
    let blurEffect = UIBlurEffect(style: .light)
    let vibrancyView: UIVisualEffectView
    let LoadView = UIView()
    
    init(text: String) {
        self.text = text
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.text = ""
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        // self.LoadView =
        super.init(coder: aDecoder)
        self.setup()
        
    }
    
    func setup() {
        
        
        // contentView.addSubview(vibrancyView)
        contentView.addSubview(LoadView)
       // contentView.backgroundColor = UIColor.grayColor()
        /*
        vibrancyView.contentView.addSubview(activityIndictor)
        vibrancyView.contentView.addSubview(label)
        */
        LoadView.addSubview(label)
        //LoadView.addSubview(activityIndictor)
        label.textColor = UIColor.white
        LoadView.addSubview(FaceBook)
        LoadView.addSubview(Message)
        LoadView.addSubview(Email)
        LoadView.addSubview(Twitter)
        LoadView.addSubview(Instagram)
        LoadView.addSubview(closeBTN)
        
        

        
        
        
        
       // activityIndictor.color = UIColor.whiteColor()
       // activityIndictor.startAnimating()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superview = self.superview {
            
            let width = superview.frame.size.width / 1.25  //2.3
            let height: CGFloat = 100.0 //50.0
            
            self.frame = CGRect(x: 10,
                y: 10, width: superview.frame.size.width - 20, height: superview.frame.size.height - 20)
            self.layer.cornerRadius = 50
            
            
            // vibrancyView.frame = self.bounds
            LoadView.layer.cornerRadius = 50
            LoadView.frame = self.bounds
            
            FaceBook.imageView?.image = UIImage(named: "facebook.png")
            Message.imageView?.image = UIImage(named: "TextMessageIcon.png")
            
            Email.imageView?.image = UIImage(named: "EmailIcon.png")
            Twitter.imageView?.image = UIImage(named: "twitter.png")
            Instagram.imageView?.image = UIImage(named: "instragram 40.png")
            
            
            //layer.backgroundColor = UIColor.blackColor().CGColor
          /*
            let activityIndicatorSize: CGFloat = 40
            activityIndictor.frame = CGRectMake(self.frame.width / 7, height / 2 - activityIndicatorSize / 2,
                activityIndicatorSize,
                activityIndicatorSize)
            activityIndictor.color = UIColor.whiteColor()
*/
            //            activityIndictor.color = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
            //8.0
            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            label.text = text
            // label.textColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
            
            label.textColor = UIColor.white
            
            label.textAlignment = NSTextAlignment.center
            //label.frame = CGRectMake(activityIndicatorSize + 5, 0, width - activityIndicatorSize - 15, height)
            
            label.frame = CGRect(x: self.frame.width / 2, y: 0, width: width, height: height)
            closeBTN.frame = CGRect(x: 120, y: 100, width: 50, height: 50)
            Email.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
            Message.frame = CGRect(x: 10, y: 100, width: 50, height: 50)
            Twitter.frame = CGRect(x: 60, y: 10, width: 50, height: 50)
            FaceBook.frame = CGRect(x: 60, y: 100, width: 50, height: 50)
            Instagram.frame = CGRect(x: 110, y: 10, width: 50, height: 50)
            
            closeBTN.setTitle("Close", for: UIControlState())
            closeBTN.setTitleColor(UIColor.black, for: UIControlState())
            closeBTN.addTarget(self, action: #selector(SocialShare.closeView(_:)), for: .touchUpInside)
            
           
            //label.textColor = UIColor.grayColor()
            label.font = UIFont.boldSystemFont(ofSize: 16)
            
            
        }
    }
    func closeView(_ sender: UIButton!) {
    self.isHidden = true
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
}
