//
//  JSAlertController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 8/28/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import Foundation
import UIKit


func JSController(_ MyTitle: String, MyMessage: String, Color: String) -> UIAlertController {
    
    let alertController = UIAlertController(title: MyTitle, message: MyMessage, preferredStyle: .alert)
    let OkAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
        print("OK button pressed")
    }
    
    alertController.addAction(OkAction);
    
    alertController.view.tintColor = UIColor.black;
    //alertController.view.backgroundColor = UIColor(red: 0.4, green: 1, blue: 0.69, alpha: 1.0)
    /*
    var subView = alertController.view.subviews.first as! UIView
    var contentView = subView.subviews.first as! UIView
    var contentView2 = subView.subviews.last as! UIView
    
    switch Color {
    case "Red":
        
    contentView.backgroundColor = UIColor(red: 0.807, green: 0.576, blue: 0.58, alpha: 1.0)
    contentView.tintColor = UIColor(red: 0.929, green: 0.113, blue: 0.145, alpha: 1.0)
   // contentView.
    contentView2.tintColor = UIColor(red: 0.929, green: 0.113, blue: 0.145, alpha: 1.0)
    
    case "Blue":
        contentView.backgroundColor = UIColor(red: 0.249, green: 0.549, blue: 0.674, alpha: 0.5)
        contentView.tintColor = UIColor(red: 0.572, green: 0.882, blue: 0.949, alpha: 1.0)
        // contentView.
        contentView2.tintColor = UIColor(red: 0.572, green: 0.882, blue: 0.949, alpha: 1.0)        
        
    case "Green":
        contentView.backgroundColor = UIColor(red: 0.4, green: 1, blue: 0.69, alpha: 1.0)
        contentView.tintColor = UIColor(red: 0.0, green: 0.4, blue: 0.2, alpha: 1.0)
        // contentView.
        contentView2.tintColor = UIColor(red: 0.0, green: 0.4, blue: 0.2, alpha: 1.0)
        
        
    default:
        print("Default Color")
        
    }
    */
    
    return alertController
    //    let alertController = JSController(MyTitle: String, MyMessage: String, Color: String)
   // self.presentViewController(alertController, animated: true, completion: nil)
    
}
