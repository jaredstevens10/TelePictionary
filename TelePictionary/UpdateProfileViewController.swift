//
//  UpdateProfileViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 2/5/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class UpdateProfileViewController: UIViewController {

     let prefs:UserDefaults = UserDefaults.standard
    @IBOutlet weak var ProfileSkipBTN: UIButton!
    
    @IBOutlet weak var dobPicker: UIDatePicker!
    var UserDOB = NSString()
    @IBOutlet weak var dobView: UIView!
    @IBOutlet weak var dobPickerTOP: NSLayoutConstraint!
    
    
    var UserFirstName = NSString()
    var UserLastName = NSString()
    
    @IBOutlet weak var ProfileFirstNameTXT: UITextField!
    @IBOutlet weak var ProfileLastNameTXT: UITextField!
 @IBOutlet weak var ProfileSubmitBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        dobPicker.setDate(NSDate(), animated: true)
        dobPicker.maximumDate = NSDate()
        dobPicker.datePickerMode = UIDatePickerMode.Date
        pickerDoneButton.addTarget(self, action: Selector("dismissPicker"), forControlEvents: UIControlEvents.TouchUpInside)
*/
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)

        
        NotificationCenter.default.addObserver(self, selector: Selector("keyboardWasShown:"), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: Selector("keyboardWillHide:"), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    
    func textFieldDidChangeBegin(textField: UITextField) {
    print("textFieldChange1")
    
    // qbDoneBTN.hidden = false
    
    //EditingGameTitle = true
    print("Turned On EditingGameTitle")
    
    UIView.animateWithDuration(0.3, animations: { () -> Void in
    
    self.dobView.center.y = self.dobView.center.y - 1000
    
    self.dobPickerTOP.constant = 200
    // self.QuoteBoxBottom.constant = keyboardFrame.size.height + 20
    // self.QuoteLabelTop.constant = 50
    //   self.qbDoneBOTTOM.constant = self.QuoteBoxBottom.constant + 20
    
    // self.qbDoneBOTTOM.constant = -(self.view.frame.height) + 100
    })
    
    
    if !EditingDOB {
    print("Game Title Changed begin false")
    
    
    } else {
    print("Game Title Changed begin true")
    
    
    }
    print("bottom textfieldchange1")
    }
    
    func textFieldDidChangeEnd(textField: UITextField) {
    
    //qbDoneBTN.hidden = true
    
    
    
    UIView.animateWithDuration(0.3, animations: { () -> Void in
    // self.QuoteBoxBottom.constant = keyboardFrame.size.height + 20
    // self.QuoteLabelTop.constant = 50
    //self.qbDoneBOTTOM.constant = -100
    })
    
    
    
    if EditingDOB {
    print("Game Title Changed end true")
    
    
    } else {
    
    
    }
    }
    
    func dismissPicker ()
    {
    UIView.animateWithDuration(0.4, animations: {
    
    self.dobView.center.y = self.dobView.center.y + 1000
    
    self.dobPickerTOP.constant = 1200
    
    // self.pickerContainer.frame = CGRectMake(0.0, 50, 320.0, 300.0)
    
    let dateFormatter = NSDateFormatter()
    let dateFormatterTWO = NSDateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    dateFormatterTWO.dateFormat = "yyyy-MM-dd"
    self.UserDOB = dateFormatterTWO.stringFromDate(self.dobPicker.date)
    self.prefs.setValue(self.UserDOB, forKey: "DOBSQL")
    
    let tempDate = dateFormatter.stringFromDate(self.dobPicker.date)
    self.prefs.setValue(tempDate, forKey: "DOBUI")
    
    print("UserDOb formater two = \(self.UserDOB)")
    
    self.dobTXT.text = dateFormatter.stringFromDate(self.dobPicker.date)
    // self.selectedDate.setTitle(dateFormatter.stringFromDate(self.picker.date), forState: UIControlState.Normal)
    
    
    })
    }
    
    */
    
    /*
    
    
    @IBAction func DismissCreateIDBTN(sender: AnyObject) {
    
    UserFirstName = ProfileFirstNameTXT.text!
    UserLastName = ProfileLastNameTXT.text!
    //UserDOB = dobTXT.text!
    
    
    let GCReady = NSUserDefaults.standardUserDefaults().boolForKey("GameCenterEnabled")
    
    
    
    //if self.user == "" {
    
    if !GCReady {
    
    
    
    dispatch_async(dispatch_get_main_queue(), {
    print("waited for Game center to catch up")
    
    
    print("couldn't creat user because game center username is blank")
    
    //green - UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
    //blue - UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0)
    //red - UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0)
    
    
    
    
    let Alert = SCLAlertView()
    Alert.addButton("Try Logging in again", action: {
    
    
    
    
    self.IsPlayerLoggedIn = self.LogIntoGameCenter()
    
    
    dispatch_async(dispatch_get_main_queue(), {
    self.actIndTwo.hidden = false
    self.actIndTwo.startAnimating()
    
    self.user = self.GameLogin()
    
    
    dispatch_async(dispatch_get_main_queue(), {
    
    
    let GCReadyTwo = NSUserDefaults.standardUserDefaults().boolForKey("GameCenterEnabled")
    
    
    dispatch_async(dispatch_get_main_queue(), {
    
    if !GCReadyTwo {
    
    // if self.user == "" {
    print("User is still blank")
    
    // self.actIndTwo.hidden = true
    // self.actIndTwo.stopAnimating()
    
    
    } else {
    
    //  self.actIndTwo.hidden = true
    //  self.actIndTwo.stopAnimating()
    /*
    
    dispatch_async(dispatch_get_main_queue(), {
    
    if !self.ShowingProfileView {
    
    UIView.animateWithDuration(0.5, animations: { () -> Void in
    
    
    self.ViewProfile.center.y = self.ViewProfile.center.y - 1000
    
    self.ViewProfileTOP.constant = -64
    
    // self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
    
    //   self.greatJobBOTTOM.constant = 15
    
    
    })
    
    self.ShowingProfileView = true
    }
    
    })
    
    */
    
    }
    
    })
    
    })
    
    })
    
    })
    
    Alert.addButton("Try again later", action: {
    
    
    dispatch_async(dispatch_get_main_queue(), {
    
    
    let Alert2 = SCLAlertView()
    
    // if WasProfileUpdated {
    Alert2.addButton("Ok", action: {
    
    
    //self.greatJobLBL.text = "
    dispatch_async(dispatch_get_main_queue(), {
    
    UIView.animateWithDuration(0.5, animations: { () -> Void in
    
    
    self.ViewProfile.center.y = self.ViewProfile.center.y + 1000
    
    self.ViewProfileTOP.constant = 936
    
    // self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
    
    //   self.greatJobBOTTOM.constant = 15
    
    
    })
    
    
    
    
    if !self.DismissProfileView {
    UIView.animateWithDuration(1.0, animations: { () -> Void in
    
    
    self.ViewWelcome3BTN.center.y = self.ViewWelcome3BTN.center.y - 100
    
    self.ViewWelcomeBTN3BOTTOM.constant = 0
    
    self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
    
    self.greatJobBOTTOM.constant = 15
    
    
    })
    }
    
    self.DismissProfileView = true
    //  })
    //   }
    })
    
    })
    
    Alert2.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Center", subTitle: "Without creating your Username you will be unable to create a new game.", duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
    
    })
    
    
    })
    
    Alert.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Game Center", subTitle: "We're still having trouble logging you into game center.  Please log in now", duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
    
    
    
    })
    
    
    
    } else {
    
    
    
    
    
    if !ProfilePictureAdded  {
    
    //let AC = JSController("Missing Image or Quote", MyMessage: "You forgot to enter your first quote or select an image.",Color: "Red")
    //  self.presentViewController(AC, animated: true, completion: nil)
    
    //alertView.show()
    //  exit(0)
    //return
    
    } else {
    
    
    print("Converting Picture")
    
    UIGraphicsBeginImageContext(ProfileImage.bounds.size)
    ProfileImage.image?.drawInRect(CGRect(x: 0, y: 0,
    width: ProfileImage.frame.size.width, height: ProfileImage.frame.size.height))
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    
    
    
    let smallImage = ProfileImage.image!.resize(0.5)
    
    
    let imageData = UIImageJPEGRepresentation(smallImage, 0.6)
    
    ProfileImageFinal = imageData!.base64EncodedStringWithOptions([])
    
    
    //  prefs.setValue(NewGamePictureData, forKey: "PICTUREDATAD")
    
    }
    
    
    if UserFirstName.isEqualToString("") || UserLastName.isEqualToString("") {
    let AC = JSController("Missing Info", MyMessage: "You forgot to enter your first name or last name.",Color: "Red")
    //  self.presentViewController(AC, animated: true, completion: nil)
    
    dispatch_async(dispatch_get_main_queue(), {
    
    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Missing Info", subTitle: "You forgot to enter your first name or last name.", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
    
    })
    
    } else {
    
    
    if UserDOB.isEqualToString("") {
    
    
    dispatch_async(dispatch_get_main_queue(), {
    
    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Missing Info", subTitle: "You forgot to enter your date of birth", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
    
    })
    
    } else {
    
    let DeviceH = self.view.frame.height
    let middleScreenY = DeviceH / 2
    let middleY = middleScreenY - 200
    
    
    var WasProfileUpdated = UpdateUserProfile()
    /*
    print("setting up user ID with game center")
    user = GameLogin()
    print("The NEW Player Name is \(user)")
    
    
    if user == "" {
    print("couldn't creat user because game center username is blank")
    } else {
    print("created username for game")
    }
    */
    // let AC = JSController("", MyMessage: "Coming Soon",Color: "Red")
    
    
    //  self.presentViewController(AC, animated: true, completion: {
    
    if WasProfileUpdated {
    
    
    UIView.animateWithDuration(0.5, animations: { () -> Void in
    
    
    self.ViewProfile.center.y = self.ViewProfile.center.y + 1000
    
    self.ViewProfileTOP.constant = 936
    
    // self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
    
    //   self.greatJobBOTTOM.constant = 15
    
    
    })
    
    
    
    
    if !DismissProfileView {
    UIView.animateWithDuration(1.0, animations: { () -> Void in
    
    
    self.ViewWelcome3BTN.center.y = self.ViewWelcome3BTN.center.y - 100
    
    self.ViewWelcomeBTN3BOTTOM.constant = 0
    
    self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
    
    self.greatJobBOTTOM.constant = 15
    
    
    })
    }
    self.menuButton.enabled = true
    self.revealViewController().panGestureRecognizer().enabled = true
    ShowingProfileView = false
    DismissProfileView = true
    //  })
    } else {
    let AC = JSController("Error Saving", MyMessage: "Error saving profile, please try again.",Color: "Red")
    //  self.presentViewController(AC, animated: true, completion: nil)
    
    
    dispatch_async(dispatch_get_main_queue(), {
    
    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error Saving", subTitle: "Error saving profile, please try again.", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
    
    })
    
    }
    
    }
    }
    
    }
    
    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "ProfileSet")
    
    
    }
    
    func UpdateUserProfile() -> Bool {
    var ProfileUsername = NSString()
    var ProfileUserID = NSString()
    
    var ProfileToken = NSData()
    
    var UpdatedPro = Bool()
    
    ProfileToken  = prefs.valueForKey("deviceToken") as! NSData
    // print("deviceToken not nil")
    print("token = \(token)")
    
    
    // let Token = ProfileToken
    let TokenNew2 = ProfileToken.description.stringByReplacingOccurrencesOfString("<", withString: "")
    let TokenNew3 = TokenNew2.stringByReplacingOccurrencesOfString(">", withString: "")
    let TokenNew = TokenNew3.stringByReplacingOccurrencesOfString(" ", withString: "")
    
    
    if (prefs.valueForKey("USERNAME") != nil)
    {
    ProfileUsername = self.prefs.valueForKey("USERNAME") as! NSString as String
    ProfileUserID = self.prefs.valueForKey("PLAYERID") as! NSString as String            //   myID = prefs.valueForKey("PLAYERID") as! NSString as String
    print("Myid = \(ProfileUserID)")
    print("username not nil")
    }
    var email = "test123@\(ServerInfo.sharedInstance)"
    var privacy = "no"
    var password = "NA"
    
    var post_old = "username=\(ProfileUsername)&playerid=\(ProfileUserID)&firstname=\(UserFirstName)&lastname=\(UserLastName)&token=\(TokenNew)email=\(email)&privacy=\(privacy)&password=\(password)&dob=\(self.UserDOB)"
    
    print("POST OLD DATA = \(post_old)")
    
    
    
    var post = post_old.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
    
    
    
    post = ("\(post)&ImageData=\(ProfileImageFinal)")
    
    
    // progressHUD.removeFromSuperview()
    //  progressHUD = ProgressHUD(text: "Saving Game Data...")
    //  self.view.addSubview(progressHUD)
    
    
    print("NEW POST STRING: \(post)")
    
    
    /*
    &Player1Cell=\(Player1Cell)&Player2Cell=\(Player2Cell)&Player3Cell=\(Player3Cell)&Player4Cell=\(Player4Cell)&Player5Cell=\(Player5Cell)&Player6Cell=\(Player6Cell)&Player7Cell=\(Player7Cell)&Player8Cell=\(Player8Cell)&Player9Cell=\(Player9Cell)&Player10Cell=\(Player10Cell)
    */
    //NSLog("PostData: %@",post);
    
    let url:NSURL = NSURL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/UpdateUserProfile.php")!
    
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
    
    //var error: NSError?
    
    let jsonData:NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers )) as! NSDictionary
    
    
    let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
    
    //[jsonData[@"success"] integerValue];
    
    //NSLog("Success: %ld", success);
    
    if(success == 1)
    {
    UpdatedPro = true
    //NSLog("New Game SUCCESS");
    //self.dismissViewControllerAnimated(true, completion: nil)
    
    let alertView:UIAlertView = UIAlertView()
    alertView.title = "Success!"
    alertView.message = "User Profile Updated."
    alertView.delegate = self
    alertView.addButtonWithTitle("OK")
    // alertView.show()
    
    
    
    //  self.performSegueWithIdentifier("Turn_Complete", sender: self)
    
    //NEED TO ADD NSNotification to go back to Home
    
    
    } else if (success == 5){
    
    UpdatedPro = true
    
    } else {
    UpdatedPro = false
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
    //  alertView.show()
    print("error message = \(error_msg)")
    
    }
    
    } else {
    UpdatedPro = false
    
    let alertView:UIAlertView = UIAlertView()
    alertView.title = "Sign Up Failed!"
    alertView.message = "Connection Failed"
    alertView.delegate = self
    alertView.addButtonWithTitle("OK")
    //   alertView.show()
    }
    }  else {
    UpdatedPro = false
    let alertView:UIAlertView = UIAlertView()
    alertView.title = "Sign in Failed!"
    alertView.message = "Connection Failure"
    if let error = reponseError {
    alertView.message = (error.localizedDescription)
    }
    alertView.delegate = self
    alertView.addButtonWithTitle("OK")
    //  alertView.show()
    }
    // }
    
    return UpdatedPro
    
    }
    
    
    func DismissKeyboard(){
    
    view.endEditing(true)
    }
    
    
    
    */
    
    
    /*
    
    
    func keyboardWillHide(notification: NSNotification) {
    UserFirstName = ProfileFirstNameTXT.text!
    UserLastName = ProfileLastNameTXT.text!
    
    
    print("KEYBOARD WILL HIDE")
    if UserFirstName.isEqualToString("") || UserLastName.isEqualToString("") {
    
    ProfileLoadLBL.text = "Waiting for input..."
    
    } else {
    
    ProfileLoadLBL.text = "Insert Profile Pic?"
    }
    
    
    var info = notification.userInfo!
    
    let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
    
    
    UIView.animateWithDuration(0.3, animations: { () -> Void in
    // self.QuoteBoxBottom.constant = (keyboardFrame.size.height - 120) + 20
    //self.QuoteLabelTop.constant = 50
    //self.qbDoneBOTTOM.constant = (keyboardFrame.size.height + 5) + self.GameTitleTXT.frame.size.height
    
    self.doneBTNBOTTOM.constant = 10
    })
    
    
    
    }
    
    func keyboardWasShown(notification: NSNotification) {
    
    print("KEYBOARD SHOWING")
    
    var info = notification.userInfo!
    
    let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
    
    
    UIView.animateWithDuration(0.3, animations: { () -> Void in
    // self.QuoteBoxBottom.constant = (keyboardFrame.size.height - 120) + 20
    //self.QuoteLabelTop.constant = 50
    //self.qbDoneBOTTOM.constant = (keyboardFrame.size.height + 5) + self.GameTitleTXT.frame.size.height
    
    self.doneBTNBOTTOM.constant = keyboardFrame.size.height + 5
    })
    
    
    
    }
    
    @IBAction func SkipCreateIDBTN(sender: AnyObject) {
    
    UserFirstName = ProfileFirstNameTXT.text!
    UserLastName = ProfileLastNameTXT.text!
    
    
    
    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "ProfileSet")
    
    
    
    
    ProfileImageFinal = ""
    
    
    //  prefs.setValue(NewGamePictureData, forKey: "PICTUREDATAD")
    
    
    if UserFirstName.isEqualToString("") || UserLastName.isEqualToString("") {
    
    
    let AC = JSController("Uh Oh...", MyMessage: "You don't have to add a profile image, but without your name your friends may have a hard time knowing it's you.",Color: "Red")
    // self.presentViewController(AC, animated: true, completion: nil)
    
    dispatch_async(dispatch_get_main_queue(), {
    
    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Uh Oh...", subTitle: "You don't have to add a profile image, but without your name your friends may have a hard time knowing it's you.", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
    
    })
    
    
    } else {
    
    
    
    
    let DeviceH = self.view.frame.height
    let middleScreenY = DeviceH / 2
    let middleY = middleScreenY - 200
    
    
    var WasProfileUpdated = UpdateUserProfile()
    
    
    if WasProfileUpdated {
    
    
    UIView.animateWithDuration(0.5, animations: { () -> Void in
    
    
    self.ViewProfile.center.y = self.ViewProfile.center.y + 1000
    
    self.ViewProfileTOP.constant = 936
    
    // self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
    
    //   self.greatJobBOTTOM.constant = 15
    
    
    })
    
    
    
    
    if !DismissProfileView {
    UIView.animateWithDuration(1.0, animations: { () -> Void in
    
    
    self.ViewWelcome3BTN.center.y = self.ViewWelcome3BTN.center.y - 100
    
    self.ViewWelcomeBTN3BOTTOM.constant = 0
    
    self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
    
    self.greatJobBOTTOM.constant = 15
    
    
    })
    }
    DismissProfileView = true
    //  })
    }
    
    }
    /*else {
    let AC = JSController("Error Saving", MyMessage: "Error saving profile, please try again.",Color: "Red")
    self.presentViewController(AC, animated: true, completion: nil)
    
    }
    */
    
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
