//
//  ImageViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/8/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import StoreKit
import MediaPlayer
import AVFoundation
import AssetsLibrary
import Photos

protocol ImageViewControllerDelegate: class {
    func ImageViewControllerFinished(_ imageviewController: ImageViewController)
}


class ImageViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIActionSheetDelegate, UIAlertViewDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver, AVAudioPlayerDelegate, BrowseImageViewControllerDelegate {
    
    @IBOutlet weak var howtapLEFT: NSLayoutConstraint!
    
    @IBOutlet weak var howtapBOTTOM: NSLayoutConstraint!
    
    @IBOutlet weak var howtapView: UIView!
    
    var IsHandlingAlertMessage = Bool()
    
    var gifNSData = Data()
    var brush: CGFloat = 10.0
    var  ScaleControlsShowing = Bool()
    @IBOutlet weak var sliderBrush: UISlider!

    @IBOutlet weak var labelBrush: UILabel!
    @IBOutlet weak var imageViewBrush: UIImageView!
    
    
    @IBOutlet weak var trimSaveBTN: UIButton!
    
    @IBOutlet weak var cutBTN: UIButton!
    
    @IBOutlet weak var SnipControlsView: UIView!
    
    @IBOutlet weak var snipImage: UIImageView!
    
    @IBOutlet weak var SnipControlsViewW: NSLayoutConstraint!
    @IBOutlet weak var SnipControlsViewH: NSLayoutConstraint!
    
    @IBOutlet weak var SnipControlsViewLEAD: NSLayoutConstraint!
    
    @IBOutlet weak var SnipControlsViewBOTTOM: NSLayoutConstraint!
    
    @IBOutlet weak var ResizeIMG_X: NSLayoutConstraint!
    
    @IBOutlet weak var ResizeIMG_Y: NSLayoutConstraint!
    
    @IBOutlet weak var scaleBothBTN: UIButton!
    @IBOutlet weak var scaleHBTN: UIButton!
    @IBOutlet weak var scaleWBTN: UIButton!
    
    var snipVisible = false
    
    var WasPasted = true
    
    var ScaleItem = String()
    
    @IBOutlet weak var ScaleControlsView: UIView!
    @IBOutlet weak var View1BGimage: UIImageView!
    
    
    @IBOutlet weak var trimBTN: UIButton!
    
    
    @IBOutlet weak var trimView: DashedBorderView!
    

    @IBOutlet weak var resizeWIDTH: NSLayoutConstraint!
    
    
    @IBOutlet weak var lockBTN: UIButton!
    var pencilLocked = Bool()
    
    @IBOutlet weak var resizeIMG: UIImageView!
    
    @IBOutlet weak var resizeHEIGHT: NSLayoutConstraint!
    
    
    @IBOutlet weak var pasteIMGBTN: UIButton!
    
    var DoUploadImage = Bool()
    var DontShowIntro = Bool()
    let SaveProgressHUD3 = ProgressHUD(text: "Saving Image...")
    var pointsUsed = Bool()
    var googleImageData = String()
    var Image64NSData = Data()
    var Image64Data_Audio = Data()
    var AudioDataDecoded = NSString()
    let timeInterval:TimeInterval = 0.1
    
    @IBOutlet var TrackCurrentTimeLBL: UILabel!
    var soundFileURLTemp: URL!
    var SelectedGoogleImage = Bool()
    
    var browseimageviewcontroller: BrowseImageViewController = BrowseImageViewController()
    
    var musicTimer:Timer!
    
    var soundFileURL:URL?
    var UseImageURL = NSString()
    var TheImageURL = NSString()
    var userID = NSString()
    var player:AVAudioPlayer!
    var MediaType = NSString()
    
    @IBOutlet weak var QuotetoDrawView: UIView!
    @IBOutlet weak var QuoteToDraw: UILabel!
    @IBOutlet weak var ShowQuoteView: UIView!
    
    @IBOutlet weak var ShowQuoteViewTOP: NSLayoutConstraint!
    @IBOutlet weak var ShowQuoteViewRight: NSLayoutConstraint!
    
    var ViewHowTo = Bool()
    
    var useGoogleImage = Bool()
    
    @IBOutlet var AudioHolder: UIView!
    @IBOutlet var View1: UIView!
    
    @IBOutlet var View1TOP: NSLayoutConstraint!
    @IBOutlet var ViewHolder2: UIView!
    
    @IBOutlet var RecorderView1TOP: NSLayoutConstraint!
    @IBOutlet var ViewHolder2TOP: NSLayoutConstraint!
    @IBOutlet var ViewHolderTOP: NSLayoutConstraint!
    
    @IBOutlet var CloseBTN: UIButton!
    var IsAudio = Bool()
    
    
    @IBOutlet weak var howtoPaintBTN: UIButton!
    @IBOutlet weak var howtoImageBTN: UIButton!
    @IBOutlet weak var howtoGoogleBTN: UIButton!
    
    var fromGoogle = Bool()
    
    @IBOutlet var ViewHolder: UIView!
    
    var ShowingColors = Bool()
    
    var dismissVC = Bool()
    
    
    
    
    
    var AudioViewShowing = Bool()
    let prefs = UserDefaults.standard
    var product_id: NSString?;
    
    
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    @IBOutlet var playButton: UIButton!
    
    
    @IBOutlet weak var chooseMusicView: UIView!
    var choosingImage = Bool()
    
    @IBOutlet weak var chooseMusicViewTOP: NSLayoutConstraint!
    
    
    @IBOutlet var subAudioHolderTOP: NSLayoutConstraint!
    
    @IBOutlet var subAudioHolder: UIView!
    
    var pdelegate: ImageViewControllerDelegate?
  //  @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var ActInd: UIActivityIndicatorView!
    
    @IBOutlet weak var TopBar: UIToolbar!
    
    @IBOutlet weak var BottomBar: UIToolbar!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var tempImageView: UIImageView!
    var ShowingQuoteView = Bool()
    @IBOutlet weak var tempFirstImageView: UIImageView!
    
       var username = NSString()
    
    @IBOutlet weak var ShowQuoteView2: UIView!
    @IBOutlet weak var toolBar: UIToolbar!
    var image = UIImage()
    var GameTurn = NSString()
    var GameID = NSString()
    //var GameTurn = NSString()
    var TurnNumber = NSString()
    var NewTurn = Int()
    var IsCompleteInfo = NSString()
    
    var AlertType = "yourTurn"
    
    var lastPoint = CGPoint.zero
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var TurnInfo = NSString()
    var DeviceTKN = NSString()
    var CurTurnNumber = NSString()
    var Image64Data = NSString()
    var Image64Data2 = NSString()
    
    var showQuoteInt = Int()
    var showQuote = Bool()
    var GameCompleteNotice = Bool()
    //var googleImageData = NSString()
    var SuccessSubmitNotice = Bool()
    
    var resizeX = CGFloat()
    var resizeY = CGFloat()
    var resizeH = CGFloat()
    var resizeW = CGFloat()
    
    var trimresizeX = CGFloat()
    var trimresizeY = CGFloat()
    var trimresizeH = CGFloat()
    var trimresizeW = CGFloat()
    
    var resizeDegrees = CGFloat()
    var IsTrimming = Bool()
    
    @IBOutlet var viewPinch: UIPinchGestureRecognizer!
    @IBOutlet var imagePan: UIPanGestureRecognizer!
    @IBOutlet var viewPan: UIPanGestureRecognizer!
    
    @IBOutlet var imageRotate: UIRotationGestureRecognizer!
    
    @IBOutlet var imagePinch: UIPinchGestureRecognizer!
    
    /*
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
*/
    
    @IBAction func clearResize(_ sender: AnyObject) {
        
        print("clear image")
        WasPasted = true
        resizeIMG.image = nil
        pencilLocked = false
        self.resizeIMG.isHidden = true
        self.pasteIMGBTN.isHidden = true
        self.trimBTN.isHidden = true
        //self.resizeIMG.layer.borderWidth = 0
        // self.lockBTN.setImage(UIImage(named: "EditButton_white.png"), forState: .Normal)
        self.cutBTN.isHidden = true
        self.lockBTN.isHidden = true
        self.ScaleControlsView.isHidden = true
        self.ScaleControlsShowing = false

        
    }

    @IBAction func trimImage(_ sender: AnyObject) {
        
           if !IsTrimming {
            imagePan.isEnabled  = false
            imagePinch.isEnabled = false
            viewPinch.isEnabled = true
            viewPan.isEnabled = true
            IsTrimming = true
            self.trimView.isHidden = false
            
            self.trimBTN.isEnabled = false
            self.pasteIMGBTN.isEnabled = false
            
            
            
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
            view.addSubview(blurEffectView)
            
            
           } else {
            imagePan.isEnabled = true
            IsTrimming = false
            imagePinch.isEnabled = true
            viewPinch.isEnabled = false
            viewPan.isEnabled = false
            self.trimView.isHidden = true
            self.trimBTN.isEnabled = true
            self.pasteIMGBTN.isEnabled = true
        }
        
    }
    
    @IBAction func PasteResizedImage(_ sender: AnyObject) {
        
        let startH = resizeH
        let startW = resizeW
        let startX = resizeX - (resizeW / 2)
        let startY = (resizeY - (resizeH / 2)) - 70
        print("Start X = \(startX)")
        print("Start Y = \(startY)")
        
    
        
        
        DispatchQueue.main.async(execute: {
            
            let image = self.resizeIMG.image
            
           // self.tempFirstImageView.image = image
            
            let vH = self.tempFirstImageView.frame.height
            let vW = self.tempFirstImageView.frame.width
            
            
            
           // let iH = image!.size.height
            
            
            
          //  let iW = image!.size.width
            //  let picRatio = iW / iH
            
            
          //  let iR = iH / iW
         //   print("image ratio = \(iR)")
            
         //   let nH2 = vW * iR
            
         //   print("nH2 = \(nH2)")
            
         //   var nH = CGFloat()
         //   let vR = vW / iW
          
        /*
            if vR < 1 {
                
                nH = iH
            } else  {
                nH = vH / vR
            }
         */
           
        
        /*
            print("new Height = \(nH)")
            
            let MiddleH = vH / 2
            print("middle H = \(MiddleH)")
            
            let nTop = MiddleH - (nH2 / 2)
        */
        
        
            
            UIGraphicsBeginImageContext(self.tempImageView.frame.size)
            
            self.tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.tempImageView.frame.size.width, height: self.tempImageView.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
            
            self.resizeIMG.image?.draw(in: CGRect(x: startX, y: startY, width: startW, height: startH), blendMode: CGBlendMode.normal, alpha: self.opacity)
            
            // self.tempFirstImageView.image?.drawInRect(CGRect(x: startX, y: startY, width: startW, height: startH), blendMode: CGBlendMode.Normal, alpha: self.opacity)
            
            self.tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            self.tempFirstImageView.image = nil
            self.resizeIMG.image = nil
        
            
        });

        pencilLocked = false
        self.resizeIMG.isHidden = true
         self.trimBTN.isHidden = true
        self.pasteIMGBTN.isHidden = true
        self.resizeIMG.layer.borderWidth = 0
       // self.lockBTN.setImage(UIImage(named: "EditButton_white.png"), forState: .Normal)
        self.cutBTN.isHidden = true
        self.lockBTN.isHidden = true
        self.ScaleControlsView.isHidden = true
        WasPasted = true
        self.trimView.isHidden = true
        snipVisible = false

        
    }
    
    
    @IBOutlet weak var SelectImageView: UIView!
    
    let colors: [(CGFloat, CGFloat, CGFloat)] = [
        (0, 0, 0),
        (105.0 / 255.0, 105.0 / 255.0, 105.0 / 255.0),
        (1.0, 0, 0),
        (0, 0, 1.0),
        (51.0 / 255.0, 204.0 / 255.0, 1.0),
        (102.0 / 255.0, 204.0 / 255.0, 0),
        (102.0 / 255.0, 1.0, 0),
        (160.0 / 255.0, 82.0 / 255.0, 45.0 / 255.0),
        (1.0, 102.0 / 255.0, 0),
        (1.0, 1.0, 0),
        (1.0, 1.0, 1.0),
    ]
    
    @IBAction func lockPencil(_ sender: AnyObject) {
    
        
        /*
        
        if !pencilLocked {
            pencilLocked = true
            self.resizeIMG.hidden = false
            self.pasteIMGBTN.hidden = false
            self.resizeIMG.layer.borderWidth = 2
            self.lockBTN.setImage(UIImage(named: "resizeIconWhite.png"), forState: .Normal)
            print("pencil is locked")
            
            
        } else {
            pencilLocked = false
            self.resizeIMG.hidden = true
            self.pasteIMGBTN.hidden = true
            self.resizeIMG.layer.borderWidth = 0
            self.lockBTN.setImage(UIImage(named: "EditButton_white.png"), forState: .Normal)
            
            print("pencil is unlocked")
        }
*/
    }
    
    
    @IBAction func scaleTrim(_ sender: UIPinchGestureRecognizer) {
        
        
        switch ScaleItem {
            
        case "both":
            print("both")
            self.trimView.transform = self.trimView.transform.scaledBy(x: sender.scale, y: sender.scale)
            //  self.view.transform = CGAffineTransformScale(self.view.transform, sender.scale, sender.scale)
            
            sender.scale = 1
            print("trim Image H = \(trimView.frame.height)")
            print("trim Image W = \(trimView.frame.width)")
            trimresizeH = trimView.frame.height
            trimresizeW = trimView.frame.width
            
        case "height":
            
            print("Height")
            self.trimView.transform = self.trimView.transform.scaledBy(x: 1, y: sender.scale)
            //  self.view.transform = CGAffineTransformScale(self.view.transform, sender.scale, sender.scale)
            
            sender.scale = 1
            print("trim Image H = \(trimView.frame.height)")
            print("trim Image W = \(trimView.frame.width)")
            trimresizeH = trimView.frame.height
            trimresizeW = trimView.frame.width
        case "width":
            print("Width")
            self.trimView.transform = self.trimView.transform.scaledBy(x: sender.scale, y: 1)
            //  self.view.transform = CGAffineTransformScale(self.view.transform, sender.scale, sender.scale)
            
            sender.scale = 1
            print("trim Image H = \(trimView.frame.height)")
            print("trim Image W = \(trimView.frame.width)")
            trimresizeH = trimView.frame.height
            trimresizeW = trimView.frame.width
            
        default:
            
            self.trimView.transform = self.trimView.transform.scaledBy(x: sender.scale, y: sender.scale)
            //  self.view.transform = CGAffineTransformScale(self.view.transform, sender.scale, sender.scale)
            
            sender.scale = 1
            print("trim Image H = \(trimView.frame.height)")
            print("trim Image W = \(trimView.frame.width)")
            trimresizeH = trimView.frame.height
            trimresizeW = trimView.frame.width
            
        }
        
        /*+
        
        if fromGoogle {
        resizeW = (resizeIMG.image?.size.width)!
        resizeH = (resizeIMG.image?.size.height)!
        } else {
        resizeW = (resizeIMG.frame.width)
        resizeH = (resizeIMG.frame.height)
        }
        */
        
    }
    
    @IBAction func scaleImage(_ sender: UIPinchGestureRecognizer) {
        
        
        switch ScaleItem {
           
        case "both":
             print("both")
        self.resizeIMG.transform = self.resizeIMG.transform.scaledBy(x: sender.scale, y: sender.scale)
        //  self.view.transform = CGAffineTransformScale(self.view.transform, sender.scale, sender.scale)
        
        sender.scale = 1
        print("resized Image H = \(resizeIMG.frame.height)")
        print("resized Image W = \(resizeIMG.frame.width)")
        resizeH = resizeIMG.frame.height
        resizeW = resizeIMG.frame.width
         //    trimresizeH = trimView.frame.height
          //   trimresizeW = trimView.frame.width
            case "height":
                
            print("Height")
                self.resizeIMG.transform = self.resizeIMG.transform.scaledBy(x: 1, y: sender.scale)
                //  self.view.transform = CGAffineTransformScale(self.view.transform, sender.scale, sender.scale)
                
                sender.scale = 1
                print("resized Image H = \(resizeIMG.frame.height)")
                print("resized Image W = \(resizeIMG.frame.width)")
                resizeH = resizeIMG.frame.height
                resizeW = resizeIMG.frame.width
        //    trimresizeH = trimView.frame.height
        //    trimresizeW = trimView.frame.width
            case "width":
            print("Width")
                self.resizeIMG.transform = self.resizeIMG.transform.scaledBy(x: sender.scale, y: 1)
                //  self.view.transform = CGAffineTransformScale(self.view.transform, sender.scale, sender.scale)
                
                sender.scale = 1
                print("resized Image H = \(resizeIMG.frame.height)")
                print("resized Image W = \(resizeIMG.frame.width)")
                resizeH = resizeIMG.frame.height
                resizeW = resizeIMG.frame.width
         //   trimresizeH = trimView.frame.height
          //  trimresizeW = trimView.frame.width
            
        default:
        
            self.resizeIMG.transform = self.resizeIMG.transform.scaledBy(x: sender.scale, y: sender.scale)
            //  self.view.transform = CGAffineTransformScale(self.view.transform, sender.scale, sender.scale)
            
            sender.scale = 1
            print("resized Image H = \(resizeIMG.frame.height)")
            print("resized Image W = \(resizeIMG.frame.width)")
            resizeH = resizeIMG.frame.height
            resizeW = resizeIMG.frame.width
        //    trimresizeH = trimView.frame.height
        //    trimresizeW = trimView.frame.width
            
        }
        
        /*+
        
        if fromGoogle {
            resizeW = (resizeIMG.image?.size.width)!
            resizeH = (resizeIMG.image?.size.height)!
        } else {
            resizeW = (resizeIMG.frame.width)
            resizeH = (resizeIMG.frame.height)
        }
*/
        
    }
    
