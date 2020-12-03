//
//  TurnPictureViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 10/27/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import Photos
import AssetsLibrary
import AVFoundation
import WDImagePicker
//import ALCameraViewController


protocol ImageViewControllerDelegate: class {
    func ImageViewControllerFinished(_ imageviewController: TurnPictureViewController)
}

class TurnPictureViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, BrowseImageViewControllerDelegate, WDImagePickerDelegate {
    
    var IsCameraImage = Bool()
    var alreadyViewingValue = Int()
    
    @IBOutlet weak var cameraBottomView: UIView!
    
    @IBOutlet weak var cameraTOP: NSLayoutConstraint!
    
    @IBOutlet weak var cameraBOTTOM: NSLayoutConstraint!
    
    @IBOutlet weak var cameraOverlay: UIView!
    
    var DeviceW = CGFloat()
    //self.view.frame.width
    var DeviceH = CGFloat()
    //self.view.frame.height
    
    @IBOutlet weak var imageLBL: UILabel!
    
    
    @IBOutlet weak var reportBTN: UIButton!
    
    var alreadyViewing = Bool()
    
    @IBOutlet weak var TopViewHolder: UIView!
    var imageInserted = Bool()
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    
    var googleImageData = String()
    var browseimageviewcontroller: BrowseImageViewController = BrowseImageViewController()
    
    var SelectedGoogleImage = Bool()
    var useGoogleImage = Bool()
    var fromGoogle = Bool()
    //google trail = 116
    //camera trail = 116
    var WasPasted = true
    var gifNSData = Data()
    var MediaTypeNew = NSString()
    
    
     let prefs:UserDefaults = UserDefaults.standard
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var mainImageLeading: NSLayoutConstraint!
    
    @IBOutlet weak var mainImageTop: NSLayoutConstraint!
    
    @IBOutlet weak var submitBTNTrailing: NSLayoutConstraint!
    
    
    @IBOutlet weak var googleBTNTrailing: NSLayoutConstraint!
    @IBOutlet weak var cameraBTNTrailing: NSLayoutConstraint!
    @IBOutlet weak var photoBTNTrailing: NSLayoutConstraint!
    
    
    @IBOutlet weak var googleBTN_TOP: NSLayoutConstraint!
    @IBOutlet weak var cameraBTN_TOP: NSLayoutConstraint!
    @IBOutlet weak var photoBTN_TOP: NSLayoutConstraint!
    @IBOutlet weak var submitBTN_TOP: NSLayoutConstraint!
    @IBOutlet weak var quoteViewHolder: UIView!
    
    @IBOutlet weak var quoteText: UILabel!
    
    var GameID = NSString()
    var newGame = Bool()
    var isNewGame = NSString()
    
    var currentTurnNumber = NSString()
    var newTurnNumber = NSString()
    var TempTurnNumber = NSString()
    
    var MediaType = NSString()
    var QuoteData = NSString()
    
    @IBOutlet weak var SmallViewTOP: NSLayoutConstraint!
    
    weak var delegate: TurnPictureViewControllerDelegate?
    
   static let storyboardIdentifier = "TurnPictureViewController"
    
    @IBOutlet weak var cameraBTN: UIButton!
     @IBOutlet weak var googleBTN: UIButton!
    @IBOutlet weak var SmallView: UIView!
    @IBOutlet weak var MainImage: UIImageView!

    let picker = UIImagePickerController()
    
    let imagePicker = UIImagePickerController()
    
    let imagePickerWD = WDImagePicker()
    
    @IBOutlet weak var submitBTN: UIButton!
    @IBOutlet weak var selectBTN: UIButton!
    
    var TurnStats: GameBoard? {
        
        didSet {
            // guard let turnInfo = GameBoard? else { return }
            
            //if GameBoard.
            
            // Determine the ice cream parts to show in the collection view.
            /*
             if iceCream.base == nil {
             iceCreamParts = Base.all.map { $0 }
             prompt = NSLocalizedString("Select a base", comment: "")
             }
             else if iceCream.scoops == nil {
             iceCreamParts = Scoops.all.map { $0 }
             prompt = NSLocalizedString("Add some scoops", comment: "")
             }
             else if iceCream.topping == nil {
             iceCreamParts = Topping.all.map { $0 }
             prompt = NSLocalizedString("Finish with a topping", comment: "")
             }
             
             */
        }
    }
    
    /*
    @IBAction func browseGoogleNow(_ sender: Any) {
        DispatchQueue.main.async(execute: {
            self.performSegue(withIdentifier: "browseimage", sender: self)
        })
        
    }
    */
    
