//
//  BasicCollectionViewCell.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 2/16/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class BasicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellBG: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var employeeName: UILabel!
    
    @IBOutlet weak var theButton: UIButton!

    @IBOutlet weak var followLBL: UILabel!
    @IBOutlet weak var foloowView: UIView!
    @IBOutlet weak var followBTN: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