    @IBAction func handleRotate(_ recognizer : UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.rotated(by: recognizer.rotation)
            resizeDegrees = recognizer.rotation
             print("image rotated = \(recognizer.rotation)")
            print("image rotated Degrees = \(resizeDegrees)")
            print("CGAffineTransformRotate = \(view.transform.rotated(by: recognizer.rotation))")
            
            recognizer.rotation = 0
        }
        
        
    }
    
    @IBAction func handlePan(_ recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                y:view.center.y + translation.y)
            print("resized Image X = \(view.center.x)")
             print("resized Image Y = \(view.center.y)")
            resizeX = view.center.x
            resizeY = view.center.y
            
          //  ResizeIMG_X.constant = view.center.x
          //  ResizeIMG_Y.constant = view.center.y
            
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
   
    
    @IBAction func handleTrimPan(_ recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                y:view.center.y + translation.y)
            print("resized Image X = \(view.center.x)")
            print("resized Image Y = \(view.center.y)")
          //  trimresizeX = view.center.x - (trimresizeW / 2)
          //  trimresizeY = view.center.y  - (trimresizeH / 2)
         
            
            trimresizeX = view.center.x
            trimresizeY = view.center.y
            
            //  ResizeIMG_X.constant = view.center.x
            //  ResizeIMG_Y.constant = view.center.y
            
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    
    @IBAction func ShowQuoteBTN(_ sender: AnyObject) {
        /*
        var alertView:UIAlertView = UIAlertView()
        alertView.title = "Your Quote to Draw"
        alertView.message = ("\(Image64Data)")
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.show()
*/
        if MediaType != "audio" {
        
            
        print("before Quote, media type = \(MediaType)")
        let QuoteString: String = Image64Data as String
        let AC = JSController("Your Quote to Draw", MyMessage: "\(QuoteString)",Color: "Blue")
            if !ShowingQuoteView {
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                // self.ShowQuoteViewTOP.constant = middleY
                
                self.ShowQuoteView.center.y = self.ShowQuoteView.center.y - 1000
                
                self.ShowQuoteViewTOP.constant = 0
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
        ShowingQuoteView = true
            }
            
      //  self.presentViewController(AC, animated: true, completion: nil)
            
        } else {
            soundFileURL = URL(string: Image64Data as String)            
            ShowAudioView()
            print("Need to show audio file")
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //self.ViewHolderTOP.constant = 1200
        
        print("use google image = \(useGoogleImage)")
        
        if useGoogleImage {
            myGoogleImage()
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: "StopTimerNotification"), object: nil)
        
        var alreadyShowedQuoteView = Bool()
        
        if prefs.value(forKey: "SHOWQUOTEVIEW") != nil {
        
        alreadyShowedQuoteView = prefs.bool(forKey: "SHOWQUOTEVIEW")
            //valueForKey("SHOWQUOTEVIEW")
            
        } else {
        
            alreadyShowedQuoteView = false
            
        }
       
        
        
        //   ImageLoading.startAnimating();
       // print(
        if showQuoteInt == 1 {
            showQuote = false
        } else {
            showQuote = true
        }
        
//        if showQuote {
       //  if !DontShowIntro {
            
            if !alreadyShowedQuoteView {
            /*
        var alertView:UIAlertView = UIAlertView()
        alertView.title = "Your Quote to Draw"
        alertView.message = ("\(Image64Data)")
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.show()
           */
   
            if MediaType != "audio" {
                ActInd.stopAnimating()
                ActInd.isHidden = true
            print("before quote, media type = \(MediaType)")
            let QuoteString: String = Image64Data as String
            QuoteToDraw.text = QuoteString
                
            let AC = JSController("Your Quote to Draw", MyMessage: "\(QuoteString)",Color: "Blue")
           // self.presentViewController(AC, animated: true, completion: nil)
               
            
                if !ShowingQuoteView {
                UIView.animate(withDuration: 1.0, animations: { () -> Void in
                    
                   // self.ShowQuoteViewTOP.constant = middleY
                    
                    self.ShowQuoteView.center.y = self.ShowQuoteView.center.y - 1200
                    
                    self.ShowQuoteViewTOP.constant = 0
                    //self.ViewShowing = true
                    // ShowingInfo = true
                    
                    // self.ViewTransTOP.constant = 0
                })
                ShowingQuoteView = true
                }
                
            } else {
                ActInd.stopAnimating()
                ActInd.isHidden = true
                ShowAudioView()
               print("Audio file found")
            }
            
      
        }
     //   let decodedData = NSData(base64EncodedString: Image64Data as! String, options: NSDataBase64DecodingOptions(rawValue: 0))
        
        
      //  println("Decoded Data: \(decodedData)")
     //   println("Setting Image")
        
      //  let image = UIImage(data: decodedData!)
        
        
     //   ImagePic.image = image
        
     //   ImageLoading.stopAnimating()
        
    prefs.set(true, forKey: "SHOWQUOTEVIEW")
    }
    
    @IBAction func HIdeQuoteView(_ sender: AnyObject) {
        
        if ShowingQuoteView {
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            // self.ShowQuoteViewTOP.constant = middleY
            
            self.ShowQuoteView.center.y = self.ShowQuoteView.center.y + 1200
            
            self.ShowQuoteViewTOP.constant = 1200
            //self.ViewShowing = true
            // ShowingInfo = true
            
            // self.ViewTransTOP.constant = 0
        })
     ShowingQuoteView = false
        }
    }
    
      func googleImage(_ notification:Notification) {
        
        let data = (notification as NSNotification).userInfo
        let googleImageData2 = data!["data"] as! Data

        useGoogleImage = true
        
       
        fromGoogle = true
        WasPasted = false
        
        
        
        let image = UIImage(data: googleImageData2)
        //  tempImageView.image = image
        
        
        resizeIMG.image = image
        resizeIMG.contentMode = UIViewContentMode.scaleAspectFit
        resizeHEIGHT.constant = self.view.frame.width - 50
        resizeWIDTH.constant = self.view.frame.width - 50
        
        
        
        
        
        
        
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        
        mainImageView.image?.draw(in: CGRect(x: 0, y: 0, width: mainImageView.frame.size.width, height: mainImageView.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
        
        tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: tempImageView.frame.size.width, height: tempImageView.frame.size.height), blendMode: CGBlendMode.normal, alpha: opacity)
        
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempImageView.image = nil
        
        
        
        
        /*
        
        UIGraphicsBeginImageContext(tempImageView.frame.size)
        
        tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: tempImageView.frame.size.width, height: tempImageView.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
        
        tempFirstImageView.image?.drawInRect(CGRect(x: 0, y: nTop, width: vW, height: nH2), blendMode: CGBlendMode.Normal, alpha: opacity)
        
        */
        
        
        
        
        let vHt = resizeIMG.frame.height
        let vWt = resizeIMG.frame.width
        let iHt = image!.size.height
        var nTopt = CGFloat()
        var nSide = CGFloat()
        
        let iWt = image!.size.width
        //  let picRatio = iW / iH
        var nHt = CGFloat()
        var nWt = CGFloat()
        var iRt = CGFloat()
        
        if iHt > iWt {
            
            print("height is bigger")
            nHt = vHt
            iRt = iWt / iHt
            
            nWt = vWt * iRt
            nTopt = 0
            nSide = (self.resizeIMG.frame.width / 2)  - (nWt / 2)
            
            print("start left side = \(nSide)")
            
        } else {
            
            print("width is bigger")
            nWt = vWt
            iRt = iHt / iWt
            nHt = vHt * iRt
            
            nTopt = (self.resizeIMG.frame.height / 2)  - (nHt / 2)
            nSide = 0
        }
        
        
        
        UIGraphicsBeginImageContext(resizeIMG.frame.size)
        
        // resizeIMG.image?.drawInRect(CGRect(x: 0, y: 0, width: resizeIMG.frame.width, height: resizeIMG.frame.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
        resizeIMG.image?.draw(in: CGRect(x: nSide, y: nTopt, width: nWt, height: nHt), blendMode: CGBlendMode.normal, alpha: 1.0)
        
        resizeIMG.image = UIGraphicsGetImageFromCurrentImageContext()
        
        
        
        
        pencilLocked = true
        
        
        self.lockBTN.isHidden = false
        
        self.trimBTN.isHidden = false
        self.cutBTN.isHidden = false
        
        
        self.resizeIMG.isHidden = false
        
        
        //  resizeH = resizeIMG.frame.height
        resizeH = (resizeIMG.image?.size.height)!
        
        //   resizeW = resizeIMG.frame.width
        resizeW = (resizeIMG.image?.size.width)!
        
        print("google H frame= \(resizeH)")
        print("google H image = \(resizeIMG.image?.size.height)")
        
        print("google W frame= \(resizeW)")
        print("google W image = \(resizeIMG.image?.size.width)")
        
        //    resizeH = (resizeIMG.image?.size.height)!
        //    resizeW = (resizeIMG.image?.size.width)!
        
        let DeviceH = self.view.frame.height
        //let halfH = DeviceH / 2;
        let DeviceW = self.view.frame.width
        //  self.resizeX = DeviceH - (resizeIMG.frame.height / 2)
        
        //  self.resizeX = DeviceH - (resizeIMG.image?.sizeframe.height / 2)
        
        //  self.resizeY = DeviceH - (resizeIMG.frame.width / 2)
        
        
        //resizeHEIGHT.constant = DeviceW
        //resizeWIDTH.constant = DeviceW
        self.resizeX = resizeIMG.center.x
        // self.resizeX = DeviceW - ((resizeIMG.image?.size.width)! / 2)
        // self.resizeX = DeviceW - ((resizeIMG.image?.size.width)! / 2)
        // self.resizeY = DeviceH - ((resizeIMG.image?.size.height)! / 2)
        self.resizeY = resizeIMG.center.y
        
        self.pasteIMGBTN.isHidden = false
        self.resizeIMG.layer.borderWidth = 2
        self.resizeIMG.layer.cornerRadius = 5
        self.resizeIMG.layer.borderColor = UIColor.lightGray.cgColor
        self.resizeIMG.clipsToBounds = true
        
        self.ScaleControlsView.isHidden = false
        
        self.ScaleControlsShowing = true
        
        self.trimBTN.isEnabled = true
        
        print("resize frame w = \(resizeIMG.frame.width)")
        print("resize size w = \(resizeIMG.image?.size.width)")
        
        //tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        tempFirstImageView.image = nil
        
        self.prefs.setValue("", forKey: "GOOGLEDATAD")

        
        
        
    }
    
    
    
    
    
    func myGoogleImage() {
        
        fromGoogle = true
        WasPasted = false
    
        
        
        
        if prefs.value(forKey: "GOOGLEDATAD") == nil  {
            
        } else {
            
           googleImageData = prefs.value(forKey: "GOOGLEDATAD") as! String
        
            if googleImageData == "" {
                
            } else {
        

                
                
       // print("POSTING GOOGLE IMAGE WITH DATA: \(googleImageData)")
        /*
        let data = notification.userInfo
        let googleImageData = data!["data"] as! String
       print("google Image Data = \(googleImageData)")
        
*/
        let Image64NSData = Data(base64Encoded: googleImageData as String, options: NSData.Base64DecodingOptions(rawValue: 0))
        
        print("Image 64 NSData : \(Image64NSData)")
        //  print("Image64NSData = \(Image64NSData!)")
        
     //   let Image64Data = NSString(data: Image64NSData!, encoding: NSUTF8StringEncoding)!
        
        
     //   let decodedData = NSData(base64EncodedString: Image64Data as String, options: NSDataBase64DecodingOptions(rawValue: 0))
        
        //  print("Decoded Data: \(decodedData)")
        print("Setting google Image")
        
      //  let image = UIImage(data: decodedData!)
                

                
                
            //    let data = notification.userInfo
            //    let googleImageData = data!["data"] as! String
             //   print("google Image Data = \(googleImageData)")
                
                
                
         let image = UIImage(data: Image64NSData!)
      //  tempImageView.image = image

        
                resizeIMG.image = image
                resizeIMG.contentMode = UIViewContentMode.scaleAspectFit
        resizeHEIGHT.constant = self.view.frame.width - 50
        resizeWIDTH.constant = self.view.frame.width - 50
                
         
                /*
                
        tempFirstImageView.image = image
        
        let vH = tempFirstImageView.frame.height
        let vW = tempFirstImageView.frame.width
        let iH = image!.size.height
        
        
        
        let iW = image!.size.width
        //  let picRatio = iW / iH
        
        
        let iR = iH / iW
        print("image ratio = \(iR)")
        
        let nH2 = vW * iR
        
        print("nH2 = \(nH2)")
        
        var nH = CGFloat()
        let vR = vW / iW
        
        if vR < 1 {
            
            nH = iH
        } else  {
            nH = vH / vR
        }
        
        
        print("new Height = \(nH)")
        
        let MiddleH = vH / 2
        print("middle H = \(MiddleH)")
        
        let nTop = MiddleH - (nH2 / 2)
                
                */
                
                
        
                UIGraphicsBeginImageContext(mainImageView.frame.size)
                
                mainImageView.image?.draw(in: CGRect(x: 0, y: 0, width: mainImageView.frame.size.width, height: mainImageView.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
                
                tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: tempImageView.frame.size.width, height: tempImageView.frame.size.height), blendMode: CGBlendMode.normal, alpha: opacity)
                
                mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                tempImageView.image = nil
                
                
                
                
        /*
 
        UIGraphicsBeginImageContext(tempImageView.frame.size)
  
        tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: tempImageView.frame.size.width, height: tempImageView.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
        
        tempFirstImageView.image?.drawInRect(CGRect(x: 0, y: nTop, width: vW, height: nH2), blendMode: CGBlendMode.Normal, alpha: opacity)
        
      */
                
                
                
                
                let vHt = resizeIMG.frame.height
                let vWt = resizeIMG.frame.width
                let iHt = image!.size.height
                var nTopt = CGFloat()
                var nSide = CGFloat()
                
                let iWt = image!.size.width
                //  let picRatio = iW / iH
                  var nHt = CGFloat()
                var nWt = CGFloat()
                var iRt = CGFloat()
                
                if iHt > iWt {
                
                    print("height is bigger")
                    nHt = vHt
                    iRt = iWt / iHt
                    
                    nWt = vWt * iRt
                    nTopt = 0
                    nSide = (self.resizeIMG.frame.width / 2)  - (nWt / 2)
                    
                    print("start left side = \(nSide)")
                    
                } else {
                    
                    print("width is bigger")
                    nWt = vWt
                    iRt = iHt / iWt
                    nHt = vHt * iRt
                    
                    nTopt = (self.resizeIMG.frame.height / 2)  - (nHt / 2)
                    nSide = 0
                }
                
              
               
                UIGraphicsBeginImageContext(resizeIMG.frame.size)
                
               // resizeIMG.image?.drawInRect(CGRect(x: 0, y: 0, width: resizeIMG.frame.width, height: resizeIMG.frame.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
                resizeIMG.image?.draw(in: CGRect(x: nSide, y: nTopt, width: nWt, height: nHt), blendMode: CGBlendMode.normal, alpha: 1.0)
                
                resizeIMG.image = UIGraphicsGetImageFromCurrentImageContext()
                
                
             
                
                pencilLocked = true
                
                
                 self.lockBTN.isHidden = false
                
                 self.trimBTN.isHidden = false
                
                
                self.resizeIMG.isHidden = false
                
                
              //  resizeH = resizeIMG.frame.height
                resizeH = (resizeIMG.image?.size.height)!
                
             //   resizeW = resizeIMG.frame.width
                resizeW = (resizeIMG.image?.size.width)!
                
                print("google H frame= \(resizeH)")
                print("google H image = \(resizeIMG.image?.size.height)")
                
                print("google W frame= \(resizeW)")
                print("google W image = \(resizeIMG.image?.size.width)")
                
            //    resizeH = (resizeIMG.image?.size.height)!
            //    resizeW = (resizeIMG.image?.size.width)!
                
                let DeviceH = self.view.frame.height
                //let halfH = DeviceH / 2;
                let DeviceW = self.view.frame.width
              //  self.resizeX = DeviceH - (resizeIMG.frame.height / 2)
                
              //  self.resizeX = DeviceH - (resizeIMG.image?.sizeframe.height / 2)
                
              //  self.resizeY = DeviceH - (resizeIMG.frame.width / 2)
                
                
                //resizeHEIGHT.constant = DeviceW
                //resizeWIDTH.constant = DeviceW
                self.resizeX = resizeIMG.center.x
               // self.resizeX = DeviceW - ((resizeIMG.image?.size.width)! / 2)
               // self.resizeX = DeviceW - ((resizeIMG.image?.size.width)! / 2)
               // self.resizeY = DeviceH - ((resizeIMG.image?.size.height)! / 2)
                self.resizeY = resizeIMG.center.y
                
                self.pasteIMGBTN.isHidden = false
                self.resizeIMG.layer.borderWidth = 2
                self.resizeIMG.layer.cornerRadius = 5
                self.resizeIMG.layer.borderColor = UIColor.lightGray.cgColor
                self.resizeIMG.clipsToBounds = true
                
                self.ScaleControlsView.isHidden = false
             self.trimBTN.isEnabled = true
                
                print("resize frame w = \(resizeIMG.frame.width)")
                print("resize size w = \(resizeIMG.image?.size.width)")
                
        //tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                
        UIGraphicsEndImageContext()
        
        tempFirstImageView.image = nil
        
        self.prefs.setValue("", forKey: "GOOGLEDATAD")
            
            }
        }

    }
    
    override func viewDidLoad() {
        ActInd.startAnimating()
        
         prefs.set(false, forKey: "SHOWQUOTEVIEW")
        
        self.trimSaveBTN.isHidden = true
        self.cutBTN.isHidden = true
        IsTrimming = false
        self.SnipControlsViewBOTTOM.constant = 0
        self.SnipControlsViewH.constant = 0
        self.SnipControlsViewW.constant = 0
        self.SnipControlsViewLEAD.constant = 0
        
     
        self.trimView.isHidden = true
        //self.snippedPic.hidden = true
        
        self.SnipControlsView.layer.cornerRadius = 5
        self.SnipControlsView.layer.masksToBounds = true
        self.SnipControlsView.clipsToBounds = true
        
        howtapView.layer.cornerRadius = 15
        howtapView.layer.masksToBounds = true
        howtapView.clipsToBounds = true
        
        self.SnipControlsView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
        
        
        
         self.pasteIMGBTN.isHidden = true
        
         self.lockBTN.setImage(UIImage(named: "resizeIconWhite.png"), for: UIControlState())
        self.resizeIMG.isHidden = true
        let DeviceH = self.view.frame.height
        //let halfH = DeviceH / 2;
        let DeviceW = self.view.frame.width
        resizeHEIGHT.constant = DeviceW - 50
        resizeWIDTH.constant = DeviceW - 50
        self.ScaleControlsView.isHidden = true
     //   self.lockBTN.setImage(UIImage(named: "EditButton_white.png"), forState: .Normal)
        //ActInd.hidden = true
        //ViewHolder.hidden = true
        self.pasteIMGBTN.layer.borderWidth = 1
        self.pasteIMGBTN.layer.borderColor = UIColor.lightGray.cgColor
        self.pasteIMGBTN.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2).cgColor
        self.pasteIMGBTN.layer.cornerRadius = 5
        
        
        self.ScaleControlsView.layer.cornerRadius = 5
        self.ScaleControlsView.layer.masksToBounds = true
        self.ScaleControlsView.clipsToBounds = true
        
        self.ScaleControlsView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
       // self.pasteIMGBTN.setTitle.Color
        
        howtoImageBTN.isEnabled = false
        howtoGoogleBTN.isEnabled = false
        CloseBTN.isEnabled = false
        self.CloseBTN.isHidden = true
        howtoPaintBTN.isEnabled = false
       // self.CloseBTN.hidden = false
        
         self.lockBTN.isHidden = true
         self.lockBTN.isEnabled = false
        
        self.View1BGimage.layer.cornerRadius = 5
        self.View1BGimage.layer.masksToBounds = true
        View1.layer.cornerRadius = 5
        View1.layer.masksToBounds = true
         self.trimBTN.isHidden = true
        
       ShowQuoteView2.layer.cornerRadius = 10
       ShowQuoteView2.layer.masksToBounds = true
       QuotetoDrawView.layer.cornerRadius = 10
        
        NotificationCenter.default.addObserver(self, selector: #selector(ImageViewController.googleImage(_:)), name: NSNotification.Name(rawValue: "googleImage"),  object: nil)
        
        browseimageviewcontroller.browseimagedelegate=self

        ViewHolderTOP.constant = 1200
        ViewHolder.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        
        AudioHolder.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        ShowQuoteView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        
        subAudioHolder.layer.cornerRadius = 10
       // navigationController!.navigationBar.barTintColor = UIColor(red: 0.929, green: 0.113, blue: 0.145, alpha: 1.0)
        
        //self.navigationController!.toolbar.barTintColor = UIColor(red: 0.572, green: 0.882, blue: 0.949, alpha: 0.1)
        
       // TopBar.barTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
        
      
       // BottomBar.barTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
        if GameID == "demo" {
            username = "demoName"
            userID = "demoID"
            MediaType = "quote"
            UseImageURL = "no"
            Image64Data = "Ah!! There's a bug...smash it!"
            TheImageURL = "NA"
        } else {
        username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
        userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
       // }
        
        (Image64Data2, MediaType, UseImageURL, TheImageURL) = GetGameData(GameID, turn: GameTurn)
        
       // print("The Image Data = \(Image64Data2)")
       // print("the Media Type = \(MediaType)")
        
        //print("encoded Quote String = \(Image64Data2)")
        
        print("base 64 encoded file = \(Image64Data2)")
        
        Image64NSData = Data(base64Encoded: Image64Data2 as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
        
        
        print("media type = \(MediaType)")
        
        if MediaType != "audio" {
        
        //WAS IMAGE64DATA BELOW
        Image64Data = NSString(data: Image64NSData, encoding: String.Encoding.utf8.rawValue)!
            
        } else {
            deleteAllRecordings()

            if UseImageURL == "no" {
                
          //  print("Sound NSData = \(Image64NSData)")
            let Image64Data2 = NSString(data: Image64NSData, encoding: String.Encoding.utf8.rawValue)!
           // print("Sound Data2 = \(Image64Data2)")
            Image64Data_Audio = Data(base64Encoded: Image64Data2 as String, options: NSData.Base64DecodingOptions(rawValue: 0))!

            } else {
                
                let FileURL = "\(TheImageURL).mp3"
                let url = URL(string: FileURL as String)
                Image64Data_Audio = try! Data(contentsOf: url!)
            }
            
            
        //    print("SoundNSData 2 = \(Image64Data)")

            let format = DateFormatter()
            format.dateFormat="yyyy-MM-dd-HH-mm-ss"
            let currentFileName = "audio-\(format.string(from: Date())).m4a"
            
            let currentFileNameTemp = "AudioClip.m4a"
         //   print("Current File Name = \(currentFileNameTemp)")
            
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            soundFileURLTemp = documentsDirectory.appendingPathComponent(currentFileNameTemp)
            
            if FileManager.default.fileExists(atPath: soundFileURLTemp.absoluteString) {
                // probably won't happen. want to do something about it?
               // print("soundfile \(soundFileURLTemp.absoluteString) exists")
            }
            
            
   
            
            
          //  print("soundFile URL = \(soundFileURLTemp)")
            
        }
        
    }

        product_id = "com.ClavenSolutions.TelePictionary.pcamera"
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

      SKPaymentQueue.default().add(self)
        
         picker.delegate = self
        
       // UITabBar.appearance().barTintColor = UIColor.redColor()
  
        
        
        SelectImageView.layer.cornerRadius = 10
        
         chooseMusicView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        
        switch GameTurn {
            case "1":
            TurnNumber = "Turn1"
            NewTurn = 2
            //NextTurn =
            case "2":
            TurnNumber = "Turn2"
            NewTurn = 3
            case "3":
            TurnNumber = "Turn3"
            NewTurn = 4
            case "4":
            TurnNumber = "Turn4"
            NewTurn = 5
        case "5":
            TurnNumber = "Turn5"
            NewTurn = 6
        case "6":
            TurnNumber = "Turn6"
            NewTurn = 7
        case "7":
            TurnNumber = "Turn7"
            NewTurn = 8
        case "8":
            TurnNumber = "Turn8"
            NewTurn = 9
        case "9":
            TurnNumber = "Turn9"
            NewTurn = 10
        case "10":
            TurnNumber = "Turn10"
            NewTurn = 11
        default:
            print("Error")
        }
        
        if NewTurn == 11 {
            IsCompleteInfo = "yes"
        } else {
            IsCompleteInfo = "no"
        }
        
        print("Image Turn Number: \(TurnNumber), New Turn is: \(NewTurn), IsComplete is: \(IsCompleteInfo)")
        
        View1.layer.cornerRadius = 10
        CloseBTN.layer.cornerRadius = 10
        
        
        ViewHolder2.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        
        let DeviceH2 = self.view.frame.height
        let middleScreenY = DeviceH2 / 2
        let middleY = middleScreenY - 200
     
        let AlreadySeenHowTo = prefs.bool(forKey: "DidShowHowTo_Image")
        
        if !AlreadySeenHowTo {
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            self.View1TOP.constant = middleY
            
            self.ViewHolder2.center.y = self.ViewHolder2.center.y - 1200
            
            self.ViewHolder2TOP.constant = 0
            //self.ViewShowing = true
            // ShowingInfo = true
            
            // self.ViewTransTOP.constant = 0
            self.ViewHowTo = true
            
             self.howtoPaintBTN.isEnabled = true
            
            
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                
                self.howtapView.center.y = self.howtapView.center.y - 1000
                self.howtapBOTTOM.constant = 50
                
            })
            
            
            
        })
 
      }
         NotificationCenter.default.addObserver(self, selector: #selector(ImageViewController.HandleAlertMessageIVC(_:)), name: NSNotification.Name(rawValue: "HandleAlertMessageIVC"),  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ImageViewController.displayForegroundDetails), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    @IBAction func View1CloseBTN(_ sender: AnyObject) {
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if ViewHowTo {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.View1TOP.constant = middleY
                
                self.ViewHolder2.center.y = self.ViewHolder2.center.y + 1200
                
                self.ViewHolder2TOP.constant = 1200
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            
            ViewHowTo = false
        }
        
      
        self.prefs.set(true, forKey: "DidShowHowTo_Image")
      
        
    }
    @IBAction func browseGoogleNow(_ sender: AnyObject) {
        
        
         if GameID != "demo" {
        
        
        if !prefs.bool(forKey: "CameraPurchased") {
            print("Cameara not purchased")
            var numPoints = 0;
            var LevelUpTime = Bool()
            (numPoints, LevelUpTime) = UPData(self.username, userid: self.userID, type: "get", points: "0",levelpoints: "0")
            //numPoints = FilterUPData(UPurldata)
            print("number of points = \(numPoints)")
            
            if numPoints > 9 {
                
                //   let check = UserStatusCheck(username, status: "audio", action: "check")
                
                //  if check{
                
                
                let theAlert2 = SCLAlertView()
                theAlert2.addButton("Yes") {
                    
                    self.pointsUsed = true
                    
                    DispatchQueue.main.async(execute: {
                        self.performSegue(withIdentifier: "browseimage", sender: self)
                    })
                    
                }
                theAlert2.addButton("No") {
                    
                    let theAlert = SCLAlertView()
                    theAlert.addButton("Let's do it") {
                        
                        
                        self.purchaseitems()
                    }
                    
                    // theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Use Your Camera", subTitle: "Add to your toolbox?")
                    
                    theAlert.addButton("No Thanks") {
                        
                    }
                    
                    //theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Import Photos", subTitle: "Add to your toolbox?")
                    theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Image Search", subTitle: "Add photos any time for only $0.99?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                    
                }
                // theAlert2.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Use Your Tokens?", subTitle: "Use 10 tokens to proceed?")
                
                
                theAlert2.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Use Your Tokens?", subTitle: "Use 10 tokens to add an image? *earn more by starting new games", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                
                
                
            } else {
                
                
                let check = UserStatusCheck(self.username, userID: self.userID, status: "photo", action: "check")
                
                if check{
                    
                    let theAlert2 = SCLAlertView()
                    theAlert2.addButton("Thanks") {
                        
                        DispatchQueue.main.async(execute: {
                            self.performSegue(withIdentifier: "browseimage", sender: self)
                        })
                        
                    }
                    
                    //theAlert2.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Great News!", subTitle: "Try it for Free")
                    
                    theAlert2.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Great News!", subTitle: "Try it for Free", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                    
                } else {
                    
                    let theAlert = SCLAlertView()
                    theAlert.addButton("Let's do it") {
                        
                        self.purchaseitems()
                    }
                    
                    
                    
                    
                    theAlert.addButton("No Thanks") {
                        
                    }
                    
                    //theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Import Photos", subTitle: "Add to your toolbox?")
                    theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Image Search", subTitle: "Add photos any time for only $0.99?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                    
                }
            }
        } else if prefs.bool(forKey: "CameraPurchased") {
            
            DispatchQueue.main.async(execute: {
                self.performSegue(withIdentifier: "browseimage", sender: self)
            })
            
        }
        
        
        
         } else {
            DispatchQueue.main.async(execute: {
                self.performSegue(withIdentifier: "browseimage", sender: self)
            })
        }
        
        
      
        
        
        
        
    }
    
    @IBAction func ShowChooseMusicView(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        
        if !choosingImage {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
              //  self.chooseMusicView.center.y = self.chooseMusicView.center.y - 1200
                
               // self.chooseMusicViewTOP.constant = 0     //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            //choosingImage = true
           
            //touchesBe
        }  //  }
    }
    
    @IBAction func ViewHowTo(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if !ViewHowTo {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.View1TOP.constant = middleY
                
                self.ViewHolder2.center.y = self.ViewHolder2.center.y - 1200
                
                self.ViewHolder2TOP.constant = 0
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            
            ViewHowTo = true
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func reset(_ sender: AnyObject) {
        
        
        let theAlert = SCLAlertView()
      
        theAlert.addButton("Clear") {
            self.mainImageView.image = nil
            self.tempImageView.image = nil
        }
       // theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Clear All?", subTitle: "Are you sure? This cannot be undone.")
        
        theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Clear All?", subTitle: "Are you sure? This cannot be undone.", duration: nil, completeText: "Cancel", style: .custom, colorStyle: 1, colorTextButton: 1)
        
        /*
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Clear All?", message: "Are you sure you clear all? This cannot be undone.", preferredStyle: .Alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Do some stuff
        }
        actionSheetController.addAction(cancelAction)
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Clear", style: .Default) { action -> Void in
            
            
            self.mainImageView.image = nil
            self.tempImageView.image = nil
        }

        actionSheetController.addAction(nextAction)
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)
*/
        
       
    }
    
    
    func deleteAllRecordings() {
        let docsDir =
        NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        let fileManager = FileManager.default
        
        do {
            let files = try fileManager.contentsOfDirectory(atPath: docsDir)
            var recordings = files.filter( { (name: String) -> Bool in
                return name.hasSuffix("m4a")
            })
            for i in 0 ..< recordings.count {
                let path = docsDir + "/" + recordings[i]
                
                print("removing \(path)")
                do {
                    try fileManager.removeItem(atPath: path)
                } catch let error as NSError {
                   //NSLog("could not remove \(path)")
                    print(error.localizedDescription)
                }
            }
            
        } catch let error as NSError {
            print("could not get contents of directory at \(docsDir)")
            print(error.localizedDescription)
        }
        
    }
    
    override func canPerformUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, withSender sender: Any) -> Bool {
        return true
    }
  /*
    override func viewControllerForUnwindSegueAction(action: Selector, fromViewController: UIViewController, withSender sender: AnyObject?) -> UIViewController? {
        <#code#>
    }
    */
    @IBAction func BackBTN(_ sender: AnyObject) {
        
        
        let theAlert = SCLAlertView()
      
        theAlert.addButton("Go To Menu") {
            
            self.dismissVC = true

            print("trying to perform go back button")
             NotificationCenter.default.post(name: Notification.Name(rawValue: "DismissVC"), object: nil, userInfo: nil);
           // NSNotificationCenter.defaultCenter().postNotificationName("DismissVC", object: nil, userInfo: nil);
                // self.dismissViewControllerAnimated(true, completion: nil)
            
            if self.GameID != "demo" {
            
            
           // self.performSegueWithIdentifier("Turn_Complete", sender: self)
                 self.dismiss(animated: true, completion: nil)
                
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            
          //   dispatch_async(dispatch_get_main_queue(), {
            
      
            
          //  })
             //self.performSegueWithIdentifier("BackToMyGames", sender: self)
        }
      //  theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Go to Menu?", subTitle: "Go to Main Menu...this will clear the image below?")
        
        theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Go To Menu?", subTitle: "Go to Main Menu...this will clear the image below?", duration: nil, completeText: "Cancel", style: .custom, colorStyle: 1, colorTextButton: 1)
        

      /*
        
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Go to Menu?", message: "Go to Main Menu...this will clear the image below?", preferredStyle: .Alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Do some stuff
        }
        actionSheetController.addAction(cancelAction)
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Go To Menu", style: .Default) { action -> Void in
            
            
            self.dismissVC = true
            
            //self.dismissViewControllerAnimated(true, completion: nil)
            
            /////  self.pdelegate?.ImageViewControllerFinished(self)
            
            /////  self.dismissViewControllerAnimated(true, completion: nil)
            print("trying to perform go back button")
            //self.performSegueWithIdentifier("Turn_Complete", sender: self)
            
            
            //     dispatch_async(dispatch_get_main_queue(), { self.dismissViewControllerAnimated(true, completion: {
            
            self.performSegueWithIdentifier("Turn_Complete", sender: self)
            
            //     })
            //   })
            
            
        }
        
        //ERROR
        /*
        var subView = actionSheetController.view.subviews.first as! UIView
        var contentView = subView.subviews.first as! UIView
        var contentView2 = subView.subviews.last as! UIView
        
        contentView.backgroundColor = UIColor(red: 0.249, green: 0.549, blue: 0.674, alpha: 0.5)
        contentView.tintColor = UIColor(red: 0.572, green: 0.882, blue: 0.949, alpha: 1.0)
        // contentView.
        contentView2.tintColor = UIColor(red: 0.572, green: 0.882, blue: 0.949, alpha: 1.0)
        */
        
        
        actionSheetController.addAction(nextAction)
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)
*/
  
    }
    
    @IBAction func share(_ sender: AnyObject) {
        
        
        
        let theAlert = SCLAlertView()
               theAlert.addButton("Submit Picture") {
            
            if self.WasPasted {
                
                self.view.addSubview(self.SaveProgressHUD3)
                
                DispatchQueue.main.async(execute: {
                    self.SubmitPic()
                })
            } else {
                let AC = JSController("Wait...", MyMessage: "Did you forget to paste the image you imported?",Color: "Red")
               // self.presentViewController(AC, animated: true, completion: nil)
                
                let theAlert2 = SCLAlertView()
                          // theAlert2.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Submit Picture", subTitle: "Are you sure you submit your image?")
                
                 theAlert2.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Submit Picture", subTitle: "No image to submit, please add an image.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
                
            }
        }
        //theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Submit Picture", subTitle: "Are you sure you submit your image?")
        
        theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Submit Picture", subTitle: "Are you sure you submit your image?", duration: nil, completeText: "Cancel", style: .custom, colorStyle: 1, colorTextButton: 1)
        
       /*
let actionSheetController: UIAlertController = UIAlertController(title: "Submit Picture?", message: "Are you sure you submit your image?", preferredStyle: .Alert)

//Create and add the Cancel action
let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
//Do some stuff
        }
actionSheetController.addAction(cancelAction)
//Create and an option action
let nextAction: UIAlertAction = UIAlertAction(title: "Submit Picture", style: .Default) { action -> Void in
    
   //self.ActInd.startAnimating()
    
   //let submitResults =  self.SubmitPic()
   //  dispatch_async(dispatch_get_main_queue(), {    self.view.addSubview(self.SaveProgressHUD)
    //  })    //dispatch_async(dispatch_get_main_queue
    
    /*dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            
            */
    
    
      if self.WasPasted {
    
    self.view.addSubview(self.SaveProgressHUD3)
    
    dispatch_async(dispatch_get_main_queue(), {
    
    self.SubmitPic()
    
    })
        
      } else {
        
        let AC = JSController("Wait...", MyMessage: "Did you forget to paste the image you imported?",Color: "Red")
        self.presentViewController(AC, animated: true, completion: nil)
        
    }
    //self.ActInd.stopAnimating()
   // });
  
    /*
    if submitResults {
        
        dispatch_async(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("Turn_Complete", sender: self)
            
        }
        
    } else {
        let AC = JSController("Error!", "There was an error submitting your image please try again..","Red")
        self.presentViewController(AC, animated: true, completion: nil)    }
    
    */
        }
 
        //ERROR
        /*
        var subView = actionSheetController.view.subviews.first as! UIView
        var contentView = subView.subviews.first as! UIView
        var contentView2 = subView.subviews.last as! UIView

            contentView.backgroundColor = UIColor(red: 0.249, green: 0.549, blue: 0.674, alpha: 0.5)
            contentView.tintColor = UIColor(red: 0.572, green: 0.882, blue: 0.949, alpha: 1.0)
            // contentView.
            contentView2.tintColor = UIColor(red: 0.572, green: 0.882, blue: 0.949, alpha: 1.0)
            */
      
        
        actionSheetController.addAction(nextAction)
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)
*/
    }

