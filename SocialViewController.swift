//
//  SocialViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 11/4/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import UIKit
import FBSDKShareKit
import FBSDKLoginKit
import FBSDKCoreKit
import AssetsLibrary
import Social
import MessageUI
import AVFoundation
import CoreMedia
import MediaPlayer

protocol SocialViewControllerDelegate: class {
    func SocialViewControllerFinished(_ socialiewController: SocialViewController)
}

class SocialViewController: UIViewController, UIDocumentInteractionControllerDelegate, MFMessageComposeViewControllerDelegate, FBSDKSharingDelegate {
    
var documentController: UIDocumentInteractionController!
var MediaSuf = NSString()
var PreviousMediaType = NSString()
    
    var CurrentImageIsGif = Bool()
    var PreviousImageIsGif = Bool()
    
    
@IBOutlet weak var view2: UIView!
var FullGameImage = UIImage()
    
  var TheFinalImageTwo = UIImage()
var TheImage = UIImage()
var TopImage = UIImage()
var TheImage2 = UIImage()
 var IsTurn1 = Bool()
    var TheFinalImage = UIImage()
    var PreviousQuote = NSString()
    var PreviousImage = UIImage()
var PreviousQuoteImage = UIImage()
    
var TheQuote = NSString()
var quoteImage = UIImage()
    var userID = NSString()
   var QBoxImage = UIImage(named: "QuoteBoxImage.png")
    // var userNames = [NSString]()
  //  @IBOutlet var actInd: UIActivityIndicatorView!
    let prefs:UserDefaults = UserDefaults.standard
    
   // @IBOutlet var TableView: UITableView!
    var QuoteTarget = Bool()
    var socialdelegate: SocialViewControllerDelegate?
    var player1 = NSString()
    var player2 = NSString()
    var player3 = NSString()
    var player4 = NSString()
    var player5 = NSString()
    var player6 = NSString()
    var player7 = NSString()
    var player8 = NSString()
    var player9 = NSString()
    var player10 = NSString()
    
    var hideBorder = Bool()
    var PicFirst = Bool()
    var player1ID = NSString()
    var player2ID = NSString()
    var player3ID = NSString()
    var player4ID = NSString()
    var player5ID = NSString()
    var player6ID = NSString()
    var player7ID = NSString()
    var player8ID = NSString()
    var player9ID = NSString()
    var player10ID = NSString()
    
    var gameid = NSString()
    var turnnumber = NSString()
    var username = NSString()
    var gamestyle = NSString()
    var CanCreateVideo = Bool()
    var theMediaType = NSString()
    var theTurnNumber = NSString()
    var SuggestedTitle = NSString()
    var SuggestedPlayers = 2
    var SuggestedTurnTime = "00:00:00"
    var SuggestedFirstTurn = NSString()
    var SuggestedNewGameImage = UIImage()
    var SuggestedQuote = NSString()
    var SuggestedNewGamePictureData = NSString()
    
    var PreviousPlayer = NSString()
    var CurrentPlayer = NSString()
  ///  var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        print("Social Turn number = \(theTurnNumber)")
        print("Media Type = \(theMediaType)")
        
        print("Previous Media Type = \(PreviousMediaType)")
        view2.layer.cornerRadius = 5
        self.navigationController?.popoverPresentationController?.backgroundColor = UIColor.lightGray
        
        print("Hide border = \(hideBorder)")
        
        print("The quote = \(TheQuote)")
        print("the previous quote = \(PreviousQuote)")
        
        print("THE TURN NUMBER IS \(theTurnNumber)")
        
        switch theTurnNumber {
        case "Turn1":
            PreviousPlayer = ""
            CurrentPlayer = player1
            IsTurn1 = true
            print("turn 1")
        case "Turn2":
            PreviousPlayer = player1
            CurrentPlayer = player2
        case "Turn3":
            PreviousPlayer = player2
            CurrentPlayer = player3
            print("turn 3")
        case "Turn4":
            PreviousPlayer = player3
            CurrentPlayer = player4
        case "Turn5":
            PreviousPlayer = player4
            CurrentPlayer = player5
            
            print("turn 5")
        case "Turn6":
            PreviousPlayer = player5
            CurrentPlayer = player6
        case "Turn7":
            PreviousPlayer = player6
            CurrentPlayer = player7
            
            print("turn 7")
        case "Turn8":
            PreviousPlayer = player7
            CurrentPlayer = player8
        case "Turn9":
            PreviousPlayer = player8
            CurrentPlayer = player9
            print("turn 9")
        case "Turn10":
            PreviousPlayer = player9
            CurrentPlayer = player10
            case "Turn11":
            print("turn 11")
        default:
            print("COULD THIS BE THE FULL GAME IMAGE??????")
            
            IsTurn1 = true

           break
        }

        
        
