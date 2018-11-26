//
//  CustomTableViewCell.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 2/18/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setLabel (_ text: String, andImage imageName: String) {
        label.text = text;
        img.image = UIImage(named: imageName);
    }
    
    @IBAction func statusChanged(_ sender: UISwitch) {
        self.label.text = sender.isOn ? "On" : "Off"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