func SubmitPic () -> NSString {
    
   // ActInd.hidden = false
  //  ActInd.startAnimating()
    //let progressHUD = ProgressHUD(text: "Saving Game Data")
    
   // self.view.addSubview(progressHUD)
    
  prefs.set(false, forKey: "SHOWQUOTEVIEW")
    
    //boolForKey("SHOWQUOTEVIEW")
    
    
    var GameType = NSString()
    
  //  var sent = Bool()

       // ActInd.startAnimating()
    
    
    
    print("merging image layer 2 with main image")
    
    print("point used = \(pointsUsed)")
    if pointsUsed {
        print("points are being used")
       // var numPoints = 0;
      let TakePoints = UPData(self.username, userid: self.userID, type: "delete", points: "10", levelpoints: "0")
        //numPoints = FilterUPData(UPurldata)
        print("number of points after use = \(TakePoints)")
    }
    
    /*
    UIGraphicsBeginImageContext(mainImageView.frame.size)
 
    
    mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: mainImageView.frame.size.width, height: mainImageView.frame.size.height), blendMode: kCGBlendModeNormal, alpha: 1.0)
    
    tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: tempImageView.frame.size.width, height: tempImageView.frame.size.height), blendMode: kCGBlendModeNormal, alpha: opacity)
    
    mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    tempImageView.image = nil
    println("tempImage / layer two = nil")
    
        
    //
    
    let smallImage = mainImageView.image!.resize(0.5)
    
    */
    

   UIGraphicsBeginImageContext(mainImageView.bounds.size)
    
    
    mainImageView.image?.draw(in: CGRect(x: 0, y: 0,
            width: mainImageView.frame.size.width, height: mainImageView.frame.size.height))
    
    tempImageView.image?.draw(in: CGRect(x: 0, y: 0,
        width: tempImageView.frame.size.width, height: tempImageView.frame.size.height))
    
    
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
//UNCOMMENT BELOW TO CHANGE PICTURE SIZE
    //    let smallImage = image.resize(0.5)
    
     //   let imageData = UIImageJPEGRepresentation(smallImage, 0.6)
    let imageData = UIImageJPEGRepresentation(image, 1.0)
    
    //DONT DELETE BELOW
    var base64Image = String()
    
    if MediaType == "gif" {
        
     base64Image = gifNSData.base64EncodedString(options: [])
        
    } else {
    
    base64Image = imageData!.base64EncodedString(options: [])
    
    }
    
    
    let base64ImageName = "Game\(GameID)\(TurnNumber)"
    
    
print("*****GAMETURN INFO: \(base64ImageName)*****")
        
       // uploadImageOne()
            let turnStyle = "picture"
    var post = NSString()
    
    if MediaType == "gif" {
        
        post = "GameID=\(GameID)&ImageData=\(base64ImageName)&TurnNumber=\(TurnNumber)&IsComplete=\(IsCompleteInfo)&NewTurn=\(NewTurn)&turnstyle=\(turnStyle)&username=\(username)&userID=\(userID)&mediatype=gif" as NSString
        
    } else {
        

             post = "GameID=\(GameID)&ImageData=\(base64ImageName)&TurnNumber=\(TurnNumber)&IsComplete=\(IsCompleteInfo)&NewTurn=\(NewTurn)&turnstyle=\(turnStyle)&username=\(username)&userID=\(userID)&mediatype=image" as NSString
    }
           //NSLog("PostData: %@",post);
    
    
            print("image view PostData: ",post);
            
            let url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/UpdateGame.php")!
            
            let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            
            let postLength:NSString = String( postData.count ) as NSString
            
            let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            
           // var reponseError: NSError?
            var response: URLResponse?
            
            var urlData: Data?
            do {
                urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
            } catch let error as NSError {
                print(error)
                urlData = nil
            }
            
            if ( urlData != nil ) {
                let res = response as! HTTPURLResponse!;
                
            //   //NSLog("Response code: %ld", res?.statusCode);
                
                if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
                {
                    let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
                    
                   //NSLog("Response ==> %@", responseData);
                    
                    print("Response ==> %@", responseData);
                    
                   // var error: NSError?
                    
                    let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
                    
                    
                    let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
                    
                    TurnInfo = jsonData.value(forKey: "turn") as! NSString
                    
                    DeviceTKN = jsonData.value(forKey: "token") as! NSString
                    
                    CurTurnNumber = jsonData.value(forKey: "turnInfo") as! NSString
                    
                    GameType = jsonData.value(forKey: "gametype") as! NSString
                    
                    
                    //var tokenNew = DeviceTKN.stringByReplacingOccurrencesOfString("'", withString: "")
                    
                    print("JSON TurnInfo - \(TurnInfo)")
                    
                 
                   // SendTurnNotice(TurnInfo, DeviceTKN, GameID, CurTurnNumber, AlertType)
                    
                    
                    //[jsonData[@"success"] integerValue];
                    
                   //NSLog("Success: %ld", success);
                    
                    if(success == 1)
                    {
                       //NSLog("Sign Up SUCCESS");
                        
                      DoUploadImage = true
                        
                        
                        if DoUploadImage {
                            
                        if GameID != "demo" {
                            if MediaType == "gif" {
                                
                                
                            UploadGameFileData(base64Image as String, FileName: "Game\(GameID)\(TurnNumber)", Type: "gif")
                                
                            } else {
                            
                            
                            
                            print("SHOULD UPLOAD IMAGE NOW")
                            print("BASE 64 DATA IS = \(base64Image)")
                            UploadGameFileData(base64Image as String, FileName: "Game\(GameID)\(TurnNumber)", Type: "image")
                            }
                        }
                            // UploadGameFile(imageData, FileName: "TestTurn1")
                        }
                        
                      
                        
                        let AlertType = "yourTurn"
                        
                        
                        if GameID != "demo" {
                        
                            let GameData = MyTurnsCount(username, userID: userID)
                            
                        
                        if TurnInfo == "NA" && DeviceTKN == "NA" && CurTurnNumber == "NA" && GameType == "NA" {
                            
                            print("Game Complete Notice Sent")
                            
                            
                            let alertView:UIAlertView = UIAlertView()
                            alertView.title = "Game Complete!"
                            alertView.message = "You have completed this game.  All Players have been sent a notice that the game is complete."
                            alertView.delegate = self
                            alertView.addButton(withTitle: "OK")

                            
                            /*
                            let AC = JSController("Game Complete!", "You have completed this game.  All Players have been sent a notice that the game is complete.","Green")
                            self.presentViewController(AC, animated: true, completion: nil)
*/
                            
                            
                            //alertView.show()
                            
                            
                            let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc: UIViewController = sb.instantiateViewController(withIdentifier: "start") as UIViewController
                            
                            let window = UIApplication.shared.windows[0] as UIWindow;
                            
                            /* UIView.transition.FromView(window.rootViewController.view, toView: vc.view, duration: 0.65, options .TransitionCrossDissolve, completion: { finished in window.rootViewController = vc })
                            */
                            
                            self.SaveProgressHUD3.removeFromSuperview()
                            
                            
                            //  self.dismissViewControllerAnimated(true, completion: {
                            
                            
                            
                            NotificationCenter.default.post(name: Notification.Name(rawValue: "DismissVC"), object: nil, userInfo: nil);
                            //   dispatch_async(dispatch_get_main_queue(), {

                            self.dismiss(animated: true, completion: nil)
                            
                            //  })
                            
                            
                            
                            
                            /*
                            UIView.transitionFromView((window.rootViewController?.view)!, toView: vc.view, duration: 0.65, options: .TransitionCrossDissolve, completion: {
                                
                                
                                
                                
                                finished in window.rootViewController = vc
                                
                                
                                
                             //   SendTurnNotice(self.TurnInfo, token: self.DeviceTKN, gameid: self.GameID, turninfo: self.CurTurnNumber, alertType: AlertType, gameType: GameType, turninfoID: "test")
                                
                            })
                            */
                            
                            
                            

                            
                        } else {
                            
                            print("about to send turn notice")
                        
                            /*
                            SendTurnNotice(TurnInfo, token: DeviceTKN, gameid: GameID, turninfo: CurTurnNumber, alertType: AlertType, gameType: GameType, turninfoID: "test")
                            */
                            /*
                            let AC = JSController("Success!", "Your Image has been saved.  Each player is getting a message now about the new game now.","Green")
                            self.presentViewController(AC, animated: true, completion: nil)
*/
                          
                            let alertView:UIAlertView = UIAlertView()
                            alertView.title = "Success!"
                            alertView.message = "Your Image has been saved.  Each player is getting a message now about the new game now."
                            alertView.delegate = self
                            alertView.addButton(withTitle: "OK")
                            
                           // alertView.show()
                            
                            
                            

                            let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc: UIViewController = sb.instantiateViewController(withIdentifier: "start") as UIViewController
                            let window = UIApplication.shared.windows[0] as UIWindow;
                            
                            /* UIView.transition.FromView(window.rootViewController.view, toView: vc.view, duration: 0.65, options .TransitionCrossDissolve, completion: { finished in window.rootViewController = vc })
                            */
                            
                            self.SaveProgressHUD3.removeFromSuperview()
                          
                            
                            
                            NotificationCenter.default.post(name: Notification.Name(rawValue: "DismissVC"), object: nil, userInfo: nil);
                            //   dispatch_async(dispatch_get_main_queue(), {
                            
                            self.dismiss(animated: true, completion: nil)
                            
                            /*
                            
                            NSNotificationCenter.defaultCenter().postNotificationName("DismissVC", object: nil, userInfo: nil);
                            
                              self.dismissViewControllerAnimated(true, completion: {
                            
                            
                            
                            
                         //   UIView.transitionFromView((window.rootViewController?.view)!, toView: vc.view, duration: 0.65, options: .TransitionCrossDissolve, completion: {

                            
                            
                            
                            finished in window.rootViewController = vc
                            
                                
                                
                                SendTurnNotice(self.TurnInfo, token: self.DeviceTKN, gameid: self.GameID, turninfo: self.CurTurnNumber, alertType: AlertType, gameType: GameType, turninfoID: "test", myID: self.userID)
                                
                             //   NSNotificationCenter.defaultCenter().postNotificationName("DismissVC", object: nil, userInfo: nil);
                                //   dispatch_async(dispatch_get_main_queue(), {
                             //   self.dismissViewControllerAnimated(true, completion: nil)
                            
                            })
                            
                            */
                            
                            //  })
                            
                            
                        }
                    } else {
                            
                            
                    SaveVideoToDirectory(imageData!, name: "/DemoImageTurn.jpg")
                            
                            
                    self.dismiss(animated: true, completion: nil)
                            
                        }

                    
                    } else {
                        
                    
                    }
                    
                } else {
                   
                    
                }
            }  else {
                
               
            }
        
        
    
    
        print("Turn Complete Segue")
            
        return TurnInfo
        
    }


    
    func uploadImageOne(){
        let imageData = UIImagePNGRepresentation(image)
        
        if imageData != nil{
            let request = NSMutableURLRequest(url: URL(string:"\(ServerInfo.sharedInstance)/Apps/TelePictionary/UpdateGame.php")!)
            var session = URLSession.shared
            
            request.httpMethod = "POST"
            
            let boundary = NSString(format: "---------------------------14737809831466499882746641449")
            let contentType = NSString(format: "multipart/form-data; boundary=%@",boundary)
            //  println("Content Type \(contentType)")
            request.addValue(contentType as String, forHTTPHeaderField: "Content-Type")
            
            let body = NSMutableData()
            
            
            // Title
            body.append(NSString(format: "\r\n--%@\r\n",boundary).data(using: String.Encoding.utf8.rawValue)!)
            body.append(NSString(format:"Content-Disposition: form-data; name=\"title\"\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
            body.append("Hello World".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            
            // Image
            body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
            body.append(NSString(format:"Content-Disposition: form-data; name=\"profile_img\"; filename=\"img.jpg\"\\r\n").data(using: String.Encoding.utf8.rawValue)!)
            body.append(NSString(format: "Content-Type: application/octet-stream\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
            body.append(imageData!)
            body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
            
            print("Body: \(body)")
            
            request.httpBody = body as Data
            
            
            let returnData = try? NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: nil)
            
            let returnString = NSString(data: returnData!, encoding: String.Encoding.utf8.rawValue)
            
            print("returnString \(returnString)")
            
        }
        
        
    }
    
    @IBAction func ShowColors(_ sender: AnyObject) {
        print("Showing Colors")
        if !ShowingColors {
       // ViewHolder.hidden = false
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            //self.View1TOP.constant = middleY
            
            self.ViewHolder.center.y = self.ViewHolder.center.y - 1200
            
            self.ViewHolderTOP.constant = 0
            // self.ViewTransTOP.constant = 0
        })
        
        ShowingColors = true
            
        }
    }
    
    
    @IBAction func HideColors(_ sender: AnyObject) {
        print("Hiding Colors")
        if ShowingColors  {
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            //self.View1TOP.constant = middleY
            
            self.ViewHolder.center.y = self.ViewHolder.center.y + 1200
            
            self.ViewHolderTOP.constant = 1200
            //self.ViewHolder.hidden = true
            // self.ViewTransTOP.constant = 0
        })
            ShowingColors = false
        }
    }
    
    
    @IBAction func pencilPressed(_ sender: AnyObject) {
        
        var index = sender.tag ?? 0
        if index < 0 || index >= colors.count {
            index = 0
        }
        
        (red, green, blue) = colors[index]
        
        if index == colors.count - 1 {
            opacity = 1.0
        }
        
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            //self.View1TOP.constant = middleY
            
            self.ViewHolder.center.y = self.ViewHolder.center.y + 1200
            
            self.ViewHolderTOP.constant = 1200
            // self.ViewTransTOP.constant = 0
        })
        ShowingColors = false
        
    }
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches began")
        
        print(" audio view showing = \(AudioViewShowing)")
        print(" ShowingColors = \(ShowingColors)")
        print(" choosingImage = \(choosingImage)")
        print(" ShowingQuoteView = \(ShowingQuoteView)")
        print(" pencilLocked = \(pencilLocked)")
        print(" IsTrimming = \(IsTrimming)")
       
            swiped = false
            
            if !ShowingColors {
                // if touch = touches.first as? UITouch {
                  let touch = touches.first!
                  lastPoint = touch.location(in: self.view)
                    // lastPoint = touch.locationInView(self.tempImageView)
                //}
            }
  
    }
    
    func drawLineFrom(_ fromPoint: CGPoint, toPoint: CGPoint) {
         print("draw line")
        
        print(" audio view showing = \(AudioViewShowing)")
        print(" ShowingColors = \(ShowingColors)")
        print(" choosingImage = \(choosingImage)")
        print(" ShowingQuoteView = \(ShowingQuoteView)")
        print(" pencilLocked = \(pencilLocked)")
        print(" IsTrimming = \(IsTrimming)")
            
        
      if !AudioViewShowing {
        if !ShowingColors {
            if !choosingImage {
                if !ShowingQuoteView {
                    if !pencilLocked  {
                        if !IsTrimming {

        print("Drawing line from point to point")
        
        // 1
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        
        tempFirstImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
     //   tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: tempImageView.frame.size.width, height: tempImageView.frame.size.height))
        
        // 2
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y - 35))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y - 35))
        
        // 3
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brushWidth)
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        // 4
        context?.strokePath()
        
        // 5
        tempFirstImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempFirstImageView.alpha = opacity
        UIGraphicsEndImageContext()
                    }
                }
            }
        }
      }
     }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 6
        
        print("touches moved")
        
        print(" audio view showing = \(AudioViewShowing)")
        print(" ShowingColors = \(ShowingColors)")
        print(" choosingImage = \(choosingImage)")
        print(" ShowingQuoteView = \(ShowingQuoteView)")
        print(" pencilLocked = \(pencilLocked)")
        print(" IsTrimming = \(IsTrimming)")
        
          if !AudioViewShowing {
        if !ShowingColors {
            if !choosingImage {
                if !ShowingQuoteView {
                    if !pencilLocked  {
                         if !IsTrimming {
        swiped = true
        let touch = touches.first
            let currentPoint = touch!.location(in: view)
            drawLineFrom(lastPoint, toPoint: currentPoint)
            
            // 7
            lastPoint = currentPoint
        //  }
                        }
                    }
                }
            }
          }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("touches ended")
        
        print(" audio view showing = \(AudioViewShowing)")
        print(" ShowingColors = \(ShowingColors)")
        print(" choosingImage = \(choosingImage)")
        print(" ShowingQuoteView = \(ShowingQuoteView)")
        print(" pencilLocked = \(pencilLocked)")
        print(" IsTrimming = \(IsTrimming)")
          if !AudioViewShowing {
        if !ShowingColors {
            if !choosingImage {
                if !ShowingQuoteView {
                     if !pencilLocked  {
                        if !IsTrimming {
        print("Touches ended")
        
        if !swiped {
            // draw a single point
            drawLineFrom(lastPoint, toPoint: lastPoint)
        }
        
        print("main image width (touches)= \(mainImageView.frame.size.width)")
        
        print("main image height (touches) = \(mainImageView.frame.size.width)")
        // Merge tempImageView into mainImageView
        
        UIGraphicsBeginImageContext(mainImageView.frame.size)
      //  mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: 1.0)
      //  tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: opacity)
        
        mainImageView.image?.draw(in: CGRect(x: 0, y: 0, width: mainImageView.frame.size.width, height: mainImageView.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
        
        tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: tempImageView.frame.size.width, height: tempImageView.frame.size.height), blendMode: CGBlendMode.normal, alpha: opacity)
        
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempImageView.image = nil
        print("tempImage / layer two = nil")
        
        //END MERGE TEMPIMAGE TO MAINIMAGE
        
        
        
        // Merge tempFirstImageView into tempImageView
        
        UIGraphicsBeginImageContext(tempImageView.frame.size)
        //  mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: 1.0)
        //  tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: opacity)
        
        tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: tempImageView.frame.size.width, height: tempImageView.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
        
        tempFirstImageView.image?.draw(in: CGRect(x: 0, y: 0, width: tempFirstImageView.frame.size.width, height: tempFirstImageView.frame.size.height), blendMode: CGBlendMode.normal, alpha: opacity)
        
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempFirstImageView.image = nil
        
        print("tempFirstImage / layer three = nil")
                    }
                    
                  }
                }
            }
        }
        }
        //END MERGE TEMPFIRSTIMAGE TO TEMPIMAGE
   
    }
    
    
    @IBAction func UndoBTN(_ sender: AnyObject) {
        print("undo button pressed")
        tempImageView.image = nil
    }
    
    var CommentsGameID = NSString()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // if segue.identifier != "Turn_Complete" {
        
        if segue.identifier == "ShowComments" {
            if let destination = segue.destination as? CommentsViewController {
                // destination.GameName = GameNameInfo[GameIndex]
                destination.GameID = CommentsGameID
                destination.wasNotified = true
                
            }
            
        }
        
        
        
        if segue.identifier == "settings" {
            
        let settingsViewController = segue.destination as! SettingsViewController
        settingsViewController.delegate = self
        settingsViewController.brush = brushWidth
        settingsViewController.opacity = opacity
        settingsViewController.red = red
        settingsViewController.green = green
        settingsViewController.blue = blue
        }
    //  }
        if segue.identifier == "BackToMyGames" {
            
            let controller = segue.destination as! GameViewController
            controller.IsUnwinding = true
        }
        
    }
    
    
    

        
        @IBOutlet weak var myImageView: UIImageView!
        let picker = UIImagePickerController()
        
        func noCamera(){
            let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
            alertVC.addAction(okAction)
           // presentViewController(alertVC, animated: true, completion: nil)
            
            
         //   let theAlert2 = SCLAlertView()
         //   theAlert2.addButton("Ok") {
         //   }
         //   theAlert2.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.99, green: 0.69, blue: 0.35, alpha: 1.0), title: "No Camera", subTitle: "This device doesn't have a camera")
            
             SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Uh Oh, No Camera", subTitle: "This device doesn't have a camera", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
        }
        
        //MARK: - Actions
        //get a photo from the library. We present as a popover on iPad, and fullscreen on smaller devices.

    @IBAction func TempGetPhoto(_ sender: AnyObject) {
        var image = UIImage()
     //  let image =  DownloadGameFile(NSURL(fileURLWithPath: "http://\(ServerInfo.sharedInstance)/Apps/Pics&Quotes/GameData/TestTurn1.jpg"))
        
     //   let image =  DownloadGameFile(NSURL(fileURLWithPath: "http://\(ServerInfo.sharedInstance)/Apps/Pics%26Quotes/GameData/TestTurn1.jpg"))
        
        let url = URL(fileURLWithPath: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/TestTurn1.jpg")
        
       
//  func DownloadGameFile(url: NSURL) -> UIImage {
            var theImage = UIImage()
            print("Download Started")
            print("lastPathComponent: " + (url.lastPathComponent ?? ""))
        
        
     //   let data = getDataFromUrl(url)
        
        getDataFromUrl(url) { (data, response, error)  in
                DispatchQueue.main.async { () -> Void in
                    guard let data = data , error == nil else { return }
                    print(response?.suggestedFilename ?? "")
                    print("Download Finished")
                    image = UIImage(data: data)!
                    
          //      }
           // }
            
       //     return theImage
   //     }

        
        
        
       DispatchQueue.main.async(execute: {
            
        self.tempFirstImageView.image = image
        
        let vH = self.tempFirstImageView.frame.height
        let vW = self.tempFirstImageView.frame.width
        let iH = image.size.height
        
        
        
        let iW = image.size.width
        //  let picRatio = iW / iH
        
        
        let iR = iH / iW
        print("image ratio = \(iR)")
        
        let nH2 = vW * iR
        
        print("nH2 = \(nH2)")
        
        var nH = CGFloat()
        let vR = vW / iW
        
        if vR < 1 {
            
            nH = iH
        } else  {
            nH = vH / vR
        }
        
        
        print("new Height = \(nH)")
        
        let MiddleH = vH / 2
        print("middle H = \(MiddleH)")
        
        let nTop = MiddleH - (nH2 / 2)
        
        UIGraphicsBeginImageContext(self.tempImageView.frame.size)
        
        self.tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.tempImageView.frame.size.width, height: self.tempImageView.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
        
        self.tempFirstImageView.image?.draw(in: CGRect(x: 0, y: nTop, width: vW, height: nH2), blendMode: CGBlendMode.normal, alpha: self.opacity)
        
        self.tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.tempFirstImageView.image = nil
        
        self.prefs.setValue("", forKey: "GOOGLEDATAD")
            
        });
        
    }
  }
        
        
        
 }


    
    
    

        
    @IBAction func photoFromLibary(_ sender: AnyObject) {
        
        
            if GameID == "demo" {
                
                self.picker.allowsEditing = false //2
                self.picker.sourceType = .photoLibrary //3
                self.picker.modalPresentationStyle = .popover
                self.present(self.picker, animated: true, completion: nil)//4
            } else {
        
        
    if (prefs.bool(forKey: "CameraPurchased")){
        
            
            self.picker.allowsEditing = false //2
            self.picker.sourceType = .photoLibrary //3
            self.picker.modalPresentationStyle = .popover
            self.present(self.picker, animated: true, completion: nil)//4
            
            
    } else if (!prefs.bool(forKey: "CameraPurchased")){
    print("Cameara not purchased")
    
    
        var numPoints = 0;
        var LevelUpTime = Bool()
      (numPoints, LevelUpTime) = UPData(self.username, userid: self.userID, type: "get", points: "0", levelpoints: "0")
        //numPoints = FilterUPData(UPurldata)
        print("number of points = \(numPoints)")
        
        if numPoints > 9 {
            
            //   let check = UserStatusCheck(username, status: "audio", action: "check")
            
            //  if check{
            
            
            let theAlert2 = SCLAlertView()
            theAlert2.addButton("Yes") {
                
                self.pointsUsed = true
            
                self.picker.allowsEditing = false //2
                self.picker.sourceType = .photoLibrary //3
                self.picker.modalPresentationStyle = .popover
                self.present(self.picker, animated: true, completion: nil)//4

            }
            theAlert2.addButton("No") {
                
                let theAlert = SCLAlertView()
                theAlert.addButton("Let's do it") {
                     self.purchaseitems()
                }
                
               
                theAlert.addButton("No Thanks") {
                    
                }
              
                //theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Import Photos", subTitle: "Add to your toolbox?")
                theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Import Photos", subTitle: "Add photos any time for only $0.99?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                

            }
           // theAlert2.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Use Your Tokens?", subTitle: "Use 10 tokens to proceed?")
            theAlert2.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Use Your Tokens?", subTitle: "Use 10 tokens to add an image?  *earn more by 'Liking' turns.", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)

            
            /*
            let actionSheetController: UIAlertController = UIAlertController(title: "Use your Tokens!", message: "With \(numPoints) tokens, You have enough tokens to select an image from your photos.  Would you like to use 10 tokens to proceed?", preferredStyle: .Alert)
            
            //Create and add the Cancel action
            // let cancelAction: UIAlertAction = UIAlertAction(title: "No thanks", style: .Cancel) { action -> Void in
            //Do some stuff
            //  }
            //  actionSheetController.addAction(cancelAction)
            //Create and an option action
            let yesAction: UIAlertAction = UIAlertAction(title: "Yes", style: .Default) { action -> Void in
                
                
                self.pointsUsed = true
                
                /*
                var numPoints = 0;
                numPoints = UPData(self.username, userid: self.userID, type: "delete", points: "10")
                //numPoints = FilterUPData(UPurldata)
                print("number of points = \(numPoints)")
*/

                self.picker.allowsEditing = false //2
                self.picker.sourceType = .PhotoLibrary //3
                self.picker.modalPresentationStyle = .Popover
                self.presentViewController(self.picker, animated: true, completion: nil)//4

                
                
                // Quote = self.RecordedData
                // self.TheType = "audio"
                // self.QorA = "Audio Clip"
                // self.PerformSubmitButton(Quote)
                
            }
            
            let noAction: UIAlertAction = UIAlertAction(title: "no", style: .Default) { action -> Void in
                
                
                let actionSheetController: UIAlertController = UIAlertController(title: "Import Photos?", message: "Would you like to add the 'Import Image' option to your Pencil Toolbox", preferredStyle: .Alert)
                
                //Create and add the Cancel action
                let cancelAction: UIAlertAction = UIAlertAction(title: "No thanks", style: .Cancel) { action -> Void in
                    //Do some stuff
                }
                actionSheetController.addAction(cancelAction)
                //Create and an option action
                let nextAction: UIAlertAction = UIAlertAction(title: "Let's do it", style: .Default) { action -> Void in
                    
                    self.purchaseitems()
                    
                }
                
                actionSheetController.addAction(nextAction)
                
                self.presentViewController(actionSheetController, animated: true, completion: nil)
                // Quote = self.RecordedData
                // self.TheType = "audio"
                // self.QorA = "Audio Clip"
                // self.PerformSubmitButton(Quote)
                
            }
            
            actionSheetController.addAction(yesAction)
            
            actionSheetController.addAction(noAction)
            
            self.presentViewController(actionSheetController, animated: true, completion: nil)
            
            */
            
        } else {
            
   
        
        
            let check = UserStatusCheck(username, userID: userID, status: "photo", action: "check")
    
    if check{
    
        
        
        let theAlert2 = SCLAlertView()
        theAlert2.addButton("Thanks") {
            
           // self.pointsUsed = true
            
            self.picker.allowsEditing = false //2
            self.picker.sourceType = .photoLibrary //3
            self.picker.modalPresentationStyle = .popover
            self.present(self.picker, animated: true, completion: nil)//4
            
        }
    
      //  theAlert2.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Great News!", subTitle: "Try it for Free")
        
        theAlert2.showCustom(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Great news!", subTitle: "Try it for Free", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)

        
        /*
    
    let actionSheetController: UIAlertController = UIAlertController(title: "Great News!", message: "Right now, For Select users, we are offering a free trial of the option to import Photos and you've been selected.  Try it out. ", preferredStyle: .Alert)
    

    let nextAction: UIAlertAction = UIAlertAction(title: "Thanks", style: .Default) { action -> Void in
    
        self.picker.allowsEditing = false //2
        self.picker.sourceType = .PhotoLibrary //3
        self.picker.modalPresentationStyle = .Popover
        self.presentViewController(self.picker, animated: true, completion: nil)//4
    
      //  }
        //take a picture, check if we have a camera first.
    }
    
    actionSheetController.addAction(nextAction)
    
    self.presentViewController(actionSheetController, animated: true, completion: nil)
    
        */
        
    } else {
        
        
        let theAlert = SCLAlertView()
        theAlert.addButton("Let's do it") {
            self.purchaseitems()
        }
        
        
        theAlert.addButton("No Thanks") {
            
        }
        
        //theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Import Photos", subTitle: "Add to your toolbox?")
        theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Import Photos", subTitle: "Add photos any time for only $0.99?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
  /*
    
    let actionSheetController: UIAlertController = UIAlertController(title: "Import Photos?", message: "Would you like to add the 'Import Image' option to your Pencil Toolbox", preferredStyle: .Alert)
    
    //Create and add the Cancel action
    let cancelAction: UIAlertAction = UIAlertAction(title: "No thanks", style: .Cancel) { action -> Void in
    //Do some stuff
    }
    actionSheetController.addAction(cancelAction)
    //Create and an option action
    let nextAction: UIAlertAction = UIAlertAction(title: "Let's do it", style: .Default) { action -> Void in
    
    self.purchaseitems()
    
    }
    
    actionSheetController.addAction(nextAction)
    
    self.presentViewController(actionSheetController, animated: true, completion: nil)
        
        */
    }
            
        }
    
    
      }
                
        }

    }
    @IBAction func closeImageSelect(_ sender: AnyObject) {
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            self.chooseMusicViewTOP.constant = 1200
            
            self.chooseMusicView.center.y = self.chooseMusicView.center.y + 1200
            
            //  self.ViewHolderMusicTOP.constant = 0
            //self.ViewShowing = true
            // ShowingInfo = true
            
            // self.ViewTransTOP.constant = 0
        })
        choosingImage = false
    }
    
    @IBAction func BrowseYTBTN(_ sender: AnyObject) {
        
        // pe
        self.performSegue(withIdentifier: "browseimage", sender: self)
        
        /*
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            self.chooseMusicViewTOP.constant = 1200
            
            self.chooseMusicView.center.y = self.chooseMusicView.center.y + 1200
            
            //  self.ViewHolderMusicTOP.constant = 0
            //self.ViewShowing = true
            // ShowingInfo = true
            
            // self.ViewTransTOP.constant = 0
        })
        
        
     choosingImage = false
        */
        
        choosingImage = false
        
    }
    
    @IBAction func shootPhoto(_ sender: AnyObject) {
        
         if self.GameID == "demo" {
            
            if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerControllerSourceType.camera
                picker.cameraCaptureMode = .photo
                present(picker, animated: true, completion: nil)
                // mainImageView.image =
            } else {
                noCamera()
            }
            
         } else {
        
        
        if (prefs.bool(forKey: "CameraPurchased")){
            
            let camP = prefs.bool(forKey: "CameraPurchased")
            
            print("camera is purchased = \(camP)")
        
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            present(picker, animated: true, completion: nil)
            // mainImageView.image =
        } else {
            noCamera()
        }
            
    //overlayView.hidden = true
        } else if (!prefs.bool(forKey: "CameraPurchased")){
            print("Cameara not purchased")
            
            var numPoints = 0;
            var LevelUpTime = Bool()
            (numPoints, LevelUpTime) = UPData(self.username, userid: self.userID, type: "get", points: "0", levelpoints: "0")
            //numPoints = FilterUPData(UPurldata)
            print("number of points = \(numPoints)")
            
            if numPoints > 9 {
                
                //   let check = UserStatusCheck(username, status: "audio", action: "check")
                
                //  if check{
                
                let theAlert2 = SCLAlertView()
                theAlert2.addButton("Yes") {
                    
                    self.pointsUsed = true
                    
                    self.picker.allowsEditing = false //2
                    self.picker.sourceType = .photoLibrary //3
                    self.picker.modalPresentationStyle = .popover
                    self.present(self.picker, animated: true, completion: nil)//4
                    
                }
                theAlert2.addButton("No") {
                    
                    let theAlert = SCLAlertView()
                    theAlert.addButton("Let's do it") {
                        self.purchaseitems()
                    }
                    
                    
                    theAlert.addButton("No Thanks") {
                        
                    }
                    
                    //theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Import Photos", subTitle: "Add to your toolbox?")
                    theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Purchase Camera", subTitle: "Add photos any time for only $0.99?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                    
                }
               // theAlert2.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Use Your Tokens?", subTitle: "Use 10 tokens to proceed?")

                
                 theAlert2.showCustom(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Use Your Tokens?", subTitle: "Use 10 tokens to add an image?   *earn more by 'Failing' turns.", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                
                
                /*
                
                
                let actionSheetController: UIAlertController = UIAlertController(title: "Use your Tokens!", message: "With \(numPoints) tokens, You have enough tokens to use your camera for this turn.  Would you like to use 10 tokens to proceed?", preferredStyle: .Alert)

                let yesAction: UIAlertAction = UIAlertAction(title: "Yes", style: .Default) { action -> Void in
                    

                    self.pointsUsed = true
                    
                    /*
                    var numPoints = 0;
                    numPoints = UPData(self.username, userid: self.userID, type: "delete", points: "10")
                    //numPoints = FilterUPData(UPurldata)
                    print("number of points = \(numPoints)")
                    */
                    
                  
                    if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                        self.picker.allowsEditing = false
                        self.picker.sourceType = UIImagePickerControllerSourceType.Camera
                        self.picker.cameraCaptureMode = .Photo
                        self.presentViewController(self.picker, animated: true, completion: nil)
                        // mainImageView.image =
                    } else {
                        self.noCamera()
                    }

                    
                }
                
                let noAction: UIAlertAction = UIAlertAction(title: "no", style: .Default) { action -> Void in
                    
             
                    
                    let actionSheetController: UIAlertController = UIAlertController(title: "Use Your Camera", message: "Would you like to add the Camera to your Game Toolbox so you can import photos?", preferredStyle: .Alert)
                    
                    //Create and add the Cancel action
                    let cancelAction: UIAlertAction = UIAlertAction(title: "No thanks", style: .Cancel) { action -> Void in
                        //Do some stuff
                    }
                    actionSheetController.addAction(cancelAction)
                    //Create and an option action
                    let nextAction: UIAlertAction = UIAlertAction(title: "Let's do it", style: .Default) { action -> Void in
                        
                        self.purchaseitems()
                        
                    }
                    
                    actionSheetController.addAction(nextAction)
                    
                    self.presentViewController(actionSheetController, animated: true, completion: nil)
                    
                    // Quote = self.RecordedData
                    // self.TheType = "audio"
                    // self.QorA = "Audio Clip"
                    // self.PerformSubmitButton(Quote)
                    
                }
                
                actionSheetController.addAction(yesAction)
                
                actionSheetController.addAction(noAction)
                
                self.presentViewController(actionSheetController, animated: true, completion: nil)
                
                */
                
            } else {
            
            
            let check = UserStatusCheck(username, userID: userID, status: "photo", action: "check")
            
            
            
            if check{
                
                
                
                let theAlert2 = SCLAlertView()
                theAlert2.addButton("Thanks") {
                    
                    if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
                        self.picker.allowsEditing = false
                        self.picker.sourceType = UIImagePickerControllerSourceType.camera
                        self.picker.cameraCaptureMode = .photo
                        self.present(self.picker, animated: true, completion: nil)
                        // mainImageView.image =
                    } else {
                        self.noCamera()
                    }
                    
                }
                
                //theAlert2.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Great News!", subTitle: "Try it for Free")
                
                theAlert2.showCustom(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Great News!", subTitle: "Try it for Free", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)

                /*
                
                let actionSheetController: UIAlertController = UIAlertController(title: "Great News!", message: "Right now, For Select users, we are offering a free trial of the option to use your Camera and you've been selected.  Try it out. ", preferredStyle: .Alert)
                
                //Create and add the Cancel action
                // let cancelAction: UIAlertAction = UIAlertAction(title: "No thanks", style: .Cancel) { action -> Void in
                //Do some stuff
                //  }
                //  actionSheetController.addAction(cancelAction)
                //Create and an option action
                let nextAction: UIAlertAction = UIAlertAction(title: "Thanks", style: .Default) { action -> Void in
                    
                    
                    if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                        self.picker.allowsEditing = false
                        self.picker.sourceType = UIImagePickerControllerSourceType.Camera
                        self.picker.cameraCaptureMode = .Photo
                        self.presentViewController(self.picker, animated: true, completion: nil)
                        // mainImageView.image =
                    } else {
                        self.noCamera()
                    }

                }
                
                actionSheetController.addAction(nextAction)
                
                self.presentViewController(actionSheetController, animated: true, completion: nil)

                */
                
            } else {
                
                
                let theAlert = SCLAlertView()
                theAlert.addButton("Let's do it") {
                    self.purchaseitems()
                }
                
                
                theAlert.addButton("No Thanks") {
                    
                }
                
                //theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Import Photos", subTitle: "Add to your toolbox?")
                theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Purchase Camera", subTitle: "Add photos any time for only $0.99?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                
                /*
            
            let actionSheetController: UIAlertController = UIAlertController(title: "Use Your Camera", message: "Would you like to add the Camera to your Game Toolbox so you can import photos?", preferredStyle: .Alert)
            
            //Create and add the Cancel action
            let cancelAction: UIAlertAction = UIAlertAction(title: "No thanks", style: .Cancel) { action -> Void in
                //Do some stuff
            }
            actionSheetController.addAction(cancelAction)
            //Create and an option action
            let nextAction: UIAlertAction = UIAlertAction(title: "Let's do it", style: .Default) { action -> Void in
                
                self.purchaseitems()
                
            }
            
            actionSheetController.addAction(nextAction)
            
            self.presentViewController(actionSheetController, animated: true, completion: nil)
                
                
                */
                
                
                
                
            }
            
        }
      }
            
        }
    }
    
    func purchaseitems(){
        
            print("About to fetch the products");
            
            if (SKPaymentQueue.canMakePayments())
            {
                let productID:NSSet = NSSet(object: self.product_id!);
                let productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>);
                

                productsRequest.delegate = self;
                productsRequest.start();
                print("Fething Products");
            }else{
                print("can't make purchases");
            }
            
        }
        
        func buyProduct(_ product: SKProduct){
            print("Sending the Payment Request to Apple");
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment);
            
            
            
        }
        
        func productsRequest (_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
            
            let count : Int = response.products.count
            if (count>0) {
                var validProducts = response.products
                let validProduct: SKProduct = response.products[0] 
                if (validProduct.productIdentifier == self.product_id as! String) {
                    print(validProduct.localizedTitle)
                    print(validProduct.localizedDescription)
                    print(validProduct.price)
                    buyProduct(validProduct);
                } else {
                    print(validProduct.productIdentifier)
                }
            } else {
                print("nothing")
            }
        }
        
        
        func request(_ request: SKRequest, didFailWithError error: Error) {
            print("Error Fetching product information");
        }
        
        func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction])    {
            print("Received Payment Transaction Response from Apple");
            
            for transaction:AnyObject in transactions {
                if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
                    switch trans.transactionState {
                    case .purchased:
                        print("Product Purchased");
                        SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                        prefs.set(true , forKey: "Purchased")
                        prefs.set(true, forKey: "CameraPurchased")
                        
                        
                         let UpdateUserPurchase = UserStatusCheck(username, userID: userID, status: "photo", action: "update")
                        
                        if UpdateUserPurchase {
                            print("successful profile update")
                        } else {
                            print("Did not update user profile")
                        }
                        
                        //   overlayView.hidden = true
                        break;
                    case .failed:
                        print("Purchased Failed");
                        SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                        break;
                        
                        
                        
                    case .restored:
                        print("Already Purchased");
                        SKPaymentQueue.default().restoreCompletedTransactions()
                        prefs.set(true , forKey: "Purchased")
                        prefs.set(true, forKey: "CameraPurchased")
                        
                        let UpdateUserPurchase = UserStatusCheck(username, userID: userID, status: "photo", action: "update")
                        
                        if UpdateUserPurchase {
                            print("successful profile update")
                        } else {
                            print("Did not update user profile")
                        }
                        
                    default:
                        break;
                    }
                }
            }
            
        }
            

    
 
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            
            
            
            fromGoogle = false
            WasPasted = false
            
            var chosenImage = UIImage()
            
            var GIFData = Data()
            
            print("GIF Info = \(info)")
            
            if let imageURL = info[UIImagePickerControllerReferenceURL] as? URL {
                let imageName = imageURL.lastPathComponent
                // let imageURLTest = imageURL.
                //GIFData = NSData(contentsOfURL: imageURL)!
                
                //let theURL = imageURL
                print("Image URL = \(imageURL)")
                print("Image Name = \(imageName)")
                
                
                var GifImage = imageName.contains(".gif")
                
                if !GifImage {
                    GifImage = imageName.contains(".GIF")
                }
                
                print("Gif Image = \(GifImage)")
                
                
                if GifImage {
                    
                    
                    var assetLib = ALAssetsLibrary()
                    var url: URL!
                        //= URL()
                    
                    var imageView = UIImageView(frame: self.view.bounds)
                    
                    //SWIFT 3 Error
                    print("Swift 3 error")
                    
                    
                    assetLib.asset(for: imageURL, resultBlock: { (asset ) in

                    //assetLib.asset(for: imageURL, resultBlock: { (asset : ALAsset!) -> Void in
                        
                        /*
                        
                        let fetchResult = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
                        
                        let phAssetTWO = fetchResult.lastObject as? PHAsset
                        
                        print("phAssetTWO = \(phAssetTWO)")
                        if let phAsset = fetchResult.firstObject as? PHAsset {
                            
                            */
                        
                        let fetchResult = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
                        
                        let phAssetTWO = fetchResult.lastObject! as PHAsset
                        
                        print("phAssetTWO = \(phAssetTWO)")
                        if let phAsset = fetchResult.firstObject {
                            
                            print("phAsset FIRST = \(phAsset)")
                            
                            PHImageManager.default().requestImageData(for: phAsset, options: nil) {
                                (imageData, dataURI, orientation, info) -> Void in
                                
                                let Length = imageData?.count
                                print("ImageData Length = \(Length)")
                                
                                let Bytes = (imageData as NSData?)?.bytes
                                
                                print("ImageData Bytes = \(Bytes)")
                                
                                print("GIF IMAGE dataURI = \(dataURI)")
                                print("GIF IMAGE orientation = \(orientation)")
                                print("GIF IMAGE INFO = \(info)")
                                print("GIF IMAGE DATA = \(imageData)")
                                
                                
                                print("GIF IMAGE FILE URL KEY = \(info!["PHImageFileURLKey"])")
                                
                                let bundle = Bundle.main
                                let myFilePath = bundle.path(forResource: "TEMPGIF", ofType: "gif")
                                //  let videoURL:NSURL = NSURL.fileURLWithPath(myFilePath!)
                                
                                
                                // let localPathTemp = info!["PHImageFileURLKey"] as! String
                                
                                //    let tempURL = info!["PHImageFileURLKey"] as! NSURL
                                
                                //    let tempURLpath = tempURL.path
                                //  print("TEMPURL PATH = \(tempURL.path)")
                                //   print("TEMPURL PATH test 2 = \(tempURLpath)")
                                
                                //   let tempURLTWO = info!["PHImageFileSandboxExtensionTokenKey"] as! NSString
                                
                                //print("tempURLTWO = \(tempURLTWO)")
                                
                                //    print("Temp URL TWO = \(tempURLTWO)")
                                
                                
                                GIFData = Data(bytes: Bytes!, count: Length!)
                                //  GIFData = NSData(bytes: Bytes.!, length: Length!)
                                
                                self.gifNSData = GIFData
                                
                                self.MediaType = "gif"
                                self.mainImageView.image = UIImage.animatedImage(withAnimatedGIFData: GIFData)
                                self.WasPasted = true
                                
                                self.mainImageView.contentMode = .scaleAspectFit
                                //   GIFData = (contentsOfURL: NSURL(string: tempURL)!)!
                                // ...
                            }
                        }
                        
                        
                        
                        }, failureBlock:  nil)
                    
                    
 
                    
                    
                    
                    DispatchQueue.main.async(execute: {
                        
                        self.MediaType = "gif"
                        self.mainImageView.image = UIImage.animatedImage(withAnimatedGIFData: GIFData)
                    })
                    
                    
                    
                } else {
                    
                    chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
                    
                    
                   // PicPreview.contentMode = .ScaleAspectFit //3
                    // myImageView.image = chosenImage
                  //  PicPreview.image = chosenImage//4
                    MediaType = "picture"
                    
             //   }
                
                
         //   }
            
            
            
            
            
            //let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
            

            
            UIGraphicsBeginImageContext(mainImageView.frame.size)
            
            mainImageView.image?.draw(in: CGRect(x: 0, y: 0, width: mainImageView.frame.size.width, height: mainImageView.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
            
            tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: tempImageView.frame.size.width, height: tempImageView.frame.size.height), blendMode: CGBlendMode.normal, alpha: opacity)
            
            mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            tempImageView.image = nil
            
            /*
            
            UIGraphicsBeginImageContext(tempImageView.frame.size)
            //  mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: 1.0)
            //  tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: opacity)
            
            tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: tempImageView.frame.size.width, height: tempImageView.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
            
          //  tempFirstImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: tempFirstImageView.frame.size.width, height: tempFirstImageView.frame.size.height), blendMode: CGBlendMode.Normal, alpha: opacity)
            
             tempFirstImageView.image?.drawInRect(CGRect(x: 0, y: nTop, width: vW, height: nH2), blendMode: CGBlendMode.Normal, alpha: opacity)
            
         
         //   resizeIMG.image = UIGraphicsGetImageFromCurrentImageContext()
            */
            
            resizeIMG.image = chosenImage
            
            
            let vHt = resizeIMG.frame.height
            let vWt = resizeIMG.frame.width
            let iHt = chosenImage.size.height
            var nTopt = CGFloat()
            var nSide = CGFloat()
            
            let iWt = chosenImage.size.width
            //  let picRatio = iW / iH
            var nHt = CGFloat()
            var nWt = CGFloat()
            var iRt = CGFloat()
            
            if iHt > iWt {
                
                print("height is bigger")
                nHt = vHt
                iRt = iWt / iHt
                
                nWt = vWt * iRt
                nTopt = 0
                nSide = (self.resizeIMG.frame.width / 2)  - (nWt / 2)
                
                print("start left side = \(nSide)")
                
            } else {
                
                print("width is bigger")
                nWt = vWt
                iRt = iHt / iWt
                nHt = vHt * iRt
                
                nTopt = (self.resizeIMG.frame.height / 2)  - (nHt / 2)
                nSide = 0
            }
            
            
            
            UIGraphicsBeginImageContext(resizeIMG.frame.size)
            
            // resizeIMG.image?.drawInRect(CGRect(x: 0, y: 0, width: resizeIMG.frame.width, height: resizeIMG.frame.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
            resizeIMG.image?.draw(in: CGRect(x: nSide, y: nTopt, width: nWt, height: nHt), blendMode: CGBlendMode.normal, alpha: 1.0)
            
            resizeIMG.image = UIGraphicsGetImageFromCurrentImageContext()
            
            
           // resizeIMG.image = chosenImage
           // resizeIMG.contentMode = UIViewContentMode.ScaleAspectFit
            
            pencilLocked = true
             self.trimBTN.isHidden = false
            self.trimBTN.isEnabled = true
            self.resizeIMG.isHidden = false
            self.ScaleControlsView.isHidden = false
            self.ScaleControlsShowing = true
            self.cutBTN.isHidden = false
            let DeviceH = self.view.frame.height
            //let halfH = DeviceH / 2;
            let DeviceW = self.view.frame.width
     
           // resizeH = DeviceW
           // resizeW = DeviceW
            
            //  resizeH = resizeIMG.frame.height
            resizeH = (resizeIMG.image?.size.height)!
            
            //   resizeW = resizeIMG.frame.width
            resizeW = (resizeIMG.image?.size.width)!
            
            resizeHEIGHT.constant = DeviceW - 50
            resizeWIDTH.constant = DeviceW - 50

            
          //  self.resizeX = DeviceW - (resizeIMG.frame.width / 2)
          //  self.resizeY = DeviceH - (resizeIMG.frame.height / 2)
            
            self.resizeX = resizeIMG.center.x
            self.resizeY = resizeIMG.center.y
            
           // self.resizeX = DeviceW - ((resizeIMG.image?.size.width)! / 2)
            // self.resizeX = DeviceW - ((resizeIMG.image?.size.width)! / 2)
           // self.resizeY = (DeviceH - ((resizeIMG.image?.size.height)! / 2) - 70)
            
            
            self.pasteIMGBTN.isHidden = false
            self.resizeIMG.layer.borderWidth = 2
            self.resizeIMG.layer.cornerRadius = 5
            self.resizeIMG.layer.borderColor = UIColor.lightGray.cgColor
           
           // self.resizeIMG.l
            self.resizeIMG.clipsToBounds = true
            
            self.lockBTN.isHidden = false
            self.lockBTN.setImage(UIImage(named: "resizeIconWhite.png"), for: UIControlState())
            print("pencil is locked")
            
            // tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
                }
            }
            
            tempFirstImageView.image = nil
            
            //END MERGE TEMPFIRSTIMAGE TO TEMPIMAGE

            print("main image width = \(mainImageView.frame.size.width)")
            
            print("main image height = \(mainImageView.frame.size.width)")
            
           
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
              //  self.chooseMusicViewTOP.constant = 1200
              //  self.chooseMusicView.center.y = self.chooseMusicView.center.y + 1200
            })
            choosingImage = false
            DontShowIntro = true
            
            dismiss(animated: true, completion: nil) //5
  
            
        }
        //What to do if the image picker cancels.
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
    

    
    /*
    
    func resizeImage(UIImage) -> UIImage {
        var actualHeight = image.size.height
        var actualWidth = image.size.width
        var maxHeight = 300.0
        var maxWidth = 400.0
        var imgRatio = actualWidth / actualHeight
        var maxRatio = maxWidth/maxHeight
        var compressionQuality = 0.5
        
        if ( actualHeight > maxHeight || actualWidth > maxWidth ){
            if (imgRatio < maxRatio)
            {
                imgRatio = maxHeight/actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if ( imgRatio > maxRatio)
            {
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else
            {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
            }
        let rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight)
        UIGraphicsBeginImageContext(rect.size)
        }
        
    }
*/
    
    func ShowAudioView() {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if !AudioViewShowing {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                
                
                self.AudioHolder.center.y = self.AudioHolder.center.y - 1200
                
                self.RecorderView1TOP.constant = 0
                
                self.subAudioHolderTOP.constant = middleY
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            playButton.isEnabled = true
            stopButton.isEnabled = false
            AudioViewShowing = true
            checkHeadphones()
        }
    }
    
    @IBAction func HideAudioView(_ sender: AnyObject) {
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if AudioViewShowing {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.RecorderView1TOP.constant = 1200
                
                self.AudioHolder.center.y = self.AudioHolder.center.y + 1200
                
                self.subAudioHolderTOP.constant = middleY
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
           
            AudioViewShowing = false
           
        }
        
    }
    
    @IBAction func stop(_ sender: UIButton) {
        print("stop")
        
        //recorder?.stop()
        player?.stop()
        
        musicTimer.invalidate()
        
       // recordButton.setTitle("Record", forState:.Normal)
        
        
        let session = AVAudioSession.sharedInstance()
        
        
        do {
            try session.setActive(false)
            playButton.isEnabled = true
            stopButton.isEnabled = false
           // recordButton.enabled = true
        } catch let error as NSError {
            print("could not make session inactive")
            print(error.localizedDescription)
        }
        
        //recorder = nil
    }
    
    @IBAction func play(_ sender: UIButton) {
        play()
    }
    
    func play() {
        stopButton.isEnabled = true
    let url = Image64Data
        do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            
           // .setCategory(AVAudioSessionCategoryPlayback, error: nil)
            
        try AVAudioSession.sharedInstance().setActive(true)
        player = try AVAudioPlayer(data: Image64Data_Audio, fileTypeHint: AVFileTypeAppleM4A)
       // player = AVAudioPlayer(data: url, fileTypeHing: AVFileTypeMPEGLayer3, error: nil)
        player.prepareToPlay()
        player.play()
        self.musicTimer = Timer.scheduledTimer(timeInterval: self.timeInterval,
                target:self,
                selector:#selector(ImageViewController.updateMusicMeter(_:)),
                userInfo:nil,
                repeats:true)
            
        
        } catch {
            print("errors = \(error)")
            
            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Error", subTitle: "Uh, there seems to be a problem with this audio file.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
        }
