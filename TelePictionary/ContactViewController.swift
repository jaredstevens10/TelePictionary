//
//  ContactViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 9/8/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import Social

class ContactViewController: UIViewController, UINavigationControllerDelegate {

    
    @IBOutlet var DoneBTN: UIButton!
    
    @IBOutlet var DoneBTNBOTTOM: NSLayoutConstraint!
    
    @IBOutlet var emailBOTTOM: NSLayoutConstraint!
    
    @IBOutlet var textBoxBOTTOM: NSLayoutConstraint!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var userID = NSString()
    
    @IBOutlet weak var textBox: UITextView!
    
    @IBOutlet weak var sendBTN: UIButton!
    @IBOutlet weak var social1BTN: UIButton!
    
    @IBOutlet weak var social2BTN: UIButton!
    @IBOutlet weak var emailAddressTXT: UITextField!
    
    var fbURL = URL(string: "fb://facebook.com/MyPicsAndQuotes")!
    var fbURLWeb = URL(string: "https://www.facebook.com/MyPicsAndQuotes")!
    
    @IBOutlet var issueLBL: UILabel!
    
    var username = NSString()
   // @IBOutlet weak var social3BTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
            textBox.text = "Tell us your thoughts..."
            textBox.textColor = UIColor.lightGray
            textBox.textAlignment = .center
        
        
        
        self.title = "Contact Us"
        
        if let font = UIFont(name: "DK Cool Crayon", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        
        let prefs:UserDefaults = UserDefaults.standard
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
        } else  {
            print("username Error")
            
            username = ""
            userID = ""
            
        }
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
            
            //UIColor(red: 0.572, green: 0.882, blue: 0.949, alpha: 0.1)
        
       // sendBTN.layer.borderWidth = 2
       // sendBTN.layer.borderColor = UIColor.whiteColor().CGColor
        
        textBox.layer.cornerRadius = 10
        
        sendBTN.layer.cornerRadius = 10
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ContactViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(ContactViewController.keyboardWasShown(_:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(ContactViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        DoneBTN.layer.cornerRadius = 10
    }
   
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    @objc func keyboardWasShown(_ notification: Notification) {
        
        issueLBL.isHidden = true
        
        var info = (notification as NSNotification).userInfo!
        
        
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
          //  self.textBoxBOTTOM.constant = keyboardFrame.size.height + 10
            
            
            self.emailBOTTOM.constant = (keyboardFrame.size.height - 160) + 15
            
            
            //self.QuoteLabelTop.constant = 50
            //self.qbDoneBOTTOM.constant = (keyboardFrame.size.height + 5) + self.GameTitleTXT.frame.size.height
            
            self.DoneBTNBOTTOM.constant = keyboardFrame.size.height + 5
        })
        
        if textBox.text == "Tell us your thoughts..." {
            //if NewGameQuote.isEqualToString("Enter Your Quote Here") {
            //(StartSegment.subviews[0] as! UIView).tintColor = UIColor.greenColor()
            textBox.text = ""
            textBox.textColor = UIColor.black
            textBox.textAlignment = .center
        }
        
        
    }
    
    
    @objc func keyboardWillHide(_ notification: Notification) {
    issueLBL.isHidden = false
    
    var info = (notification as NSNotification).userInfo!
    
    
    var keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    
    
    UIView.animate(withDuration: 0.3, animations: { () -> Void in
    self.textBoxBOTTOM.constant = 5
        
        
     self.emailBOTTOM.constant = 10
    //self.QuoteLabelTop.constant = 50
    //self.qbDoneBOTTOM.constant = (keyboardFrame.size.height + 5) + self.GameTitleTXT.frame.size.height
    
    self.DoneBTNBOTTOM.constant = -100
    })
        
        if textBox.text.isEmpty || textBox.text == "Tell us your thoughts..." {
            //if NewGameQuote.isEqualToString("Enter Your Quote Here") {
            //(StartSegment.subviews[0] as! UIView).tintColor = UIColor.greenColor()
            textBox.text = "Tell us your thoughts..."
            textBox.textColor = UIColor.lightGray
            textBox.textAlignment = .center
        }
               
    
    }
    
    @objc func DismissKeyboard(){
        
        /*
        if GameTitleTXT.text.isEmpty {
        GameTitleBTN.layer.backgroundColor = UIColor(red: 0.99, green: 0.69, blue: 0.35, alpha: 1.0).CGColor
        
        } else  {
        GameTitleBTN.layer.backgroundColor = UIColor.greenColor().CGColor
        }
        */
        
        view.endEditing(true)
    }
    
