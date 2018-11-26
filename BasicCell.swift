//
//  BasicCell.swift
//  DeviantArtBrowser
//
//  Created by Joshua Greene on 4/19/15.
//  Copyright (c) 2015 Razeware, LLC. All rights reserved.
//

import UIKit

class BasicCell: UITableViewCell {
    
    
    @IBOutlet weak var TurnByLBL: UILabel!
    
    @IBOutlet weak var TurnByHolder: UIView!
    
    
    
    
    @IBOutlet weak var panelW: NSLayoutConstraint!
    
    @IBOutlet weak var gameTypeP: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var LikeButton: UIButton!
    @IBOutlet weak var FailButton: UIButton!
    @IBOutlet weak var ShareButton: UIButton!
    @IBOutlet weak var playBTN: UIButton!
    
    @IBOutlet weak var cellBottomView: UIView!
    
    @IBOutlet weak var lastTurnLBL: UILabel!
    
    var visualEffectView: UIView?
    
    @IBOutlet weak var turnNumberLBL: UILabel!
    @IBOutlet weak var titleIMG: UIImageView!
    @IBOutlet var titleLBL: UILabel!
    @IBOutlet weak var nextArrowIMG: UIImageView!
    @IBOutlet weak var blurCoverIMG: UIImageView!
    
    @IBOutlet weak var numberIMG: UIImageView!
    
    @IBOutlet weak var blurView1: UIVisualEffectView!
    
    @IBOutlet weak var turnNumberIMG: UIImageView!
    @IBOutlet weak var Turn1View: UIView!
    
    @IBOutlet weak var turnView: UIView!
    
    @IBOutlet weak var Turn1Image: UIImageView!
    
    @IBOutlet weak var Turn10Image: UIImageView!
    
    @IBOutlet weak var Turn1ImageBack: UIImageView!
    
    @IBOutlet weak var timeLimitLBL: UILabel!
    @IBOutlet weak var allPlayerBTN: UIButton!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var buyButton: UIButton!
    
    @IBOutlet var TurnLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    @IBOutlet var TableImage: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var greenCheck: UIImageView!
    
    @IBOutlet weak var numbers: UILabel!
    
    @IBOutlet var TableImageCTs: UIButton!
    
    @IBOutlet weak var sendMailBTN: UIButton!
    
    @IBOutlet var TableImageGC: UIButton!
    
    @IBOutlet weak var contentView2: UIView!
    
    @IBOutlet var pokeBTN: UIButton!
    @IBOutlet var TableImageFB: UIButton!
    
    @IBOutlet weak var contentBTN: UIButton!
    
    @IBOutlet weak var TakeTurnBTN: UIButton!
    
    
    
    @IBOutlet weak var cellViewBG: UIView!
    
    
    @IBOutlet weak var Turn1ImageW: NSLayoutConstraint!
    
    @IBOutlet weak var statusLBL: UILabel!
    
    @IBOutlet weak var createdByLBL: UILabel!
    @IBOutlet weak var createdByLBL_who: UILabel!
    
    @IBOutlet weak var currentTurnLBL: UILabel!
    @IBOutlet weak var currentTurnLBL_who: UILabel!
    
    
    @IBOutlet weak var visibilityLBL: UILabel!
    
    @IBOutlet weak var heartView: UIView!
    @IBOutlet weak var heartLBL: UILabel!
    @IBOutlet weak var failLBL: UILabel!
    @IBOutlet weak var heartIMG: UIImageView!
    
    @IBOutlet weak var lblView: UIView!
    
    @IBOutlet var messageBTN: UIButton!
    
    @IBOutlet var restoreButton: UIButton!
    
    @IBOutlet var commentsLBL: UILabel!
    
    @IBOutlet var commentsBTN: UIButton!
    
    @IBOutlet weak var commentView: UIView!
    @IBOutlet var deleteCommentBTN: UIButton!
    
    @IBOutlet weak var pokeLBL: UILabel!
    
    
    func setupIsBlurred(_ isBlurred: Bool) {
        if isBlurred {
            if self.visualEffectView == nil {
                let blurEffect = UIBlurEffect(style: .dark)
                let visualEffectView = UIVisualEffectView(effect: blurEffect)
                
                visualEffectView.frame = self.Turn1Image.bounds
                
                //self.visualEffectView!.autoresizingMask = UIViewAu
                
                //self.visualEffectView!.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
                
                self.Turn1Image.addSubview(visualEffectView)
                
                self.visualEffectView = visualEffectView
            }
        } else {
            self.visualEffectView?.removeFromSuperview()
            self.visualEffectView = nil
        }
    }
    
    func setLabel (_ text: String, andImage imageName: String) {
        titleLBL.text = text;
        titleIMG.image = UIImage(named: imageName);
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func pulseBTN(_ shouldPulse: Bool) {
        
        if shouldPulse {
            
            
            let pulseAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale");
            pulseAnimation.duration = 30.0;
            pulseAnimation.toValue = NSNumber(value: 1.0 as Float);
            pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
            pulseAnimation.autoreverses = true;
            pulseAnimation.repeatCount = FLT_MAX;
            self.TakeTurnBTN.layer.add(pulseAnimation, forKey: nil)
            //self.TakeTurnBTN.a
            
            
        } else {
            
            self.TakeTurnBTN.layer.removeAllAnimations()
            
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
}