        if theTurnNumber == "Turn11" {
            
        TheImage = FullGameImage
            
        } else {
        
        
        if TheQuote.isEqual(to: "") || TheQuote.isEqual(to: " ") {
            
            print("Picture is primary TARGET !!!!!")
            
            _ = self.TheImage.size.height
            _ = self.TheImage.size.width
            
            _ = self.PreviousImage.size.height * 0.9
            _ = self.PreviousImage.size.width * 0.9

            
            
           // let font = UIFont(name: "ChalkboardSE-Regular", size: 11.0)
            
            
            let font = UIFont(name: "DK Cool Crayon", size: 18.0)
            
            _ = UIFont(name: "Chalkduster", size: 30.0)
            
            
            let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            textStyle.alignment = NSTextAlignment.center
            
            let textColor = UIColor.black
            
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.white
            shadow.shadowOffset = CGSize(width: 0,height: 1)
            // let textColorShadow = UIColor.whiteColor()
            
            var textFontAttributes: [NSAttributedString.Key : AnyObject]?
            
            
            if let actualFont = font {
                textFontAttributes = [NSAttributedString.Key.font: actualFont, NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.paragraphStyle: textStyle]
                
            }
            
            let ih = self.QBoxImage!.size.height
            let iw = self.QBoxImage!.size.width
            
            let newSize = CGSize(width: iw, height: ih)
            
            
            UIGraphicsBeginImageContext(newSize)
            
            
            
            let Rect2 = CGRect(x: 0,y: 0,width: iw,height: ih)
            
            
            _ = CGRect(x: 25,y: 85,width: iw,height: ih)
            
            QBoxImage!.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
            
            
            let qRect1 = CGRect(x: 50,y: 170,width: iw - 50,height: ih)
            
            print("Previous quote is, before making prevousquoteimage, \(PreviousQuote)")
            
            let PreviousQTemp = "\(PreviousQuote) -\(PreviousPlayer)"
            
            PreviousQTemp.draw(in: qRect1, withAttributes: textFontAttributes)
            
            PreviousQuoteImage = UIGraphicsGetImageFromCurrentImageContext()!

            
            PreviousImage = PreviousQuoteImage
            /*
            
            let font = UIFont(name: "ChalkboardSE-Regular", size: 11.0)

            let fontTitle = UIFont(name: "Chalkduster", size: 30.0)
            
           
            let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
            textStyle.alignment = NSTextAlignment.Center
            
            let textColor = UIColor.blackColor()
            
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.whiteColor()
            shadow.shadowOffset = CGSizeMake(0,1)
            // let textColorShadow = UIColor.whiteColor()
            
            var textFontAttributes: [String : AnyObject]?
            
            
            if let actualFont = font {
                textFontAttributes = [NSAttributedString.Key.font: actualFont, NSAttributedString.Key.foregroundColor: textColor, NSParagraphStyleAttributeName: textStyle]
                
            }
            
            let ih = self.QBoxImage!.size.height
            let iw = self.QBoxImage!.size.width
            
            let newSize = CGSizeMake(iw, ih)
            
            
            UIGraphicsBeginImageContext(newSize)
            
            
            
            let Rect2 = CGRectMake(0,0,iw,ih)
            
            
            let picRect = CGRectMake(25,85,iw,ih)
            
            QBoxImage!.drawInRect(Rect2, blendMode:CGBlendMode.Normal, alpha: 1.0)
            
            
            let qRect1 = CGRectMake(50,170,iw,ih)
            
            PreviousQuote.drawInRect(qRect1, withAttributes: textFontAttributes)
            
            PreviousQuoteImage = UIGraphicsGetImageFromCurrentImageContext()
            
            
            
            switch theTurnNumber {
            case "Turn1":
                if theMediaType == "quote" {
                    PreviousImage = PreviousQuoteImage
                   // PicFirst = true
                }
                print("turn 1")
            case "Turn2":
                if theMediaType == "quote" {
                    PreviousImage = PreviousQuoteImage
                  //  PicFirst = true
                }
            case "Turn3":
                if theMediaType == "quote" {
                    PreviousImage = PreviousQuoteImage
                  //  PicFirst = true
                }
                print("turn 3")
            case "Turn4":
                if theMediaType == "quote" {
                    PreviousImage = PreviousQuoteImage
                  //  PicFirst = true
                }
            case "Turn5":
                if theMediaType == "quote" {
                    PreviousImage = PreviousQuoteImage
                 //   PicFirst = true
                }
                print("turn 5")
            case "Turn6":
                if theMediaType == "quote" {
                    PreviousImage = PreviousQuoteImage
                    PicFirst = true
                }
            case "Turn7":
                if theMediaType == "quote" {
                    PreviousImage = PreviousQuoteImage
                  //  PicFirst = true
                }
                print("turn 7")
            case "Turn8":
                if theMediaType == "quote" {
                    PreviousImage = PreviousQuoteImage
                  //  PicFirst = true
                }
            case "Turn9":
                if theMediaType == "quote" {
                    PreviousImage = PreviousQuoteImage
                 //   PicFirst = true
                }
                print("turn 9")
            case "Turn10":
                if theMediaType == "quote" {
                    PreviousImage = PreviousQuoteImage
                  //  PicFirst = true
                }
            default:
                if theMediaType == "quote" {
                    PreviousImage = PreviousQuoteImage
                   // PicFirst = true
                }
                print("turn 1")
            }
            
*/
            
        } else {
            
            
           QuoteTarget = true
              print("Quote is primiary target")
            
            
           // let font = UIFont(name: "ChalkboardSE-Regular", size: 11.0)
            let font = UIFont(name: "DK Cool Crayon", size: 18.0)
            
            _ = UIFont(name: "Chalkduster", size: 30.0)
            
            
            let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            textStyle.alignment = NSTextAlignment.center
            
            let textColor = UIColor.black
            
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.white
            shadow.shadowOffset = CGSize(width: 0,height: 1)
            // let textColorShadow = UIColor.whiteColor()
            
            var textFontAttributes: [NSAttributedString.Key : AnyObject]?
            
            
            if let actualFont = font {
                textFontAttributes = [NSAttributedString.Key.font: actualFont, NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.paragraphStyle: textStyle]
                
            }
            
            let ih = self.QBoxImage!.size.height
            let iw = self.QBoxImage!.size.width
            
            let newSize = CGSize(width: iw, height: ih)
            
            
            UIGraphicsBeginImageContext(newSize)
            
            
            
            let Rect2 = CGRect(x: 0,y: 0,width: iw,height: ih)
            
            
            _ = CGRect(x: 25,y: 85,width: iw,height: ih)
            
            QBoxImage!.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
            
            
            let qRect1 = CGRect(x: 50,y: 170,width: iw,height: ih)
            
            _ = "\(PreviousQuote) -\(CurrentPlayer)"
            
            PreviousQuote.draw(in: qRect1, withAttributes: textFontAttributes)
            
            PreviousQuoteImage = UIGraphicsGetImageFromCurrentImageContext()!

            
            
            
            
            
            
            
            
            print("the quote is not blank")
            
            _ = UIFont(name: "ChalkboardSE-Regular", size: 18.0)
            
            
            _ = UIFont(name: "Chalkduster", size: 30.0)
            
            
            
            let textStyle2 = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            textStyle.alignment = NSTextAlignment.center
            
            let textColor2 = UIColor.black
            
            _ = NSShadow()
            shadow.shadowColor = UIColor.white
            shadow.shadowOffset = CGSize(width: 0,height: 1)
            // let textColorShadow = UIColor.whiteColor()
            
            var textFontAttributes2: [NSAttributedString.Key : AnyObject]?
            
            
            if let actualFont2 = font {
                textFontAttributes2 = [NSAttributedString.Key.font: actualFont2, NSAttributedString.Key.foregroundColor: textColor2, NSAttributedString.Key.paragraphStyle: textStyle2]
                
            }
            
            let ih22 = self.QBoxImage!.size.height
            let iw22 = self.QBoxImage!.size.width
            
            let newSize22 = CGSize(width: iw22, height: ih22)
            
            
            UIGraphicsBeginImageContext(newSize22)
            
         
            
            let Rect222 = CGRect(x: 0,y: 0,width: iw22,height: ih22)
            
            let textw22 = iw22 - 50
            let texth22 = ih22 - 170
            
           // let picRect = CGRectMake(25,85,iw,ih)
           
            _ = CGRect(x: 25,y: 85,width: textw22,height: texth22)

            
            QBoxImage!.draw(in: Rect222, blendMode:CGBlendMode.normal, alpha: 1.0)
            

           // let qRect1 = CGRectMake(50,170,iw,ih)
            let qRect122 = CGRect(x: 50,y: 170,width: textw22,height: texth22)

            
            let QTemp = "\(TheQuote) -\(CurrentPlayer)"
            QTemp.draw(in: qRect122, withAttributes: textFontAttributes2)
            
            quoteImage = UIGraphicsGetImageFromCurrentImageContext()!
            
            print("there turn number is \(theTurnNumber)")
            
            switch theTurnNumber {
                case "Turn1":
                    if theMediaType == "quote" {
                     TheImage = quoteImage
                        PicFirst = true
                    }
                print("turn 1")
            case "Turn2":
                if theMediaType == "quote" {
                    TheImage = quoteImage
                    PicFirst = true
                }
            case "Turn3":
                if theMediaType == "quote" {
                    TheImage = quoteImage
                    PicFirst = true
                }
                print("turn 3")
            case "Turn4":
                if theMediaType == "quote" {
                    TheImage = quoteImage
                    PicFirst = true
                }
            case "Turn5":
                if theMediaType == "quote" {
                    TheImage = quoteImage
                    PicFirst = true
                }
                print("turn 5")
            case "Turn6":
                if theMediaType == "quote" {
                    TheImage = quoteImage
                    PicFirst = true
                }
            case "Turn7":
                if theMediaType == "quote" {
                    TheImage = quoteImage
                    PicFirst = true
                }
                print("turn 7")
            case "Turn8":
                if theMediaType == "quote" {
                    TheImage = quoteImage
                    PicFirst = true
                }
            case "Turn9":
                if theMediaType == "quote" {
                    TheImage = quoteImage
                    PicFirst = true
                }
                print("turn 9")
            case "Turn10":
                if theMediaType == "quote" {
                    TheImage = quoteImage
                    PicFirst = true
                }
            default:
                if theMediaType == "quote" {
                    TheImage = quoteImage
                    PicFirst = true
                }
                print("turn 1")
            }
            
            print("Pic First = \(PicFirst)")
           // TheImage = quoteImage
        }
        
            
        }
        