    @IBAction func SendMessage(_ sender: AnyObject) {
        
        
        if Reachability.isConnectedToNetwork() {

        
        
        if username.isEqual(to: "") || userID.isEqual(to: "") {
            
            DispatchQueue.main.async(execute: {
                
                
                let Alert2 = SCLAlertView()
                
                // if WasProfileUpdated {
                Alert2.addButton("Ok", action: {
                    
                    
                })
                
                Alert2.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Center", subTitle: "We're having trouble verifying your username.  Please try logging into game center from the home menu", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
        } else {
        
       // var emailTo = "jaredstevens10@yahoo.com"
        
        var emailTo: NSString = emailAddressTXT.text! as NSString
        
        let messageTo: NSString = textBox.text as NSString
        
        if messageTo.isEqual(to: "") || messageTo.isEqual(to: "Tell us your thoughts...") {
            
            //let AC = JSController("Missing Message", MyMessage: "Please enter your message to us in the text box above",Color: "Red")
           // self.presentViewController(AC, animated: true, completion: nil)
            
            DispatchQueue.main.async(execute: {

            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Missing Message", subTitle: "Please enter your message to us in the text box above", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            })
            
            
        } else {
            
            if emailTo.isEqual(to: "") {
                emailTo = "na@clavensolutions.com"
            }
      
          let SentResults = SendMessage(emailTo, username: username, message: messageTo)
            
            if SentResults {
               // let AC = JSController("Message Sent", MyMessage: "Your message was successfully sent",Color: "Green")
               // self.presentViewController(AC, animated: true, completion: nil)
                
                
                
                DispatchQueue.main.async(execute: {
                    
                    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Message Sent", subTitle: "Your message was successfully sent", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                })

                
                
                
                textBox.text = "Tell us your thoughts..."
                textBox.textAlignment = .center
                emailAddressTXT.text = ""
            } else {
               // let AC = JSController("Error", MyMessage: "There was an error sending your message, please check your network settings and try again",Color: "Red")
                //self.presentViewController(AC, animated: true, completion: nil)
            
                DispatchQueue.main.async(execute: {
                    
                    SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "There was an error sending your message, please check your network settings and try again", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                })

                
            
            }
     }
            
     }
            
        }
        else
        {
            
            
            
            DispatchQueue.main.async(execute: {
                
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Connection Error!", subTitle: "Check your network settings", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SendMessage (_ email: NSString, username: NSString, message: NSString) -> Bool {
        
        let post:NSString = "username=\(username)&message=\(message)&email=\(email)" as NSString
        var sentResult = Bool()
        
       //NSLog("PostData: %@",post);
        
        let url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/ContactUs.php")!
        
        let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
        
        let postLength:NSString = String( postData.count ) as NSString
        
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postData
        request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        var reponseError: NSError?
        var response: URLResponse?
        
        var urlData: Data?
        do {
            urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
        } catch let error as NSError {
            reponseError = error
            urlData = nil
        }
        
        if ( urlData != nil ) {
            let res = response as! HTTPURLResponse!;
            
           //NSLog("Response code: %ld", res?.statusCode);
            
            if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
            {
                let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
                
               //NSLog("Response ==> %@", responseData);
                
                var error: NSError?
                
                let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
                
                
                let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
                
                //[jsonData[@"success"] integerValue];
                
               //NSLog("Success: %ld", success);
                
                if(success == 1)
                {
                   //NSLog("Sign Up SUCCESS");
                    sentResult = true
                    //  self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    sentResult = false
                }
                
            } else {
                sentResult = false
            }
        }  else {
            sentResult = false
        }
        return sentResult
    }
    
    @IBAction func facebookBTN(_ sender: AnyObject) {
        
        //UIApplication.tryURL(["fb://facebook.com/MyPicsAndQuotes","http://www.facebook.com/MyPicsAndQuotes"])
        UIApplication.tryURL(["","http://www.facebook.com/MyPicsAndQuotes"])
    }
    
    
    
    @IBAction func twitterBTN(_ sender: AnyObject) {
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            // 2
            let tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            // 3
            tweetSheet?.setInitialText("@MyPicsAndQuotes ")
            //  tweetSheet.addImage(imageView.image)
            
            // 4
            self.present(tweetSheet!, animated: true, completion: nil)
        } else {
            // 5
            print("error")
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