//        let url = soundFileURLTemp
    
        
        /*
        if self.recorder != nil {
        url = self.recorder.url
        } else {
        url = self.soundFileURL!
        }
        */
        
        print("playing \(url)")
        
        /*
        do {
            self.player = try AVAudioPlayer(contentsOfURL: url)
            //stopButton.enabled = true
            player.delegate = self
            player.prepareToPlay()
            player.volume = 1.0
            player.play()
        } catch let error as NSError {
            self.player = nil
            print(error.localizedDescription)
        }
        */
    }
  
    func checkHeadphones() {
        // check NewDeviceAvailable and OldDeviceUnavailable for them being plugged in/unplugged
        let currentRoute = AVAudioSession.sharedInstance().currentRoute
        if currentRoute.outputs.count > 0 {
            for description in currentRoute.outputs {
                if description.portType == AVAudioSessionPortHeadphones {
                    print("headphones are plugged in")
                    break
                } else {
                    print("headphones are unplugged")
                }
            }
        } else {
            print("checking headphones requires a connection to a device")
        }
    }
 

    func updateMusicMeter(_ timer:Timer) {

        //  if recorder.recording {
        let min = Int((player?.currentTime)! / 60)
        
        let sec = Int((player?.currentTime)!.truncatingRemainder(dividingBy: 60))
        
        let s = String(format: "%02d:%02d", min, sec)
        TrackCurrentTimeLBL.text = s
  
    }
    
    
    
    @IBAction func howtoPaintBTN(_ sender: AnyObject) {
        
        let AC = JSController("Paint Tools", MyMessage: "Start by tapping the Paint icon below, then select a color.  You can resize your bursh and create your own color, just tap the Arrows on the Paint Pallete.",Color: "Red")
        
       // self.presentViewController(AC, animated: true, completion: nil)
        
        DispatchQueue.main.async(execute: {
            
            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Paint Tools", subTitle: "Start by tapping the Paint icon below, then select a color.  You can resize your bursh and create your own color, just tap the Arrows on the Paint Pallete.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        })
        
        
            /*{
            let AC = JSController("Erasing", MyMessage: "Don't forget you have an 'Undo' button on the bottom left and a 'Clear All' button at the top middle (the trash sweeper)",Color: "Red")
            
            self.presentViewController(AC, animated: true, completion: {
                
            })

        })
*/
        
         UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            
            self.howtapView.center.x = self.howtapView.center.x + 100
            self.howtapLEFT.constant = 135
            
            })
        
        
        self.howtoImageBTN.isEnabled = true
        
    }
    
    @IBAction func howtoImageBTN(_ sender: AnyObject) {
        
        
        let AC = JSController("Photos & Camera", MyMessage: "To insert an image from your photos just tap the 'Picture' button below, then tap on the camera or photo album.",Color: "Red")
        
       // self.presentViewController(AC, animated: true, completion: nil)

        DispatchQueue.main.async(execute: {
            
            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Photos & Camera", subTitle: "To insert an image from your photos just tap the 'Picture' button below, then tap on the camera or photo album.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        })
        
        
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            
            self.howtapView.center.x = self.howtapView.center.x + 95
            self.howtapLEFT.constant = 230
            
        })
        
        self.howtoGoogleBTN.isEnabled = true

       
        
    }
    
    @IBAction func howtoGoogleBTN(_ sender: AnyObject) {
        
        let AC = JSController("Google Image", MyMessage: "Grab an image from google, just tap the Photo button below, then the Google image icon.  Search for a photo then tap the Screen Grab icon to copy the image.",Color: "Red")
        
       // self.presentViewController(AC, animated: true, completion: nil)
        
        
        DispatchQueue.main.async(execute: {
            
            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Google Image", subTitle: "Grab an image from google, just tap the Photo button below, then the Google image icon.  Search for a photo then tap the Screen Grab icon to copy the image.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        })
        
            /*{
            let AC = JSController("Oh yeah...", MyMessage: "You can draw on images you select from google, or  any image you insert.",Color: "Red")
            
            self.presentViewController(AC, animated: true, completion: {
                self.CloseBTN.enabled = true
            })

        })
       */
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            
            self.howtapView.center.y = self.howtapView.center.y + 1000
            self.howtapBOTTOM.constant = -950
            
        })
        
        
        self.CloseBTN.isHidden = false
        self.CloseBTN.isEnabled = true
        
    }
    
   
    
    @IBAction func ScaleBoth(_ sender: AnyObject) {
        
        scaleBothBTN.setImage(UIImage(named: "hwIconCHECK.png"), for: UIControlState())
        scaleHBTN.setImage(UIImage(named: "heightIcon.png"), for: UIControlState())
        scaleWBTN.setImage(UIImage(named: "widthIcon.png"), for: UIControlState())
        
        ScaleItem = "both"
    }
    
    @IBAction func ScaleHeight(_ sender: AnyObject) {
        
        scaleBothBTN.setImage(UIImage(named: "hwIcon.png"), for: UIControlState())
        scaleHBTN.setImage(UIImage(named: "heightIconCHECK.png"), for: UIControlState())
        scaleWBTN.setImage(UIImage(named: "widthIcon.png"), for: UIControlState())
            ScaleItem = "height"
    }
    
    
    @IBAction func ScaleWidth(_ sender: AnyObject) {
        
        scaleBothBTN.setImage(UIImage(named: "hwIcon.png"), for: UIControlState())
        scaleHBTN.setImage(UIImage(named: "heightIcon.png"), for: UIControlState())
        scaleWBTN.setImage(UIImage(named: "widthIconCHECK.png"), for: UIControlState())
        
            ScaleItem = "width"
    }
    
    
    
    
    @IBAction func snipPictureBTN(_ sender: AnyObject) {
        
        if !IsTrimming {
            self.trimView.isHidden = false
            snipVisible = true
    
            trimresizeH = (trimView.frame.size.height)
            
            //   resizeW = resizeIMG.frame.width
            trimresizeW = (trimView.frame.size.width)
            
            // resizeH = (snipImage.image?.size.height)!
            
            //   resizeW = resizeIMG.frame.width
            // resizeW = (snipImage.image?.size.width)!
            
            // resizeHEIGHT.constant = DeviceW - 50
            //  resizeWIDTH.constant = DeviceW - 50
            
            
            //  self.resizeX = DeviceW - (resizeIMG.frame.width / 2)
            //  self.resizeY = DeviceH - (resizeIMG.frame.height / 2)
            
            self.trimresizeX = trimView.center.x
            self.trimresizeY = trimView.center.y
    
    
    imagePan.isEnabled  = false
    imagePinch.isEnabled = false
    viewPinch.isEnabled = true
    viewPan.isEnabled = true
    IsTrimming = true
    self.trimView.isHidden = false
    
    self.trimBTN.isEnabled = false
    self.pasteIMGBTN.isEnabled = false
    
    
    /*
    
    var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
    var blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = view.bounds
    blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
    view.addSubview(blurEffectView)
    
      */
            
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                // self.ShowQuoteViewTOP.constant = middleY
                
                
                
                self.SnipControlsView.center.y = self.SnipControlsView.center.y - 50
                self.SnipControlsView.center.x = self.SnipControlsView.center.x + 50
                
                self.SnipControlsViewBOTTOM.constant = 10
                self.SnipControlsViewH.constant = 40
                self.SnipControlsViewW.constant = 130
                self.SnipControlsViewLEAD.constant = 10
                
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            
            
           // IsTrimming = true
            
            if !self.ScaleControlsShowing {
                self.ScaleControlsView.isHidden = false
                self.ScaleControlsShowing = true
            }
            
            
        } else {
            self.trimView.isHidden = true
            
            imagePan.isEnabled = true
            IsTrimming = false
            imagePinch.isEnabled = true
            viewPinch.isEnabled = false
            viewPan.isEnabled = false
            self.trimView.isHidden = true
            self.trimBTN.isEnabled = true
            self.pasteIMGBTN.isEnabled = true
            
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                // self.ShowQuoteViewTOP.constant = middleY
                
             //   self.SnipControlsView.center.y = self.SnipControlsView.center.y + 50
             //   self.SnipControlsView.center.x = self.SnipControlsView.center.x - 50
                
                self.SnipControlsViewBOTTOM.constant = -40
               // self.SnipControlsViewH.constant = 0
               // self.SnipControlsViewW.constant = 0
                self.SnipControlsViewLEAD.constant = -40
                
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            
            if self.ScaleControlsShowing {
            
                if !pencilLocked {
                self.ScaleControlsView.isHidden = true
                self.ScaleControlsShowing = false
                }
            }
            
          //  snipVisible = false
        }
        
        
    }
    
    
    @IBAction func saveBTN(_ sender: AnyObject) {
        
        
        
        if self.pencilLocked {
            
            
            print("pencil locked")
            self.resizeIMG.image = self.snipImage.image
            
            
            
          //  self.pencilLocked = false
            // self.snipImage.hidden = true
            //    self.trimBTN.hidden = true
            //   self.pasteIMGBTN.hidden = true
            //   self.resizeIMG.layer.borderWidth = 0
            // self.lockBTN.setImage(UIImage(named: "EditButton_white.png"), forState: .Normal)
            //  self.cutBTN.hidden = true
            // self.lockBTN.hidden = true
            print("hide scale controls")
            //  self.ScaleControlsView.hidden = true
            self.WasPasted = true
            //self.trimView.hidden = true
            //  snipVisible = false
            
            if self.ScaleControlsShowing {
                
                if !self.pencilLocked {
                   // self.ScaleControlsView.hidden = true
                   // self.ScaleControlsShowing = false
                }
            } else {
                self.pencilLocked = false
            }
            
            
            
            self.trimView.isHidden = true
            
            
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                //   self.SnipControlsView.center.y = self.SnipControlsView.center.y + 50
                
                //   self.SnipControlsView.center.x = self.SnipControlsView.center.x - 50
                
                self.SnipControlsViewBOTTOM.constant = -40
                //  self.SnipControlsViewH.constant = 0
                //  self.SnipControlsViewW.constant = 0
                self.SnipControlsViewLEAD.constant = -40
                
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            
            
            self.snipVisible = false
            self.trimSaveBTN.isHidden = true
            self.snipImage.image = nil
            
            self.imagePan.isEnabled = true
            self.IsTrimming = false
            self.imagePinch.isEnabled = true
            self.viewPinch.isEnabled = false
            self.viewPan.isEnabled = false
            self.trimView.isHidden = true
            self.trimBTN.isEnabled = true
            self.pasteIMGBTN.isEnabled = true
            
            self.trimBTN.isEnabled = true
            self.pasteIMGBTN.isEnabled = true
            
            
        } else {
        
              print("pencil not locked")
        
            
            let theAlert = SCLAlertView()
            
            theAlert.addButton("No, Paste over") {
                let startH = self.trimresizeH
                let startW = self.trimresizeW
                let startX = self.trimresizeX - (self.trimresizeW / 2)
                let startY = (self.trimresizeY - (self.trimresizeH / 2)) - 70
                print("Start X = \(startX)")
                print("Start Y = \(startY)")
                
                
                
                
                //     dispatch_async(dispatch_get_main_queue(),{
                
                let image = self.snipImage.image
                
                // self.tempFirstImageView.image = image
                
                let vH = self.tempFirstImageView.frame.height
                let vW = self.tempFirstImageView.frame.width
                
                
                
                
                UIGraphicsBeginImageContext(self.tempImageView.frame.size)
                
                self.tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.tempImageView.frame.size.width, height: self.tempImageView.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
                
                self.snipImage.image?.draw(in: CGRect(x: startX, y: startY, width: startW, height: startH), blendMode: CGBlendMode.normal, alpha: self.opacity)
                
                // self.tempFirstImageView.image?.drawInRect(CGRect(x: startX, y: startY, width: startW, height: startH), blendMode: CGBlendMode.Normal, alpha: self.opacity)
                
                self.tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                self.tempFirstImageView.image = nil
                //  self.snipImage.image = nil
                
                
                //      });
                
                
                self.pencilLocked = false
                // self.snipImage.hidden = true
                //    self.trimBTN.hidden = true
                //   self.pasteIMGBTN.hidden = true
                //   self.resizeIMG.layer.borderWidth = 0
                // self.lockBTN.setImage(UIImage(named: "EditButton_white.png"), forState: .Normal)
                //  self.cutBTN.hidden = true
                // self.lockBTN.hidden = true
                print("hide scale controls")
                //  self.ScaleControlsView.hidden = true
                self.WasPasted = true
                //self.trimView.hidden = true
                //  snipVisible = false
                
                if self.ScaleControlsShowing {
                    
                    if !self.pencilLocked {
                        self.ScaleControlsView.isHidden = true
                        self.ScaleControlsShowing = false
                    }
                }
                
                
                
                self.trimView.isHidden = true
                
                
                UIView.animate(withDuration: 1.0, animations: { () -> Void in
                    //   self.SnipControlsView.center.y = self.SnipControlsView.center.y + 50
                    
                    //   self.SnipControlsView.center.x = self.SnipControlsView.center.x - 50
                    
                    self.SnipControlsViewBOTTOM.constant = -40
                    //  self.SnipControlsViewH.constant = 0
                    //  self.SnipControlsViewW.constant = 0
                    self.SnipControlsViewLEAD.constant = -40
                    
                    //self.ViewShowing = true
                    // ShowingInfo = true
                    
                    // self.ViewTransTOP.constant = 0
                })
                
                
                self.snipVisible = false
                self.trimSaveBTN.isHidden = true
                self.snipImage.image = nil
                
                self.imagePan.isEnabled = true
                self.IsTrimming = false
                self.imagePinch.isEnabled = true
                self.viewPinch.isEnabled = false
                self.viewPan.isEnabled = false
                self.trimView.isHidden = true
                self.trimBTN.isEnabled = true
                self.pasteIMGBTN.isEnabled = true
                
                self.trimBTN.isEnabled = true
                self.pasteIMGBTN.isEnabled = true

            }
            
            theAlert.addButton("Yes, Clear Canvas first") {
                self.mainImageView.image = nil
                self.tempImageView.image = nil
                let startH = self.trimresizeH
                let startW = self.trimresizeW
                let startX = self.trimresizeX - (self.trimresizeW / 2)
                let startY = (self.trimresizeY - (self.trimresizeH / 2)) - 70
                print("Start X = \(startX)")
                print("Start Y = \(startY)")
                
                print("Start H = \(startH)")
                print("Start W = \(startW)")
                
                
                //       dispatch_async(dispatch_get_main_queue(),{
                
                let image = self.snipImage.image
                
                // self.tempFirstImageView.image = image
                
                let vH = self.tempFirstImageView.frame.height
                let vW = self.tempFirstImageView.frame.width
                
                
                
                
                UIGraphicsBeginImageContext(self.tempImageView.frame.size)
                
                self.tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.tempImageView.frame.size.width, height: self.tempImageView.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
                
                self.snipImage.image?.draw(in: CGRect(x: startX, y: startY, width: startW, height: startH), blendMode: CGBlendMode.normal, alpha: self.opacity)
                
                // self.tempFirstImageView.image?.drawInRect(CGRect(x: startX, y: startY, width: startW, height: startH), blendMode: CGBlendMode.Normal, alpha: self.opacity)
                
                self.tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                self.tempFirstImageView.image = nil
                self.snipImage.image = nil
                
                
                //         });
                
                
                self.pencilLocked = false
                // self.snipImage.hidden = true
                //    self.trimBTN.hidden = true
                //   self.pasteIMGBTN.hidden = true
                //   self.resizeIMG.layer.borderWidth = 0
                // self.lockBTN.setImage(UIImage(named: "EditButton_white.png"), forState: .Normal)
                //  self.cutBTN.hidden = true
                // self.lockBTN.hidden = true
                print("hide scale controls")
                //  self.ScaleControlsView.hidden = true
                self.WasPasted = true
                //self.trimView.hidden = true
                //  snipVisible = false
                
                if self.ScaleControlsShowing {
                    
                    if !self.pencilLocked {
                        self.ScaleControlsView.isHidden = true
                        self.ScaleControlsShowing = false
                    }
                }
                
                
                
                self.trimView.isHidden = true
                
                
                UIView.animate(withDuration: 1.0, animations: { () -> Void in
                    //   self.SnipControlsView.center.y = self.SnipControlsView.center.y + 50
                    
                    //   self.SnipControlsView.center.x = self.SnipControlsView.center.x - 50
                    
                    self.SnipControlsViewBOTTOM.constant = -40
                    //  self.SnipControlsViewH.constant = 0
                    //  self.SnipControlsViewW.constant = 0
                    self.SnipControlsViewLEAD.constant = -40
                    
                    //self.ViewShowing = true
                    // ShowingInfo = true
                    
                    // self.ViewTransTOP.constant = 0
                })
                
                
                self.snipVisible = false
                self.trimSaveBTN.isHidden = true
                self.snipImage.image = nil
                
                self.imagePan.isEnabled = true
                self.IsTrimming = false
                self.imagePinch.isEnabled = true
                self.viewPinch.isEnabled = false
                self.viewPan.isEnabled = false
                self.trimView.isHidden = true
                self.trimBTN.isEnabled = true
                self.pasteIMGBTN.isEnabled = true
                
                self.trimBTN.isEnabled = true
                self.pasteIMGBTN.isEnabled = true

            }
           // theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Clear Canvas before Paste?", subTitle: "Would you like to clear the canvas first?")
            
              theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Clear Canvas before Paste?", subTitle: "Would you like to clear the canvas first?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
        
            
            /*

            let actionSheetController: UIAlertController = UIAlertController(title: "Clear Canvas before Paste?", message: "Would you like to clear the canvas first?", preferredStyle: .Alert)
            
            //Create and add the Cancel action
            let cancelAction: UIAlertAction = UIAlertAction(title: "Yes clear canvas, then paste", style: .Default) { action -> Void in
                //Do some stuff
                
                self.mainImageView.image = nil
                self.tempImageView.image = nil
                

                
                let startH = self.trimresizeH
                let startW = self.trimresizeW
                let startX = self.trimresizeX - (self.trimresizeW / 2)
                let startY = (self.trimresizeY - (self.trimresizeH / 2)) - 70
                print("Start X = \(startX)")
                print("Start Y = \(startY)")
                
                print("Start H = \(startH)")
                print("Start W = \(startW)")
                
                
         //       dispatch_async(dispatch_get_main_queue(),{
                    
                    let image = self.snipImage.image
                    
                    // self.tempFirstImageView.image = image
                    
                    let vH = self.tempFirstImageView.frame.height
                    let vW = self.tempFirstImageView.frame.width
                    
                    
                    
                    
                    UIGraphicsBeginImageContext(self.tempImageView.frame.size)
                    
                    self.tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: self.tempImageView.frame.size.width, height: self.tempImageView.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
                    
                    self.snipImage.image?.drawInRect(CGRect(x: startX, y: startY, width: startW, height: startH), blendMode: CGBlendMode.Normal, alpha: self.opacity)
                    
                    // self.tempFirstImageView.image?.drawInRect(CGRect(x: startX, y: startY, width: startW, height: startH), blendMode: CGBlendMode.Normal, alpha: self.opacity)
                    
                    self.tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    
                    self.tempFirstImageView.image = nil
                    self.snipImage.image = nil
                    
                    
       //         });
            
                
                self.pencilLocked = false
                // self.snipImage.hidden = true
                //    self.trimBTN.hidden = true
                //   self.pasteIMGBTN.hidden = true
                //   self.resizeIMG.layer.borderWidth = 0
                // self.lockBTN.setImage(UIImage(named: "EditButton_white.png"), forState: .Normal)
                //  self.cutBTN.hidden = true
                // self.lockBTN.hidden = true
                print("hide scale controls")
                //  self.ScaleControlsView.hidden = true
                self.WasPasted = true
                //self.trimView.hidden = true
                //  snipVisible = false
                
                if self.ScaleControlsShowing {
                    
                    if !self.pencilLocked {
                        self.ScaleControlsView.hidden = true
                        self.ScaleControlsShowing = false
                    }
                }
                
                
                
                self.trimView.hidden = true
                
                
                UIView.animateWithDuration(1.0, animations: { () -> Void in
                    //   self.SnipControlsView.center.y = self.SnipControlsView.center.y + 50
                    
                    //   self.SnipControlsView.center.x = self.SnipControlsView.center.x - 50
                    
                    self.SnipControlsViewBOTTOM.constant = -40
                    //  self.SnipControlsViewH.constant = 0
                    //  self.SnipControlsViewW.constant = 0
                    self.SnipControlsViewLEAD.constant = -40
                    
                    //self.ViewShowing = true
                    // ShowingInfo = true
                    
                    // self.ViewTransTOP.constant = 0
                })
                
                
                self.snipVisible = false
                self.trimSaveBTN.hidden = true
                self.snipImage.image = nil
                
                self.imagePan.enabled = true
                self.IsTrimming = false
                self.imagePinch.enabled = true
                self.viewPinch.enabled = false
                self.viewPan.enabled = false
                self.trimView.hidden = true
                self.trimBTN.enabled = true
                self.pasteIMGBTN.enabled = true
                
                self.trimBTN.enabled = true
                self.pasteIMGBTN.enabled = true
                
                
            
                
                    }
            actionSheetController.addAction(cancelAction)
            //Create and an option action
            let nextAction: UIAlertAction = UIAlertAction(title: "No, paste over canvas", style: .Default) { action -> Void in
                
           /*
            dispatch_async(dispatch_get_main_queue(),{
        self.InsertImage()
                })
*/

                
                let startH = self.trimresizeH
                let startW = self.trimresizeW
                let startX = self.trimresizeX - (self.trimresizeW / 2)
                let startY = (self.trimresizeY - (self.trimresizeH / 2)) - 70
                print("Start X = \(startX)")
                print("Start Y = \(startY)")
                
                
                
                
           //     dispatch_async(dispatch_get_main_queue(),{
                    
                    let image = self.snipImage.image
                    
                    // self.tempFirstImageView.image = image
                    
                    let vH = self.tempFirstImageView.frame.height
                    let vW = self.tempFirstImageView.frame.width
                    
                    
                    
                    
                    UIGraphicsBeginImageContext(self.tempImageView.frame.size)
                    
                    self.tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: self.tempImageView.frame.size.width, height: self.tempImageView.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
                    
                    self.snipImage.image?.drawInRect(CGRect(x: startX, y: startY, width: startW, height: startH), blendMode: CGBlendMode.Normal, alpha: self.opacity)
                    
                    // self.tempFirstImageView.image?.drawInRect(CGRect(x: startX, y: startY, width: startW, height: startH), blendMode: CGBlendMode.Normal, alpha: self.opacity)
                    
                    self.tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    
                    self.tempFirstImageView.image = nil
                  //  self.snipImage.image = nil
                    
                    
          //      });
                
        
                self.pencilLocked = false
                // self.snipImage.hidden = true
                //    self.trimBTN.hidden = true
                //   self.pasteIMGBTN.hidden = true
                //   self.resizeIMG.layer.borderWidth = 0
                // self.lockBTN.setImage(UIImage(named: "EditButton_white.png"), forState: .Normal)
                //  self.cutBTN.hidden = true
                // self.lockBTN.hidden = true
                print("hide scale controls")
                //  self.ScaleControlsView.hidden = true
                self.WasPasted = true
                //self.trimView.hidden = true
                //  snipVisible = false
                
                if self.ScaleControlsShowing {
                    
                    if !self.pencilLocked {
                        self.ScaleControlsView.hidden = true
                        self.ScaleControlsShowing = false
                    }
                }
                
                
                
                self.trimView.hidden = true
                
                
                UIView.animateWithDuration(1.0, animations: { () -> Void in
                    //   self.SnipControlsView.center.y = self.SnipControlsView.center.y + 50
                    
                    //   self.SnipControlsView.center.x = self.SnipControlsView.center.x - 50
                    
                    self.SnipControlsViewBOTTOM.constant = -40
                    //  self.SnipControlsViewH.constant = 0
                    //  self.SnipControlsViewW.constant = 0
                    self.SnipControlsViewLEAD.constant = -40
                    
                    //self.ViewShowing = true
                    // ShowingInfo = true
                    
                    // self.ViewTransTOP.constant = 0
                })
                
                
                self.snipVisible = false
                self.trimSaveBTN.hidden = true
                self.snipImage.image = nil
                
                self.imagePan.enabled = true
                self.IsTrimming = false
                self.imagePinch.enabled = true
                self.viewPinch.enabled = false
                self.viewPan.enabled = false
                self.trimView.hidden = true
                self.trimBTN.enabled = true
                self.pasteIMGBTN.enabled = true
                
                self.trimBTN.enabled = true
                self.pasteIMGBTN.enabled = true
                
        
            }
        
        
        actionSheetController.addAction(nextAction)
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        
            */
            
        }


    
    }
    
    func InsertImage(){
        

            let startH = self.trimresizeH
            let startW = self.trimresizeW
            let startX = self.trimresizeX - (self.trimresizeW / 2)
            let startY = (self.trimresizeY - (self.trimresizeH / 2)) - 70
            print("Start X = \(startX)")
            print("Start Y = \(startY)")
            
            
            
            
            DispatchQueue.main.async(execute: {
                
                let image = self.snipImage.image
                
                // self.tempFirstImageView.image = image
                
                let vH = self.tempFirstImageView.frame.height
                let vW = self.tempFirstImageView.frame.width
        
                
                
                
                UIGraphicsBeginImageContext(self.tempImageView.frame.size)
                
                self.tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.tempImageView.frame.size.width, height: self.tempImageView.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
                
                self.snipImage.image?.draw(in: CGRect(x: startX, y: startY, width: startW, height: startH), blendMode: CGBlendMode.normal, alpha: self.opacity)
                
                // self.tempFirstImageView.image?.drawInRect(CGRect(x: startX, y: startY, width: startW, height: startH), blendMode: CGBlendMode.Normal, alpha: self.opacity)
                
                self.tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                self.tempFirstImageView.image = nil
                self.snipImage.image = nil
                
                
            });
            
        
        self.pencilLocked = false
        // self.snipImage.hidden = true
        //    self.trimBTN.hidden = true
        //   self.pasteIMGBTN.hidden = true
        //   self.resizeIMG.layer.borderWidth = 0
        // self.lockBTN.setImage(UIImage(named: "EditButton_white.png"), forState: .Normal)
        //  self.cutBTN.hidden = true
        // self.lockBTN.hidden = true
        print("hide scale controls")
        //  self.ScaleControlsView.hidden = true
        self.WasPasted = true
        //self.trimView.hidden = true
        //  snipVisible = false
        
        if self.ScaleControlsShowing {
            
            if !self.pencilLocked {
                self.ScaleControlsView.isHidden = true
                self.ScaleControlsShowing = false
            }
        }
        
        
        
        self.trimView.isHidden = true
        
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            //   self.SnipControlsView.center.y = self.SnipControlsView.center.y + 50
            
            //   self.SnipControlsView.center.x = self.SnipControlsView.center.x - 50
            
            self.SnipControlsViewBOTTOM.constant = -40
            //  self.SnipControlsViewH.constant = 0
            //  self.SnipControlsViewW.constant = 0
            self.SnipControlsViewLEAD.constant = -40
            
            //self.ViewShowing = true
            // ShowingInfo = true
            
            // self.ViewTransTOP.constant = 0
        })
        
        
        self.snipVisible = false
        self.trimSaveBTN.isHidden = true
        self.snipImage.image = nil
        
        self.imagePan.isEnabled = true
        self.IsTrimming = false
        self.imagePinch.isEnabled = true
        self.viewPinch.isEnabled = false
        self.viewPan.isEnabled = false
        self.trimView.isHidden = true
        self.trimBTN.isEnabled = true
        self.pasteIMGBTN.isEnabled = true
        
        self.trimBTN.isEnabled = true
        self.pasteIMGBTN.isEnabled = true

    }
    
    
    @IBAction func closeControls(_ sender: AnyObject) {
        
        self.trimView.isHidden = true
       // self.cutBTN.hidden = true
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            // self.ShowQuoteViewTOP.constant = middleY
            
          //  self.SnipControlsView.center.y = self.SnipControlsView.center.y + 50
            
          //  self.SnipControlsView.center.x = self.SnipControlsView.center.x - 50
            
            self.SnipControlsViewBOTTOM.constant = -40
          //  self.SnipControlsViewH.constant = 0
          //  self.SnipControlsViewW.constant = 0
            self.SnipControlsViewLEAD.constant = -40
            
            //self.ViewShowing = true
            // ShowingInfo = true
            
            // self.ViewTransTOP.constant = 0
        })
        
        self.snipImage.image = nil
        snipVisible = false
        
        imagePan.isEnabled = true
        IsTrimming = false
        imagePinch.isEnabled = true
        viewPinch.isEnabled = false
        viewPan.isEnabled = false
        self.trimView.isHidden = true
        self.trimBTN.isEnabled = true
        self.pasteIMGBTN.isEnabled = true
        //snipImage.image = nil
        self.trimSaveBTN.isHidden = true
        
        if self.ScaleControlsShowing {
            
            if !pencilLocked {
                self.ScaleControlsView.isHidden = true
                self.ScaleControlsShowing = false
            }
        }
        
    }
    
    @IBAction func CaptureScreen(_ sender: AnyObject) {
        
        print("CAPTURE trim resize x = \(trimresizeX)")
        print("CAPTURE trim resize y = \(trimresizeY)")
        print("CAPTURE trim resize height = \(trimresizeH)")
        print("CAPTURE trim resize Width = \(trimresizeW)")
        
        self.trimView.isHidden = true
        //   let snipTemp = self.snipView.pb_takeSnapshot(resizeX, y: resizeY, h: resizeH, w: resizeW)
        self.SnipControlsView.isHidden = true
        self.ScaleControlsView.isHidden = true
        self.cutBTN.isHidden = true
        self.pasteIMGBTN.isHidden = true
        self.trimBTN.isHidden = true
        
         self.trimSaveBTN.isHidden = false
        
        
        
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: trimresizeH,height: trimresizeW), false, 0)
        
        var image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        
        // drawViewHierarchyInRect(CGRectMake(-01, -01, self.frame.size.width, self.frame.size.height), afterScreenUpdates: true)
        
        //  self.view.drawViewHierarchyInRect(CGRectMake((resizeX), (resizeY), resizeW, resizeH), afterScreenUpdates: true)
        
        
        //  self.view.drawViewHierarchyInRect(CGRectMake((-1 * resizeX), (-1 * resizeY), snipView.bounds.size.width, snipView.bounds.size.height), afterScreenUpdates: true)
        
        //   self.view.drawViewHierarchyInRect(CGRectMake((-100), (-100), snipView.bounds.size.width, snipView.bounds.size.height), afterScreenUpdates: true)
        
      //  var FromSide = trimresizeX - (trimresizeW / 2)
     //   var FromTop = trimresizeY - (trimresizeH / 2)
        
        
        let FromSide = trimresizeX - (trimresizeH / 2)
        let FromTop = trimresizeY - (trimresizeW / 2)
        
        print("From Side = \(FromSide)")
        print("From Top = \(FromTop)")
        
        //  self.view.drawViewHierarchyInRect(CGRectMake(-(resizeX), -(resizeY), self.view.frame.width, self.view.frame.height), afterScreenUpdates: true)
        
        
        self.view.drawHierarchy(in: CGRect(x: -(FromSide), y: -(FromTop), width: self.view.frame.width, height: self.view.frame.height), afterScreenUpdates: true)
        
        
      //  self.view.drawViewHierarchyInRect(CGRectMake(-(FromSide), -(FromTop), self.view.frame.width, self.view.frame.height), afterScreenUpdates: true)
        
        
     //   self.view.drawViewHierarchyInRect(CGRectMake(-(FromSide), -(FromTop), self.view.frame.height, self.view.frame.width), afterScreenUpdates: true)
        
        // var snipTemp  = UIGraphicsGetImageFromCurrentImageContext()
        
        
        
        self.snipImage.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
       // self.snipImage.contentMode = UIViewContentMode.ScaleAspectFit
        
        self.snipImage.isHidden = false
        self.trimView.isHidden = false
     
        
        self.SnipControlsView.isHidden = false
        
        
        
        
        self.ScaleControlsView.isHidden = false
        
        
         if pencilLocked {
            
        self.cutBTN.isHidden = false
        self.pasteIMGBTN.isHidden = false
        self.trimBTN.isHidden = false
            
        }
        
        //self.snipImage.image = snipTemp
      //  self.snipView.hidden = false
        
        
      //  imageData = UIImageJPEGRepresentation(snipImage.image!, 1.0)!;
        
     //   print("ImageNSData = \(imageData)")
        
        
        
        //self.snippedPic.image = snipTemp
        //  self.snippedPic.hidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sliderBrush.value = Float(brush)
        labelBrush.text = NSString(format: "%.1f", brush.native) as String
        
        
        drawPreview()
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        if sender == sliderBrush {
            brush = CGFloat(sender.value)
            labelBrush.text = NSString(format: "%.2f", brush.native) as String
            
             self.brushWidth = self.brush
        }
        
        /*
else {
            opacity = CGFloat(sender.value)
            labelOpacity.text = NSString(format: "%.2f", opacity.native) as String
        }
        */
        drawPreview()
    }
    
    func drawPreview() {
        UIGraphicsBeginImageContext(imageViewBrush.frame.size)
        var context = UIGraphicsGetCurrentContext()
        
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brush)
        
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
        context?.move(to: CGPoint(x: 45.0, y: 45.0))
        context?.addLine(to: CGPoint(x: 45.0, y: 45.0))
        context?.strokePath()
        imageViewBrush.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIGraphicsBeginImageContext(imageViewBrush.frame.size)
        context = UIGraphicsGetCurrentContext()
        
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(20)
        context?.move(to: CGPoint(x: 45.0, y: 45.0))
        context?.addLine(to: CGPoint(x: 45.0, y: 45.0))
        
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: opacity)
        context?.strokePath()
      //  imageViewOpacity.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }

    
    
    func HandleAlertMessageIVC(_ notification:Notification)  {
    
    print("Did Receive Remote Notification While In Game")
    
    var QuoteExample = String()
    var player1 = String()
    var player2 = String()
    var player3 = String()
    var player4 = String()
    var player5 = String()
    var player6 = String()
    var player7 = String()
    var player8 = String()
    var player9 = String()
    var player10 = String()
    
    let userInfo:Dictionary<String,String?> = (notification as NSNotification).userInfo as! Dictionary<String,String?>
    
    var jsonAlert = JSON(userInfo)
    print("JSON ALERT \(jsonAlert)")
    //   println("JSON ALERT \(jsonAlert)")
    let NotificationMessage = jsonAlert["message"].stringValue
    let gameBy = jsonAlert["gameBy"].stringValue
    let gameId = jsonAlert["gameId"].stringValue
    let category = jsonAlert["category"].stringValue
    let turninfo = jsonAlert["turninfo"].stringValue
    let gameType = jsonAlert["gameType"].stringValue
    
    if category == "GameSuggestion" {
    
    
    QuoteExample = jsonAlert["quote"].stringValue
    print("Quote example is =\(QuoteExample)")
    player1 = jsonAlert["player1"].stringValue
    print("Player 1 is \(player1)")
    player2 = jsonAlert["player2"].stringValue
    player3 = jsonAlert["player3"].stringValue
    player4 = jsonAlert["player4"].stringValue
    player5 = jsonAlert["player5"].stringValue
    player6 = jsonAlert["player6"].stringValue
    player7 = jsonAlert["player7"].stringValue
    player8 = jsonAlert["player8"].stringValue
    player9 = jsonAlert["player9"].stringValue
    player10 = jsonAlert["player10"].stringValue
    
    } else {
    
    }
    
    print("in Game Alert Category: \(category)")
    
    
    
    if !IsHandlingAlertMessage {
    
    IsHandlingAlertMessage = true
    
    switch category {
    

    case "gameComment":
    
    
    DispatchQueue.main.async(execute: {
    
    
    let theAlert = SCLAlertView()
    
    
    theAlert.addButton("Check It Out!") {
    
    var window: UIWindow?
    
    if let viewControllers = self.navigationController?.viewControllers {
    for viewController in viewControllers {
    if viewController.isKind(of: ViewController.self) {
    
    } else {
    UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: nil)
    }
    }
    } else {
    print("else showing")
    
    self.navigationController?.popToRootViewController(animated: false)
    UIApplication.shared.keyWindow?.makeKeyAndVisible()
    UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: nil)
    }
    
    DispatchQueue.main.async(execute: {
    
    self.CommentsGameID = gameId as NSString
    self.TurnNumber = turninfo as NSString
  //  self.GameType = gameType
    
    print("GameID =\(self.CommentsGameID)")
    print("TurnInfo =\(self.TurnNumber)")
    print("Trying to take turn")
    DispatchQueue.main.async(execute: {
    //  self.dismissViewControllerAnimated(false, completion: nil)
    self.ViewComments()
    
    })
    })
    
    
    }
    
    
    
    //theAlert.showCustomOK(UIImage(named: "commentsIcon White.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "New Comment", subTitle: NotificationMessage)
    
    theAlert.showCustom(UIImage(named: "commentsIcon White.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "New Comment", subTitle: NotificationMessage, duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
    
    })
    
    
    default:
    print("unknown push alert")
    
    }
    
    
    }
    
    }
    
    
    func ViewComments() {
        
        print("ViewComments")
        
        self.performSegue(withIdentifier: "ShowComments", sender: self)
        
    }
    
    func displayForegroundDetails() {
        print("APP ENTERED THE FOREGROUND")
        
        
        var window: UIWindow?
        
        
        if self.isViewLoaded && view.window != nil {
            
            
          //  self.view.addSubview(self.RefreshHUD)
            
            DispatchQueue.main.async(execute: {
                print("is on my games view controller, trying to refresh my games")
             //   self.RefreshGameData(self)
                // self.TableView.reloadData()
                DispatchQueue.main.async(execute: {
                //    self.RefreshHUD.removeFromSuperview()
                 //   self.TableView.reloadData()
                    
                    self.performSegue(withIdentifier: "ShowComments", sender: self)
                })
            })
            
            
            print("My games VC is loaded and on screen")
        } else {
            print("myGames vc is not loaded or on screen")
        }
        
        if self.isViewLoaded  {
            print("My games VC is loaded")
        } else {
            print("myGames vc is not loaded")
        }
        
        
        
        
        if let viewControllers = self.navigationController?.viewControllers {
            
            for viewController in viewControllers {
                if viewController.isKind(of: ImageViewController.self) {
                    
                    
                    /*
                    self.view.addSubview(self.RefreshHUD)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                    print("is on my games view controller, trying to refresh my games")
                    self.RefreshGameData(self)
                    // self.TableView.reloadData()
                    dispatch_async(dispatch_get_main_queue(), {
                    self.RefreshHUD.removeFromSuperview()
                    self.TableView.reloadData()
                    })
                    })
                    */
                } else {
                    //   UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self, animated: false, completion: nil)
                    print("Not on My Games ViewController")
                }
            }
        } else {
            print("else showing")
            
            /*
            self.navigationController?.popToRootViewControllerAnimated(false)
            UIApplication.sharedApplication().keyWindow?.makeKeyAndVisible()
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self, animated: false, completion: nil)
            */
        }
        
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        
    }
 
    
}


