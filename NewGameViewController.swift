//
//  NewGameViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/9/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController, UIAlertViewDelegate, UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    let pickerData = ["No Limit","2:00","1:30","1:00","0:30","0:15","0:05","Unlimited"]
    
  //  @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var username = NSString()
    var myemail = NSString()
    
    var EmailInfo = [NSString]()
    var CellInfo = [NSString]()
    var NameInfo = [NSString]()
    var NumPlayers = Int()
    
    var Player1 = NSString()
    var Player2 = NSString()
    var Player3 = NSString()
    var Player4 = NSString()
    var Player5 = NSString()
    var Player6 = NSString()
    var Player7 = NSString()
    var Player8 = NSString()
    var Player9 = NSString()
    var Player10 = NSString()

    var Player1Email = NSString()
    var Player2Email = NSString()
    var Player3Email = NSString()
    var Player4Email = NSString()
    var Player5Email = NSString()
    var Player6Email = NSString()
    var Player7Email = NSString()
    var Player8Email = NSString()
    var Player9Email = NSString()
    var Player10Email = NSString()
    var TimeLimit = NSString()
    var TimeLimitPick = String()
    
    @IBOutlet weak var StartBTN: UIButton!
    
    @IBOutlet weak var QuoteDoneBTN: UIButton!
    @IBOutlet weak var GameNametxt: UITextField!
    @IBOutlet weak var QuoteBox: UITextView!
    @IBOutlet weak var turntimeBTN: UIButton!
    @IBAction func TimeLimitView(_ sender: AnyObject) {
        
   if pickerView.isHidden == true {
    pickerView.isHidden = false}
else if pickerView.isHidden == false {
    pickerView.isHidden = true
    }
}

    
    
    @IBAction func EnterQuoteBTN(_ sender: AnyObject) {
        
        if QuoteBox.isHidden == true {
        QuoteBox.isHidden = false
            QuoteDoneBTN.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                 self.turntimeBTN.center.y = self.turntimeBTN.center.y + 65
            })
            
         // turntimeBTN.center.y = turntimeBTN.center.y + 65
        } else if QuoteBox.isHidden == false {
           // QuoteBox.hidden = true
            QuoteDoneBTN.isHidden = true
            UIView.animate(withDuration: 0.3, animations: {
                self.turntimeBTN.center.y = self.turntimeBTN.center.y - 65
                self.DismissKeyboard()
            })
            QuoteBox.isHidden = true
        }
    }
    
    @IBAction func QuoteDoneBTN(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StartBTN.layer.cornerRadius = 10
        StartBTN.layer.borderWidth = 2
        StartBTN.layer.borderColor = UIColor.white.cgColor

        
        QuoteDoneBTN.layer.cornerRadius = 10
        QuoteDoneBTN.isHidden = true
        self.QuoteBox.delegate = self;
        
        self.GameNametxt.delegate = self;
        
        QuoteBox.isHidden = true
       // StartBTN.layer.cornerRadius = 20
       // turntimeBTN.center.y = turntimeBTN.center.y - 130
        pickerView.isHidden = true
        print("EMAIL ARRAY: \(EmailInfo)")
        
      
      //  pickerView.dataSource = self
        pickerView.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewGameViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let prefs:UserDefaults = UserDefaults.standard
        username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
        
        if prefs.value(forKey: "EMAIL") != nil {
              myemail = (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
        }
        NumPlayers = NameInfo.count
        
        // admin =
        /*
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
*/
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        TimeLimitPick = pickerData[row]
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData) //, attributes)
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }

    
    func GetTraitID(_ Traits: [Double]) -> Int {
        let UsedTrait = Int(arc4random_uniform(UInt32(Traits.count)))
        return UsedTrait
    }
    
    /*
    
    @IBAction func StartGame(sender: AnyObject) {
        
        switch TimeLimitPick {
        case "No Time Limit":
        TimeLimit = "00:00:00"
        case "2:00":
            TimeLimit = "02:00:00"
        case "1:30":
            TimeLimit = "01:30:00"
        case "1:00":
            TimeLimit = "01:00:00"
        case "0:30":
            TimeLimit = "00:30:00"
        case "0:15":
            TimeLimit = "00:15:00"
        case "0:05":
            TimeLimit = "00:05:00"
        case "Unlimited":
            TimeLimit = "9999999"
        default:
            TimeLimit = "00:00:00"
            
        }
        
        // username = txtUsername.text as NSString
        let GameName:NSString = GameNametxt.text!
        let Player1:NSString = NameInfo[0]
        
        Player1Email = myemail
        
        let te = "jaredstevens10@yahoo.com"
        let tc = "13214364915"
        
        if NumPlayers >= 2 {
             Player2 = NameInfo[1]
             Player2Email = EmailInfo[1]
                //.dataUsingEncoding(NSUTF8StringEncoding)
          //Player2Email = Player2EmailOld?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
            //Player2Cell = tc //CellInfo[1]

       // Player2Email = te
           
            
        } else {
             Player2 = "-"
           var Player2Email = "-"
            /*
            var Player2Email = Player2Emailstr.dataUsingEncoding(NSUTF8StringEncoding)
            Player2Email = Player2EmailOld?.base64EncodedStringWithOptions
(NSDataBase64EncodingOptions(rawValue: 0))
*/
            // Player2Cell = "-"
        }
        
        
        if NumPlayers >= 3 {
             Player3 = NameInfo[2]
           //  Player3Email = te //EmailInfo[2]
            Player3Email = tc //CellInfo[2]
            
        } else {
             Player3 = "-"
             Player3Email = "-"
          //  Player3Cell = "-"
        }
        
        
        if NumPlayers >= 4 {
           Player4 = NameInfo[3]
           Player4Email = te //EmailInfo[3]
           // Player4Cell = tc //CellInfo[3]
            
            
        } else {
           Player4 = "-"
           Player4Email = "-"
           // Player4Cell = "-"
        }
        
        if NumPlayers >= 5 {
           Player5 = NameInfo[4]
           Player5Email = te //EmailInfo[4]
         //   Player5Cell = tc //CellInfo[4]
            
        } else {
           Player5 = "-"
           Player5Email = "-"
          //  Player5Cell = "-"
        }
        
        if NumPlayers >= 6 {
           Player6 = NameInfo[5]
           Player6Email = te //EmailInfo[5]
           // Player6Cell = tc //CellInfo[5]
        } else {
           Player6 = "-"
           Player6Email = "-"
         //   Player6Cell = "-"
        }
        
        if NumPlayers >= 7 {
           Player7 = NameInfo[6]
           Player7Email = te //EmailInfo[6]
        //    Player7Cell = tc //CellInfo[6]
            
        } else {
           Player7 = "-"
           Player7Email = "-"
          //  Player7Cell = "-"
        }
        
        if NumPlayers >= 8 {
           Player8 = NameInfo[7]
           Player8Email = te //EmailInfo[7]
          //  Player8Cell = tc //CellInfo[7]
        } else {
           Player8 = "-"
           Player8Email = "-"
          //  Player8Cell = "-"
                    }
        
        if NumPlayers >= 9 {
           Player9 = NameInfo[8]
           Player9Email = te //EmailInfo[8]
          //  Player9Cell = tc //CellInfo[8]
        } else {
           Player9 = "-"
           Player9Email = "-"
         //   Player9Cell = "-"
        }
        
        if NumPlayers >= 10 {
           Player10 = NameInfo[9]
           Player10Email = te //EmailInfo[9]
          //  Player10Cell = tc //CellInfo[9]
        } else {
           Player10 = "-"
           Player10Email = "-"
          //  Player10Cell = "-"
        }
        
        
   
      
        
        
        let QuoteBoxtext:NSString = QuoteBox.text as NSString
        
        if ( GameName.isEqualToString("") || QuoteBoxtext.isEqualToString("") ) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "You Forgot!"
            alertView.message = "Please enter a Game Name and the first Quote"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else {
            
            let post_old:NSString = "GameName=\(GameName)&Player1=\(Player1)&Player2=\(Player2)&Player3=\(Player3)&Player4=\(Player4)&Player5=\(Player5)&Player6=\(Player6)&Player7=\(Player7)&Player8=\(Player8)&Player9=\(Player9)&Player10=\(Player10)&Turn1=\(QuoteBoxtext)&players=\(NumPlayers)&Player1Email=\(Player1Email)&Player2Email=\(Player2Email)&Player3Email=\(Player3Email)&Player4Email=\(Player4Email)&Player5Email=\(Player5Email)&Player6Email=\(Player6Email)&Player7Email=\(Player7Email)&Player8Email=\(Player8Email)&Player9Email=\(Player9Email)&Player10Email=\(Player10Email)&timelimit=\(TimeLimit)"
            
            let post = post_old.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            
            print("NEW POST STRING: \(post)")
            
            
            /*
&Player1Cell=\(Player1Cell)&Player2Cell=\(Player2Cell)&Player3Cell=\(Player3Cell)&Player4Cell=\(Player4Cell)&Player5Cell=\(Player5Cell)&Player6Cell=\(Player6Cell)&Player7Cell=\(Player7Cell)&Player8Cell=\(Player8Cell)&Player9Cell=\(Player9Cell)&Player10Cell=\(Player10Cell)
*/
           //NSLog("PostData: %@",post);
            
            let url:NSURL = NSURL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/NewGame.php")!
            
            let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
            
           // var postData:NSData = post.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            
            let postLength:NSString = String( postData.length )
            
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            
            var reponseError: NSError?
            var response: NSURLResponse?
            
            var urlData: NSData?
            do {
                urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            } catch let error as NSError {
                reponseError = error
                urlData = nil
            }
            
            if ( urlData != nil ) {
                let res = response as! NSHTTPURLResponse!;
                
               //NSLog("Response code: %ld", res.statusCode);
                
                if (res.statusCode >= 200 && res.statusCode < 300)
                {
                    let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    
                   //NSLog("Response ==> %@", responseData);
                    
                    var error: NSError?
                    
                    let jsonData:NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers )) as! NSDictionary
                    
                    
                    let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                    
                    //[jsonData[@"success"] integerValue];
                    
                   //NSLog("Success: %ld", success);
                    
                    if(success == 1)
                    {
                       //NSLog("Sign Up SUCCESS");
                        self.dismissViewControllerAnimated(true, completion: nil)
                        
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Success!"
                        alertView.message = "Your Game has been created.  Each player is getting a message now about the new game now."
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                        
                        GameNametxt.text = ""
                      //  Player1txt.text = ""
                     //   Player2txt.text = ""
                     //   Player3txt.text = ""
                      //Player4txt.text = ""
                        QuoteBox.text = ""
                        
                        
                    } else {
                        var error_msg:NSString
                        
                        if jsonData["error_message"] as? NSString != nil {
                            error_msg = jsonData["error_message"] as! NSString
                        } else {
                            error_msg = "Unknown Error"
                        }
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign Up Failed!"
                        alertView.message = error_msg as String
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                        
                    }
                    
                } else {
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign Up Failed!"
                    alertView.message = "Connection Failed"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
            }  else {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign in Failed!"
                alertView.message = "Connection Failure"
                if let error = reponseError {
                    alertView.message = (error.localizedDescription)
                }
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("Turn_Complete", sender: self)                        }
        print("Turn Complete Segue")
        
    }
    */
 

    
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func BackBTN(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
