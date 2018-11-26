//
//  LikeFailPhotoCell.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 12/7/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import UIKit

class LikeFailPhotoCell: UICollectionViewCell {
    
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var numberIMG: UIImageView!
    @IBOutlet weak var friendsBTN: UIButton!
    
    @IBOutlet weak var bestfriendsBTN: UIButton!
    @IBOutlet weak var publicBTN: UIButton!
    
    @IBOutlet weak var meBTN: UIButton!
    
    @IBOutlet weak var publicIMG: UIImageView!
     @IBOutlet weak var bestfriendsIMG: UIImageView!
      @IBOutlet weak var friendsIMG: UIImageView!
      @IBOutlet weak var meIMG: UIImageView!
    
    @IBOutlet weak var CellLBL: UILabel!
    
    @IBOutlet weak var playBTN: UIButton!
    @IBOutlet weak var TurnImage: UIImageView!
    
    @IBOutlet weak var blurImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isSelected = false
    }
 
    
    
    
}