extension ImageViewController: SettingsViewControllerDelegate {
    func settingsViewControllerFinished(_ settingsViewController: SettingsViewController) {
        self.brushWidth = settingsViewController.brush
        self.opacity = settingsViewController.opacity
        self.red = settingsViewController.red
        self.green = settingsViewController.green
        self.blue = settingsViewController.blue
        self.showQuoteInt = 1
        
        
        
    }
    
    
}

extension ImageViewController {
    //}: FBFriendsViewControllerDelegate {
    func BrowseImageViewControllerFinished(_ browseimageviewController: BrowseImageViewController) {
        
        
        self.googleImageData = browseimageviewController.theImageData as String
        
        
        
        let Image64NSData = Data(base64Encoded: googleImageData as String, options: NSData.Base64DecodingOptions(rawValue: 0))
        
        
        //  print("Image64NSData = \(Image64NSData!)")
        
        let Image64Data = NSString(data: Image64NSData!, encoding: String.Encoding.utf8.rawValue)!
        
        
        let decodedData = Data(base64Encoded: Image64Data as String, options: NSData.Base64DecodingOptions(rawValue: 0))
        
        //  print("Decoded Data: \(decodedData)")
        print("Setting google Image")
        
        //  let image = UIImage(data: decodedData!)
        let image = UIImage(data: Image64NSData!)
        tempImageView.image = image
        
        
        
        if self.SelectedGoogleImage{
            //ShowMusicViewNow()
        }
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        //self.FBFriendName = fbfriendsviewController.FBFriendName
        
        
    }
}
/*
extension UIImage {
    func resize(scale:CGFloat)-> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width*scale, height: size.height*scale)))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext())
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    func resizeToWidth(width:CGFloat)-> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext())
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}
*/


/*
extension NSString {

    func stringByAddingPercentEncodingForURLQueryValue() -> NSString? {
        let characterSet = NSMutableCharacterSet.alphanumericCharacterSet()
        characterSet.addCharactersInString("-._* ")
        return stringByAddingPercentEncodingWithAllowedCharacters(characterSet)?.stringByReplacingOccurrencesOfString(" ", withString: "+")
    }

    func stringByAddingPercentEncodingForURLQueryValue2() -> NSString? {
        let characterSet = NSMutableCharacterSet.alphanumericCharacterSet()
        characterSet.addCharactersInString("-._* ")
        return stringByAddingPercentEncodingWithAllowedCharacters(characterSet)?.stringByReplacingOccurrencesOfString("%2F", withString: "/")
    }





}
*/

