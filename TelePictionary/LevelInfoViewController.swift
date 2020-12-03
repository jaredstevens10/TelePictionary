//
//  LevelInfoViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 11/5/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import UIKit

class LevelInfoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var ImageURL = String()
    var MediaType = NSString()
    @IBOutlet weak var FirstNameLBL: UILabel!
    
    @IBOutlet weak var backBTN: UIButton!
    var OtherUserProfile = Bool()
    
    @IBOutlet weak var cameraBTN: UIButton!
    
    @IBOutlet weak var statsView: UIView!
    
    @IBOutlet weak var titlesView: UIView!
    
    @IBOutlet weak var photoBTN: UIButton!
    
    @IBOutlet weak var backBTN2: UIButton!
    var Char1 = UIImage(named: "CharacterNormal.png")
    var Char2 = UIImage(named: "CharacterBum.png")
    var Char3 = UIImage(named: "CharacterPirate.png")
    var Char4 = UIImage(named: "CharacterScholar.png")
    var Char5 = UIImage(named: "CharacterEinstien.png")
    var Char6 = UIImage(named: "CharacterWizard.png")
    var UserLikes = NSString()
    var UserFails = NSString()
    
    @IBOutlet weak var UserLevelLBL: UILabel!
    @IBOutlet weak var TotalLikesLBL: UILabel!
    @IBOutlet weak var TotalFailsLBL: UILabel!
    
    
    @IBOutlet weak var GameTitleLBL: UILabel!
    @IBOutlet weak var LikeTitleLBL: UILabel!
    @IBOutlet weak var FailTitleLBL: UILabel!
    
    
    @IBOutlet weak var PixieCharacter: UIImageView!
    @IBOutlet weak var LastNameLBL: UILabel!
    @IBOutlet weak var numberGamesLBL: UILabel!
    var UserGames = NSString()
    var RankLikes = Int()
    var RankFails = Int()
    var RankGames = Int()
    @IBOutlet weak var usernameLBL: UILabel!
   // var token = NSData()
    @IBOutlet weak var ProfileImage: UIImageView!
    var ProfileImageFinal = NSString()
    var WasUpdated = Bool()
    let picker = UIImagePickerController()
    var ProfilePictureAdded = Bool()
    
    
    @IBOutlet weak var title2HEIGHT: NSLayoutConstraint!
    @IBOutlet weak var title3HEIGHT: NSLayoutConstraint!
    
    var username = NSString()
    var UserFirstName = NSString()
    var UserLastName = NSString()
    var UserEmail = NSString()
    var ProfileImageDataString = NSString()
    //var UserGamesLBL = NSString()
    var ProfileUserName = NSString()
    var UserLevel = NSString()
    var UserTokens = NSString()
    var playerID = NSString()
    let prefs = UserDefaults.standard
    var ShowB2 = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statsView.layer.cornerRadius = 5
        titlesView.layer.cornerRadius = 5
        usernameLBL.layer.cornerRadius = 5
        usernameLBL.layer.masksToBounds = true
        usernameLBL.clipsToBounds = true
        picker.delegate = self
        
        ProfileImage.layer.cornerRadius = 5
       // ProfileImage.frame.
     //   ProfileImage.layer.masksToBounds = true
        ProfileImage.clipsToBounds = true
        
        if OtherUserProfile {
            if ShowB2 {
                backBTN2.isHidden = false
            } else {
                backBTN2.isHidden = true
            }
            backBTN.isHidden = true
                       photoBTN.isHidden = true
            cameraBTN.isHidden = true
          GetUserProfileData(playerID as String)
            
        } else {
        backBTN2.isHidden = true
        if prefs.value(forKey: "PLAYERID") != nil {
        playerID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
        // Do any additional setup after loading the view.
        GetUserProfileData(playerID as String)
        } else {
            playerID = ""
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBTN2(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func closeBTN(_ sender: AnyObject) {
        
        if playerID == "" {
        
            
            self.dismiss(animated: true, completion: nil)
            
            
        } else {
        

        
        if WasUpdated {
            
            UIGraphicsBeginImageContext(ProfileImage.bounds.size)
            ProfileImage.image?.draw(in: CGRect(x: 0, y: 0,
                width: ProfileImage.frame.size.width, height: ProfileImage.frame.size.height))
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            
            
            
            let smallImage = ProfileImage.image!.resize(0.5)
            
            
            //let imageData = UIImageJPEGRepresentation(smallImage, 1.0)
            let imageData = smallImage.jpegData(compressionQuality: 1.0)!
            ProfileImageFinal = imageData.base64EncodedString(options: []) as NSString
            
            
            let ProfileUpdated = UpdateUserProfile()
            print("ProfileUpdated")
            
            
            
            
        
            if ProfileUpdated {
        self.dismiss(animated: true, completion: nil)
            } else {
                let AC = JSController("Error Saving Profile", MyMessage: "Error saving profile, please try again.",Color: "Red")
                self.present(AC, animated: true, completion: {  self.dismiss(animated: true, completion: nil)
                })
            }
            
        } else {
        self.dismiss(animated: true, completion: nil)

        }
        
    }
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func photoFromLibary(_ sender: AnyObject) {
        
        print("photo from library")
        self.picker.allowsEditing = false //2
        self.picker.sourceType = .photoLibrary //3
        self.picker.modalPresentationStyle = .popover
        self.present(self.picker, animated: true, completion: nil)//4
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage //2
        
        WasUpdated = true
        
        ProfileImage.contentMode = .scaleAspectFit //3
        // myImageView.image = chosenImage
        ProfileImage.image = chosenImage//4
        ProfilePictureAdded = true
        //  (StartSegment.subviews[0] ).tintColor = UIColor(red: 0.4, green: 1, blue: 0.69, alpha: 1.0)
        
        print("Picture add = \(ProfilePictureAdded)")
        
        
        print("image picked")
        
        /*
        if UserFirstName.isEqualToString("") || UserLastName.isEqualToString("") {
            
           // ProfileLoadLBL.text = "Waiting for input..."
            
        } else {
            
          //  ProfileLoadLBL.text = "Tap 'Submit' to continue"
        }
        */
        
        self.dismiss(animated: true, completion: nil) //5
        
        
    }
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
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
    
    
    func GetUserProfileData (_ userid: String) {
        
        
     //   let TokenNew2 = Token.description.stringByReplacingOccurrencesOfString("<", withString: "")
     //   let TokenNew3 = TokenNew2.stringByReplacingOccurrencesOfString(">", withString: "")
     //   let TokenNew = TokenNew3.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        
        
        let tempemail = "test123@\(ServerInfo.sharedInstance)"
        let privacy = "no"
        
       // print("Token - Spaces Removed: \(TokenNew)")
        
        let post:NSString = "playerid=\(userid)" as NSString
        
        //&password=\(password)&token=\(TokenNew)&playerid=\(PlayerID)&email=\(tempemail)&privacy=\(privacy)"
        
        
       //NSLog("PostData: %@",post);
        
        let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GetUserProfile.php")!
        
     //   print("URL entered")
        
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
                
                //    var error: NSError?
                
                let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
                
                
                let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
                
                //[jsonData[@"success"] integerValue];
                
               //NSLog("Success: %ld", success);
                
                //Admin = jsonData.valueForKey("admin") as! NSString
                
                
                
                if(success == 1)
                {
                  // //NSLog("MERGE With Game Database - SUCCESS");
                    
                    let prefs:UserDefaults = UserDefaults.standard
                    
                    //prefs.setObject(username, forKey: "USERNAME")
                    
                  //  prefs.setInteger(1, forKey: "ISLOGGEDIN")
                 //   prefs.synchronize()
                    
                    //  prefs.setValue(Admin, forKey: "ADMIN")
                    
                    UserEmail = jsonData.value(forKey: "email") as! NSString
                    UserLevel = jsonData.value(forKey: "level") as! NSString
                    print("userlevel1 = \(UserLevel)")
                    let UserLevel2: Int = Int(UserLevel as String)!
                    UserTokens = jsonData.value(forKey: "points") as! NSString
                    var UserTokens2: Int = Int(UserTokens as String)!

                    ProfileUserName = jsonData.value(forKey: "username") as! NSString
                    ProfileImageDataString = jsonData.value(forKey: "imagedata") as! NSString
                    UserFirstName = jsonData.value(forKey: "firstname") as! NSString
                    UserLastName = jsonData.value(forKey: "lastname") as! NSString
                    FirstNameLBL.text = ("\(UserFirstName.description) \(UserLastName.description)")
                    //LastNameLBL.text = UserLastName as String
                    usernameLBL.text = ProfileUserName as String
                    UserLevelLBL.text = "Player Level: \(UserLevel)"
                    
                    UserLikes = jsonData.value(forKey: "like") as! NSString
                    UserFails = jsonData.value(forKey: "fail") as! NSString
                    UserGames = jsonData.value(forKey: "games") as! NSString
                    
                    let uniqueID = jsonData.value(forKey: "uniqueID") as! NSString
                    
                    ImageURL = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/player\(uniqueID).jpg"
                    
                    ImageURL = ImageURL.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
                    
                    print("Image URL = \(ImageURL)")
                    
                    TotalLikesLBL.text = UserLikes as String
                    TotalFailsLBL.text = UserFails as String
                    numberGamesLBL.text = UserGames as String
                    
                    
                   let RankLikes2 = jsonData.value(forKey: "likerank") as! NSString
                   let RankFails2 = jsonData.value(forKey: "failrank") as! NSString
                   let RankGames2 = jsonData.value(forKey: "gamerank") as! NSString
                    
                    RankLikes = Int(RankLikes2 as String)!
                    RankFails = Int(RankFails2 as String)!
                    RankGames = Int(RankGames2 as String)!
                    
                    var NumTitles = Int()
                    NumTitles = 0
                    
                    if RankFails < 11 {
                        NumTitles += 1
                    }
                    
                    if RankGames < 11 {
                        NumTitles += 1
                    }

                    if RankLikes < 11 {
                        NumTitles += 1
                    }
                    
                    var AllTitlesArray = [NSString]()
                    
                    
                    switch RankGames {
                    case _ where RankGames == 0:
                        print("NA")
                        break
                    case _ where RankGames == 1:
                       // print("most fails of any player!")
                        numberGamesLBL.textColor = UIColor.green
                        AllTitlesArray.append("Most Games Played")
                        break
                    case _ where RankGames < 6:
                      //  print("top five most fails")
                        numberGamesLBL.textColor = UIColor.green
                        AllTitlesArray.append("Top 5 Most Games Played")
                        break
                    case _ where RankGames < 11:
                        numberGamesLBL.textColor = UIColor.green
                        AllTitlesArray.append("Top 10 Most Games Played")
                       // print("top ten most fails")
                        break
                    default:
                        break
                    }
                    
                    switch RankLikes {
                    case _ where RankLikes == 0:
                        print("NA")
                        break
                    case _ where RankLikes == 1:
                        AllTitlesArray.append("Most Likes By A Player")
                          TotalLikesLBL.textColor = UIColor.green
                       // print("most likes of any player")
                        break
                    case _ where RankLikes < 6:
                        AllTitlesArray.append("Top 5 Most Likes")
                          TotalLikesLBL.textColor = UIColor.green
                       // print("top five most likes")
                        break
                    case _ where RankLikes < 11:
                        AllTitlesArray.append("Top 10 Most Likes")
                        TotalLikesLBL.textColor = UIColor.green
                       // print("top ten most likes")
                        break
                    default:
                        break
                    }
                    
                    switch RankFails {
                    case _ where RankFails == 0:
                        print("NA")
                    case _ where RankFails == 1:
                        AllTitlesArray.append("Most Fails By A Player")
                        print("most games played")
                        TotalFailsLBL.textColor = UIColor.red
                        break
                    case _ where RankFails < 6:
                        AllTitlesArray.append("Top 5 Most Fails")
                        print("top five most games")
                        TotalFailsLBL.textColor = UIColor.red
                        break
                    case _ where RankFails < 11:
                        AllTitlesArray.append("Top 10 Most Fails")
                        print("top ten most games")
                        TotalFailsLBL.textColor = UIColor.red
                        break
                    default:
                        break
                    }
                    
                   print("Current Games titles are = \(AllTitlesArray)")
                    
                    if AllTitlesArray.count > 0 {
                    self.GameTitleLBL.text = AllTitlesArray[0] as String
                        if AllTitlesArray.count > 1 {
                            self.LikeTitleLBL.text = AllTitlesArray[1] as String
                            self.title2HEIGHT.constant = 25
                            if AllTitlesArray.count > 2 {
                                self.title3HEIGHT.constant = 25
                                self.FailTitleLBL.text = AllTitlesArray[2] as String
                            } else {
                                self.title3HEIGHT.constant = 0
                            }
                        } else {
                            self.title2HEIGHT.constant = 0
                        }
                    } else {
                     self.GameTitleLBL.text = "None"
                    }
                    
                    print("user level is \(UserLevel2)")

                    
                    switch UserLevel2 {
                    case 1:
                    PixieCharacter.image = Char1
                    case 2:
                        PixieCharacter.image = Char1

                    case 3:
                        PixieCharacter.image = Char2

                    case 4:
                        PixieCharacter.image = Char3

                    case 5:
                        PixieCharacter.image = Char4

                    case 10:
                        PixieCharacter.image = Char6

                    default:
                        PixieCharacter.image = Char1

                    }

                    
                    
                    let request = URLRequest(url: URL(string: ImageURL)!)
                    let mainQueue = OperationQueue.main
                    NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
                        if error == nil {
                            // Convert the downloaded data in to a UIImage object
                            let image = UIImage(data: data!)
                            // Store the imge in to our cache
                            //  self.imageCache[urlString] = image
                            // Update the cell
                            DispatchQueue.main.async(execute: {
                                //if let cellToUpdate = TableView.cellForItemAtIndexPath(indexPath) {
                                //if let cellToUpdate = TableView.cel
                                self.ProfileImage.image = image
                            })
                        }
                        else {
                            
                           self.ProfileImage.image = UIImage(named: "blankProfile.png")
                            
                            print("Error: \(error!.localizedDescription)")
                        }
                    })
                    
                  //  prefs.setValue(Email, forKey: "EMAIL")
                    
                  //  prefs.setValue(username, forKey: "USERNAME")
                  //  prefs.setValue(PlayerID, forKey: "PLAYERID")
                    
                    /*
                    
                    if ProfileImageDataString.isEqualToString("") {
                        ProfileImage.image = UIImage(named: "blankProfile.png")
                    } else {
                    let Image64NSData = NSData(base64EncodedString: ProfileImageDataString as String, options: NSDataBase64DecodingOptions(rawValue: 0))
                    
                    
                    //  print("Image64NSData = \(Image64NSData!)")
                    
                    let Image64Data = NSString(data: Image64NSData!, encoding: NSUTF8StringEncoding)!
                    
                  //  print("IMAGE 64 DATA =           \(Image64Data)")
                    
                    
                    let decodedData = NSData(base64EncodedString: Image64Data as String, options: NSDataBase64DecodingOptions(rawValue: 0))
                    
                    
                  //  print("DECODED DATA =         \(decodedData)")
                    print("Setting Image")
                    
                        if let image = UIImage(data: decodedData!) {
                    
                    
                    
                    ProfileImage.image = image
                            
                        } else {
                            ProfileImage.image = UIImage(named: "blankProfile.png")
                        }
                        
                    }
                    */
                    
                    ProfileImage.layer.cornerRadius = 0
                    
                    /*

                    let UniqueID = UserLastName = jsonData.valueForKey("uniqueID") as! NSString
                    
                    let URLString = "\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/player\(UniqueID).jpg"
                    
                    let request = NSURLRequest(URL: NSURL(string: URLString)!)
                    let mainQueue = NSOperationQueue.mainQueue()
                    NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
                        if error == nil {
                            // Convert the downloaded data in to a UIImage object
                            var theimage = UIImage(data: data!)
                             dispatch_async(dispatch_get_main_queue(), {
                            self.ProfileImage.image = theimage
                            })
                        } else {
                             print("Error: \(error!.localizedDescription)")
                        }
                        
                    })
                    
                    */
                   
                    //  self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    
                    
                    
                    var error_msg:NSString
                    
                    
                    if jsonData["error_message"] as? NSString != nil {
                        error_msg = jsonData["error_message"] as! NSString
                    } else {
                        error_msg = "Unknown Error"
                    }
                    
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Pics & Quotes!"
                    //alertView.message = "Sign in Error"
                    alertView.message = error_msg as String
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    //  alertView.show()
                    
                }
                
            } else {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Error!"
                alertView.message = "Connection Failed"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
            }
        } else {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Unable to Match GameCenter Username"
            alertView.message = "Please check your internet connection if you would like to play with your friends remotely"
            if let error = reponseError {
                alertView.message = (error.localizedDescription)
            }
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
        }
    }

    func UpdateUserProfile() -> Bool {
        var ProfileUsername = NSString()
        var ProfileUserID = NSString()
        
        var ProfileToken = Data()
        
        var UpdatedPro = Bool()
        
        ProfileToken  = prefs.value(forKey: "deviceToken") as! Data
        // print("deviceToken not nil")
       // print("token = \(token)")
        
        
        // let Token = ProfileToken
        let TokenNew2 = ProfileToken.description.replacingOccurrences(of: "<", with: "")
        let TokenNew3 = TokenNew2.replacingOccurrences(of: ">", with: "")
        let TokenNew = TokenNew3.replacingOccurrences(of: " ", with: "")
        
        
        if (prefs.value(forKey: "USERNAME") != nil)
        {
            ProfileUsername = (self.prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            ProfileUserID = (self.prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString            //   myID = prefs.valueForKey("PLAYERID") as! NSString as String
            print("Myid = \(ProfileUserID)")
            print("username not nil")
        }
        let email = "test123@\(ServerInfo.sharedInstance)"
        let privacy = "no"
        let password = "NA"
        
        let post_old = "username=\(ProfileUsername)&playerid=\(ProfileUserID)&firstname=\(UserFirstName)&lastname=\(UserLastName)&token=\(TokenNew)email=\(email)&privacy=\(privacy)&password=\(password)"
        
        print("POST OLD DATA = \(post_old)")
        
        
        
        //var post = post_old.addingPercentEscapes(using: String.Encoding.utf8)!
        var post = post_old.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        
        
        //post = ("\(post)&ImageData=\(ProfileImageFinal)")
        post = ("\(post)&ImageData=TBD")
        
        // progressHUD.removeFromSuperview()
        //  progressHUD = ProgressHUD(text: "Saving Game Data...")
        //  self.view.addSubview(progressHUD)
        
        
        print("NEW POST STRING: \(post)")
        
        
        /*
        &Player1Cell=\(Player1Cell)&Player2Cell=\(Player2Cell)&Player3Cell=\(Player3Cell)&Player4Cell=\(Player4Cell)&Player5Cell=\(Player5Cell)&Player6Cell=\(Player6Cell)&Player7Cell=\(Player7Cell)&Player8Cell=\(Player8Cell)&Player9Cell=\(Player9Cell)&Player10Cell=\(Player10Cell)
        */
       //NSLog("PostData: %@",post);
        
        let url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/UpdateUserProfile.php")!
        
        let postData:Data = post!.data(using: String.Encoding.ascii)!
        
        // var postData:NSData = post.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
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
                
                //var error: NSError?
                
                let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
                
                
                let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
                
                let PlayerGameID:NSInteger = jsonData.value(forKey: "playerid") as! NSInteger
                
                let uniqueID = PlayerGameID.description
                print("uniqueID = \(uniqueID)")
                
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
                    alertView.addButton(withTitle: "OK")
                    // alertView.show()
                    
                    
                    
                    //  self.performSegueWithIdentifier("Turn_Complete", sender: self)
                    
                    //NEED TO ADD NSNotification to go back to Home
                    
                    
                } else if (success == 5){
                    
                    UpdatedPro = true
                    
                    if ProfilePictureAdded {
                        
                        MediaType = "image"
                        
                        
                        if MediaType == "gif" {
                            
                            UploadGameFileData(ProfileImageFinal as String, FileName: "player\(uniqueID)", Type: "gif")
                            
                        } else {
                            
                            print("SHOULD UPLOAD IMAGE NOW")
                            // print("BASE 64 DATA IS = \(base64Image)")
                            UploadGameFileData(ProfileImageFinal as String, FileName: "player\(uniqueID)", Type: "image")
                        }
                        
                    }
                    
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
                    alertView.addButton(withTitle: "OK")
                    //  alertView.show()
                    print("error message = \(error_msg)")
                    
                }
                
            } else {
                UpdatedPro = false
                
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign Up Failed!"
                alertView.message = "Connection Failed"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
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
            alertView.addButton(withTitle: "OK")
            //  alertView.show()
        }
        // }
        
        return UpdatedPro
        
    }
    

}