    @IBAction func browseGoogleNow2(_ sender: Any) {
        
        DispatchQueue.main.async(execute: {
            self.performSegue(withIdentifier: "browseimage", sender: self)
        })
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("PICTURE TURN LOADED")
        
        cameraOverlay.isHidden = true
        DeviceW = self.view.frame.width
        DeviceH = self.view.frame.height
        
        let FontSizeTemp = DeviceW / 10
        
        self.imageLBL.font.withSize(FontSizeTemp)
        
        
        self.textView.isHidden = false
        self.textView.text = "Select an image"
        
       // view.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
       // self.SmallViewTOP.constant = 100
        picker.delegate = self
        
        self.submitBTN.layer.cornerRadius = 30
        self.submitBTN.layer.borderColor = UIColor.white.cgColor
        self.submitBTN.layer.borderWidth = 1
        
        
        self.selectBTN.layer.cornerRadius = 20
      //  self.selectBTN.layer.borderColor = UIColor.white.cgColor
      //  self.selectBTN.layer.borderWidth = 1
        self.selectBTN.clipsToBounds = true
        self.selectBTN.layer.masksToBounds = true
        self.selectBTN.layer.backgroundColor = UIColor.white.cgColor
        
        
        self.cameraBTN.layer.cornerRadius = 20
      //  self.cameraBTN.layer.borderColor = UIColor.white.cgColor
      //  self.cameraBTN.layer.borderWidth = 1
        self.cameraBTN.clipsToBounds = true
        self.cameraBTN.layer.masksToBounds = true
        
        
        self.googleBTN.layer.cornerRadius = 20
       // self.googleBTN.layer.borderColor = UIColor.white.cgColor
       // self.googleBTN.layer.borderWidth = 1
        self.googleBTN.clipsToBounds = true
        self.googleBTN.layer.masksToBounds = true
        
        
        self.MainImage.layer.masksToBounds = true
        self.MainImage.clipsToBounds = true
        self.MainImage.layer.cornerRadius = 10
        
        self.quoteViewHolder.layer.masksToBounds = true
        self.quoteViewHolder.clipsToBounds = true
        self.quoteViewHolder.layer.cornerRadius = 10
        self.quoteViewHolder.layer.borderColor = UIColor.white.cgColor
        self.quoteViewHolder.layer.borderWidth = 2
        
        
         NotificationCenter.default.addObserver(self, selector: #selector(TurnPictureViewController.UpdatePictureFrameView(_:)), name: NSNotification.Name(rawValue: "UpdatePictureFrameView"),  object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(TurnPictureViewController.googleImage(_:)), name: NSNotification.Name(rawValue: "googleImage"),  object: nil)
        
      //  NotifictionCetner.default.addObserver(self, selector: #selector(imagePicker), name: NSNotification.name(add))
        
        browseimageviewcontroller.browseimagedelegate=self
        
        
        if newGame {
            //isNewGame = "yes"
            //currentTurnNumber = "1"
            quoteViewHolder.isHidden = true
            self.reportBTN.isHidden = true
        }
        
        alreadyViewingValue = 1
    
        // Do any additional setup after loading the view.
    }
    
    func UpdatePictureFrameView(_ notification:Notification) {
        
        let DeviceW = self.view.frame.width
        let HalfDeviceW = DeviceW / 2
        //let BigImageX = HalfDeviceW - 100
        
        let userInfo:Dictionary<String,String?> = (notification as NSNotification).userInfo as! Dictionary<String,String?>
        
        var jsonAlert = JSON(userInfo)
        print("JSON ALERT \(jsonAlert)")
        
        let RawValue = jsonAlert["rawValue"].stringValue
        
        /*
        switch RawValue {
        case "1":
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                
                self.SmallView.center.y = self.SmallView.center.y + 100
                self.SmallViewTOP.constant = 100
                self.MainImage.center.y = self.MainImage.center.y + 120
                self.MainImage.center.x = self.MainImage.center.x + 100
                self.MainImage.transform = CGAffineTransform(scaleX: 2, y: 2);
                
                let ImageStart = HalfDeviceW - (self.MainImage.frame.width / 4)
                
                self.mainImageLeading.constant = ImageStart
                self.mainImageTop.constant = 250
                
                self.submitBTN.center.x = self.submitBTN.center.x - 75
                self.submitBTNTrailing.constant = HalfDeviceW - (self.submitBTN.frame.width / 2)
                self.submitBTN_TOP.constant = 120
                
                self.googleBTN.center.x = self.googleBTN.center.x - 150
                self.cameraBTN.center.x = self.cameraBTN.center.x - 75
                self.selectBTN.center.x = self.selectBTN.center.x + 6
                
                self.googleBTN.center.y = self.googleBTN.center.y - 85
                self.cameraBTN.center.y = self.cameraBTN.center.y - 45
                self.selectBTN.center.y = self.selectBTN.center.y + 5
                
                
                
                
                
                
                
                self.cameraBTNTrailing.constant = HalfDeviceW - (self.cameraBTN.frame.width / 2)
                
                let GoogleBTN_Left = HalfDeviceW - (self.googleBTN.frame.width / 2)
                
                self.photoBTNTrailing.constant = GoogleBTN_Left - 100
                self.googleBTNTrailing.constant = HalfDeviceW + (self.cameraBTN.frame.width / 2) + 60
                
                
                self.googleBTN_TOP.constant = 70
                self.cameraBTN_TOP.constant = 55
                self.photoBTN_TOP.constant = 70
                
                self.cameraBTN.transform = CGAffineTransform(scaleX: 2, y: 2);
                self.selectBTN.transform = CGAffineTransform(scaleX: 2, y: 2);
                self.googleBTN.transform = CGAffineTransform(scaleX: 2, y: 2);
                
                //google trail = 116
                //camera trail = 116
                
            })
            
            
        case "0":
            
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                
                self.SmallView.center.y = self.SmallView.center.y + 100
                self.SmallViewTOP.constant = 0
                
                self.MainImage.center.y = self.MainImage.center.y - 150
                 self.MainImage.center.x = self.MainImage.center.x - 100
                self.MainImage.transform = CGAffineTransform(scaleX: 1, y: 1);
                
                self.mainImageLeading.constant = 66
                self.mainImageTop.constant = 20
               
                self.submitBTN.center.x = self.submitBTN.center.x + 75
                self.submitBTNTrailing.constant = 28
                self.submitBTN_TOP.constant = 30
                
                self.googleBTN.center.x = self.googleBTN.center.x + 150
                self.cameraBTN.center.x = self.cameraBTN.center.x + 75
                self.selectBTN.center.x = self.selectBTN.center.x - 6
                
                self.googleBTN.center.y = self.googleBTN.center.y + 85
                self.cameraBTN.center.y = self.cameraBTN.center.y + 45
                self.selectBTN.center.y = self.selectBTN.center.y - 5
                
                
                self.googleBTNTrailing.constant = 116
                self.cameraBTNTrailing.constant = 116
                self.photoBTNTrailing.constant = 116
                
                self.googleBTN_TOP.constant = 105
                self.cameraBTN_TOP.constant = 65
                self.photoBTN_TOP.constant = 25
                
                self.cameraBTN.transform = CGAffineTransform(scaleX: 1, y: 1);
                self.selectBTN.transform = CGAffineTransform(scaleX: 1, y: 1);
                self.googleBTN.transform = CGAffineTransform(scaleX: 1, y: 1);
                
                
                
            })
            
            
        default:
            break
        }
        
        */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let DeviceW = self.view.frame.width
        let HalfDeviceW = DeviceW / 2
        let AppPresStyle = prefs.value(forKey:  "PresentationRawValue") as! String
        
        
        
        
        print("PICTURE TURN APPEARED")
        
        
        
        
        let ViewingPicture = prefs.value(forKey: "VIEWINGPICTURETURN")
        
        
        
        print("TURN PICTURE APPEARED")
        
        print("NewGame: \(newGame)")
        print("Turn Quote VC - GameID = \(GameID)")
        
       // NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdatePictureFrameView"), object: nil, userInfo: ["rawValue":"1"])
        
        
        if newGame {
            
            isNewGame = "yes"
            currentTurnNumber = "1"
            quoteViewHolder.isHidden = true
            actInd.stopAnimating()
            
            if useGoogleImage {
                self.textView.isHidden = true
                print("Should use Google")
                self.imageInserted = true
                myGoogleImage()
            } else {
                
                if !alreadyViewing {
                    if alreadyViewingValue < 2 {
                switch AppPresStyle {
                case "1":
                    UIView.animate(withDuration: 0.5, animations: { () -> Void in
                        
                        
                        self.SmallView.center.y = self.SmallView.center.y + 100
                        self.SmallViewTOP.constant = 100
                        self.MainImage.center.y = self.MainImage.center.y + 120
                        self.MainImage.center.x = self.MainImage.center.x + 100
                        self.MainImage.transform = CGAffineTransform(scaleX: 2, y: 2);
                        
                        let ImageStart = HalfDeviceW - (self.MainImage.frame.width / 4)
                        
                        self.mainImageLeading.constant = ImageStart
                        self.mainImageTop.constant = 250
                        
                        self.submitBTN.center.x = self.submitBTN.center.x - 75
                        self.submitBTNTrailing.constant = HalfDeviceW - (self.submitBTN.frame.width / 2)
                        self.submitBTN_TOP.constant = 120
                        
                        self.googleBTN.center.x = self.googleBTN.center.x - 150
                        self.cameraBTN.center.x = self.cameraBTN.center.x - 75
                        self.selectBTN.center.x = self.selectBTN.center.x + 6
                        
                        self.googleBTN.center.y = self.googleBTN.center.y - 85
                        self.cameraBTN.center.y = self.cameraBTN.center.y - 45
                        self.selectBTN.center.y = self.selectBTN.center.y + 5
                        
                        
                        
                        
                        
                        
                        
                        self.cameraBTNTrailing.constant = HalfDeviceW - (self.cameraBTN.frame.width / 2)
                        
                        let GoogleBTN_Left = HalfDeviceW - (self.googleBTN.frame.width / 2)
                        
                        self.photoBTNTrailing.constant = GoogleBTN_Left - 100
                        self.googleBTNTrailing.constant = HalfDeviceW + (self.cameraBTN.frame.width / 2) + 60
                        
                        
                        self.googleBTN_TOP.constant = 70
                        self.cameraBTN_TOP.constant = 55
                        self.photoBTN_TOP.constant = 70
                        
                        self.cameraBTN.transform = CGAffineTransform(scaleX: 2, y: 2);
                        self.selectBTN.transform = CGAffineTransform(scaleX: 2, y: 2);
                        self.googleBTN.transform = CGAffineTransform(scaleX: 2, y: 2);
                        
                        //google trail = 116
                        //camera trail = 116
                        
                    })
                    
                    
                case "0":
                    
                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        
                        
                        self.SmallView.center.y = self.SmallView.center.y + 100
                        self.SmallViewTOP.constant = -5
                        
                        self.MainImage.center.y = self.MainImage.center.y - 150
                        self.MainImage.center.x = self.MainImage.center.x - 100
                        self.MainImage.transform = CGAffineTransform(scaleX: 1, y: 1);
                        
                        self.mainImageLeading.constant = 66
                        self.mainImageTop.constant = 20
                        
                        self.submitBTN.center.x = self.submitBTN.center.x + 75
                        self.submitBTNTrailing.constant = 28
                        self.submitBTN_TOP.constant = 30
                        
                        self.googleBTN.center.x = self.googleBTN.center.x + 150
                        self.cameraBTN.center.x = self.cameraBTN.center.x + 75
                        self.selectBTN.center.x = self.selectBTN.center.x - 6
                        
                        self.googleBTN.center.y = self.googleBTN.center.y + 85
                        self.cameraBTN.center.y = self.cameraBTN.center.y + 45
                        self.selectBTN.center.y = self.selectBTN.center.y - 5
                        
                        
                        self.googleBTNTrailing.constant = 116
                        self.cameraBTNTrailing.constant = 116
                        self.photoBTNTrailing.constant = 116
                        
                        self.googleBTN_TOP.constant = 105
                        self.cameraBTN_TOP.constant = 65
                        self.photoBTN_TOP.constant = 25
                        
                        self.cameraBTN.transform = CGAffineTransform(scaleX: 1, y: 1);
                        self.selectBTN.transform = CGAffineTransform(scaleX: 1, y: 1);
                        self.googleBTN.transform = CGAffineTransform(scaleX: 1, y: 1);
                        
                        
                        
                    })
                    
                    
                default:
                    break
                }
              }
            }
                
            }
            
        } else {
            
            
            
            self.reportBTN.isHidden = false
            
            
           // self.TopViewHolder.center.y = self.TopViewHolder.center.y + 75
           // self.SmallViewTOP.constant = 70
            
            
            
            if useGoogleImage {
                 self.textView.isHidden = true
                 self.imageInserted = true
                myGoogleImage()
                print("Should use Google")
            } else {
                
                if !alreadyViewing {
                       if alreadyViewingValue < 2 {
                switch AppPresStyle {
                case "1":
                    UIView.animate(withDuration: 0.5, animations: { () -> Void in
                        
                        self.TopViewHolder.center.y = self.TopViewHolder.center.y + 75
                        self.SmallViewTOP.constant = 70
                        
                    })
                    
                    
                case "0":
                    
                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        
                        self.TopViewHolder.center.y = self.TopViewHolder.center.y - 75
                        self.SmallViewTOP.constant = -5
                        
                    })
                    
                    
                default:
                    break
                }
            }
        }
            quoteViewHolder.isHidden = false

            
            isNewGame = "no"
            
