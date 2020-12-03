//
//  SignUpViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/2/15.
//  Copyright (c) 2015 Jared Stevens. All rights reserved.
//

import UIKit
import AVFoundation
import GameKit
import AssetsLibrary
import Photos

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GKGameCenterControllerDelegate {

    var DoUpload = Bool()
    var gifNSData = Data()
    var MediaType = NSString()
    var email = NSString()
    var fullname = NSString()
    @IBOutlet weak var cancelButton: UIButton!
    var localPlayer = GKLocalPlayer.local
    var ProfilePictureAdded = Bool()
    @IBOutlet weak var ProfileImage: UIImageView!
    var ShootingPhoto = Bool()
    var ShowingProfileView = Bool()
    let prefs:UserDefaults = UserDefaults.standard
    var token = Data()
    @IBOutlet weak var signupButton: UIButton!
    
    let picker = UIImagePickerController()
    
   //  @IBOutlet var txtFirstname : UITextField!
   //  @IBOutlet var txtLastname : UITextField!
    @IBOutlet var txtUsername : UITextField!
    @IBOutlet var txtPassword : UITextField!
    @IBOutlet var txtConfirmPassword : UITextField!
    
  //  @IBOutlet var txtEmail : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullname = prefs.object(forKey: "FULLNAME") as! NSString
        email = prefs.object(forKey: "EMAILADDRESS") as! NSString
        
        MediaType = "image"
        
        if (self.prefs.value(forKey: "deviceToken") != nil)  {
            self.token  = self.prefs.value(forKey: "deviceToken") as! Data
            print("deviceToken not nil")
            print("token = \(self.token)")
        } else {
            print("DeviceToken IS nil")
        }
        
        picker.delegate = self
        
        txtUsername.becomeFirstResponder()
        signupButton.layer.cornerRadius = 40
        cancelButton.layer.cornerRadius = 25
        self.ProfileImage.layer.cornerRadius = 10
        self.ProfileImage.clipsToBounds = true
        self.ProfileImage.layer.masksToBounds = true
        self.ProfileImage.layer.borderWidth = 1
        self.ProfileImage.layer.borderColor = UIColor.white.cgColor
        self.ProfileImage.image = UIImage(named: "blankProfile.png")
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
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
    
    @IBAction func gotoLogin(_ sender : UIButton) {
        
        self.performSegue(withIdentifier: "backtostart", sender: self)
//        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func signupTapped(_ sender : UIButton) {
        
        let Token = self.token
        let TokenNew2 = Token.description.replacingOccurrences(of: "<", with: "")
        let TokenNew3 = TokenNew2.replacingOccurrences(of: ">", with: "")
        let TokenNew = TokenNew3.replacingOccurrences(of: " ", with: "")
        
      //  var firstname:NSString = txtFirstname.text! as NSString
     //   var lastname:NSString = txtLastname.text! as NSString
        let username:NSString = txtUsername.text! as NSString
        let password:NSString = txtPassword.text! as NSString
        let confirm_password:NSString = txtConfirmPassword.text! as NSString
        
     //   var email:NSString = txtEmail.text! as NSString
        
        if ( username.isEqual(to: "") || password.isEqual(to: "") ) {
            
            
        //}|| firstname.isEqualToString("") || lastname.isEqualToString("") ) {
            
            DispatchQueue.main.async(execute: {
                
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "Please enter a username and password.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
        } else if ( !password.isEqual(confirm_password) ) {
            
            DispatchQueue.main.async(execute: {
                
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "The passwords do not match", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
        } else {
            
            
            
            //self.SaveMyProfile()
            
            DispatchQueue.main.async(execute: {
                
                let theAlert = SCLAlertView()
                
                theAlert.addButton("Submit", action: {
                    self.SaveMyProfile(username, password: password, confirm_password: confirm_password, TokenNew: TokenNew as NSString)
                })
                
                theAlert.addButton("View Agreement", action: {
                    self.ShowingProfileView = true
                    DispatchQueue.main.async(execute: {
                        self.performSegue(withIdentifier: "ViewEULA", sender: self)
                        
                    })
                    
                })
                
                
                
                theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "User Agreement", subTitle: "With creating your user profile you are accepting the end user agreeement", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
            
            
        }
        
    }
    
    @IBAction func viewEULA(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "ViewEULA", sender: self)
    }
    
   
    
    func SaveMyProfile (_ username: NSString, password: NSString, confirm_password: NSString, TokenNew: NSString) {
        
            
            var base64Image = String()
            
            if ProfilePictureAdded {
                let image = self.ProfileImage.image
                
                //let imageData = UIImageJPEGRepresentation(image!, 1.0)
                let imageData = image!.jpegData(compressionQuality: 1.0)
                
                if MediaType == "gif" {
                    
                    base64Image = gifNSData.base64EncodedString(options: [])
                    
                } else {
                    
                   // base64Image = imageData!.base64EncodedString(options: [])
                    base64Image = imageData!.base64EncodedString(options: [])
                }
                DoUpload = true
            }
            
            
            var post:NSString = "username=\(username)&password=\(password)&c_password=\(confirm_password)&email=\(email)&token=\(TokenNew)&playerid=\(email)&privacy=no&setting=signup" as NSString
            
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
                    
                    let uniqueIDtemp: NSInteger = jsonData.value(forKey: "uniqueID") as! NSInteger
                    let uniqueID = uniqueIDtemp.description
                    //[jsonData[@"success"] integerValue];
                    
                    //NSLog("Success: %ld", success);
                    
                    if(success == 1)
                    {
                        //NSLog("Sign Up SUCCESS");
                        prefs.set(true, forKey: "ISLOGGEDIN")
                        prefs.setValue(username, forKey: "USERNAME")
                        prefs.setValue(email, forKey: "PLAYERID")
                        
                        
                        
                        
                        if MediaType == "gif" {
                            
                            UploadGameFileData(base64Image as String, FileName: "player\(uniqueID)", Type: "gif")
                            
                        } else {
                            
                            print("SHOULD UPLOAD IMAGE NOW")
                            print("BASE 64 DATA IS = \(base64Image)")
                            UploadGameFileData(base64Image as String, FileName: "player\(uniqueID)", Type: "image")
                        }
                        
                        DispatchQueue.main.async(execute: {
                            
                            self.performSegue(withIdentifier: "backtostart", sender: self)
                            // self.dismissViewControllerAnimated(true, completion: nil)
                        })
                        
                        
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
                        alertView.addButton(withTitle: "OK")
                        // alertView.show()
                        
                        DispatchQueue.main.async(execute: {
                            
                            
                            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "\(error_msg)", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                            
                        })
                        
                        
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
        }
    
    
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    
    
    
    
    @IBAction func photoFromLibary(_ sender: AnyObject) {
        
        print("photo from library")
        self.picker.allowsEditing = false //2
        self.picker.sourceType = .photoLibrary //3
        self.picker.modalPresentationStyle = .popover
        self.present(self.picker, animated: true, completion: nil)//4
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage //2
        
        ShowingProfileView = true
        
        ProfileImage.contentMode = .scaleAspectFit //3
        // myImageView.image = chosenImage
        ProfileImage.image = chosenImage//4
        ProfilePictureAdded = true
        //  (StartSegment.subviews[0] ).tintColor = UIColor(red: 0.4, green: 1, blue: 0.69, alpha: 1.0)
        
        print("Picture add = \(ProfilePictureAdded)")
        
        
        print("image picked")
        
        /*
        if UserFirstName.isEqualToString("") || UserLastName.isEqualToString("") {
            
            ProfileLoadLBL.text = "Waiting for input..."
            
        } else {
            
            ProfileLoadLBL.text = "Tap 'Submit' to continue"
        }
        
        */
        
        
        self.dismiss(animated: true, completion: nil)
        
        /*{
        if self.ShootingPhoto {
        
        print("CAMERA DISMISSED")
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
        
        
        self.ViewProfile.center.y = self.ViewProfile.center.y + 1000
        
        self.ViewProfileTOP.constant = 0
        
        // self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
        
        //   self.greatJobBOTTOM.constant = 15
        
        
        })
        }
        
        })
        */
        //5
        
        
    }
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        ShowingProfileView = true
        
        
        
        dismiss(animated: true, completion: nil)
        print("image picker cancelled")
        
        
        
        
    }
    
    @IBAction func shootPhoto(_ sender: AnyObject)  {
        
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.cameraCaptureMode = .photo
            present(picker, animated: true, completion: nil)
            // mainImageView.image =
            
            self.ShootingPhoto = true
            self.ShowingProfileView = true
        } else {
            noCamera()
        }
        
    }
    
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController)
    {
        gameCenterViewController.dismiss(animated: true, completion: nil)
        
       // IsPlayerLoggedIn = LogIntoGameCenter()
        
        //print("After GCVC Did Finish, is player logged in = \(IsPlayerLoggedIn)")
        
    }
    
}


