//
//  LoginViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/9/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import GameKit

//@available(iOS 9.0, *)
class LoginViewController: UIViewController {
    @IBOutlet weak var logo: UIImageView!
    
    var NotFirstLaunch = false
    
    @IBOutlet weak var loginMessage: UILabel!
    var LoggedIn = Bool()
    @IBOutlet weak var laterButton: UIButton!
    var FromMyGames = Bool()
    var FromMyTurns = Bool()
    var FromNewGame = Bool()
    var FromAllPlayers = Bool()
    var FromFollowingTurns = Bool()
    
    var FromSettings = Bool()
   // var FromMyTurns = Bool()
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var resetPassword: UIButton!
    
    @IBOutlet weak var currentPlayerLBL: UILabel!
    
    
    var Admin = NSString()
    var Email = NSString()
    var username = NSString()
    
    var gcEnabled = Bool()
    var user = NSString()
    
    var localPlayer = GKLocalPlayer()
    
    @IBOutlet weak var resetPW: UIButton!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    var player = NSString()
    var playerid = NSString()
    
    let prefs:UserDefaults = UserDefaults.standard
    
    var password = NSString()
    var player_login = NSString()
    var player_id = NSString()
    var deviceToken = Data()
    var deviceToken2 = NSString()
    var deviceToken3 = Data()
    var dt = Data()
    var FinalToken = NSString()
    var privacy = NSString()
    