      //  CreateTheImage()
     //   self.TableView.separatorStyle = UITableViewCell.SeparatorStyle.None
        /*
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "RefreshFailData:", forControlEvents: UIControl.Event.ValueChanged)
        */
        /*
        PlayerArrayTemp.append(player1)
        PlayerArrayTemp.append(player2)
        PlayerArrayTemp.append(player3)
        PlayerArrayTemp.append(player4)
        PlayerArrayTemp.append(player5)
        PlayerArrayTemp.append(player6)
        PlayerArrayTemp.append(player7)
        PlayerArrayTemp.append(player8)
        PlayerArrayTemp.append(player9)
        PlayerArrayTemp.append(player10)
        
        PlayerIDArrayTemp.append(player1ID)
        PlayerIDArrayTemp.append(player2ID)
        PlayerIDArrayTemp.append(player3ID)
        PlayerIDArrayTemp.append(player4ID)
        PlayerIDArrayTemp.append(player5ID)
        PlayerIDArrayTemp.append(player6ID)
        PlayerIDArrayTemp.append(player7ID)
        PlayerIDArrayTemp.append(player8ID)
        PlayerIDArrayTemp.append(player9ID)
        PlayerIDArrayTemp.append(player10ID)
        */
   
        super.viewDidLoad()
        if prefs.value(forKey: "USERNAME") != nil {
            
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
        } else  {
            username = "tempName"
            userID = "tempID"
        }
        
        
        
        
        if Reachability.isConnectedToNetwork() {
            
            
            
        }
            
        else
            
        {
            
            
            let AC = JSController("Network Error", MyMessage: "Please Confirm Your Network Settings",Color: "Red")
            self.present(AC, animated: true, completion: nil)
            
        }
        
       
        //   actInd.stopAnimating()
        if theMediaType == "gif" {
            CurrentImageIsGif = true
        }
        
