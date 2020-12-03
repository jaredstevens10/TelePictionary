//
//  SignUpTwoViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 2/24/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class SignUpTwoViewController: UIViewController {

    
    @IBOutlet var txtName : UITextField!
    @IBOutlet weak var signupButton: UIButton!
     let prefs = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.title = "Sign Up"
        
        if let font = UIFont(name: "DK Cool Crayon", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
        
        txtName.becomeFirstResponder()
        signupButton.layer.cornerRadius = 40

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func closeBTN(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBTN(_ sender: AnyObject) {
        
        
        let name: NSString = txtName.text! as NSString
        if !name.isEqual(to: "") {
            
            prefs.set(name, forKey: "FULLNAME")
            
            self.performSegue(withIdentifier: "nextsegue", sender: self)
            
        } else {
            
            DispatchQueue.main.async(execute: {
                
                
                SCLAlertView().showCustomOKSIGN(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Name", subTitle: "Please enter your name", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
        }

        
        
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