            TempTurnNumber = prefs.value(forKey: "TURNINFO_TURNNUMBER") as! NSString
            
            switch TempTurnNumber {
                
            case "1":
                self.newTurnNumber = "2"
            case "2":
                self.newTurnNumber = "3"
            case "3":
                self.newTurnNumber = "4"
            case "4":
                self.newTurnNumber = "5"
            case "5":
                self.newTurnNumber = "6"
            case "6":
                self.newTurnNumber = "7"
            case "7":
                self.newTurnNumber = "8"
            case "8":
                self.newTurnNumber = "9"
            case "9":
                self.newTurnNumber = "10"
            case "10":
                self.newTurnNumber = "11"
                
            default:
                break
                
            }
            
            
            let TempGameID = prefs.value(forKey: "TURNINFO_GAMEID") as! NSString
            
            if TempGameID == "NA" {
                print("Nothing Happens because the GameID = NA")
                
            } else {
            
            
           // prefs.setValue(GameIDFromConversation!, forKey: "TURNINFO_GAMEID")
           // prefs.setValue(PreviousTurnNumber!, forKey: "TURNINFO_TURNNUMBER")
            
            
            (MediaType, QuoteData) = LoadQuote(GameID: TempGameID, GameTurn: newTurnNumber)
            
                print("QuoteData = \(QuoteData)")
            
            quoteText.text = QuoteData as String
                
            }
            
            
            actInd.stopAnimating()
            
          }
        
            
        }
        
       alreadyViewingValue += 1
    }
    
    func googleImage(_ notification:Notification) {
        
        let data = (notification as NSNotification).userInfo
        let googleImageData2 = data!["data"] as! Data
        
        self.prefs.setValue("image", forKey: "PICTUREDATA_MEDIATYPE")
        
        useGoogleImage = true
        
        
        fromGoogle = true
        WasPasted = false
        
        
        
        let imageGoogle = UIImage(data: googleImageData2)
        //  tempImageView.image = image
        MainImage.image = imageGoogle
        
        self.MediaTypeNew = "image"
        self.prefs.setValue(self.MediaTypeNew, forKey: "PICTUREDATA_MEDIATYPE")
        
       
        /*
        resizeIMG.image = image
        resizeIMG.contentMode = UIViewContentMode.scaleAspectFit
        resizeHEIGHT.constant = self.view.frame.width - 50
        resizeWIDTH.constant = self.view.frame.width - 50
        
        */
        
        
        
        
        /*
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        
        mainImageView.image?.draw(in: CGRect(x: 0, y: 0, width: mainImageView.frame.size.width, height: mainImageView.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
        
        tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: tempImageView.frame.size.width, height: tempImageView.frame.size.height), blendMode: CGBlendMode.normal, alpha: opacity)
        
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempImageView.image = nil
        
        */
        
        
        /*
         
         UIGraphicsBeginImageContext(tempImageView.frame.size)
         
         tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: tempImageView.frame.size.width, height: tempImageView.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
         
         tempFirstImageView.image?.drawInRect(CGRect(x: 0, y: nTop, width: vW, height: nH2), blendMode: CGBlendMode.Normal, alpha: opacity)
         
         */
        /*
        
        
        
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
        
        
        */
        
        //    resizeH = (resizeIMG.image?.size.height)!
        //    resizeW = (resizeIMG.image?.size.width)!
        
        let DeviceH = self.view.frame.height
        //let halfH = DeviceH / 2;
        let DeviceW = self.view.frame.width
        //  self.resizeX = DeviceH - (resizeIMG.frame.height / 2)
        
        //  self.resizeX = DeviceH - (resizeIMG.image?.sizeframe.height / 2)
        
        //  self.resizeY = DeviceH - (resizeIMG.frame.width / 2)
        
        /*
        
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
        
        */
        
        self.prefs.setValue("", forKey: "GOOGLEDATAD")
        
        
        
        
    }
    
    
    
    
    
    func myGoogleImage() {
        
        fromGoogle = true
        WasPasted = false
        
        
        self.prefs.setValue("image", forKey: "PICTUREDATA_MEDIATYPE")
        
        
        if prefs.value(forKey: "GOOGLEDATAD") == nil  {
            
        } else {
            
            googleImageData = prefs.value(forKey: "GOOGLEDATAD") as! String
            
            prefs.set(googleImageData, forKey: "PICTUREDATAD")
            
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
                
                MainImage.image = image
                self.imageInserted = true
                
                /*
                resizeIMG.image = image
                resizeIMG.contentMode = UIViewContentMode.scaleAspectFit
                resizeHEIGHT.constant = self.view.frame.width - 50
                resizeWIDTH.constant = self.view.frame.width - 50
                
                */
                
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
                
                
                /*
                UIGraphicsBeginImageContext(mainImageView.frame.size)
                
                mainImageView.image?.draw(in: CGRect(x: 0, y: 0, width: mainImageView.frame.size.width, height: mainImageView.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
                
                tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: tempImageView.frame.size.width, height: tempImageView.frame.size.height), blendMode: CGBlendMode.normal, alpha: opacity)
                
                mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                tempImageView.image = nil
                
                
                */
                
                /*
                 
                 UIGraphicsBeginImageContext(tempImageView.frame.size)
                 
                 tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: tempImageView.frame.size.width, height: tempImageView.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
                 
                 tempFirstImageView.image?.drawInRect(CGRect(x: 0, y: nTop, width: vW, height: nH2), blendMode: CGBlendMode.Normal, alpha: opacity)
                 
                 */
                
                
                
                /*
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
                
                */
                
                //    resizeH = (resizeIMG.image?.size.height)!
                //    resizeW = (resizeIMG.image?.size.width)!
                
                let DeviceH = self.view.frame.height
                //let halfH = DeviceH / 2;
                let DeviceW = self.view.frame.width
                //  self.resizeX = DeviceH - (resizeIMG.frame.height / 2)
                
                //  self.resizeX = DeviceH - (resizeIMG.image?.sizeframe.height / 2)
                
                //  self.resizeY = DeviceH - (resizeIMG.frame.width / 2)
                
                
                /*
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
                
                */
                
                self.prefs.setValue("", forKey: "GOOGLEDATAD")
                
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBTN(_ sender: AnyObject) {
        
        
         self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        prefs.set(false, forKey: "IsCameraImageSaved")
        
        alreadyViewing = true
        for view in self.view.subviews {
            
            if view == picker.view {
                
                print("View is picker view, about to remove")
            //if view.isKind(of: picker) {
            view.removeFromSuperview()
            //}
            }
        }
       // cameraOverlay.isHidden = true
       // view..removeAll()
       // dismiss(animated: true, completion: nil)
    }
    
    @IBAction func photoFromLibary(_ sender: AnyObject) {
      
        prefs.set(false, forKey: "IsCameraImageSaved")
        /*
        cameraOverlay.isHidden = false
        self.cameraTOP.constant = 68
        
        self.cameraBOTTOM.constant = 150
     //   if GameID == "demo" {
        /*
       // let blurTempImage
        //let blurTempImage = bluredImage(image: MainImage.image!, radius: 20)
        let blurTempImage = bluredImageView(view: MainImage, radius: 40)
        //let blurTempImage = bluredImage(image: MainImage.image!)
        MainImage.image = blurTempImage
        MainImage.contentMode = .scaleAspectFit
        MainImage.layer.borderWidth = 2
        MainImage.layer.borderColor = UIColor.white.cgColor
        */
        
    
        
            self.picker.allowsEditing = false //2
            self.picker.sourceType = .photoLibrary //3
           // self.picker.modalPresentationStyle = .popover
           //self.present(self.picker, animated: true, completion: nil)
        
           // self.picker.cameraOverlayView?.frame = CGRect(x: 0, y: 70, width: self.DeviceW, height: (self.DeviceH - 70))
        
           self.cameraOverlay.addSubview(self.picker.view)
  */
        
        
        presentImagePickerWithSourceType(sourceType: .photoLibrary)
        
        
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey  : Any]) {
        
        
        var chosenImage = UIImage()
        
        var GIFData = Data()
        
        
        
        print("Picker Type: \(picker)")
        
        print("GIF Info = \(info)")
        
        print("CAMERA IMAGE FILE URL KEY = \(info["PHImageFileURLKey"])")
        print("CAMERA ImageDestination Info =\(info["UIImagePickerControllerMediaMetadata"])")
        
        
        self.IsCameraImage = prefs.bool(forKey: "IsCameraImageSaved")
        
        
        
        if IsCameraImage {
          self.prefs.set(false, forKey: "IsCameraImageSaved")   
            print("It is a camera image!!!")
        
        let CameraDictionary = info["UIImagePickerControllerMediaMetadata"] as! NSDictionary
            
            
            
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
  
        //let cameraImageData = UIImageJPEGRepresentation(chosenImage, 0.5)
            
        //print("CameraImageData = \(cameraImageData)")
            

            
            DispatchQueue.main.async(execute: {
                
                self.IsCameraImage = false
                self.prefs.set(false, forKey: "IsCameraImageSaved")
                self.MediaTypeNew = "image"
                self.MainImage.image = chosenImage
                //self.dismiss(animated: true, completion: nil)
                self.cameraOverlay.isHidden = true
                self.prefs.setValue(self.MediaTypeNew, forKey: "PICTUREDATA_MEDIATYPE")
                self.textView.isHidden = true
                self.textView.text = ""
                
                
                for view in self.view.subviews {
                    
                    if view == picker.view {
                        
                        print("Did Pick Camera Image...View is picker view, about to remove")
                        //if view.isKind(of: picker) {
                        view.removeFromSuperview()
                        picker.removeFromParentViewController()
                        //picker.dismiss(animated: false, completion: nil)
                        //}
                    }
                }
                
                
            })
            
            
        
        } else {
        
        
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
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
            
            
           // self.IsCameraImage = prefs.bool(forKey: "IsCameraImageSaved")
            
          //  print("is camera image test one: \(IsCameraImage)")
            
            /*
            
            if IsCameraImage {
                
                
                print("is a camera image")
                
                
                var assetLib = ALAssetsLibrary()
                var url: URL!
                //= URL()
                
                var imageView = UIImageView(frame: self.view.bounds)
                
                //SWIFT 3 Error Fixed
                //print("Swift 3 error")
                
                assetLib.asset(for: imageURL, resultBlock: { (asset ) in
                    
                    /*
                     <#code#>
                     }, failureBlock: <#T##ALAssetsLibraryAccessFailureBlock!##ALAssetsLibraryAccessFailureBlock!##(Error?) -> Void#>)
                     
                     
                     assetLib.asset(for: imageURL, resultBlock: { (asset : ALAsset!) -> Void in
                     
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
                            
                            print("CAMERA IMAGE dataURI = \(dataURI)")
                            print("CAMERA IMAGE orientation = \(orientation)")
                            print("CAMERA IMAGE INFO = \(info)")
                            print("CAMERA IMAGE DATA = \(imageData)")
                            
                            
                            print("CAMERA IMAGE FILE URL KEY = \(info!["PHImageFileURLKey"])")
                            
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
                            //GIFData = Data(bytes: UnsafePointer, count: Length!)
                            // GIFData = Data(bytes: UnsafePointer<UInt8>(Bytes!), count: Length!)
                            //  GIFData = NSData(bytes: Bytes.!, length: Length!)
                            
                            //  print("GIF DATA = \(GIFData)")
                            
                            let str = String(bytes: GIFData, encoding: String.Encoding.utf8)
                            
                            //print("GIF STRING \(str)")
                            
                            // let TempGIFData = GIFData as NSData
                            
                            let TempGIFData = GIFData.base64EncodedString(options: []) as NSString
                            
                            
                            
                            self.prefs.setValue(TempGIFData, forKey: "PICTUREDATAD")
                           // self.prefs.setValue(TempGIFData, forKey: "PICTUREDATAD_GIF")
                            
                            // print("TEMP GIF DATA = \(TempGIFData)")
                            
                            self.gifNSData = GIFData
                            
                            self.MediaType = "image"
                           // self.MainImage.image = UIImage.animatedImage(withAnimatedGIFData: GIFData)
                            self.WasPasted = true
                            
                            
                            self.MediaTypeNew = "image"
                            self.MainImage.contentMode = .scaleAspectFit
                            self.MainImage.image = UIImage(data: GIFData)//chosenImage
                            
                           
                            
                            print("GIF Image Should be in place")
                            //   GIFData = (contentsOfURL: NSURL(string: tempURL)!)!
                            // ...
                        }
                    }
                    
                    
                    
                }, failureBlock:  nil)
                
                
                
                
                
                
                DispatchQueue.main.async(execute: {
                    
                    self.MediaTypeNew = "image"
                    self.MainImage.image = UIImage.animatedImage(withAnimatedGIFData: GIFData)
                    //self.dismiss(animated: true, completion: nil)
                    self.cameraOverlay.isHidden = true
                    self.prefs.setValue(self.MediaTypeNew, forKey: "PICTUREDATA_MEDIATYPE")
                    
                    for view in self.view.subviews {
                        
                        if view == picker.view {
                            
                            print("Did Pick GIF1...View is picker view, about to remove")
                            //if view.isKind(of: picker) {
                            view.removeFromSuperview()
                            //}
                        }
                    }
                    
                    
                })
                self.textView.isHidden = true
                self.textView.text = ""
                self.imageInserted = true
                
                
            } else {
            
            */
            
            
            
            
            
            
            if GifImage {
                
                self.IsCameraImage = false
                
                
                var assetLib = ALAssetsLibrary()
                var url: URL!
                //= URL()
                
                var imageView = UIImageView(frame: self.view.bounds)
                
                //SWIFT 3 Error Fixed
                print("Swift 3 error")
                
                assetLib.asset(for: imageURL, resultBlock: { (asset ) in
                    
                    /*
                    <#code#>
                }, failureBlock: <#T##ALAssetsLibraryAccessFailureBlock!##ALAssetsLibraryAccessFailureBlock!##(Error?) -> Void#>)
                
                
                assetLib.asset(for: imageURL, resultBlock: { (asset : ALAsset!) -> Void in
                    
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
                            //GIFData = Data(bytes: UnsafePointer, count: Length!)
                           // GIFData = Data(bytes: UnsafePointer<UInt8>(Bytes!), count: Length!)
                            //  GIFData = NSData(bytes: Bytes.!, length: Length!)
                            
                          //  print("GIF DATA = \(GIFData)")
                            
                            let str = String(bytes: GIFData, encoding: String.Encoding.utf8)
                            
                            //print("GIF STRING \(str)")
                            
                           // let TempGIFData = GIFData as NSData
                            
                            let TempGIFData = GIFData.base64EncodedString(options: []) as NSString
                            
                            
                            
                            self.prefs.setValue(TempGIFData, forKey: "PICTUREDATAD")
                            self.prefs.setValue(TempGIFData, forKey: "PICTUREDATAD_GIF")
                            
                           // print("TEMP GIF DATA = \(TempGIFData)")
                            
                            self.gifNSData = GIFData
                            
                            self.MediaType = "gif"
                            self.MainImage.image = UIImage.animatedImage(withAnimatedGIFData: GIFData)
                            self.WasPasted = true
                            
                            self.MainImage.contentMode = .scaleAspectFit
                            
                            print("GIF Image Should be in place")
                            //   GIFData = (contentsOfURL: NSURL(string: tempURL)!)!
                            // ...
                        }
                    }
                    
                    
                    
                }, failureBlock:  nil)
                
                
                
                
                
                
                DispatchQueue.main.async(execute: {
                    
                    self.MediaTypeNew = "gif"
                    self.MainImage.image = UIImage.animatedImage(withAnimatedGIFData: GIFData)
                    //self.dismiss(animated: true, completion: nil)
                    self.cameraOverlay.isHidden = true
                    self.prefs.setValue(self.MediaTypeNew, forKey: "PICTUREDATA_MEDIATYPE")
                    
                    for view in self.view.subviews {
                        
                        if view == picker.view {
                            
                            print("Did Pick GIF1...View is picker view, about to remove")
                            //if view.isKind(of: picker) {
                            view.removeFromSuperview()
                            //}
                        }
                    }
                    
                    
                })
                self.textView.isHidden = true
                self.textView.text = ""
                self.imageInserted = true
                
            } else {
                
                IsCameraImage = false
                chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
                
                 self.MediaTypeNew = "image"
                MainImage.contentMode = .scaleAspectFit
                MainImage.image = chosenImage
                //self.dismiss(animated: true, completion: nil)
                self.cameraOverlay.isHidden = true
                self.prefs.setValue(MediaTypeNew, forKey: "PICTUREDATA_MEDIATYPE")
                self.textView.isHidden = true
                self.textView.text = ""
                
                self.imageInserted = true
                
                for view in self.view.subviews {
                    
                    if view == picker.view {
                        
                        print("Did Pick Photo...View is picker view, about to remove")
                        //if view.isKind(of: picker) {
                        view.removeFromSuperview()
                        //}
                    }
                }
                
                //self.textView.isHidden = true
                
            }
      //  }
        
        }
        
    }
    
        
        /*
        
        print("image picked")
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            MainImage.contentMode = .scaleAspectFit
            MainImage.image = pickedImage
            self.dismiss(animated: true, completion: nil)
            
            
            self.textView.isHidden = true
            self.textView.text = ""
            
            self.imageInserted = true
            //self.textView.isHidden = true
            
        } else {
    print("Something went wrong")
    }
        
        
        */
       // dismiss(animated: true, completion: nil)
        
        alreadyViewing = true
     // self.picker.allowsEditing = false
        
    }
    
    
    @IBAction func submitBTN(_ sender: AnyObject) {
        
        
        
        if imageInserted {
        
        
        let imageData = UIImageJPEGRepresentation(MainImage.image!, 0.5)
        
        //DONT DELETE BELOW
        var base64Image = String()
        
        /*
        if MediaType == "gif" {
            
            base64Image = gifNSData.base64EncodedString(options: [])
            
        } else {
            
            */
            
            base64Image = imageData!.base64EncodedString(options: [])
        
        
        
        
        
       // let smallImage = PicPreview.image!.resize(0.5)
        
        
      //  let imageData = UIImageJPEGRepresentation(smallImage, 0.6)
        
       // NewGamePictureData = imageData!.base64EncodedString(options: []) as NSString
        
        
        prefs.setValue(base64Image, forKey: "PICTUREDATAD")
        
       // print("New Game Picture added \(base64Image)")

        
        
        
        
        
        
       // print("BASE64IMAGE Data: \(base64Image)")
          /*
        }
        
        */
        
        /*
        
        let smallImage = MainImage.image!.resize(0.5)
        
        
        let imageData = UIImageJPEGRepresentation(smallImage, 0.6)
        
        NewGamePictureData = imageData!.base64EncodedString(options: []) as NSString
        
        
        prefs.setValue(NewGamePictureData, forKey: "PICTUREDATAD")
        
        */
        
        
        
        
        
        print("Should submit picture")
        
        
        
        let alertController = UIAlertController(title: "Submit Turn", message: "Are you sure you want to submit this picture?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Not Yet", style: .cancel) { (action:UIAlertAction!) in
            // println("you have pressed the Cancel button");
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction!) in
            
            
            
             if Reachability.isConnectedToNetwork() {
            
            var MyName = String()
            
            
            if self.prefs.value(forKey: "EXTUSERNAME") == nil {
                MyName = "Guest"
            } else {
                MyName = self.prefs.value(forKey: "EXTUSERNAME") as! String
            }
            
            
            
           
           // let RemindString = MessageArray.randomItem()
      //      DispatchQueue.main.async(execute: {
                
                let myLoadView:LoadingViewOne = UINib(nibName: "LoadingView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LoadingViewOne
                
               // myRemindView.remindLBL?.text = RemindString
                
                let DeviceH = self.view.frame.height
                //let halfH = DeviceH / 2;
                let DeviceW = self.view.frame.width
                //let WLess10 = DeviceW - 10;
                let startX = (DeviceW / 2) - 125;
                let startY = (DeviceH / 2) - 125;
                
                
                myLoadView.alpha = 0.0
                myLoadView.theView.layer.cornerRadius = 10
                myLoadView.theView.layer.masksToBounds = true
                myLoadView.theView.clipsToBounds = true
                myLoadView.frame = UIScreen.main.bounds
                
                self.view.addSubview(myLoadView)
                
                
                UIView.animate(withDuration: 0.25, animations: {
                    myLoadView.alpha = 1.0
                })
                
                
          //  })
            
            
            
            
              DispatchQueue.main.async(execute: {
                let SendingUserUUID = UIDevice.current.identifierForVendor!.uuidString
                print("Sending USID = \(SendingUserUUID)")
            
            
            if self.newGame {
                
               NotificationCenter.default.post(name: Notification.Name(rawValue: "SendMessage"), object: nil, userInfo: ["message":"Come up with a quote to describe this picture","turnType":"image","theQuote":"NA","imageData":"\(base64Image)","currentTurnNumber":"\(self.currentTurnNumber)","gameID":"NA","mediaType":"\(self.MediaTypeNew)","turnNumber":"NA","username":"NA","userID":"\(SendingUserUUID)","turnStyle":"NA","IsCompleteInfo":"NA","newTurn":"NA","NG_GameTitle":"NA","NG_PlayerTemp":"NA","NG_FirstTurn":"image","NG_TurnTime":"NA","NG_ContentRating":"NA","NameArrayDELETE":"NA","EmailArrayDELETE":"NA","UNIDArrayDELETE":"NA","newGame":"\(self.isNewGame)"])
            
            
        } else {
            
            let tempGameID = self.prefs.value(forKey: "TURNINFO_GAMEID") as! NSString
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "SendMessage"), object: nil, userInfo: ["message":"Come up with a quote to describe this picture","turnType":"image","image":"NA","imageData":"\(base64Image)","currentTurnNumber":"\(self.newTurnNumber)","gameID":"\(tempGameID)","mediaType":"\(self.MediaTypeNew)","turnNumber":"\(self.newTurnNumber)","username":"NA","userID":"\(SendingUserUUID)","turnStyle":"NA","IsCompleteInfo":"NA","newTurn":"NA","NG_GameTitle":"NA","NG_PlayerTemp":"NA","NG_FirstTurn":"image","NG_TurnTime":"NA","NG_ContentRating":"NA","NameArrayDELETE":"NA","EmailArrayDELETE":"NA","UNIDArrayDELETE":"NA","newGame":"no"])
            
            
        }
        
              })
            
            
            
            
            } else {
                
                
                
                
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Network Error"
                alertView.message = "Please Confirm your network settings"
                alertView.delegate = self
                
                alertView.addButton(withTitle: "OK")
                alertView.show()
                
                
            }
            //println("you have pressed OK button");
        }
        
        
        
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
            
        } else {
            
            let alertControllerError = UIAlertController(title: "No Image?", message: "Please insert an image first", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action:UIAlertAction!) in
                // println("you have pressed the Cancel button");
            }
            
            alertControllerError.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction!) in

                //println("you have pressed OK button");
            }
            
            
            
            
          //  alertControllerError.addAction(OKAction)
            
            self.present(alertControllerError, animated: true, completion:nil)
   
            
            
            
            
        }
        
        
        
      //  let theTurn = TurnInfo(currentUser: "currentUser", lastUser: "lastUser", TurnType: "picture", TurnURL: "turnURL")
        

        
        
        
        /*
        {
            
            
            
            print("SHOULD UPLOAD IMAGE NOW")
            print("BASE 64 DATA IS = \(base64Image)")
            UploadGameFileData(base64Image as String, FileName: "Game\(GameID)\(TurnNumber)", Type: "image")
        }
        
       */
        
        
        
      //  delegate?.turnPictureViewController(self, didSelect: theTurn)
        //self.dismiss(animated: true, completion: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
     @IBAction func shootPhoto(_ sender: AnyObject) {
        
        
    
    if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
        
        IsCameraImage = true
        
        prefs.set(true, forKey: "IsCameraImageSaved")
        print("IsCameraImage = \(IsCameraImage)")
        
        /*
    picker.allowsEditing = false
    picker.sourceType = UIImagePickerControllerSourceType.camera
        
    cameraOverlay.isHidden = false
    self.cameraTOP.constant = -30
    self.cameraBOTTOM.constant = 250
    picker.modalPresentationStyle = .popover
   // let CameraView = UIView()
   // let ViewSize = CGRect(x: 0, y: 70, width: self.DeviceW, height: (self.DeviceH - 100))
   // CameraView.frame = ViewSize
   // picker.view = CameraView
        
        
        
      //  Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)
        
        //let myLoadView:LoadingViewOne = UINib(nibName: "LoadingView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LoadingViewOne
        
      //  cameraOverlay.frame = picker.cameraOverlayView!.frame
      //  picker.cameraOverlayView = cameraOverlay
       // cameraOverlay = nil
        
    //self.picker.
    //self.picker.cameraViewTransform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    //self.picker.cameraViewTransform = CGAffineTransform(translationX: 0.0, y: 70.0);
    picker.cameraCaptureMode = .photo
    self.cameraOverlay.addSubview(self.picker.view)
        
        
        
        
        
       // self.imagePickerWD = WDImagePicker()
        self.imagePickerWD.cropSize = CGSize(280, 90)
        self.imagePickerWD.delegate = self
        
        self.present(self.imagePickerWD.imagePickerController, animated: true, completion: nil)
        
        
        */
        
     presentImagePickerWithSourceType(sourceType: .camera)
        
        
        
   // present(picker, animated: true, completion: nil)
    // mainImageView.image =
    } else {
        IsCameraImage = false
        
    noCamera()
    }
    
    }
    
    
    private func presentImagePickerWithSourceType(sourceType: UIImagePickerControllerSourceType)
    {
        if UIImagePickerController.isSourceTypeAvailable(sourceType)
        {
            
            if sourceType == .camera {
               
                picker.sourceType = sourceType
                picker.delegate = self
                picker.allowsEditing = false
                addChildViewController(picker)
                
                
                
                
                let insetTop: CGFloat = 85.0
                let insetBottom: CGFloat = 45.0
                
                let overlayInsetTop: CGFloat = 85.0
                let overlayInsetBottom: CGFloat = 200
                //120
                
                let overlayHeight = self.view.bounds.size.height - (overlayInsetTop + overlayInsetBottom)
                
                let height = self.view.bounds.size.height - (insetTop + insetBottom)
                picker.view.frame = CGRect(x: 0.0, y: insetTop, width: self.view.bounds.size.width, height: height)
                //picker.showsCameraControls = false
                
                /*
                picker.cameraOverlayView?.frame = CGRect(x: 0.0, y: overlayInsetTop, width: self.view.bounds.size.width, height: overlayHeight)
                
                */
                
                
                
                let CameraNewView:LoadingCameraView = UINib(nibName: "LoadingCameraView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LoadingCameraView
                
                // Bundle.mainBundle().loadNibNamed("CameraViewOne", owner: self, options: nil)
                
                // myRemindView.remindLBL?.text = RemindString
                
                let DeviceH = self.view.frame.height
                //let halfH = DeviceH / 2;
                let DeviceW = self.view.frame.width
                //let WLess10 = DeviceW - 10;
                let startX = (DeviceW / 2) - 125;
                let startY = (DeviceH / 2) - 125;
                
                
                CameraNewView.alpha = 0.0
                //CameraNewView.theView.layer.cornerRadius = 10
                //CameraNewView.theView.layer.masksToBounds = true
               // CameraNewView.theView.clipsToBounds = true
                CameraNewView.frame = UIScreen.main.bounds
                
                
                /*
                picker.modalPresentationStyle = .fullScreen
                present(picker,animated: true,completion: {
                    self.picker.cameraOverlayView = CameraNewView
                })
                
                */
                
                // self.view.addSubview(myLoadView)
                
               // self.view.addSubview(CameraNewView)
                picker.cameraOverlayView =  CameraNewView
                    
                view.addSubview(picker.view)
                picker.didMove(toParentViewController: self)
                
                
            } else  {
           // let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            picker.allowsEditing = false
            addChildViewController(picker)
            let insetTop: CGFloat = 85.0
            let insetBottom: CGFloat = 45.0
            let height = self.view.bounds.size.height - (insetTop + insetBottom)
            picker.view.frame = CGRect(x: 0.0, y: insetTop, width: self.view.bounds.size.width, height: height)
            view.addSubview(picker.view)
            picker.didMove(toParentViewController: self)
            
            
            }
        }  
    }
    
   
    
    
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
         present(alertVC, animated: true, completion: nil)
        
        
        //   let theAlert2 = SCLAlertView()
        //   theAlert2.addButton("Ok") {
        //   }
        //   theAlert2.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.99, green: 0.69, blue: 0.35, alpha: 1.0), title: "No Camera", subTitle: "This device doesn't have a camera")
        
       // SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Uh Oh, No Camera", subTitle: "This device doesn't have a camera", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
    }
    
    @IBAction func ReportContent(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Report Content?", message: "Are you sure you want to report this content as inappropriate?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel) { (action:UIAlertAction!) in
            // println("you have pressed the Cancel button");
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction!) in
            
            
            
            
            let alertController2 = UIAlertController(title: "Content Report", message: "Thank you.  This content has been reported and will be reviewed", preferredStyle: .alert)
            
            let cancelAction2 = UIAlertAction(title: "Ok", style: .cancel) { (action:UIAlertAction!) in
                // println("you have pressed the Cancel button");
            }
            alertController2.addAction(cancelAction2)
            
            /*
             let OKAction = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction!) in
             
             
             
             }
             */
            //alertController2.addAction(OKAction)
            
            self.present(alertController2, animated: true, completion:nil)
            
            
            
            
            
            
            
            
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
        
    }
    
    
    @IBAction func closePickerView(_ sender: Any) {
        
        
        self.cameraOverlay.isHidden = true
        
    }
    
    

}

protocol TurnPictureViewControllerDelegate: class {
    /// Called when the user taps to select an `IceCreamPart` in the `BuildIceCreamViewController`.
    func turnPictureViewController(_ controller: TurnPictureViewController, didSelect previousTurn: TurnInfo)
}

extension TurnPictureViewController {
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
        MainImage.image = image
        
        
        
        if self.SelectedGoogleImage{
            //ShowMusicViewNow()
        }
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        //self.FBFriendName = fbfriendsviewController.FBFriendName
        
        
    }
}

extension CGSize{
    init(_ width:CGFloat,_ height:CGFloat) {
        self.init(width:width,height:height)
    }
}