        if PreviousMediaType == "gif" {
            PreviousImageIsGif = true
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        /*
        if CurrentImageIsGif {
            
           CreateTheImageGIF()
            
        } else {
            
           if PreviousImageIsGif {
            
            CreateTheImageGIFPrevious()
            
           } else {
        
         CreateTheImage()
            
            }
        }
        */
        
        CreateTheImage()
        
        //   actInd.startAnimating()
        if Reachability.isConnectedToNetwork() {
            
            /*
            let URLData = GetLikeFailData(gameid, type: "fail", turnnumber: turnnumber)
            //println(test)
            CommentDataInfo = FilterFailData(URLData)
            print("Aboue to sync CommentData = \(CommentDataInfo)")
            
            idArrayInfo = CommentDataInfo[0] as! [(NSString)]
            
            userArrayInfo = CommentDataInfo[1] as! [(NSString)]
            }
            
            
            else
            
            {
            
            
            let AC = JSController("Network Error", MyMessage: "Please Confirm Your Network Settings",Color: "Red")
            self.presentViewController(AC, animated: true, completion: nil)
            
            }
            */
            
            
            //   actInd.stopAnimating()
            
        }
         
       
    }
  
    
    func PokeClicked(_ sender: UIButton){
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func facebookBTN(_ sender: AnyObject) {
      
        print("the media type =\(theMediaType)")
        
        switch theMediaType {
            case "picture":
            MediaSuf = "jpg"
            case "audio":
            MediaSuf = "jpg"
            case "quote":
            MediaSuf = "jpg"
            case "gif":
            MediaSuf = "gif"
            
        default:
            break
        }
        
        /*
        let newSize = CGSizeMake(700, 900)
        UIGraphicsBeginImageContext(newSize)
        
        let frameImage = UIImage(named: "chalkboardFrame2.png")
        
        let ih = self.TheImage.size.height
        let iw = self.TheImage.size.width
        print("ih = \(ih)")
        print("iw = \(iw)")
        let ivar = iw / ih
        let niw = 600 * ivar
        let StartX = 350 - (niw / 2)
        
        let Rect2 = CGRectMake(0,0,700,900)
        let picRect = CGRectMake(StartX,90,niw,600)
        frameImage!.drawInRect(Rect2, blendMode:CGBlendMode.Normal, alpha: 1.0)
        
        self.TheImage.drawInRect(picRect, blendMode: CGBlendMode.Normal, alpha: 1.0)
        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        //    let imageData = UIImagePNGRepresentation(newImage)
        
        */
        var ih2 = CGFloat()
        var iw2 = CGFloat()
        
        
        let ih = self.TheImage.size.height
        let iw = self.TheImage.size.width
        
        if hideBorder {
            ih2 = ih
            iw2 = iw
        } else {
            ih2 = ih + 250
            iw2 = iw + 50
        }
        
        let newSize = CGSize(width: iw2, height: ih2)
        
        UIGraphicsBeginImageContext(newSize)
        
        let frameImage = UIImage(named: "chalkboardTall.png")
        let textImage = UIImage(named: "PQText.png")
        
        let ivar = ih / iw
        //let niw = 617 * ivar
        let th = textImage!.size.height
        let tw = textImage!.size.width
        
        let fh = frameImage!.size.height
        let fw = frameImage!.size.width
        
        let varh = th / fh;
        let varw = tw / fw
        let Nth =  (ih + 100) * varh
        let Ntw =  (iw + 100) * varw
        
        
        let Rect2 = CGRect(x: 0,y: 0,width: iw + 50,height: ih + 200)
        let Rect2Final = CGRect(x: 0,y: 0,width: iw,height: ih)

        let PQTextFrame = CGRect(x: ((iw + 50)/2 - (Ntw / 2)), y: 20, width: Ntw, height: Nth)
        
        let picRect = CGRect(x: 25,y: 85,width: iw,height: ih)
        let picRectComplete = CGRect(x: 0,y: 0,width: iw,height: ih)
      //  frameImage!.drawInRect(Rect2, blendMode:CGBlendMode.Normal, alpha: 1.0)
        
        
        if hideBorder {
            frameImage!.draw(in: Rect2Final, blendMode:CGBlendMode.normal, alpha: 1.0)
            textImage!.draw(in: PQTextFrame, blendMode:CGBlendMode.normal, alpha: 1.0)
            self.TheImage.draw(in: picRectComplete, blendMode: CGBlendMode.normal, alpha: 1.0)
        } else {
            frameImage!.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
            textImage!.draw(in: PQTextFrame, blendMode:CGBlendMode.normal, alpha: 1.0)
            self.TheImage.draw(in: picRect, blendMode: CGBlendMode.normal, alpha: 1.0)
        }

     //   textImage!.drawInRect(PQTextFrame, blendMode:CGBlendMode.Normal, alpha: 1.0)
        
     //   self.TheImage.drawInRect(picRect, blendMode: CGBlendMode.Normal, alpha: 1.0)
        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        //coltonmiller7@gmail.com
        
    
        let FBImage = TheFinalImage
        //let FBImage = newImage
        
        
        //  var FBImage = self.pageViewController.viewControllers!.ui
        // let postresult = shareImageToFaceBook2(FBImage) 
        
        DispatchQueue.main.async(execute: {
            
        let tempTurnNumber = self.theTurnNumber as String
            
        let newTurnNumber = tempTurnNumber.replacingOccurrences(of: "Turn", with: "", options: NSString.CompareOptions.literal, range: nil)
            
        let createdImagePHP = CreateImagePHP(self.gameid, mediaType: self.theMediaType, turnNumber: newTurnNumber as NSString)
        
       // let createdImagePHP = CreateImagePHP(self.gameid, mediaType: self.theMediaType, turnNumber: self.theTurnNumber)
        
        
         DispatchQueue.main.async(execute: {
            
            
            
            /*
         //FACEBOOK INFO
        print("FBSDKAccess Token = \(FBSDKAccessToken.currentAccessToken())")
        
        //   if (FBSDKAccessToken.currentAccessToken() != nil)
        //    {
        let photo : FBSDKSharePhoto = FBSDKSharePhoto()
        photo.image = self.TheFinalImage as UIImage
        photo.userGenerated = true
        
        let linkContent : FBSDKShareLinkContent = FBSDKShareLinkContent()
        
        //  let photo : FBSDKSharePhoto = FBSDKSharePhoto()
        linkContent.contentURL = NSURL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(self.gameid)Turn\(self.theTurnNumber).php")
        
        linkContent.contentTitle = "Pics & Quotes"
        linkContent.contentDescription = "Join this game!"
        linkContent.imageURL = NSURL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(self.gameid)Turn\(self.theTurnNumber).\(self.MediaSuf)")
        
            //print("Attaching URL for Image = http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(self.gameid)Turn\(self.theTurnNumber).\(self.MediaSuf)")
        //linkContent.
        // photo.userGenerated = true
        
        /*
        let content = FBSDKShareLinkContent()
        
        content.contentURL = <URL to the app in the App Store>
        content.imageURL = <valid image URL>
        content.contentTitle = <some title>
        content.contentDescription = <some descr>
        
        let shareDialog = FBSDKShareDialog()
        shareDialog.fromViewController = viewController
        shareDialog.shareContent = content
        shareDialog.delegate = self
        
        if !shareDialog.canShow() {
            print("cannot show native share dialog")
        }
        
       // shareDialog.show()
        */
        
        /*
        let content : FBSDKSharePhotoContent = FBSDKSharePhotoContent()
        //content.photos = [photo]
        //content.
        //content.
        content.contentURL = NSURL(string: "http://\(ServerInfo.sharedInstance)")
        content.photos = [photo]
        
        
        */
        // content.
        let Share : FBSDKShareDialog = FBSDKShareDialog()
        Share.mode = .Native
          //  Share.mode = .FeedBrowser
        Share.fromViewController = self
        //Share.shareContent = content
        Share.shareContent = linkContent
        Share.delegate = self
        //Share.show()
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
        
        if !Share.canShow() {
        
        } else {
        Share.show()
        }
        } else {
        
        getFBPermission()
        print("FB Token = \(FBSDKAccessToken.currentAccessToken())")
        print("Getting permission")
        if !Share.canShow() {
        
        } else {
        Share.show()
        }
        
        
        }
        
        
*/

        
        //  Share.showFromViewController(self, withContent: content, delegate: nil)
        
        
        /*
        let postresult = shareImageToFaceBook(FBImage)
        
        if postresult {
        print("Image posted to facebook")
        } else {
        print("error image not posted")
        }

        */

        
        
       
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
            
            let FBSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            
            FBSheet.setInitialText("I'm Playing Pics & Quotes")
            
            //  FBSheet.addURL(NSURL(string: "http://\(ServerInfo.sharedInstance)/Apps/Pics&Quotes/GoToApp.php"))
            
            let FBImage2 = self.TheFinalImageTwo
            
            FBSheet.add(FBImage)
           // FBSheet.addImage(FBImage2)
            
            FBSheet.add(URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(self.gameid)Turn\(self.theTurnNumber).php"))
            
            FBSheet.completionHandler = {
                result -> Void in
                
                //var fbImage2 = theimage
                let getResult = result as SLComposeViewControllerResult;
                switch(getResult.rawValue){
                case SLComposeViewControllerResult.cancelled.rawValue:
                    print("Cancelled")
                    
                case SLComposeViewControllerResult.done.rawValue:
                    print("it's done")
                    print("Adding Points")
                    let  numPoints = UPData(self.username, userid: self.userID, type: "add", points: "5", levelpoints: "5")
                    //numPoints = FilterUPData(UPurldata)
                    print("number of points after Add = \(numPoints)")
                    
                    /*
                    dispatch_async(dispatch_get_main_queue(), {

                    
                    let AC = JSController("Tokens Earned!", MyMessage: "You Just earned 5 tokens for Sharing this turn on Facebook!",Color: "Green")
                        self.presentViewController(AC, animated: true, completion: {
                            
                              NSNotificationCenter.defaultCenter().postNotificationName("updatePixie", object: nil)
                            
                        })
                        })
                    
                    */
                    
                    DispatchQueue.main.async(execute: {
                    
                    let theAlert = SCLAlertView()
                        
                        theAlert.addButton("OK", action: {
                            NotificationCenter.default.post(name: Notification.Name(rawValue: "updatePixie"), object: nil)
                        })
                        
                        theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Tokens Earned!", subTitle: "You Just earned 5 tokens for Sharing this turn on Facebook!", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                    })
                    
                    
                default:
                    print("error!")
                    
                }
                self.dismiss(animated: true, completion: nil)
            }
            
            // FBSheet.
            
            self.present(FBSheet, animated: true, completion: nil)
            
            
        
            
        } else {
            /*
            let alert = UIAlertController(title: "Accounts", message: "Please login to Facebook", preferredStyle: UIAlertController.Style.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            */
            
            DispatchQueue.main.async(execute: {
            
            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Accounts", subTitle: "Please login to Facebook", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            })
            
            
        }
        
      
            
            
            
            
        })
        })
        
    }

    
    @IBAction func textBTN(_ sender: AnyObject) {
        
        
        var ih2 = CGFloat()
        var iw2 = CGFloat()
        
        
        let ih = self.TheImage.size.height
        let iw = self.TheImage.size.width
        
        if hideBorder {
            ih2 = ih
            iw2 = iw
        } else {
            ih2 = ih + 250
            iw2 = iw + 50
        }
        
        let newSize = CGSize(width: iw2, height: ih2)
        
        UIGraphicsBeginImageContext(newSize)
        
        let frameImage = UIImage(named: "chalkboardTall.png")
        let textImage = UIImage(named: "PQText.png")
        
        _ = ih / iw
        //let niw = 617 * ivar
        let th = textImage!.size.height
        let tw = textImage!.size.width
        
        let fh = frameImage!.size.height
        let fw = frameImage!.size.width
        
        let varh = th / fh;
        let varw = tw / fw
        let Nth =  (ih + 100) * varh
        let Ntw =  (iw + 100) * varw
        
        
        
        
        let Rect2 = CGRect(x: 0,y: 0,width: iw + 50,height: ih + 200)
        let Rect2Final = CGRect(x: 0,y: 0,width: iw,height: ih)
        
        let PQTextFrame = CGRect(x: ((iw + 50)/2 - (Ntw / 2)), y: 20, width: Ntw, height: Nth)
        
        let picRect = CGRect(x: 25,y: 85,width: iw,height: ih)
        let picRectComplete = CGRect(x: 0,y: 0,width: iw,height: ih)
        //  frameImage!.drawInRect(Rect2, blendMode:CGBlendMode.Normal, alpha: 1.0)
        
        
        if hideBorder {
            frameImage!.draw(in: Rect2Final, blendMode:CGBlendMode.normal, alpha: 1.0)
            textImage!.draw(in: PQTextFrame, blendMode:CGBlendMode.normal, alpha: 1.0)
            self.TheImage.draw(in: picRectComplete, blendMode: CGBlendMode.normal, alpha: 1.0)
        } else {
            frameImage!.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
            textImage!.draw(in: PQTextFrame, blendMode:CGBlendMode.normal, alpha: 1.0)
            self.TheImage.draw(in: picRect, blendMode: CGBlendMode.normal, alpha: 1.0)
        }
        
        var TheFinalImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        
        
        
        //   let FBImage = self.theimage
        // let FBImage = newImage
        
        //save to images
        _ = ALAssetsLibrary()
        // let imageToSave = filter.outputImage
        _ = self.TheFinalImage.imageOrientation
        //let imageData = UIImageJPEGRepresentation(TheFinalImage, 1.0)
        let imageData = TheFinalImage.jpegData(compressionQuality: 1.0)
        //let imageData = UIImageJPEGRepresentation(newImage, 1.0)
        _ = UIImage(data: imageData!)
        
        let messageVC = MFMessageComposeViewController()
        
        
        messageVC.body = "";
        // messageVC.recipients = [""]
        messageVC.messageComposeDelegate = self;
        messageVC.addAttachmentData(imageData!, typeIdentifier: "image/jpeg", filename: "GamePhoto.jpeg")
        
        self.present(messageVC, animated: false, completion: nil)
    }
    
    @IBAction func twitterBTN(_ sender: AnyObject) {
        
        print("the media type =\(theMediaType)")
        
        switch theMediaType {
        case "picture":
            MediaSuf = "jpg"
        case "audio":
            MediaSuf = "jpg"
        case "quote":
            MediaSuf = "jpg"
        case "gif":
            MediaSuf = "gif"
            
        default:
            break
        }
        
    
    if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
    
    let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
    twitterSheet.completionHandler = {
    result -> Void in
    
    //var fbImage2 = theimage
    let getResult = result as SLComposeViewControllerResult;
    switch(getResult.rawValue){
    case SLComposeViewControllerResult.cancelled.rawValue:
    print("Cancelled")
    case SLComposeViewControllerResult.done.rawValue:
    print("it's done")
    
    let  numPoints = UPData(self.username, userid: self.userID, type: "add", points: "5", levelpoints: "0")
    //numPoints = FilterUPData(UPurldata)
    print("number of points = \(numPoints)")
    
    DispatchQueue.main.async(execute: {
        
        
        /*
        dispatch_async(dispatch_get_main_queue(), {
            
            
            
            let theAlert = SCLAlertView()
            theAlert.addButton("Ok", action: {
                dispatch_async(dispatch_get_main_queue(), {
                NSNotificationCenter.defaultCenter().postNotificationName("updatePixie", object: nil)
                })
                
                })
                
                theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Tokens Earned!", subTitle: "You Just earned 5 tokens for Sharing this turn on Twitter!", duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
        })
        */
        
        
        DispatchQueue.main.async(execute: {
            
            let theAlert = SCLAlertView()
            
            theAlert.addButton("OK", action: {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "updatePixie"), object: nil)
            })
            
            theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Tokens Earned!", subTitle: "You Just earned 5 tokens for Sharing this turn on Twitter!", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
        })
        
        
        
        /*
        let AC = JSController("Tokens Earned!", MyMessage: "You Just earned 5 tokens for Sharing this turn on Twitter!",Color: "Green")
        self.presentViewController(AC, animated: true, completion: {
             NSNotificationCenter.defaultCenter().postNotificationName("updatePixie", object: nil)
            }

        )
        */
    })

    
    default:
    print("error!")
    
    }
    self.dismiss(animated: true, completion: nil)
    }
        
    let tempTurnNumber = theTurnNumber as String
        
    let newTurnNumber = tempTurnNumber.replacingOccurrences(of: "Turn", with: "", options: NSString.CompareOptions.literal, range: nil)
        
    let createdImagePHP = CreateImagePHP(self.gameid, mediaType: self.theMediaType, turnNumber: newTurnNumber as NSString)
        
        
    twitterSheet.setInitialText("I'm Playing Pics & Quotes")
        
        var ih2 = CGFloat()
        var iw2 = CGFloat()
        
        
        let ih = self.TheImage.size.height
        let iw = self.TheImage.size.width
        
        if hideBorder {
            ih2 = ih
            iw2 = iw
        } else {
            ih2 = ih + 250
            iw2 = iw + 50
        }
        
        let newSize = CGSize(width: iw2, height: ih2)
        
        UIGraphicsBeginImageContext(newSize)
        
        let frameImage = UIImage(named: "chalkboardTall.png")
        let textImage = UIImage(named: "PQText.png")
        
        
        let ivar = ih / iw
        //let niw = 617 * ivar
        let th = textImage!.size.height
        let tw = textImage!.size.width
        
        let fh = frameImage!.size.height
        let fw = frameImage!.size.width
        
        let varh = th / fh;
        let varw = tw / fw
        let Nth =  (ih + 100) * varh
        let Ntw =  (iw + 100) * varw
        
        
        let Rect2 = CGRect(x: 0,y: 0,width: iw + 50,height: ih + 200)
        let Rect2Final = CGRect(x: 0,y: 0,width: iw,height: ih)
        
        let PQTextFrame = CGRect(x: ((iw + 50)/2 - (Ntw / 2)), y: 20, width: Ntw, height: Nth)
        
        let picRect = CGRect(x: 25,y: 85,width: iw,height: ih)
        let picRectComplete = CGRect(x: 0,y: 0,width: iw,height: ih)
        //  frameImage!.drawInRect(Rect2, blendMode:CGBlendMode.Normal, alpha: 1.0)
        
        
        if hideBorder {
            frameImage!.draw(in: Rect2Final, blendMode:CGBlendMode.normal, alpha: 1.0)
            textImage!.draw(in: PQTextFrame, blendMode:CGBlendMode.normal, alpha: 1.0)
            self.TheImage.draw(in: picRectComplete, blendMode: CGBlendMode.normal, alpha: 1.0)
        } else {
            frameImage!.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
            textImage!.draw(in: PQTextFrame, blendMode:CGBlendMode.normal, alpha: 1.0)
            self.TheImage.draw(in: picRect, blendMode: CGBlendMode.normal, alpha: 1.0)
        }
        
        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
    
    
    
    
    
    //   let FBImage = self.theimage
//    let TwitterImage = newImage
    let TwitterImage = TheFinalImage
    
    // let TwitterImage = self.theimage
    
    twitterSheet.add(TwitterImage)
    twitterSheet.add(URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(self.gameid)Turn\(self.theTurnNumber).php"))
    
    self.present(twitterSheet, animated: true, completion: nil)
    
    } else {
    /*
    let alert = UIAlertController(title: "Accounts", message: "Please login to Twitter", preferredStyle: UIAlertController.Style.Alert)
    
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Default, handler: nil))
    
    self.presentViewController(alert, animated: true, completion: nil)
    */
        DispatchQueue.main.async(execute: {
            
            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Accounts", subTitle: "Please login to Twitter", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
        })
    
    
    }
}
    
  
@IBAction func WhatsAppBTN(_ sender: AnyObject) {
  
    print("About to open What's App")
    
    
    var ih2 = CGFloat()
    var iw2 = CGFloat()
    
    
    let ih = self.TheImage.size.height
    let iw = self.TheImage.size.width
    
    if hideBorder {
        ih2 = ih
        iw2 = iw
    } else {
        ih2 = ih + 250
        iw2 = iw + 50
    }
    
    let newSize = CGSize(width: iw2, height: ih2)
    UIGraphicsBeginImageContext(newSize)
    
    let frameImage = UIImage(named: "chalkboardTall.png")
    
   // let ih = self.TheImage.size.height
  //  let iw = self.TheImage.size.width
    
    let ivar = ih / iw
    let niw = 617 * ivar
    
    let Rect2 = CGRect(x: 0,y: 0,width: 935,height: 701)
    let Rect2Final = CGRect(x: 0,y: 0,width: iw,height: ih)

    let picRect = CGRect(x: 47,y: 84,width: niw,height: 617)
//    frameImage!.drawInRect(Rect2, blendMode:CGBlendMode.Normal, alpha: 1.0)
  
    if hideBorder {
        frameImage!.draw(in: Rect2Final, blendMode:CGBlendMode.normal, alpha: 1.0)
    } else {
        frameImage!.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
    }

    
    self.TheImage.draw(in: picRect, blendMode: CGBlendMode.normal, alpha: 1.0)
    
   // var TheImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    
    
    let filename = "myimage.wai"
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, false)[0] as NSString
    let destinationPath = documentsPath.appending("/" + filename)
    
    //  .stringByExpandingTildeInPath
    
    //UIImagePNGRepresentation(newImage)!.writeToFile(destinationPath, atomically: false)
    
    try? TheFinalImage.pngData()!.write(to: URL(fileURLWithPath: destinationPath), options: [])
    let fileUrl = URL(fileURLWithPath: destinationPath) as URL
    
    self.documentController = UIDocumentInteractionController(url: fileUrl)
    self.documentController.delegate = self
    self.documentController.uti = "net.whatsapp.image"
    self.documentController.presentOpenInMenu(from: CGRect.zero, in: self.view, animated: false)
    }
    
    
@IBAction func instagramBTN(_ sender: AnyObject) {
    
    
    let ih = self.TheImage.size.height
    let iw = self.TheImage.size.width
    
    let newSize = CGSize(width: iw + 50, height: ih + 100)
    UIGraphicsBeginImageContext(newSize)
    
    let frameImage = UIImage(named: "chalkboardTall.png")
    let textImage = UIImage(named: "PQText.png")
    
    _ = ih / iw
    //let niw = 617 * ivar
    let th = textImage!.size.height
    let tw = textImage!.size.width
    
    let fh = frameImage!.size.height
    let fw = frameImage!.size.width
    
    let varh = th / fh;
    let varw = tw / fw
    let Nth =  (ih + 100) * varh
    let Ntw =  (iw + 100) * varw
    
    let Rect2 = CGRect(x: 0,y: 0,width: iw + 50,height: ih + 200)
    let Rect2Final = CGRect(x: 0,y: 0,width: iw,height: ih)
    
    let PQTextFrame = CGRect(x: ((iw + 50)/2 - (Ntw / 2)), y: 20, width: Ntw, height: Nth)
    
    let picRect = CGRect(x: 25,y: 85,width: iw,height: ih)
    let picRectComplete = CGRect(x: 0,y: 0,width: iw,height: ih)
    //  frameImage!.drawInRect(Rect2, blendMode:CGBlendMode.Normal, alpha: 1.0)
    
    
    if hideBorder {
        frameImage!.draw(in: Rect2Final, blendMode:CGBlendMode.normal, alpha: 1.0)
        textImage!.draw(in: PQTextFrame, blendMode:CGBlendMode.normal, alpha: 1.0)
        self.TheImage.draw(in: picRectComplete, blendMode: CGBlendMode.normal, alpha: 1.0)
    } else {
        frameImage!.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
        textImage!.draw(in: PQTextFrame, blendMode:CGBlendMode.normal, alpha: 1.0)
        self.TheImage.draw(in: picRect, blendMode: CGBlendMode.normal, alpha: 1.0)
    }
    
   // _:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    
    
    print("About to open Instagram")
    let instagramUrl = URL(string: "instagram://app")
    if(UIApplication.shared.canOpenURL(instagramUrl!)){
        
        
    //let imageData = UIImageJPEGRepresentation(TheFinalImage, 1.0)
    let imageData = TheFinalImage.jpegData(compressionQuality: 1.0)
        //let imageData = UIImageJPEGRepresentation(newImage, 1.0)
    
    
    let captionString = "I'm playing Pics & Quotes"
    let writePath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("instagram.igo")
    print("Instagram Write Path = \(writePath)")
    if(!((try? imageData!.write(to: writePath, options: [.atomic])) != nil)) {
    return
    } else {
    let fileURL = writePath
    self.documentController = UIDocumentInteractionController(url: fileURL)
    self.documentController.delegate = self
    self.documentController.uti = "com.instgram.exclusivegram"
    self.documentController.annotation = NSDictionary(object: captionString, forKey: "InstgramCaption" as NSCopying)
    self.documentController.presentOpenInMenu(from: self.view.frame, in: self.view, animated: true)
    }
    } else {
    print("Insagram app not available")
    }
    
    }

        
@IBAction func saveBTN(_ sender: AnyObject) {

    var ih2 = CGFloat()
    var iw2 = CGFloat()
    
    
   let ih = self.TheImage.size.height
   let iw = self.TheImage.size.width
    
     if hideBorder {
        ih2 = ih
        iw2 = iw
     } else {
        ih2 = ih + 250
        iw2 = iw + 50
    }
  
    let newSize = CGSize(width: iw2, height: ih2)
    UIGraphicsBeginImageContext(newSize)
    
    let frameImage = UIImage(named: "chalkboardTall.png")
    let textImage = UIImage(named: "PQText.png")
    
    _ = ih / iw
    //let niw = 617 * ivar
    let th = textImage!.size.height
    let tw = textImage!.size.width
    
    let fh = frameImage!.size.height
    let fw = frameImage!.size.width
    
    let varh = th / fh;
    let varw = tw / fw
    let Nth =  (ih + 100) * varh
    let Ntw =  (iw + 100) * varw
    
    //use this one
    let Rect2 = CGRect(x: 0,y: 0,width: iw + 50,height: ih + 200)
    let Rect2Final = CGRect(x: 0,y: 0,width: iw,height: ih)
    
    let PQTextFrame = CGRect(x: ((iw + 50)/2 - (Ntw / 2)), y: 20, width: Ntw, height: Nth)
    
    let picRect = CGRect(x: 25,y: 85,width: iw,height: ih)
    let picRectComplete = CGRect(x: 0,y: 0,width: iw,height: ih)
    //  frameImage!.drawInRect(Rect2, blendMode:CGBlendMode.Normal, alpha: 1.0)
    
    
    if hideBorder {
        frameImage!.draw(in: Rect2Final, blendMode:CGBlendMode.normal, alpha: 1.0)
        textImage!.draw(in: PQTextFrame, blendMode:CGBlendMode.normal, alpha: 1.0)
        self.TheImage.draw(in: picRectComplete, blendMode: CGBlendMode.normal, alpha: 1.0)
    } else {
        frameImage!.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
        textImage!.draw(in: PQTextFrame, blendMode:CGBlendMode.normal, alpha: 1.0)
        self.TheImage.draw(in: picRect, blendMode: CGBlendMode.normal, alpha: 1.0)
    }
    
    let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    //    let imageData = UIImagePNGRepresentation(newImage)
    
    
    
    
    
    
    //   let FBImage = self.theimage
    // let FBImage = newImage
    //save to images
    _ = ALAssetsLibrary()
    // let imageToSave = filter.outputImage
    _ = self.TheImage.imageOrientation
    //let imageData = UIImageJPEGRepresentation(newImage, 1.0)
    let imageData = newImage.jpegData(compressionQuality: 1.0)
    let compressedJPGImage = UIImage(data: imageData!)
    UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
    print("Should show JSSAlertView")
    
    //alertview.close()
    _ = JSController("Success", MyMessage: "The Image has been Saved to your photo album",Color: "Green")
    
   // self.presentViewController(AC, animated: true, completion: nil)
    
    
    DispatchQueue.main.async(execute: {
        
        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Success", subTitle: "The Image has been Saved to your photo album", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
    })

    
    
    //alertview.show()
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
 
        
        
        if segue.identifier == "expGame" {
            if let destination = segue.destination as? ConfirmPlayersViewController {
                // destination.GameName = GameNameInfo[GameIndex]
                // destination.player = player
                destination.NewGameTitle = SuggestedTitle
                destination.NewGamePlayers = SuggestedPlayers
                destination.NewGameTurnTime = SuggestedTurnTime as NSString
                destination.NewGameFirstTurn = SuggestedFirstTurn
                //   destination.NewGameImage = SuggestedNewGameImage
                destination.NewGameQuote = SuggestedQuote
                destination.NewGamePictureData = SuggestedNewGamePictureData
            }
            
        }
}
    
    @IBAction func videoBTN(_ sender: AnyObject) {
        CanCreateVideo = true
        
        self.dismiss(animated: true, completion: nil)
        
        self.socialdelegate?.SocialViewControllerFinished(self)
    }
        /*
   // print("Image Count = \(self.images.count)")
    let Image1 = UIImage(named: "QuoteBoxImage.png")
    let Image2 = UIImage(named: "imageFrame.png")
    
    //   self.writeImagesToMovieAtPath()
    //     createVideoFromImage((Image1?.CGImage)!)
    
    let tempVideoFile: NSString = self.VideoFile.description
    
    if tempVideoFile.isEqualToString("")  {
    self.view.addSubview(self.progressHUD)
    
    
    
    self.CreateGameVideo()
    //Image1!, Image2: Image2!)
    print("Creating Video")
    } else {
    self.ShareVideo(self.VideoFile)
    }
    
    //   progressHUD.removeFromSuperview()
    
    }
  */  
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        switch (result.rawValue) {
        case MessageComposeResult.cancelled.rawValue:
            self.dismiss(animated: true, completion:nil)
        case MessageComposeResult.failed.rawValue:
            self.dismiss(animated: true, completion: nil)
            
        case MessageComposeResult.sent.rawValue:
            self.dismiss(animated: true, completion: nil)
            
        default:
            break;
        }
        
    }
 