  //  @IBOutlet weak var cancelBTN: UIButton!
    
    
    @IBAction func cancelBTN(_ sender: AnyObject) {
        
        if FromMyGames {
            prefs.set("MYGAMES", forKey: "LOGINSENTFROM")
        }
        
        if FromMyTurns {
            prefs.set("MYTURNS", forKey: "LOGINSENTFROM")
        }
        
        if FromNewGame {
            prefs.set("NEWGAME", forKey: "LOGINSENTFROM")
            
        }
        
        if FromFollowingTurns {
            prefs.set("FOLLOWINGPEOPLE", forKey: "LOGINSENTFROM")
            
        }
        
       
        
        prefs.set(true, forKey: "LOGINLATER")
        prefs.set(false, forKey: "ISLOGGEDIN")
        prefs.setValue("guest", forKey: "USERNAME")
        prefs.setValue("guest", forKey: "PLAYERID")
        
        
        if FromSettings {
            
            
            
            DispatchQueue.main.async(execute: {
                
                
                
                self.performSegue(withIdentifier: "restart", sender: self)
                
                
                
                //theAlert.dismissViewControllerAnimated(false, completion: nil)
                // UIApplication.sharedApplication().keyWindow?.rootViewController?.dismissViewControllerAnimated(false, completion: nil)
              //  self.IsHandlingAlertMessage = false
                // theAlert.removeFromParent()
                print("about to dismiss the root view controller????")
                
                
              //  UIApplication.sharedApplication().keyWindow?.makeKeyAndVisible()
                
                
                
                
                /*
                self.dismissViewControllerAnimated(false, completion: {
                    
                
                self.performSegueWithIdentifier("logout", sender: self)
                
                })
                */
                
                
                
                
                    //   UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self, animated: false, completion: nil)
                
                
                
                /*
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    UIApplication.sharedApplication().keyWindow?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
                   // UIApplication.sharedApplication().keyWindow?.rootViewController.
                })
                
                self.dismissViewControllerAnimated(false, completion: nil)
                print("DISMISSING THE SOFT ALERT SCREEN")
                
                */
                
               // self.TakeTurn()
            })
            
            
            
            
        } else {
            
            
            
        
        DispatchQueue.main.async(execute: {
        
        self.dismiss(animated: true, completion: nil)
            
        })
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginMessage.isHidden = true
        logo.isHidden = false
        
        if FromMyGames {
            loginMessage.isHidden = false
            logo.isHidden = true
        }
        
        if FromMyTurns {
            loginMessage.isHidden = false
            logo.isHidden = true
        }
        
        if FromNewGame {
            loginMessage.isHidden = false
            logo.isHidden = true

        }
        
        if FromFollowingTurns {
            loginMessage.isHidden = false
            logo.isHidden = true
            
        }
       
        
        let ShouldSkip = UserDefaults.standard.bool(forKey: "LOGINLATER")
        let ISLOGGEDIN = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
        
        print("Should Skip from Login VC = \(ShouldSkip)")
        
        if ISLOGGEDIN {
        print("IS LOGGED IN")
        
        print("Current Username = \(prefs.value(forKey: "USERNAME"))")
        print("Current playerID = \(prefs.value(forKey: "PLAYERID"))")
        print("Current email = \(prefs.value(forKey: "EMAIL"))")
            
        } else {
          print("IS NOT LOGGED IN")
           prefs.setValue("guest", forKey: "USERNAME")
           prefs.setValue("guest", forKey: "PLAYERID")
        prefs.setValue("guest", forKey: "EMAIL")
            
            print("Current Username = \(prefs.value(forKey: "USERNAME"))")
            print("Current playerID = \(prefs.value(forKey: "PLAYERID"))")
            print("Current email = \(prefs.value(forKey: "EMAIL"))")
            
        }
        /*
        self.LoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("ISLOGGEDIN")
        
        if LoggedIn {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        
        */
        
        
        resetPW.layer.masksToBounds = true
        resetPW.layer.cornerRadius = 20
        resetPW.clipsToBounds = true
        
       // txtEmail.hidden = true
       // resetPW.hidden = true
        
        //player = prefs.valueForKey("USERNAME") as! String
       // print("found Game player in login screent = \(player)")
        
      //  signupButton.layer.cornerRadius = 10
        loginButton.layer.cornerRadius = 40
        signupButton.layer.cornerRadius = 25
        laterButton.layer.cornerRadius = 25
        //cancelBTN.layer.cornerRadius = 10
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        
        
        
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        NotFirstLaunch = UserDefaults.standard.bool(forKey: "FirstLaunch")
        
        /*
        self.LoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("ISLOGGEDIN")
        
        if LoggedIn {
            self.dismissViewControllerAnimated(true, completion: nil)
        }

        
        */
        
   //     let p = localPlayer.alias
        
   //     print("player auth: \(self.localPlayer.authenticated)")
        
        
        
       // print("localPlayer = \(p)")
        
      //  print("found Game player in login screen = \(player)")
        
        
     //   currentPlayerLBL.text = "Current Game Center Player: \(player)"
        
        if prefs.value(forKey: "USERNAME") != nil {
        player = prefs.value(forKey: "USERNAME") as! String as NSString
        print("user name not nil, found Game player in login screen = \(player)")

        
       // currentPlayerLBL.text = "Current Game Center Player: \(player)"
        }
        
        
        
        if NotFirstLaunch {
            print("Not First Launch")
            
            
        } else {
            print("First Launch, setting NSUserDefault")
            // NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
            
            //self.performSegueWithIdentifier("goto_login", sender: self)
         self.performSegue(withIdentifier: "DemoGame", sender: self)
        //self.performSegueWithIdentifier("First_Load", sender: self)
        
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // #pragma mark - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    @IBAction func MergePlayer(_ sender: AnyObject) {
        
        let loginTest = GameLogin()
        
        //GameLogin()
        
        if loginTest {
        
        print("Player Login = \(player)")
        
        FinalToken = GetTokenInfo()
        
        SearchForMember(player as String, PlayerID: playerid as String)
            
        } else {
            print("did not get info back from player login with GameCenter")
        }
        
    }
    
    @IBAction func signinTapped(_ sender : UIButton) {
        username = "testuser"
       // var password:NSString = txtPassword.text
       // let username: NSString = txtUsername.text!
        let password: NSString = txtPassword.text! as NSString
        let email: NSString = txtEmail.text! as NSString
        
        
        var deviceToken3 = Data()
        
        if (prefs.value(forKey: "deviceToken") != nil) {
            deviceToken3 = prefs.value(forKey: "deviceToken") as! Data}
            
        else {
            print("error: DeviceToken was nil")
            // promptUserToRegisterPushNotifications()
            
            // let types = UIUserNotificationType.Alert | UIUserNotificationType.Sound | UIUserNotificationType.Badge
            // let settings = UIUserNotificationSettings(forTypes: types, categories: nil)
            // UIApplication.sharedApplication().registerUserNotificationSettings(settings)
            // UIApplication.sharedApplication().registerForRemoteNotifications()
            
            //application.
            //UIApplication.sharedApplication().registerForRemoteNotifications()
            //println("device token reprompted - \(deviceToken3)")
            // deviceToken3 = prefs.valueForKey("deviceToken") as! NSData
        }
        
        let TokenNew: NSString = deviceToken3.description.replacingOccurrences(of: " ", with: "") as NSString
        
        if ( email.isEqual(to: "") || password.isEqual(to: "") ) {
            
            DispatchQueue.main.async(execute: {
                
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "Please enter your username and password", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
        } else {
            
            let post:NSString = "username=\(username)&password=\(password)&email=\(email)&playerid=\(email)&token=\(TokenNew)" as NSString
            
           //NSLog("PostData: %@",post);
            
            let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/PQLogin.php")!
            
            print("URL entered")
            
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
                
              // //NSLog("Response code: %ld", res?.statusCode);
                
                if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
                {
                    let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
                    
                   //NSLog("Response ==> %@", responseData);
                    
                    var error: NSError?
                    
                    let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
                    
                    
                    let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
                    
                    //[jsonData[@"success"] integerValue];
                    
                   //NSLog("Success: %ld", success);
                    
                    //Admin = jsonData.valueForKey("admin") as! NSString
                    
                   
                    
                    if(success == 1)
                    {
                       //NSLog("Login SUCCESS");
                        
                        let prefs:UserDefaults = UserDefaults.standard
                        
                        //prefs.setObject(username, forKey: "USERNAME")
                        
                       // prefs.setInteger(1, forKey: "ISLOGGEDIN")
                        prefs.set(true, forKey: "ISLOGGEDIN")
                        prefs.synchronize()
                        
                        //  prefs.setValue(Admin, forKey: "ADMIN")
                        
                        Email = jsonData.value(forKey: "email") as! NSString
                        let theUsername = jsonData.value(forKey: "theusername") as! NSString
                        
                        print("the username =\(theUsername)")
                        prefs.setValue(Email, forKey: "EMAIL")
                        
                        prefs.setValue(theUsername, forKey: "USERNAME")
                        
                        prefs.setValue(Email, forKey: "PLAYERID")
                        
                        prefs.setValue("yes", forKey: "FOLLOWALERT")
                        prefs.setValue("yes", forKey: "LIKEFAILALERT")

                        
                        self.dismiss(animated: true, completion: nil)
                        print("sync view dismissed")
                        
                    } else {
                        var error_msg:NSString
                        
                        
                        if jsonData["error_message"] as? NSString != nil {
                            error_msg = jsonData["error_message"] as! NSString
                        } else {
                            error_msg = "Unknown Error"
                        }
                        
                        
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign in Failed!"
                        //alertView.message = "Sign in Error"
                        alertView.message = error_msg as String
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                       // alertView.show()
                        
                       // txtEmail.text = ""
                       // txt
                        
                        DispatchQueue.main.async(execute: {
                            
                            
                            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "\(error_msg)", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                            
                        })
                        
                        
                    }
                    
                } else {
                    DispatchQueue.main.async(execute: {
                        
                        
                        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "The Connection Failed", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                        
                    })
                }
            } else {
                
                DispatchQueue.main.async(execute: {
                    
                    
                    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "Please check your internet connection", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
                
            }
        }
        
    }
    
    
    @IBAction func ForgotPW(_ sender: AnyObject) {
        username = "testuser"
        // var password:NSString = txtPassword.text
        // let username: NSString = txtUsername.text!
        let password: NSString = txtPassword.text! as NSString
        let email: NSString = txtEmail.text! as NSString
        
        
        if ( email.isEqual(to: "") ) {
            
            DispatchQueue.main.async(execute: {
                
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "Please enter your email address", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
        } else {
            
            let post:NSString = "email=\(email)" as NSString
            
           //NSLog("PostData: %@",post);
            
            let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/reset.php")!
            
            print("URL entered")
            
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
                
              // //NSLog("Response code: %ld", res?.statusCode);
                
                if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
                {
                    let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
                    
                   //NSLog("Response ==> %@", responseData);
                    
                    var error: NSError?
                    
                    let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
                    
                    
                    let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
                    
                    //[jsonData[@"success"] integerValue];
                    
                   //NSLog("Success: %ld", success);
                    
                    //Admin = jsonData.valueForKey("admin") as! NSString
                    
                    
                    
                    if(success == 1)
                    {
                       //NSLog("Login SUCCESS");
                        
                        let prefs:UserDefaults = UserDefaults.standard
                        
                        //prefs.setObject(username, forKey: "USERNAME")
                        
                        DispatchQueue.main.async(execute: {
                            
                            
                            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Password", subTitle: "Please check your email for instructions to reset your password", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                            
                        })
                        
                        // prefs.setInteger(1, forKey: "ISLOGGEDIN")
                     //   prefs.setBool(true, forKey: "ISLOGGEDIN")
                    //    prefs.synchronize()
                        
                        //  prefs.setValue(Admin, forKey: "ADMIN")
                        
                      //  Email = jsonData.valueForKey("email") as! NSString
                        
                    //    prefs.setValue(Email, forKey: "EMAIL")
                        
                    //    prefs.setValue(username, forKey: "USERNAME")
                        
                    //    self.dismissViewControllerAnimated(true, completion: nil)
                        print("sync view dismissed")
                        
                    } else {
                        var error_msg:NSString
                        
                        
                        if jsonData["error_message"] as? NSString != nil {
                            error_msg = jsonData["error_message"] as! NSString
                        } else {
                            error_msg = "Unknown Error"
                        }
                        
                        
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign in Failed!"
                        //alertView.message = "Sign in Error"
                        alertView.message = error_msg as String
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        // alertView.show()
                        
                        // txtEmail.text = ""
                        // txt
                        
                        DispatchQueue.main.async(execute: {
                            
                            
                            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "\(error_msg)", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                            
                        })
                        
                        
                    }
                    
                } else {
                    DispatchQueue.main.async(execute: {
                        
                        
                        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "The Connection Failed", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                        
                    })
                }
            } else {
                
                DispatchQueue.main.async(execute: {
                    
                    
                    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "Please check your internet connection", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
                
            }
        }
        
    }
    
    
    
    @IBAction func resetisTapped(_ sender : UIButton) {
        
        let email_post:NSString = txtEmail.text! as NSString
        
        
        
        if ( email_post.isEqual(to: "") ) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Reset Failed!"
            alertView.message = "Please enter your Email Address"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
        } else {
            
            let post:NSString = "email=\(email_post)" as NSString
            
           //NSLog("PostData: %@",post);
            
            let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/reset.php")!
            
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
                
             //  //NSLog("Response code: %ld", res?.statusCode);
                
                if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
                {
                    let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
                    
                   //NSLog("Response ==> %@", responseData);
                    
                    var error: NSError?
                    
                    let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
                    
                    
                    let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
                    
                    //[jsonData[@"success"] integerValue];
                    
                   //NSLog("Success: %ld", success);
                    
                    //Admin = jsonData.valueForKey("admin") as! NSString
                    
                   // Email = jsonData.valueForKey("email") as! NSString
                    
                    if(success == 1)
                    {
                       //NSLog("Login SUCCESS");
                        
                        let prefs:UserDefaults = UserDefaults.standard
                        prefs.set(username, forKey: "USERNAME")
                        prefs.set(1, forKey: "ISLOGGEDIN")
                        prefs.synchronize()
                        
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Confirmation"
                        alertView.message = "An email has been sent to the email address you provided.  It will provide a link to reset your password"
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        alertView.show()
                        //  prefs.setValue(Admin, forKey: "ADMIN")
                        
                      //  prefs.setValue(Email, forKey: "EMAIL")
                        
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        var error_msg:NSString
                        
                        if jsonData["error_message"] as? NSString != nil {
                            error_msg = jsonData["error_message"] as! NSString
                        } else {
                            error_msg = "Unknown Error"
                        }
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Reset Failed!"
                        alertView.message = error_msg as String
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        alertView.show()
                        
                    }
                    
                } else {
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Reset Failed!"
                    alertView.message = "Connection Failed"
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                }
            } else {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Reset Failed!"
                alertView.message = "Connection Failure"
                if let error = reponseError {
                    alertView.message = (error.localizedDescription)
                }
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
            }
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    
    
    func GetTokenInfo() -> NSString {
        
        if (prefs.value(forKey: "deviceToken") != nil) {
            deviceToken3 = prefs.value(forKey: "deviceToken") as! Data}
            
        else {
            print("error: DeviceToken was nil")
           // promptUserToRegisterPushNotifications()
            
           // let types = UIUserNotificationType.Alert | UIUserNotificationType.Sound | UIUserNotificationType.Badge
           // let settings = UIUserNotificationSettings(forTypes: types, categories: nil)
           // UIApplication.sharedApplication().registerUserNotificationSettings(settings)
           // UIApplication.sharedApplication().registerForRemoteNotifications()

            //application.
            //UIApplication.sharedApplication().registerForRemoteNotifications()
            //println("device token reprompted - \(deviceToken3)")
           // deviceToken3 = prefs.valueForKey("deviceToken") as! NSData
        }
        
        let TokenNew: NSString = deviceToken3.description.replacingOccurrences(of: " ", with: "") as NSString
        
        print("Token New: \(TokenNew)")
        
        
        print("User's name is \(player)")
        print("Loging VC Device Token: \(deviceToken3)")
        
        return TokenNew
        
    }
    /*
    func promptUserToRegisterPushNotifications() {
        let types = UIUserNotificationType.Alert | UIUserNotificationType.Sound | UIUserNotificationType.Badge
        let settings = UIUserNotificationSettings(forTypes: types, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {

        NSUserDefaults.standardUserDefaults().setObject(deviceToken, forKey: "deviceToken")
        
    }
    */
    func SearchForMember (_ PLAYER: String, PlayerID: String) {
        
        password = "test123"
        // username.stringByReplacingOccurrencesOfString(" ", withString: "")
        let PlayerID2 = PlayerID.replacingOccurrences(of: ":", with: "")
        
        
        
        var user = self.localPlayer.alias
        
        let post:NSString = "username=\(PLAYER)&password=\(PlayerID2)" as NSString
        
       //NSLog("PostData: %@",post);
        
        let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/TelePictionaryLogin.php")!
        
        print("URL entered")
        
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
            
          // //NSLog("Response code: %ld", res?.statusCode);
            
            if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
            {
                let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
                
               //NSLog("Response ==> %@", responseData);
                
                var error: NSError?
                
                let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
                
                
                let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
                
                //[jsonData[@"success"] integerValue];
                
               //NSLog("Success: %ld", success);
                
                //Admin = jsonData.valueForKey("admin") as! NSString
                
                
                
                if(success == 1)
                {
                   //NSLog("Login SUCCESS");
                    
                    let prefs:UserDefaults = UserDefaults.standard
                    
                    //prefs.setObject(username, forKey: "USERNAME")
                    
                    prefs.set(1, forKey: "ISLOGGEDIN")
                    prefs.synchronize()
                    
                    //  prefs.setValue(Admin, forKey: "ADMIN")
                    
                  //  Email = jsonData.valueForKey("email") as! NSString
                    
                //    prefs.setValue(Email, forKey: "EMAIL")
                    
                    prefs.setValue(username, forKey: "USERNAME")
                    
                    
                    
                    self.dismiss(animated: true, completion: nil)
                } else {
                    
                    var error_msg:NSString
                    
                    print("Merging with Game Members: Token - \(deviceToken), player - \(PLAYER) ")
                    
                    var playerfound = "no"
                    MergeWithGameMembers(PLAYER as String, password: password as String, Token: FinalToken as String, PlayerID: playerid as String as String as NSString)
                    
                    /*
                    if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                    } else {
                    error_msg = "Unknown Error"
                    }
                    
                    
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign in Failed!"
                    //alertView.message = "Sign in Error"
                    alertView.message = error_msg as String
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                    */
                }
                
            } else {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign in Failed!"
                alertView.message = "Connection Failed"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
            }
        } else {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Connection Failure"
            if let error = reponseError {
                alertView.message = (error.localizedDescription)
            }
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
        }
    }
    
    
    
    func MergeWithGameMembers (_ username: String, password: String, Token: String, PlayerID: NSString) {
        
      //  var TokenNew: NSString = Token.description.stringByReplacingOccurrencesOfString(" ", withString: "")
        print("Token Old: \(Token)")
        
        let TokenNew2 = Token.replacingOccurrences(of: "<", with: "")
        let TokenNew = TokenNew2.replacingOccurrences(of: ">", with: "")
        let PlayerID2 = PlayerID.replacingOccurrences(of: ":", with: "")
        
        print("Token - Spaces Removed: \(TokenNew)")
        
        let emailaddress = "test123"
        privacy = "no"
        
        
        let post:NSString = "username=\(username)&password=\(PlayerID2)&c_password=\(PlayerID2)&token=\(TokenNew)&playerid=\(PlayerID)&email=\(emailaddress)&privacy=\(privacy)" as NSString
        
        
       //NSLog("PostData: %@",post);
        
        let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/TelePictionarySignup.php")!
        
        print("URL entered")
        
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
            
         //  //NSLog("Response code: %ld", res?.statusCode);
            
            if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
            {
                let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
                
               //NSLog("Response ==> %@", responseData);
                
                var error: NSError?
                
                let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
                
                
                let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
                
                //[jsonData[@"success"] integerValue];
                
               //NSLog("Success: %ld", success);
                
                //Admin = jsonData.valueForKey("admin") as! NSString
                
                
                
                if(success == 1)
                {
                   //NSLog("Login SUCCESS");
                    
                    let prefs:UserDefaults = UserDefaults.standard
                    
                    //prefs.setObject(username, forKey: "USERNAME")
                    
                    prefs.set(1, forKey: "ISLOGGEDIN")
                   // prefs.synchronize()
                    
                    //  prefs.setValue(Admin, forKey: "ADMIN")
                    
                    //Email = jsonData.valueForKey("email") as! NSString
                    
                   // prefs.setValue(Email, forKey: "EMAIL")
                    
                     prefs.setValue(username, forKey: "USERNAME")
                    
                     self.dismiss(animated: true, completion: nil)
                } else {
                    
                    
                    
                    var error_msg:NSString
                    
                    
                    if jsonData["error_message"] as? NSString != nil {
                        error_msg = jsonData["error_message"] as! NSString
                    } else {
                        error_msg = "Unknown Error"
                    }
                    
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign in Failed!"
                    //alertView.message = "Sign in Error"
                    alertView.message = error_msg as String
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                    
                }
                
            } else {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign in Failed!"
                alertView.message = "Connection Failed"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
            }
        } else {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Connection Failure"
            if let error = reponseError {
                alertView.message = (error.localizedDescription)
            }
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
        }
    }
    
    func GameLogin () -> Bool{
        
        var loginTrue = Bool()
        
//   -> {(NSString, NSString) {
        print("LoginVC - login called")
        //localPlayer = GKLocalPlayer.local
        
        self.localPlayer.authenticateHandler = {(ViewController: UIViewController?, error: Error?) -> Void in
            
            if ((ViewController) == nil) {
                print("view controller is nil")
            }
            
            
            if ((ViewController) != nil) {
                print("VC True")
                self.present(ViewController!, animated: true, completion: nil)
                
                
            } else if self.localPlayer.isAuthenticated {
                self.gcEnabled = true
                print("Player authenticated")
                
                //self.player = localPlayer.displayName
                self.playerid = self.localPlayer.playerID as NSString
                self.player = self.localPlayer.alias as NSString
                
                print("GC player: \(self.player)")
                print("GC playerid: \(self.playerid)")
                
                self.prefs.setValue(self.player, forKey: "USERNAME")
                self.prefs.setValue(self.playerid, forKey: "PLAYERID")
                loginTrue = true
                
            } else {
                self.gcEnabled = false
                print("Local player could not be authenticated, disableing game")
                print("Authentifcate error: \(error)")
                print("Player NOT authenticated")
                
                //self.player = ""
                loginTrue = false
                
                
            }
            
        }
        return loginTrue
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       // if segue.identifier == "login" {
            if let destination = segue.destination as? MyGamesViewController {
                print("seguing to My games from login test")
                //destination.FromMyGames = true
            }
      //  }
        
    }
    
}
