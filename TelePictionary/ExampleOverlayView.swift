//
//  ExampleOverlayView.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 2/15/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation

import UIKit
//import Koloda

private let overlayRightImageName = "yesOverlayImage"
private let overlayLeftImageName = "noOverlayImage"

class ExampleOverlayView: OverlayView {
    @IBOutlet lazy var overlayImageView: UIImageView! = {
        [unowned self] in
        
        var imageView = UIImageView(frame: self.bounds)
        self.addSubview(imageView)
        
        return imageView
        }()
    
    override var overlayState:OverlayMode  {
        didSet {
            switch overlayState {
            case .left :
                overlayImageView.image = UIImage(named: overlayLeftImageName)
            case .right :
                overlayImageView.image = UIImage(named: overlayRightImageName)
            default:
                overlayImageView.image = nil
            }
            
        }
    }
    
}