   /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "expGame" {
            if let destination = segue.destinationViewController as? ConfirmPlayersViewController {
                
                destination.expGame = true
                //destination.ReplyUserID = userID
               // destination.ReplyUser = username
                //
            }
        }
        
    }
   */
    func CreateTheImageGIFPrevious() {
        
        TheFinalImage = PreviousImage
        TheFinalImageTwo = TheImage
        
    }
    
    func CreateTheImageGIF() {
       
        TheFinalImage = PreviousImage
        TheFinalImageTwo = TheImage
        
    }
    
    func CreateTheImage() {
        
        
        
        
        if theTurnNumber == "Turn11" {
            
            TheFinalImage = FullGameImage
            
        } else {
        
        
        var ih2 = CGFloat()
        var iw2 = CGFloat()
        var ih = CGFloat()
        var iw = CGFloat()

        
        var ihP_start = CGFloat()
        var iwP_start = CGFloat()
        
        if QuoteTarget {
        
        ih = self.TheImage.size.height
        iw = self.TheImage.size.width
        
        
        ihP_start = self.PreviousImage.size.height
        iwP_start = self.PreviousImage.size.width
            
            if !IsTurn1 {
                if hideBorder {
                    ih2 = ih
                    iw2 = iw
                } else {
                    ih2 = (ih + 300) + (ih * 0.7)
                    iw2 = iw + 100
                }
            } else {
                ih2 = (ih + 300)
                iw2 = iw + 100
            }

            
        } else {
            
        ihP_start = self.TheImage.size.height
        iwP_start = self.TheImage.size.width
            
       // ihP_start = self.TheImage.size.height
        //iwP_start = self.TheImage.size.width
            
            
        ih = self.PreviousImage.size.height
        iw = self.PreviousImage.size.width
            
            if !IsTurn1 {
                if hideBorder {
                    ih2 = ih
                    iw2 = iw
                } else {
                    ih2 = (ih + 300) + (ih * 0.7)
                    iw2 = iw + 50
                }
            } else {
                ih2 = (ih + 300)
                iw2 = iw + 50
            }

            
        }

        //  let ivar = ih / iw
        //let ImageVar
        let ivarP = ihP_start / iwP_start
        
        
        let newSize = CGSize(width: iw2, height: ih2)
        
        UIGraphicsBeginImageContext(newSize)
        
        let frameImage = UIImage(named: "chalkboardTall.png")
        let textImage = UIImage(named: "PQText.png")
        
        let blueArrow = UIImage(named: "blueArrow.png")

        
        _ = ih / iw
        //let niw = 617 * ivar
        let th = textImage!.size.height
        let tw = textImage!.size.width
        
        let fh = frameImage!.size.height
        let fw = frameImage!.size.width
        
        let varh = th / fh;
        let varw = tw / fw
        let Nth =  (ih + 100) * varh
        let Ntw =  (iw + 100) * varw
        
        let ihP = self.TheImage.size.height * 0.9
        //let iwP = self.TheImage.size.width * 0.7
        let iwP = ihP * ivarP

        
        print("previous image height = \(ihP)")
        print("previous image Width = \(iwP)")

        
        let blueH = ih / 8
        let blueW = ih / 8
        
        
       // let Rect2 = CGRectMake(0,0,iw + 50,ih + 250)
        let Rect2 = CGRect(x: 0,y: 0,width: iw2, height: (ih + 300) + (ih * 0.7))
        let Rect2Final = CGRect(x: 0,y: 0,width: iw,height: ih)
        
        let PQTextFrame = CGRect(x: ((iw + 50)/2 - (Ntw / 2)), y: 20, width: Ntw, height: Nth)
        var picRectTOP = CGRect()
        var picRectBOTTOM = CGRect()
        
        if QuoteTarget {
       picRectTOP = CGRect(x: (iw2 / 2) - (iwP / 2),y: 100,width: iwP,height: ihP)
       picRectBOTTOM = CGRect(x: 25,y: (ih2 / 2) + (25 + blueH),width: iw,height: ih)
            
        } else {
            
            picRectTOP = CGRect(x: (iw2 / 2) - (iw / 2),y: 100,width: iw,height: ih)
            picRectBOTTOM = CGRect(x: 25,y: (ih2 / 2) + (25 + blueH),width: iw,height: ih)

        }
        
        
        let picRectBOTTOM1 = CGRect(x: 25,y: (ih2 / 2) + 25,width: iw,height: ih)

      //  let blueRect = CGRectMake(((iw2 / 2) - (blueW / 2)),(ih2 / 2) + 100,blueH,blueW)
   let blueRect = CGRect(x: ((iw2 / 2) - (blueW / 2)),y: (ih2 / 2) + 25,width: blueH,height: blueW)
        
        let picRectComplete = CGRect(x: 0,y: 0,width: iw,height: ih)
        //  frameImage!.drawInRect(Rect2, blendMode:CGBlendMode.Normal, alpha: 1.0)
        
        if !IsTurn1 {
        
        if hideBorder {
            frameImage!.draw(in: Rect2Final, blendMode:CGBlendMode.normal, alpha: 1.0)
            textImage!.draw(in: PQTextFrame, blendMode:CGBlendMode.normal, alpha: 1.0)
            self.TheImage.draw(in: picRectComplete, blendMode: CGBlendMode.normal, alpha: 1.0)
        } else {
            frameImage!.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
            textImage!.draw(in: PQTextFrame, blendMode:CGBlendMode.normal, alpha: 1.0)
            
            self.PreviousImage.draw(in: picRectTOP, blendMode: CGBlendMode.normal, alpha: 1.0)
          //  blueArrow!.drawInRect(blueRect, blendMode: CGBlendMode.Normal, alpha: 1.0)
            self.TheImage.draw(in: picRectBOTTOM, blendMode: CGBlendMode.normal, alpha: 1.0)
            blueArrow!.draw(in: blueRect, blendMode: CGBlendMode.normal, alpha: 1.0)

        }
        
        } else {
            
            frameImage!.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
            textImage!.draw(in: PQTextFrame, blendMode:CGBlendMode.normal, alpha: 1.0)
            self.TheImage.draw(in: picRectBOTTOM1, blendMode: CGBlendMode.normal, alpha: 1.0)
            
            
            
            print("is turn 1")
        }
        
        
        
        
        TheFinalImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        
        }
        
        //   let FBImage = self.theimage
        // let FBImage = newImage
        
        //save to images
        
        /*
        let library = ALAssetsLibrary()
        // let imageToSave = filter.outputImage
        let orientation = self.TheImage.imageOrientation
        let imageData = UIImageJPEGRepresentation(newImage, 1.0)
        let compressedJPGImage = UIImage(data: imageData!)
        
        let messageVC = MFMessageComposeViewController()
        
        
        messageVC.body = "";
        // messageVC.recipients = [""]
        messageVC.messageComposeDelegate = self;
        messageVC.addAttachmentData(imageData!, typeIdentifier: "image/jpeg", filename: "GamePhoto.jpeg")
        
        self.presentViewController(messageVC, animated: false, completion: nil)
*/
    }
    
    
    func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable: Any])
    {
        print("sharer didCompleteWithResults, results.count\(results.count)")
        print(results)
        // still cannot get post id from photo upload
    }
    
    
    func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {
        
        print("sharer NSError")
       // print(error.description)
        
    }
    
    func sharerDidCancel(_ sharer: FBSDKSharing!) {
        
        print("sharerDidCancel")
        
    }
    
}
