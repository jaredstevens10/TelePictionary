//
//  SignUpThreeViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 2/25/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class SignUpThreeViewController: UIViewController {
    
    @IBOutlet var txtEmail : UITextField!
    @IBOutlet weak var signupButton: UIButton!
    let prefs = UserDefaults.standard
    
    var token = Data()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmail.becomeFirstResponder()
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
    
    
    func CheckEmail(_ email: String) -> Bool {
        
            var isOk = Bool()
            
            var post:NSString = "playerid=\(email)&setting=checkemail" as NSString
            
            //NSLog("PostData: %@",post);
            
            var url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/PQSignUp.php")!
            
            var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            
            var postLength:NSString = String(postData.count) as NSString
            
            var request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            
            var reponseError: NSError?
            var response: URLResponse?
            
            //var urlData = NSData()
            
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
                    var responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
                    
                    //NSLog("Response ==> %@", responseData);
                    
                    var error: NSError?
                    
                    let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                    
                    
                    let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
                    
                  //  let uniqueIDtemp: NSInteger = jsonData.valueForKey("uniqueID") as! NSInteger
                  //  let uniqueID = uniqueIDtemp.description
                    //[jsonData[@"success"] integerValue];
                    
                    //NSLog("Success: %ld", success);
                    
                    if(success == 1)
                    {
                        isOk = true
                        print("Email is available")
                        
                        
                    } else {
                        
                        isOk = false
                        
                        /*
                        var error_msg:NSString
                        
                        if jsonData["error_message"] as? NSString != nil {
                            error_msg = jsonData["error_message"] as! NSString
                        } else {
                            error_msg = "Unknown Error"
                        }
                        var alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign Up Failed!"
                        alertView.message = error_msg as String
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        // alertView.show()
                        
                        dispatch_async(dispatch_get_main_queue(),{
                            
                            
                            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "\(error_msg)", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                            
                        })
                        */
                        
                    }
                    
                } else {
                    DispatchQueue.main.async(execute: {
                        
                        
                        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "The Connection Failed", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                        
                    })
                }
            }  else {
                DispatchQueue.main.async(execute: {
                    
                    
                    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "Please check your internet connection", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
            }
        
        
        return isOk
    }
    
    
    @IBAction func nextBTN(_ sender: AnyObject) {
        
        let email = txtEmail.text
        let email2: NSString = txtEmail.text! as NSString
        if !email2.isEqual(to: "") {
        if ((email?.contains("@")) != nil) {
            
             prefs.set(email, forKey: "EMAILADDRESS")
            
            
            
            
            
            if CheckEmail(email!) {
            
            
            
            
            
            self.performSegue(withIdentifier: "nextsegue", sender: self)
                
            } else {
                
               
                
                DispatchQueue.main.async(execute: {
                    
                    
                    SCLAlertView().showCustomOKSIGN(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Email", subTitle: "This Email address is already in use.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
            
            }
            
        } else {
            
            DispatchQueue.main.async(execute: {
                
                
                SCLAlertView().showCustomOKSIGN(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Email", subTitle: "Please enter a valid email address", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
        }
            
        } else {
            
            DispatchQueue.main.async(execute: {
                
                
                SCLAlertView().showCustomOKSIGN(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Email", subTitle: "Please enter a valid email address", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
        }
        
    }
   
    /*
    @IBAction func signupTapped(sender : UIButton) {
        
        let Token = self.token
        let TokenNew2 = Token.description.stringByReplacingOccurrencesOfString("<", withString: "")
        let TokenNew3 = TokenNew2.stringByReplacingOccurrencesOfString(">", withString: "")
        let TokenNew = TokenNew3.stringByReplacingOccurrencesOfString(" ", withString: "")
        
       // var firstname:NSString = txtFirstname.text! as NSString
       // var lastname:NSString = txtLastname.text! as NSString
       // var username:NSString = txtUsername.text! as NSString
       // var password:NSString = txtPassword.text! as NSString
       // var confirm_password:NSString = txtConfirmPassword.text! as NSString
        
        var email:NSString = txtEmail.text! as NSString
        
        if ( username.isEqualToString("") || password.isEqualToString("") || firstname.isEqualToString("") || lastname.isEqualToString("") ) {
            
            dispatch_async(dispatch_get_main_queue(),{
                
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "Please complete all the fields.", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                
            })
        } else if ( !password.isEqual(confirm_password) ) {
            
            dispatch_async(dispatch_get_main_queue(),{
                
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "The passwords do not match", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                
            })
        } else {
            
            var base64Image = String()
            
            if ProfilePictureAdded {
                let image = self.ProfileImage.image
                
                let imageData = UIImageJPEGRepresentation(image!, 1.0)
                
                
                if MediaType == "gif" {
                    
                    base64Image = gifNSData.base64EncodedStringWithOptions([])
                    
                } else {
                    
                    base64Image = imageData!.base64EncodedStringWithOptions([])
                    
                }
                DoUpload = true
            }
            
            
            var post:NSString = "username=\(username)&password=\(password)&c_password=\(confirm_password)&email=\(email)&token=\(TokenNew)&playerid=\(email)&privacy=no"
            
            //NSLog("PostData: %@",post);
            
            var url:NSURL = NSURL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/PQSignUp.php")!
            
            var postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
            
            var postLength:NSString = String( postData.length )
            
            var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            
            var reponseError: NSError?
            var response: NSURLResponse?
            
            //var urlData = NSData()
            
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
                    var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    
                    //NSLog("Response ==> %@", responseData);
                    
                    var error: NSError?
                    
                    let jsonData:NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers)) as! NSDictionary
                    
                    
                    let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                    
                    let uniqueIDtemp: NSInteger = jsonData.valueForKey("uniqueID") as! NSInteger
                    let uniqueID = uniqueIDtemp.description
                    //[jsonData[@"success"] integerValue];
                    
                    //NSLog("Success: %ld", success);
                    
                    if(success == 1)
                    {
                        //NSLog("Sign Up SUCCESS");
                        prefs.setBool(true, forKey: "ISLOGGEDIN")
                        
                        
                        if MediaType == "gif" {
                            
                            UploadGameFileData(base64Image as String, FileName: "player\(uniqueID)", Type: "gif")
                            
                        } else {
                            
                            print("SHOULD UPLOAD IMAGE NOW")
                            print("BASE 64 DATA IS = \(base64Image)")
                            UploadGameFileData(base64Image as String, FileName: "player\(uniqueID)", Type: "image")
                        }
                        
                        
                        
                        
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        var error_msg:NSString
                        
                        if jsonData["error_message"] as? NSString != nil {
                            error_msg = jsonData["error_message"] as! NSString
                        } else {
                            error_msg = "Unknown Error"
                        }
                        var alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign Up Failed!"
                        alertView.message = error_msg as String
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        // alertView.show()
                        
                        dispatch_async(dispatch_get_main_queue(),{
                            
                            
                            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "\(error_msg)", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                            
                        })
                        
                        
                    }
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(),{
                        
                        
                        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "The Connection Failed", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                        
                    })
                }
            }  else {
                dispatch_async(dispatch_get_main_queue(),{
                    
                    
                    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "Please check your internet connection", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                    
                })
            }
        }
        
    }
    
*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
