//
//  NewViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 8/18/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import StoreKit
import Foundation
import MediaPlayer
import AVFoundation
import AssetsLibrary
import Photos
import iAd
import FBSDKShareKit
import FBSDKLoginKit
import FBSDKCoreKit
import Social


class NewViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIActionSheetDelegate, UIPopoverPresentationControllerDelegate, UIAlertViewDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver, NewPorQViewControllerDelegate, MPMediaPickerControllerDelegate, AVAudioPlayerDelegate, AVAudioRecorderDelegate, ADBannerViewDelegate, FBSDKSharingDelegate {
    
    var ShareCancelMessage = String()
    var FBShared = Bool()
    var TwitterShared = Bool()
    @IBOutlet weak var backBTN: UIButton!
    
    var TempImageCurrent = UIImage()
    
    var NewGameID = NSInteger()
    var FromMyGamesView = Bool()
    
    @IBOutlet weak var funLBL: UILabel!
    
    @IBOutlet weak var funBTN: UIButton!
    
    var isFun = NSString()
    var fromGoogle = Bool()
    var fromGoogleImage = Bool()
    var useGoogleImage = Bool()
    
    @IBOutlet weak var bannerView1: ADBannerView!
     let NewGameProgressHUD = ProgressHUD(text: "Creating Game...")
    var ContentRatingSelected = NSString()
    var TheProduct = NSString()
    @IBOutlet var contentE: UIButton!
    @IBOutlet var contentT: UIButton!
    @IBOutlet var contentM: UIButton!
    var IsGameCenter = Bool()
    var contentE_NO = UIImage(named: "ContentE.png")
    var contentE_YES = UIImage(named: "ContentE_Check.png")
    var contentM_NO = UIImage(named: "contentM.png")
    var contentM_YES = UIImage(named: "contentM_Check.png")
    var contentT_NO = UIImage(named: "ContentT.png")
    var contentT_YES = UIImage(named: "ContentT_Check.png")
    
    let SentVC = "newgameview"
    @IBOutlet var RecordView1TOP: NSLayoutConstraint!
    @IBOutlet var ViewHolder2TOP: NSLayoutConstraint!
    @IBOutlet var ViewHolderMusicTOP: NSLayoutConstraint!
    @IBOutlet weak var chooseMusicViewTOP: NSLayoutConstraint!
    
    
    @IBOutlet weak var startBTNpublic: UIButton!
  
    @IBOutlet var MusicView1TOP: NSLayoutConstraint!
    
    var MediaType = NSString()
    @IBOutlet weak var MediaView: UIView!
    
    @IBOutlet weak var picker2: UIPickerView!
    
    @IBOutlet weak var pickerView2: UIView!
    
    @IBOutlet weak var ViewHolderMusic: UIView!
    
    @IBOutlet weak var ViewHolder2: UIView!
    
    @IBOutlet weak var chooseMusicView: UIView!
    @IBOutlet weak var choseMusicSubView: UIView!
    @IBOutlet weak var BrowseYTBTN: UIButton!
    
    @IBOutlet weak var MusicView1: UIView!
    @IBOutlet var TrackCurrentTimeLBL: UILabel!
    @IBOutlet var TrimStartLBL: UILabel!
    @IBOutlet var TrimStopLBL: UILabel!
    
    @IBOutlet var stopMusic: UIButton!
    @IBOutlet var ShowPickerBTN: UIButton!
    @IBOutlet var TrimAudio: UIButton!
    
    @IBOutlet var pauseMusic: UIButton!
    @IBOutlet var playMusic: UIButton!
    @IBOutlet var MusicSaveBTN: UIButton!
    @IBOutlet var SelectAudioBTN: UIButton!
  
    @IBOutlet var MediaTitleLBL: UILabel!
    @IBOutlet var MediaSlider: UISlider!
    
    @IBOutlet var MediaArtistLBL: UILabel!
    @IBOutlet var MediaLengthLBL: UILabel!
    
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var saveBTN: UIButton!
    
    @IBOutlet var stopButton: UIButton!
    
    @IBOutlet var playButton: UIButton!
    
    @IBOutlet var statusLabel: UILabel!
    
    @IBOutlet var pickerViewTOP: NSLayoutConstraint!
    var ImportedFileData = NSString()
    var ImportedFileType = NSString()
    
    @IBOutlet var pickerCloseBTN: UIButton!

    @IBOutlet weak var RecordView1: UIView!
    
    @IBOutlet weak var chooseMusicBTN: UIButton!
    var PLAYAUDIO = String()
    var choosingMusic = Bool()
    var YTAudioFile: URL!
    var YTAudioFileTitle = NSString()
    var YTAudioFileArtist = NSString()

    
    var MinSelected = Int()
    var SecSelected = Int()
    var MinData = Array(0...9)
    var SecData = Array(0...59)
    var HourData = [Int]()
    
    let rangeSlider1 = RangeSlider(frame: CGRect.zero)
    let rangeSlider2 = RangeSlider(frame: CGRect.zero)

    
    var mediaItem: MPMediaItem?
    var RecordedMessage = Bool()
    var recorder: AVAudioRecorder!
    var mediaPicker: MPMediaPickerController?
    var myMusicPlayer: MPMusicPlayerController?
    var myYTPlayer: AVAudioPlayer!
    var SongLength = Float64()
    var SongTitle = NSString()
    var SongArtist = NSString()
    var player:AVAudioPlayer!
    var MusicViewShowing = Bool()
    var MusicURL: URL!
    var StartTrim = CMTime()
    var StopTrim = CMTime()
    var SongMaxLength = Double()
    var SelectedYTAudio = Bool()
    
    var product_id_audio: NSString?;
    
   // var audiobrowseviewcontroller: AudioBrowseViewController = AudioBrowseViewController()
   // @IBOutlet var progressView: UIProgressView!
    
    let timeInterval:TimeInterval = 0.1
    let timeIntervalReverse:TimeInterval = 1.0
    let timerEnd:TimeInterval = 10.0
    var timeCount:TimeInterval = 0.0
    var timeCountRecord:TimeInterval = 10.0
    
    var meterTimer:Timer!
    var musicTimer:Timer!
    
    var soundFileURL:URL?
    
    var RecordViewShowing = false
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
     var RecordedData = NSString()
    
     var PlayPushed = Bool()
    
    let SelectSongProgressHUD = ProgressHUD(text: "Loading Song...")
    
    let SelectSongTrimProgressHUD = ProgressHUD(text: "Trimming Audio...")
    
    var HasHours = Bool()
    var ShowingPicker = Bool()
    
    ////
    
    var pointsUsed = Bool()
    var View1SelectImage = Bool()
    
    @IBOutlet var theView: UIView!
    @IBOutlet var View1: UIView!
    @IBOutlet var View1QBTN: UIButton!
    @IBOutlet var View1TOP: NSLayoutConstraint!
    
    @IBOutlet var View1EnterLBL: UILabel!
    
    
    @IBOutlet var View1TOPP: NSLayoutConstraint!
    
    @IBOutlet var View2TOP: NSLayoutConstraint!
    @IBOutlet var View2BOT: NSLayoutConstraint!
    @IBOutlet var View2LEF: NSLayoutConstraint!
    @IBOutlet var View2RIG: NSLayoutConstraint!
    
    @IBOutlet var ViewConfirm: UIView!
    @IBOutlet var ViewConfirmTOP: NSLayoutConstraint!
    
    @IBOutlet var ConfirmTitleLBL: UILabel!
    @IBOutlet var ConfirmTimeLBL: UILabel!
    //@IBOutlet var ConfirmNumLBL: UILabel!
    @IBOutlet var ConfirmPrivateSwitch: UISwitch!
    //@IBOutlet var ConfirmStyleLBL: UILabel!
    
    @IBOutlet var ConfirmViewLBL: UILabel!
    
    
    @IBOutlet weak var View2Quote: UIView!
    
    @IBOutlet var QuoteViewNext: UIButton!
    @IBOutlet var View1QuoteBox: UITextView!
    
    
    @IBOutlet var theView2: UIView!
    @IBOutlet var theView2NextBTN: UIButton!
    
    @IBOutlet var theView2LBL: UILabel!
    @IBOutlet var theView2TOP: NSLayoutConstraint!
    
    @IBOutlet var theViewNumPlayers: UIView!
    
    @IBOutlet var theViewNumPlayersTOP: NSLayoutConstraint!
    @IBOutlet var theViewNumPlayersNextBTN: UIButton!
    
    @IBOutlet var theViewNumPlayersLBL: UILabel!
    
     var newporqviewcontroller: NewPorQViewController = NewPorQViewController()
    
    var introModalDidDisplay = false
    
    let prefs = UserDefaults.standard
    
    var username = NSString()
    var userID = NSString()
    
    var product_id: NSString?;
    var product_id_all: NSString?;
 
    @IBOutlet weak var pickerView: UIPickerView!
    
    let picker = UIImagePickerController()
    let pickerData = ["No Limit","2:00","1:30","1:00","0:30","0:15","0:05","Unlimited"]
    
   
    @IBOutlet weak var PictureINFO: UIButton!


    @IBOutlet weak var QuoteINFO: UIButton!
    

   // @IBOutlet weak var PicOrQuote: UIButton!
    
  //  @IBOutlet weak var QuoteTitleLBL: UIButton!
 
  //  @IBOutlet weak var GameTitleBTN: UIButton!
    
    @IBOutlet weak var GameTitleTXT: UITextField!
    
    @IBOutlet var GameTitleBOTTOM: NSLayoutConstraint!
    @IBOutlet weak var PlayerTimeBTN: UIButton!
    
    @IBOutlet weak var NumPlayerBTN: UIButton!
    
    @IBOutlet weak var PlayerCountSTPR: UIStepper!
    
    @IBOutlet weak var PlayerCountLBL: UILabel!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var image = UIImage()
    
    @IBOutlet weak var TurnTimePKR: UIPickerView!
    @IBOutlet weak var TurnTimeLBL: UILabel!
    
    
    @IBOutlet weak var TimeView: UIView!
    @IBOutlet var TimeViewTOP: NSLayoutConstraint!
    @IBOutlet var TimeViewNextBTN: UIButton!
    
    
    @IBOutlet weak var TurnTimeINFO: UIButton!
    
    @IBOutlet weak var ImageView: UIView!
    @IBOutlet var ImageNextBTN: UIButton!
    
    @IBOutlet var ImageViewLBL2: UILabel!
   // @IBOutlet var ImageViewLBL: UILabel!

    
    
    @IBOutlet weak var PicPreview: UIImageView!
    
    @IBOutlet weak var AlbumBTN: UIButton!
    @IBOutlet weak var CameraBTN: UIButton!
    
    @IBOutlet weak var QuoteBoxBottom: NSLayoutConstraint!
    
    @IBOutlet weak var ImageViewTop: NSLayoutConstraint!
    
    @IBOutlet var ImageViewLBL: UILabel!
    
    var ViewImageViewLBL = true
    
    @IBOutlet weak var TimeViewTop: NSLayoutConstraint!
    @IBOutlet weak var QuoteLabelTop: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var GameTitleINFO: UIButton!
    @IBOutlet weak var PlayerCountINFO: UIButton!
    
    @IBOutlet weak var TurnTimeCountLBL: UIButton!
    
    @IBOutlet weak var startBTN: UIButton!
    
    @IBOutlet weak var StartSegment: UISegmentedControl!
    var ViewGameTitle = Bool()
    var ViewTurnTime = Bool()
    var ViewNumPlayers = Bool()
    var ViewImageView = Bool()
    var ViewQuoteView = Bool()
    var ViewTimeView = Bool()
    var EditingGameTitle = Bool()
    var PictureAdded = false
    var PlayerCount = 2
    
    var TimeLimit = NSString()
    var TimeLimitPick = String()
    
    //QUOTE VIEW
    
    @IBOutlet weak var QuoteBox: UITextView!
    
    @IBOutlet weak var QuoteLabel: UILabel!
   // @IBOutlet weak var QuoteBox2: UITextView!
    @IBOutlet weak var QuoteView: UIView!
    
    @IBOutlet weak var QuoteViewLBL: UILabel!
    
    
    @IBOutlet weak var qbDoneBTN: UIButton!
    
    @IBOutlet weak var qbDoneBOTTOM: NSLayoutConstraint!
    
    //END QUOTE VIEW
    
    //NEW GAME VARIABLES
    var NewGameTitle = NSString()
    var NewGamePlayers: Int = 2
    var NewGameTurnTime = NSString()
    var NewGameFirstTurn = NSString()
    var NewGameQuote = NSString()
    var NewGameImage = UIImage()
    var NewGamePictureData = NSString()
    var NewGameAudioData = NSString()
    var QuoteSelected = Bool()
    
    var titleready = false
    var quoteready = false
    var picready = false
    var numplayersready = false
    var turntimeready = false
    
    
    
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
    
    var Player1ID2 = NSString()
    var Player2ID2 = NSString()
    var Player3ID2 = NSString()
    var Player4ID2 = NSString()
    var Player5ID2 = NSString()
    var Player6ID2 = NSString()
    var Player7ID2 = NSString()
    var Player8ID2 = NSString()
    var Player9ID2 = NSString()
    var Player10ID2 = NSString()
    
    
    var DoUploadImage = Bool()
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
    
    @IBOutlet weak var TimeConfirmedLBL: UILabel!
    
    
    func keyboardWasShown(_ notification: Notification) {
        print("KeyboardShown1")
        //EditingGameTitle = false
        
        if !EditingGameTitle {
            
            //GameTitleBTN.hidden = true
            GameTitleTXT.isHidden = true
            GameTitleINFO.isHidden = true
            qbDoneBTN.isHidden = false
            print("quote box label should move down")
  
            
        } else {
            print("NOW IM EDITING GMAE TITLE")
       
            var info = (notification as NSNotification).userInfo!
            let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.GameTitleBOTTOM.constant = (keyboardFrame.size.height - 115) + 5
                //self.QuoteLabelTop.constant = 50
                //self.qbDoneBOTTOM.constant = (keyboardFrame.size.height + 5) + self.GameTitleTXT.frame.size.height
                
               // self.GameTitleBOTTOM.constant = keyboardFrame.size.height + 5
                
            })
                
            
            
            
            
            
        }
        
        print("editing Game title = \(EditingGameTitle)")
        
        var info = (notification as NSNotification).userInfo!
        
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.QuoteBoxBottom.constant = (keyboardFrame.size.height - 120) + 5
            //self.QuoteLabelTop.constant = 50
            //self.qbDoneBOTTOM.constant = (keyboardFrame.size.height + 5) + self.GameTitleTXT.frame.size.height
            
            self.qbDoneBOTTOM.constant = keyboardFrame.size.height + 5
        })
        
        
        print("keyboard was shown")
        // if textView.textColor == UIColor.lightGrayColor() {
        
        if QuoteBox.text == "Enter Your Quote Here" || QuoteBox.text == "AUDIO CLIP SELECTED" {
            //println("textbox textcolor is light gray")
            QuoteBox.text = ""
            QuoteBox.textColor = UIColor.black
            QuoteBox.textAlignment = .center //.Left
           
         
            
        } else {
 
        }

        
    }
    
    func keyboardWillHide(_ notification: Notification) {
        
        if EditingGameTitle {
            
        } else {
            print("quote box label should move up")
            
            self.qbDoneBTN.isHidden = true
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
       
                self.qbDoneBOTTOM.constant = -50
                
                  // self.QuoteLabelTop.constant = -100
            })
        
          }
        
        
        
        
        
        print("editing Game title = \(EditingGameTitle)")
        
        var info = (notification as NSNotification).userInfo!
     //   var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
 
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.QuoteBoxBottom.constant = 130
            
            self.GameTitleBOTTOM.constant = 115
            //13
            
            //   self.QuoteLabelTop.constant = -100
        })
        
        //PlayerTimeBTN.hidden = false
       // NumPlayerBTN.hidden = false
        TurnTimeINFO.isHidden = false
        print("Keyboard will hide")
        
        
        
        
        PlayerCountINFO.isHidden = false
      //  PlayerCountSTPR.hidden = false
      //  PlayerCountLBL.hidden = false
      //  GameTitleBTN.hidden = false
        GameTitleTXT.isHidden = false
        GameTitleINFO.isHidden = false

        
        if GameTitleTXT.text!.isEmpty {
     
            
        } else  {

            titleready = true
        }
        
        
        if QuoteBox.text.isEmpty {

            QuoteBox.text = "Enter Your Quote Here"
            QuoteBox.textColor = UIColor.lightGray
            QuoteBox.textAlignment = .center
            

          
        } else  if QuoteBox.text == "Enter Your Quote Here" {
 
            
        } else {

            print("quote green")

            
            NewGameQuote = QuoteBox.text as NSString
            quoteready = true
            MediaType = "quote"
            NewGameFirstTurn = "quote"
            print("Quote Ready = \(quoteready)")
            
        }

        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    

    
    func textFieldDidChangeBegin(_ textField: UITextField) {
        print("textFieldChange1")
        
        qbDoneBTN.isHidden = false
        
       //EditingGameTitle = true
        print("Turned On EditingGameTitle")
 
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
           // self.QuoteBoxBottom.constant = keyboardFrame.size.height + 20
           // self.QuoteLabelTop.constant = 50
         //   self.qbDoneBOTTOM.constant = self.QuoteBoxBottom.constant + 20
           
            self.qbDoneBOTTOM.constant = -(self.view.frame.height) + 100
        })
        
        
        if !EditingGameTitle {
        print("Game Title Changed begin false")
            EditingGameTitle = true
           // QuoteBox.hidden = true
            TurnTimeINFO.isHidden = true
            PlayerCountLBL.isHidden = true
          //  PlayerCountSTPR.hidden = true
            
            
        } else {
            print("Game Title Changed begin true")
            EditingGameTitle = false
            //QuoteBox.hidden = true
            TurnTimeINFO.isHidden = true
            PlayerCountLBL.isHidden = true
         //   PlayerCountSTPR.hidden = true
            
    }
        print("bottom textfieldchange1")
}
    
    func textFieldDidChangeEnd(_ textField: UITextField) {

        qbDoneBTN.isHidden = true
    
        
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            // self.QuoteBoxBottom.constant = keyboardFrame.size.height + 20
            // self.QuoteLabelTop.constant = 50
            self.qbDoneBOTTOM.constant = -100
        })

        
        
        if EditingGameTitle {
            print("Game Title Changed end true")
            EditingGameTitle = false
            //QuoteBox.hidden = false
            TurnTimeINFO.isHidden = false
            PlayerCountLBL.isHidden = false
  
        } else {
            print("Game Title Changed end false")
           // EditingGameTitle = true
             if self.StartSegment.selectedSegmentIndex != 1 {
              //  QuoteBox.hidden = false
            
             } else  {
              //  QuoteBox.hidden = true
            }

    }
}
    
    
    @IBAction func Pic1BTN(_ sender: AnyObject) {
        theView.isHidden = true
    }
    
    
    @IBAction func View1SelectQuoteBTN(_ sender: AnyObject) {
        
        View1SelectImage = false
        NewGameFirstTurn = "quote"
        
        if !FromMyGamesView {
        View1TOPP.constant = 0
        View2TOP.constant = 0
        } else {
            View1TOPP.constant = 30
            View2TOP.constant = 30
        }
        
        let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromRight, UIViewAnimationOptions.showHideTransitionViews]
        
        UIView.transition(from: self.View1, to: self.View2Quote, duration: 0.8, options: animationOptions, completion: nil)
    }
    
    
    @IBAction func View2NextBTN(_ sender: AnyObject) {
        
         if !FromMyGamesView {
        View1TOPP.constant = 0
        View2TOP.constant = 0
         } else {
            View1TOPP.constant = 30
            View2TOP.constant = 30
            
            
        }
        let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromRight, UIViewAnimationOptions.showHideTransitionViews]

    UIView.transition(from: self.View2Quote, to: self.View1, duration: 0.8, options: animationOptions, completion: nil)
    }
    
    
    @IBAction func ViewPicBTN(_ sender: AnyObject) {
        if !FromMyGamesView {
        View1TOPP.constant = 0
        View2TOP.constant = 0
        } else {
            View1TOPP.constant = 30
            View2TOP.constant = 30
        }
        NewGameFirstTurn = "picture"
        print("Picture is NewGameFirstTurn")
        if View1SelectImage {
            
        let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromRight, UIViewAnimationOptions.showHideTransitionViews]
        
        
            UIView.transition(from: self.View2Quote, to: self.ImageView, duration: 0.8, options: animationOptions, completion: nil)
            
        } else {
            let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromLeft, UIViewAnimationOptions.showHideTransitionViews]
            
            
            UIView.transition(from: self.View2Quote, to: self.ImageView, duration: 0.8, options: animationOptions, completion: nil)
        }
   
    }
    
    @IBAction func ViewQuoteBTN(_ sender: AnyObject) {
        
        View2Quote.isHidden = false
        NewGameFirstTurn = "quote"
        
         if !FromMyGamesView {
        View1TOPP.constant = 0
        View2TOP.constant = 0
         } else {
            View1TOPP.constant = 30
            View2TOP.constant = 30
        }
        
        if View1SelectImage {
            
        let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromLeft, UIViewAnimationOptions.showHideTransitionViews]
        
        UIView.transition(from: self.ImageView, to: self.View2Quote, duration: 0.8, options: animationOptions, completion: nil)
            
        } else {
            let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromRight, UIViewAnimationOptions.showHideTransitionViews]
            
            UIView.transition(from: self.ImageView, to: self.View2Quote, duration: 0.8, options: animationOptions, completion: nil)
        }
        
    }
    
    @IBAction func View1SelectPicBTN(_ sender: AnyObject) {
       // View1TOPP.constant = 0
       // View2TOP.constant = 0
        View1SelectImage = true
        View2Quote.isHidden = true
        NewGameFirstTurn = "picture"
        
        if ViewImageViewLBL {
            ImageViewLBL.isHidden = true
        } else {
        ImageViewLBL.isHidden = false
        }
        
        
        
        let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromRight, UIViewAnimationOptions.showHideTransitionViews]
        
        UIView.transition(from: self.View1, to: self.ImageView, duration: 0.8, options: animationOptions, completion: nil)
        
        
    }
    
    @IBAction func GoBackToView1BTN(_ sender: AnyObject) {
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 250
        
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            self.theView2.center.y = self.theView2.center.y + 1500
            
            self.theView2TOP.constant = 1500
            
            self.theView.center.y = self.theView.center.y + 1500
            
            
            if !self.FromMyGamesView {
                self.View1TOP.constant = middleY
            } else {
                self.View1TOP.constant = middleY + 30
            }
            
          //  self.View1TOP.constant = middleY
            
        })
        
    }
    @IBAction func GoToView2BTN(_ sender: AnyObject) {
      //theView
       
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 250
        

        
        
        if NewGameFirstTurn == "quote" {
            
            var QuoteSet = NSString()
            QuoteSet = QuoteBox.text as NSString
            
            if QuoteSet.isEqual(to: "") || QuoteSet == "Enter Your Quote Here" {
                
                let AC = JSController("Starting Quote Missing", MyMessage: "Please enter a quote for this game.",Color: "Red")
                //self.presentViewController(AC, animated: true, completion: nil)
                
                
                
                
                
                DispatchQueue.main.async(execute: {

                    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Missing Turn", subTitle: "Please enter a quote", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
                
                
            } else {
                
                
                UIView.animate(withDuration: 1.0, animations: { () -> Void in
                    self.theView.center.y = self.theView.center.y - 1500
                    
                    self.View1TOP.constant = -1500
                    
                    self.theView2.center.y = self.theView2.center.y - 1500
                    
                    
                    if !self.FromMyGamesView {
                        self.theView2TOP.constant = middleY
                    } else {
                        self.theView2TOP.constant = middleY + 30
                    }
                    
                   // self.theView2TOP.constant = middleY

                })
 
        }
        
        } else {
            
            
            if picready {
              
                UIView.animate(withDuration: 1.0, animations: { () -> Void in
                    self.theView.center.y = self.theView.center.y - 1500
                    
                    self.View1TOP.constant = -1500
                    
                    self.theView2.center.y = self.theView2.center.y - 1500
                    
                     if !self.FromMyGamesView {
                    self.theView2TOP.constant = middleY
                     } else {
                     self.theView2TOP.constant = middleY + 30
                    }
                    
                })
  
            } else {
                
                let AC = JSController("Starting Quote/Image Missing", MyMessage: "Please enter a quote or select an image for this game.",Color: "Red")
               // self.presentViewController(AC, animated: true, completion: nil)
                
               
                
                DispatchQueue.main.async(execute: {
                    
                    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Missing Turn", subTitle: "Please enter a quote or select an iamge", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
                
                
            }
            
        }
            
        
    }
    
    
    @IBAction func GoBackToView2BTN(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 250
        
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            self.TimeView.center.y = self.TimeView.center.y + 1500
            
            self.TimeViewTOP.constant = 1500
            
            self.theView2.center.y = self.theView2.center.y + 1500
            
            if !self.FromMyGamesView {
                self.theView2TOP.constant = middleY
            } else {
                self.theView2TOP.constant = middleY + 30
            }

            
           // self.theView2TOP.constant = middleY
            
           
            
            
        })
        
    }
    
    @IBAction func GoToView3BTN(_ sender: AnyObject) {
        
        var TitleSet = NSString()
        TitleSet = GameTitleTXT.text! as NSString
        
        if TitleSet.isEqual(to: "") {
            
            let AC = JSController("Game Title Missing", MyMessage: "Please enter a title for this game.",Color: "Red")
            //self.presentViewController(AC, animated: true, completion: nil)
            
            
            
            
            DispatchQueue.main.async(execute: {
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Missing Title", subTitle: "Please enter a title for this game", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
            
        } else {
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 250
        
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.theView2.center.y = self.theView2.center.y - 1500
            
            self.theView2TOP.constant = -1500
            
            self.TimeView.center.y = self.TimeView.center.y - 1500
            
            
            if !self.FromMyGamesView {
                self.TimeViewTOP.constant = middleY
            } else {
                self.TimeViewTOP.constant = middleY + 30
            }

            
          //  self.TimeViewTOP.constant = middleY
            
            
          })
        }
        
    }
    
    @IBAction func GoBackToView3BTN(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 250
        
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            self.ViewConfirm.center.y = self.ViewConfirm.center.y + 1500
            
            self.ViewConfirmTOP.constant = 1500
            
          //  self.theViewNumPlayers.center.y = self.theViewNumPlayers.center.y + 1500
            
          //  self.theViewNumPlayersTOP.constant = 1500
            
            self.TimeView.center.y = self.TimeView.center.y + 1500
            
            
            if !self.FromMyGamesView {
                self.TimeViewTOP.constant = middleY
            } else {
                self.TimeViewTOP.constant = middleY + 30
            }
          //  self.TimeViewTOP.constant = middleY
            

        })
 
    }
    
    
    @IBAction func GoToView4BTN(_ sender: AnyObject) {
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 250
        
        print("Time Limited Picked = \(TimeLimitPick)")
        
        let TimeLimitPick2: NSString = TimeLimitPick as NSString
        
        
        
        if TimeLimitPick2.isEqual(to: "") {
            
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                self.TimeView.center.y = self.TimeView.center.y - 1500
                
                self.TimeViewTOP.constant = -1500
                
                self.theViewNumPlayers.center.y = self.theViewNumPlayers.center.y - 1500
                
                
                if !self.FromMyGamesView {
                    self.theViewNumPlayersTOP.constant = middleY
                } else {
                    self.theViewNumPlayersTOP.constant = middleY + 30
                }
               // self.theViewNumPlayersTOP.constant = middleY
                
                
            })

            
            TimeLimitPick = pickerData[1]
            //TimeLimit = "00:00:00"
            TimeLimit = "02:00:00"
            NewGameTurnTime = TimeLimit
            
            
            turntimeready = true            
        } else {
            
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
            
            NewGameTurnTime = TimeLimit
            turntimeready = true
            
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.TimeView.center.y = self.TimeView.center.y - 1500
            
            self.TimeViewTOP.constant = -1500
            
            self.theViewNumPlayers.center.y = self.theViewNumPlayers.center.y - 1500
            
            if !self.FromMyGamesView {
                self.theViewNumPlayersTOP.constant = middleY
            } else {
                self.theViewNumPlayersTOP.constant = middleY + 30
            }
            
         //   self.theViewNumPlayersTOP.constant = middleY
            
            
          })
        }
    }
    
    
    @IBAction func GoBackToView4BTN(_ sender: AnyObject) {
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 250
        
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
       
            
            self.ViewConfirm.center.y = self.ViewConfirm.center.y + 1500
            
            self.ViewConfirmTOP.constant = 1500
            
            self.theViewNumPlayers.center.y = self.theViewNumPlayers.center.y + 1500
            
            if !self.FromMyGamesView {
                self.theViewNumPlayersTOP.constant = middleY
            } else {
                self.theViewNumPlayersTOP.constant = middleY + 30
            }
            
          //  self.theViewNumPlayersTOP.constant = middleY
            
            
        })
        
    }
    @IBAction func GoToConfirmBTN(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 250
        
        print("Time Limited Picked = \(TimeLimitPick)")
        
        let TimeLimitPick2: NSString = TimeLimitPick as NSString
        
        
        
        if TimeLimitPick2.isEqual(to: "") {
            
           
            
            
            TimeLimitPick = pickerData[1]
            //TimeLimit = "00:00:00"
            TimeLimit = "02:00:00"
            NewGameTurnTime = TimeLimit
            
            
            turntimeready = true
        } else {
            
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
            
            NewGameTurnTime = TimeLimit
            turntimeready = true
        
        }
        
        NewGamePlayers = 2
        
        if NewGamePlayers < 2 {
            let AC = JSController("Not Enough Players", MyMessage: "Please select at least 2 players for your game.",Color: "Red")
            //self.presentViewController(AC, animated: true, completion: nil)
        
            
            
            DispatchQueue.main.async(execute: {
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Not Enough Players", subTitle: "You must have at least 2 players", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
            
        } else {
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 250
        
        ConfirmTitleLBL.text = GameTitleTXT.text
        ConfirmTimeLBL.text = TimeLimitPick as String
        //ConfirmNumLBL.text = NewGamePlayers.description
        //ConfirmStyleLBL.text = "\(NewGameFirstTurn as String) first"
            
        ConfirmPrivateSwitch.setOn(false, animated: false)
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            

            
            self.TimeView.center.y = self.TimeView.center.y - 1500
            
            self.TimeViewTOP.constant = -1500
        
           // self.theViewNumPlayers.center.y = self.theViewNumPlayers.center.y - 1500
            
          //  self.theViewNumPlayersTOP.constant = -1500
            
            self.ViewConfirm.center.y = self.ViewConfirm.center.y - 1500
            
            
            if !self.FromMyGamesView {
                self.ViewConfirmTOP.constant = middleY
            } else {
                self.ViewConfirmTOP.constant = middleY + 30
            }
          //  self.ViewConfirmTOP.constant = middleY
            
            
            
            
          })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let ISLOGGEDIN = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
        print("View will appear - is logged in = \(ISLOGGEDIN)")
        
        if !ISLOGGEDIN {
            let fromWhere: NSString = prefs.object(forKey: "LOGINSENTFROM") as! NSString
            if fromWhere.isEqual(to: "NEWGAME") {
                
                
                //   let fromView = tabBarController?.selectedViewController?.view
                // let toView = tabBarController?.viewControllers![2] as! UINavigationController
                //  let toView = tabBarController?.viewControllers![2] as! GalleryViewController
                
                prefs.set("NONE", forKey: "LOGINSENTFROM")
                
                tabBarController?.selectedIndex = 2
                
                //  UIView.transitionFromView(fromView!, toView: toView, duration: 0.325, options: UIViewAnimationOptions.CurveEaseInOut, completion: nil)
                
                
            } else {
                
                self.performSegue(withIdentifier: "login", sender: self)
                
                
            }
            
            
            
        } else {
            
            
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //    var strImg : String = "http://www.drodd.com/images8/funny-gif/funny-gif17.gif"
    //    var url: NSURL = NSURL(string: strImg)!
    //    PicPreview.image = UIImage.animatedImageWithAnimatedGIFURL(url)
        
       // isFun = prefs.valueForKey("ISFUN") as! NSString
        isFun = "yes"
        self.bannerView1.delegate = self
        bannerView1.isHidden = true
        //self.canDisplayBannerAds = true
        self.canDisplayBannerAds = false
        self.PicPreview.layer.cornerRadius = 5
        self.PicPreview.layer.borderWidth = 1
        self.PicPreview.layer.borderColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0).cgColor
        self.PicPreview.clipsToBounds = true
        self.PicPreview.layer.masksToBounds = true
        
        //ConfirmPrivateSwitch.setOn(false, animated: false)
        
        
        
        
        if prefs.value(forKey: "USERNAME") != nil {
          username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
          userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
        } else  {
          print("username Error")
            
            username = ""
            userID = ""
            
        }
        
        //GameTitleBTN.hidden = true
        //PlayerTimeBTN.hidden = true
       // NumPlayerBTN.hidden = true
       // PicOrQuote.hidden = true
        
       newporqviewcontroller.porqdelegate=self
        
        
        if !FromMyGamesView {
        self.title = "New Game"
        
        backBTN.isHidden = true
        if let font = UIFont(name: "DK Cool Crayon", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.white]
        }
            
            
            if self.revealViewController() != nil {
                menuButton.target = self.revealViewController()
                menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            }
            navigationController!.navigationBar.barTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
            
            
            
            
        } else {
            
           backBTN.isHidden = false
        }
        
        
        
        product_id_audio = "com.ClavenSolutions.TelePictionary.paudion"
        
        picker2.dataSource = self
        picker2.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: Selector("YTCompleteTrim2:"), name: NSNotification.Name(rawValue: "YTTrim2"), object: nil);
        
        /////
        
        NotificationCenter.default.addObserver(self, selector: Selector("HandleImportedFile:"), name: NSNotification.Name(rawValue: "ImportedFileType"), object: nil);
        
        NotificationCenter.default.addObserver(self, selector: "googleImageNVC:", name: NSNotification.Name(rawValue: "googleImageNVC"),  object: nil)

        
        ///
        
        choseMusicSubView.layer.cornerRadius = 10
        
        pickerView2.layer.cornerRadius = 5
        MusicSaveBTN.isHidden = true
        playMusic.isHidden = true
        TrimAudio.isHidden = true
        stopMusic.isHidden = true
        pauseMusic.isHidden = true
        ShowPickerBTN.isHidden = true
        
        rangeSlider2.trackHighlightTintColor = UIColor.red
        rangeSlider2.curvaceousness = 0.0
        
        //rangeSlider1.lowerValue = (rangeSlider1.upperValue - 10.0)
        
        MusicView1.addSubview(rangeSlider1)
        // MusicView1.addSubview(rangeSlider2)
        
        rangeSlider1.addTarget(self, action: "rangeSliderValueChanged:", for: .valueChanged)
        rangeSlider1.isHidden = true
        TrimAudio.layer.cornerRadius = 10
        
        MediaSlider.minimumValue = 0
        MediaSlider.isHidden = true
        saveBTN.layer.cornerRadius = 10
        RecordView1.layer.cornerRadius = 10
        chooseMusicView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        ViewHolder2.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        ViewHolderMusic.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        
        MusicView1.layer.cornerRadius = 10
        MediaView.layer.cornerRadius = 10
        
        
        SelectAudioBTN.layer.cornerRadius = 10
        MusicSaveBTN.layer.cornerRadius = 10
        
        
        
        QuoteBox.layer.borderWidth = 1
        QuoteBox.layer.borderColor = UIColor.lightGray.cgColor
        
        //QuoteBox.layer.borderColor = UIColor.lightGrayColor().CGColor
        QuoteBox.layer.cornerRadius = 10
        theView2.layer.cornerRadius = 10
        theView2NextBTN.layer.cornerRadius = 10
        theView.layer.cornerRadius = 10
        theView.layer.masksToBounds = true
        View2Quote.layer.cornerRadius = 10
        
        theViewNumPlayers.layer.cornerRadius = 10

        
        ViewConfirm.layer.cornerRadius = 10
        ViewConfirm.layer.masksToBounds = true
        
        ConfirmViewLBL.layer.masksToBounds = true
        
        ConfirmViewLBL.roundCorners([.topLeft, .topRight], radius: 10)
        
        theViewNumPlayersLBL.layer.masksToBounds = true
        theViewNumPlayersLBL.roundCorners([.topLeft, .topRight], radius: 10)
        
        theViewNumPlayersNextBTN.layer.cornerRadius = 10
     
        theView2LBL.layer.masksToBounds = true
        theView2LBL.roundCorners([.topLeft, .topRight], radius: 10)
        
        View1EnterLBL.layer.masksToBounds = true
        View1EnterLBL.roundCorners([.topLeft, .topRight], radius: 10)
        
        TimeView.layer.cornerRadius = 10
        
        //theView.layer.cornerRadius = 10
        //theView2.layer.cornerRadius = 10
        
        ImageNextBTN.layer.cornerRadius = 10
        
        QuoteViewNext.layer.cornerRadius = 10
        chooseMusicBTN.layer.cornerRadius = 25
        
        qbDoneBTN.layer.cornerRadius = 10
               PictureAdded = false
        EditingGameTitle = false
        NotificationCenter.default.addObserver(self, selector: #selector(NewViewController.keyboardWasShown(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewViewController.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        
        
        GameTitleTXT.addTarget(self, action: #selector(NewViewController.textFieldDidChangeBegin(_:)), for: UIControlEvents.editingDidBegin)
        
        GameTitleTXT.addTarget(self, action: #selector(NewViewController.textFieldDidChangeEnd(_:)), for: UIControlEvents.editingDidEnd)
        //QuoteBox.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        product_id = "com.ClavenSolutions.TelePictionary.pcamera"
        product_id_all = "com.ClavenSolutions.TelePictionary.allpurchase"
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        SKPaymentQueue.default().add(self)
        
        TurnTimePKR.delegate = self
        picker.delegate = self
        
        TurnTimePKR.selectRow(1, inComponent: 0, animated: true)
        
        let SwipeDown = UISwipeGestureRecognizer(target: self, action: #selector(NewViewController.respondToSwipeGesture(_:)))
        SwipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(SwipeDown)
        
        let SwipeUp = UISwipeGestureRecognizer(target: self, action: #selector(NewViewController.respondToSwipeGesture(_:)))
        SwipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(SwipeUp)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        

        ViewGameTitle = false
        ViewTurnTime = false
        ViewNumPlayers = false
        ViewImageView = false
        ViewTimeView = false
        ViewQuoteView = false
        
       // QuoteBox.hidden = true
       // QuoteLabel.hidden = true
        //startBTN.hidden = true
        
       // GameTitleBTN.layer.cornerRadius = 10
     //   GameTitleBTN.layer.borderWidth = 2
        //GameTitleBTN.layer.borderColor = UIColor.whiteColor().CGColor
       // PlayerTimeBTN.layer.cornerRadius = 10
     //   PlayerTimeBTN.layer.borderWidth = 2
        //PlayerTimeBTN.layer.borderColor = UIColor.whiteColor().CGColor
       // NumPlayerBTN.layer.cornerRadius = 10
     //   NumPlayerBTN.layer.borderWidth = 2
        //NumPlayerBTN.layer.borderColor = UIColor.whiteColor().CGColor
        startBTN.layer.cornerRadius = 10
        startBTNpublic.layer.cornerRadius = 10
  
        
      //  PicOrQuote.layer.cornerRadius = 10

        
        TimeConfirmedLBL.layer.cornerRadius = 10
        TimeConfirmedLBL.layer.masksToBounds = true
       // TimeConfirmedLBL.layer.borderWidth = 1
        //TimeConfirmedLBL.layer.borderColor = UIColor.whiteColor().CGColor
        
        ImageViewLBL2.layer.masksToBounds = true
        ImageViewLBL2.roundCorners([.topLeft, .topRight], radius: 10)
        
        TurnTimeLBL.layer.masksToBounds = true
        TurnTimeLBL.roundCorners([.topLeft, .topRight], radius: 10)
        //TurnTimeLBL.roundCorners(.TopRight, radius: 10)
        //startBTN.layer.borderColor = UIColor(red: 0.99, green: 0.69, blue: 0.35, alpha: 1.0).CGColor
      
        
        TimeView.layer.cornerRadius = 10
        TimeViewNextBTN.layer.cornerRadius = 10
        ImageView.layer.cornerRadius = 10
        QuoteBox.layer.cornerRadius = 10
        
        QuoteBox.text = "Enter Your Quote Here"
        QuoteBox.textColor = UIColor.lightGray
        QuoteBox.textAlignment = NSTextAlignment.center       // QuoteLabel.layer.cornerRadius = 10
       // QuoteLable.layer.maskToBounds = YES;
        
        PlayerCountSTPR.maximumValue = 10
        PlayerCountSTPR.wraps = true
        PlayerCountLBL.layer.cornerRadius = 10
        PlayerCountLBL.layer.masksToBounds = true
        
        
        PlayerCountLBL.text = PlayerCount.description

        
        
        qbDoneBTN.isHidden = true
        
     
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 250
       // self.View1TOP.constant = middleY
        
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.theView.center.y = self.theView.center.y - 1500
            
           // self.View1TOP.constant = middleY
            
            if !self.FromMyGamesView {
                self.View1TOP.constant = middleY
            } else {
                self.View1TOP.constant = middleY + 30
            }
            
        })
        
        if isFun.isEqual(to: "no") {
            
            contentE.setImage(UIImage(named: "ContentEasy.png"), for: UIControlState())
            contentM.setImage(UIImage(named: "ContentHard.png"), for: UIControlState())
            contentT.setImage(UIImage(named: "ContentMedium.png"), for: UIControlState())
            
            funBTN.setTitle("Difficulty Rating?", for: UIControlState())
            
            funLBL.text = "Select Difficulty Level"
            
        } else {
            
            funLBL.text = "Select Content Rating"
            
            funBTN.setTitle("Content Rating?", for: UIControlState())
            
            contentE.setImage(contentE_NO, for: UIControlState())
            contentM.setImage(contentM_NO, for: UIControlState())
            contentT.setImage(contentT_NO, for: UIControlState())
            
        }

    }


    
    func viewDidAppear() {
        
        
        let ISLOGGEDIN = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
        print("View will appear - is logged in = \(ISLOGGEDIN)")
        
        if !ISLOGGEDIN {
            self.performSegue(withIdentifier: "login", sender: self)
            
            //  GameTabBarController?.selectedIndex = 1
        } else {
            
            
            
            let numBadges = self.prefs.integer(forKey: "numTurns")
            let completedGames = self.prefs.integer(forKey: "comGames")
            // navigationController!.tabBarItem.badgeValue = numBadges.description
            let tabArray = self.tabBarController?.tabBar.items as NSArray!
            let TurnItem = tabArray?.object(at: 0) as! UITabBarItem
            let CompletedItem = tabArray?.object(at: 3) as! UITabBarItem
            
            print("NUMBER OF TURNS = \(numBadges)")
            
            if numBadges > 0 {
                TurnItem.badgeValue = numBadges.description
            }
            
            if completedGames > 0 {
                CompletedItem.badgeValue = completedGames.description
            }
            
            if prefs.value(forKey: "USERNAME") != nil {
                
                username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
                userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
            } else  {
                username = "guest"
                userID = "guest"
            }
        
        
        //   let CheckAudioReturnNew = boolForKey("ISAUDIOCLIP")
        prefs.set(false, forKey: "ISAUDIOCLIP")
        
        let tempUser = prefs.value(forKey: "USERNAME")
        
        print("Temp user = \(tempUser)")
        
            
            /*
        if prefs.valueForKey("USERNAME") == nil {
            
            let Alert = SCLAlertView()
            Alert.addButton("Log in Now", action: {
                
                
                //   self.IsPlayerLoggedIn = self.LogIntoGameCenter()
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    LogIntoGameCenterNew()
                    
                })
                
            })
            
            Alert.addButton("Later", action: {
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    SCLAlertView().showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Center", subTitle: "Without being logged into Game Center many of this games features are disabled.", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                    
                })
                
                
            })
            
            Alert.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Game Center", subTitle: "You need to be logged into Game Center to view your games.  Please log in now", duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
            
        } else {
            
            */
        
        /*
        
        self.IsGameCenter = NSUserDefaults.standardUserDefaults().boolForKey("GameCenterEnabled")
        
        if !self.IsGameCenter {
            
            print("Game Center is not enabled")
            
            let Alert = SCLAlertView()
            Alert.addButton("Log in Now", action: {
                
                
                //   self.IsPlayerLoggedIn = self.LogIntoGameCenter()
               
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                   LogIntoGameCenterNew()
                    
                })
                
            })
            
            Alert.addButton("Later", action: {
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    SCLAlertView().showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Center", subTitle: "Without being logged into Game Center many of this games features are disabled.", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                    
                })
                
                
            })
            
            Alert.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Game Center", subTitle: "You need to be logged into Game Center to view your games.  Please log in now", duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
            
            
            
        } else {
            
            */
            
            //NSUserDefaults.standardUserDefaults().setBool(true, forKey: "GameCenterEnabled")
            
        
        
        print("presenting Pick or Quote")
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 150
        
            if !fromGoogleImage {
        
        UIView.animate(withDuration: 2.0, animations: { () -> Void in
            self.theView.center.y = self.theView.center.y - 1500
            
            
            if !self.FromMyGamesView {
                self.View1TOP.constant = middleY
            } else {
                self.View1TOP.constant = middleY + 30
            }
            
            //self.View1TOP.constant = middleY
         })
                
        }
            
            
     
    //  }
        
    // }
            
    }
        
    }
    
    
  
    
    func PickOrQuote() {
        
        print("Intro Modal = \(introModalDidDisplay)")
        
        if(!introModalDidDisplay) {
            print("Intro Modal = \(introModalDidDisplay)")
            
            introModalDidDisplay = true
            
            print("Intro Modal = \(introModalDidDisplay)")
            
            let PQViewController = storyboard?.instantiateViewController(withIdentifier: "NewPorQ") as! NewPorQViewController
        
            PQViewController.modalPresentationStyle = .popover
            
            present(PQViewController, animated: true, completion: nil)
        
        }
   
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
    
    controller.presentedViewController.createBlur()
    
    if !(presentedViewController is UINavigationController) {
    return UINavigationController(rootViewController: presentedViewController!)
    } else {
        return UINavigationController(rootViewController: presentedViewController!)
        }
        
    }
    
    
    func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if ViewTurnTime {
            if let swipeGesture = gesture as? UISwipeGestureRecognizer {
                switch swipeGesture.direction {
                    
                case UISwipeGestureRecognizerDirection.up:
                    //println("swiped image view down")
                    
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
                    
                    NewGameTurnTime = TimeLimit
                    turntimeready = true
                    
                    UIView.animate(withDuration: 0.3, animations: {
                        self.TimeView.center.y = (self.TimeView.center.y - 500)
                        self.TimeViewTop.constant = -400
                    })
                    ViewTurnTime = false
                    
                    if (titleready && picready && numplayersready && turntimeready) || (titleready && quoteready && numplayersready && turntimeready)  {
                        
                     
                        
                    } else {
                        
                   
                    }
                    
                    
                    
                default:
                    break
                }
                
                QuoteBox.isHidden = false
               // GameTitleBTN.hidden = false
                PictureINFO.isHidden = false
                QuoteINFO.isHidden = false
               // startBTN.hidden = false
                GameTitleINFO.isHidden = false
                
                if NewGameTurnTime != "" {
                    
                
                    
                    //PlayerTimeBTN.layer.backgroundColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).CGColor

                } else {
         
                    
                   // PlayerTimeBTN.layer.backgroundColor = UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0).CGColor
                    
              
                }
            }
        }
        
        if ViewImageView {
            if let swipeGesture = gesture as? UISwipeGestureRecognizer {
                switch swipeGesture.direction {
                    
                case UISwipeGestureRecognizerDirection.down:
                    
                    
                    if !PictureAdded {
                        print("Image Empty")
                        
                   
                        
                        if !quoteready {
                          
                        }
                        
                    } else {
                        
                        NewGameFirstTurn = "picture"
                        print("Item First: \(NewGameFirstTurn)")
                        
                  
                    }

                    
                    
                    print("swiped image view down")
                    
                    let xPosition = ImageView.frame.origin.x
                    let yPosition = ImageView.frame.origin.y + 500
                    let height = ImageView.frame.size.height
                    let width = ImageView.frame.size.width
                    
                    UIView.animate(withDuration: 0.3, animations: {
                         //self.ImageView.center.y = (self.ImageView.center.y + 500)
                        self.ImageView.frame = CGRect(x: xPosition, y: yPosition, width: height, height: width)
                        self.ImageViewTop.constant = 100
                    })
                    
                    
                    
                    ViewImageView = false
                    //GameTitleBTN.hidden = false
                    GameTitleINFO.isHidden = false
                    GameTitleTXT.isHidden = false
                    
                    
                default:
                    break
                }
            }
        }
        
    }


    
    func textViewDidBeginEditing(_ textView: UITextView) {
       // if textView == QuoteBox {
        
       // var activeField = textField;
        
        
        print("textbox began editing")
           // if textView.textColor == UIColor.lightGrayColor() {
                
                if textView.text == "Enter Your Quote Here" {            print("textbox textcolor is light gray")
                textView.text = ""
                textView.textColor = UIColor.black
                textView.textAlignment = .left
            }
       // }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter Your Quote Here"
            textView.textColor = UIColor.lightGray
            textView.textAlignment = .center
        }
        
        
    }
    
    @IBAction func oneClicker(_ sender: UIStepper) {
        print("Stepper Clicked")
        
        
    self.PlayerCountLBL.text = Int(sender.value).description
        
        
        NewGamePlayers = Int(sender.value)
        print("Stepper value = \(Int(sender.value))")
        
        if NewGamePlayers > 1 {
       
            
            PlayerCountLBL.layer.backgroundColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).cgColor
            
     
            
            numplayersready = true
            
            if (titleready && picready && numplayersready && turntimeready) || (titleready && quoteready && numplayersready && turntimeready)  {
                
             
                
            } else {
                
               
            }
            
            
        } else if NewGamePlayers < 2 {
         //  NumPlayerBTN.layer.borderColor = UIColor.whiteColor().CGColor
          //NumPlayerBTN.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            PlayerCountLBL.layer.backgroundColor = UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0).cgColor
            
          //  startBTN.layer.backgroundColor = UIColor(red: 0.9843, green: 0.9333, blue: 0.53333, alpha: 1.0).CGColor
                //UIColor.clearColor().CGColor
            
            PlayerCountINFO.tintColor = UIColor.white                //UIColor(red: 0.99, green: 0.69, blue: 0.35, alpha: 1.0).CGColor
            numplayersready = false
            
        }
        
    }
 
     /*
    @IBAction func GameTitleBTN(sender: AnyObject) {
        
        print("Game Title button Pressed")
        
        NewGameTitle = GameTitleTXT.description
        
        if !ViewGameTitle {
        /*
            self.GameTitleTXT.hidden = true
            self.GameTitleTXT.center.y = self.GameTitleTXT.center.y + 175
            self.GameTitleTXT.hidden = false
            */
            
        UIView.animateWithDuration(0.3, animations: {
            self.GameTitleTXT.center.y = self.GameTitleTXT.center.y + 37
        })
            ViewGameTitle = true
        } else {
            
            
            if NewGameTitle.isEqualToString("") {
                print("game title is empty")
            } else {
            UIView.animateWithDuration(0.3, animations: {
                self.GameTitleTXT.center.y = self.GameTitleTXT.center.y - 37
                
                        })
            
            /*
            self.GameTitleTXT.hidden = true
            self.GameTitleTXT.center.y = self.GameTitleTXT.center.y - 175
            */
            ViewGameTitle = false
        }

        }
        
    }
    
    */
    
    func CreatePublicGame (_ isPixie: NSString) {
        
        
     
        
      var DoUploadImage = Bool()
        var post = String()
        var post_old = String()
        
        
        NewGameTurnTime = "00:00:00"
        
        if isPixie.isEqual(to: "yes") {
            
            Player1 = "Pixie"
            //Player1ID2 = self.userID
            Player1ID2 = "OPEN"
        } else {
        
        Player1 = self.username
        Player1ID2 = self.userID
            
        }
        
        Player2 = "OPEN"
        Player3 = "OPEN"
        Player4 = "OPEN"
        Player5 = "OPEN"
        Player6 = "OPEN"
        Player7 = "OPEN"
        Player8 = "OPEN"
        Player9 = "OPEN"
        Player10 = "OPEN"
        
        
       
        Player2ID2 = "OPEN"
        Player3ID2 = "OPEN"
        Player4ID2 = "OPEN"
        Player5ID2 = "OPEN"
        Player6ID2 = "OPEN"
        Player7ID2 = "OPEN"
        Player8ID2 = "OPEN"
        Player9ID2 = "OPEN"
        Player10ID2 = "OPEN"
        
        
        
        Player1Email = "NA"
        Player2Email = "NA"
        Player3Email = "NA"
        Player4Email = "NA"
        Player5Email = "NA"
        Player6Email = "NA"
        Player7Email = "NA"
        Player8Email = "NA"
        Player9Email = "NA"
        Player10Email = "NA"
        
    let NumPlayers = 10
    let NewGameContentRating = ContentRatingSelected
    NewGameTitle = GameTitleTXT.text! as NSString
    let GameName = GameTitleTXT.text!
        
    if NewGameFirstTurn == "quote" {

        
        print("FIRST TURN IS A QUOTE")
        
if MediaType == "audio" {
//DoUploadImage = true
print("audio type game")

post_old = "Player1ID=\(Player1ID2)&Player2ID=\(Player2ID2)&Player3ID=\(Player3ID2)&Player4ID=\(Player4ID2)&Player5ID=\(Player5ID2)&Player6ID=\(Player6ID2)&Player7ID=\(Player7ID2)&Player8ID=\(Player8ID2)&Player9ID=\(Player9ID2)&Player10ID=\(Player10ID2)&GameName=\(GameName)&Player1=\(Player1)&Player2=\(Player2)&Player3=\(Player3)&Player4=\(Player4)&Player5=\(Player5)&Player6=\(Player6)&Player7=\(Player7)&Player8=\(Player8)&Player9=\(Player9)&Player10=\(Player10)&players=\(NumPlayers)&Player1Email=\(Player1Email)&Player2Email=\(Player2Email)&Player3Email=\(Player3Email)&Player4Email=\(Player4Email)&Player5Email=\(Player5Email)&Player6Email=\(Player6Email)&Player7Email=\(Player7Email)&Player8Email=\(Player8Email)&Player9Email=\(Player9Email)&Player10Email=\(Player10Email)&timelimit=\(NewGameTurnTime)&gamestyle=\(NewGameFirstTurn)&gameSetting=public&content=\(NewGameContentRating)"

print("POST OLD DATA = \(post_old)")



post = post_old.addingPercentEscapes(using: String.Encoding.utf8)!





//UNCOMMENT TO INSERT AUDIO FILE RAW DATA
//post = ("\(post)&Turn1=\(audioData)&mediatype=audio")
post = ("\(post)&Turn1=TBD&mediatype=audio")




} else {
let QuoteBoxtext = NewGameQuote
// DoUploadImage = false


/*
var ThisTitle = "image"



//CREATE JSON WITH ENCODED MEDIA
let DataJSON: [String : AnyObject] = ["Data": ["type":"quote","turninfo": QuoteBoxtext, "title": ThisTitle, "artist": username]]

//CONVERT NEW JSON TO NSDATA
let JSON_NSData = jsonToNSData(DataJSON)

//ENCODE JSON NSDATA

let QuoteBoxtextNew = NSString(data: JSON_NSData!, encoding: NSUTF8StringEncoding)!

*/

post_old = "Player1ID=\(Player1ID2)&Player2ID=\(Player2ID2)&Player3ID=\(Player3ID2)&Player4ID=\(Player4ID2)&Player5ID=\(Player5ID2)&Player6ID=\(Player6ID2)&Player7ID=\(Player7ID2)&Player8ID=\(Player8ID2)&Player9ID=\(Player9ID2)&Player10ID=\(Player10ID2)&GameName=\(GameName)&Player1=\(Player1)&Player2=\(Player2)&Player3=\(Player3)&Player4=\(Player4)&Player5=\(Player5)&Player6=\(Player6)&Player7=\(Player7)&Player8=\(Player8)&Player9=\(Player9)&Player10=\(Player10)&players=\(NumPlayers)&Player1Email=\(Player1Email)&Player2Email=\(Player2Email)&Player3Email=\(Player3Email)&Player4Email=\(Player4Email)&Player5Email=\(Player5Email)&Player6Email=\(Player6Email)&Player7Email=\(Player7Email)&Player8Email=\(Player8Email)&Player9Email=\(Player9Email)&Player10Email=\(Player10Email)&timelimit=\(NewGameTurnTime)&gamestyle=\(NewGameFirstTurn)&Turn1=\(QuoteBoxtext)&mediatype=quote&gameSetting=public&content=\(NewGameContentRating)"

//  println("POST OLD DATA = \(post_old)")



post = post_old.addingPercentEscapes(using: String.Encoding.utf8)!

}



print("Quote is posted")
} else {
        
        print("FIRST TURN IS A PICTURE")
        if MediaType == "gif" {
          DoUploadImage = true
          self.NewGameFirstTurn = "picture"
            
            post_old = "Player1ID=\(Player1ID2)&Player2ID=\(Player2ID2)&Player3ID=\(Player3ID2)&Player4ID=\(Player4ID2)&Player5ID=\(Player5ID2)&Player6ID=\(Player6ID2)&Player7ID=\(Player7ID2)&Player8ID=\(Player8ID2)&Player9ID=\(Player9ID2)&Player10ID=\(Player10ID2)&GameName=\(GameName)&Player1=\(Player1)&Player2=\(Player2)&Player3=\(Player3)&Player4=\(Player4)&Player5=\(Player5)&Player6=\(Player6)&Player7=\(Player7)&Player8=\(Player8)&Player9=\(Player9)&Player10=\(Player10)&players=\(NumPlayers)&Player1Email=\(Player1Email)&Player2Email=\(Player2Email)&Player3Email=\(Player3Email)&Player4Email=\(Player4Email)&Player5Email=\(Player5Email)&Player6Email=\(Player6Email)&Player7Email=\(Player7Email)&Player8Email=\(Player8Email)&Player9Email=\(Player9Email)&Player10Email=\(Player10Email)&timelimit=\(NewGameTurnTime)&gamestyle=\(NewGameFirstTurn)&gameSetting=public&content=\(NewGameContentRating)"
            
            print("POST OLD DATA = \(post_old)")
            
            
            
            post = post_old.addingPercentEscapes(using: String.Encoding.utf8)!
            
            
            
            
            //UNCOMMENT TO INSERT IMAGE RAW DATA
            //post = ("\(post)&Turn1=\(picData)&mediatype=image")
            
            post = ("\(post)&Turn1=TBD&mediatype=gif")
            
            
        } else {
        
print("pictureData is posted")
DoUploadImage = true

/////
/*

post_old = "GameName=\(GameName)&Player1=\(Player1)&Player2=\(Player2)&Player3=\(Player3)&Player4=\(Player4)&Player5=\(Player5)&Player6=\(Player6)&Player7=\(Player7)&Player8=\(Player8)&Player9=\(Player9)&Player10=\(Player10)&players=\(NumPlayers)&Player1Email=\(Player1Email)&Player2Email=\(Player2Email)&Player3Email=\(Player3Email)&Player4Email=\(Player4Email)&Player5Email=\(Player5Email)&Player6Email=\(Player6Email)&Player7Email=\(Player7Email)&Player8Email=\(Player8Email)&Player9Email=\(Player9Email)&Player10Email=\(Player10Email)&timelimit=\(NewGameTurnTime)&gamestyle=\(NewGameFirstTurn)&Turn1=\(picData)"

//  println("POST OLD DATA = \(post_old)")



post = post_old.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
/////
*/

post_old = "Player1ID=\(Player1ID2)&Player2ID=\(Player2ID2)&Player3ID=\(Player3ID2)&Player4ID=\(Player4ID2)&Player5ID=\(Player5ID2)&Player6ID=\(Player6ID2)&Player7ID=\(Player7ID2)&Player8ID=\(Player8ID2)&Player9ID=\(Player9ID2)&Player10ID=\(Player10ID2)&GameName=\(GameName)&Player1=\(Player1)&Player2=\(Player2)&Player3=\(Player3)&Player4=\(Player4)&Player5=\(Player5)&Player6=\(Player6)&Player7=\(Player7)&Player8=\(Player8)&Player9=\(Player9)&Player10=\(Player10)&players=\(NumPlayers)&Player1Email=\(Player1Email)&Player2Email=\(Player2Email)&Player3Email=\(Player3Email)&Player4Email=\(Player4Email)&Player5Email=\(Player5Email)&Player6Email=\(Player6Email)&Player7Email=\(Player7Email)&Player8Email=\(Player8Email)&Player9Email=\(Player9Email)&Player10Email=\(Player10Email)&timelimit=\(NewGameTurnTime)&gamestyle=\(NewGameFirstTurn)&gameSetting=public&content=\(NewGameContentRating)"

print("POST OLD DATA = \(post_old)")



post = post_old.addingPercentEscapes(using: String.Encoding.utf8)!




//UNCOMMENT TO INSERT IMAGE RAW DATA
//post = ("\(post)&Turn1=\(picData)&mediatype=image")

post = ("\(post)&Turn1=TBD&mediatype=image")

            
        }

}

// progressHUD.removeFromSuperview()
//  progressHUD = ProgressHUD(text: "Saving Game Data...")
//  self.view.addSubview(progressHUD)


print("NEW POST STRING 2: \(post)")


/*
&Player1Cell=\(Player1Cell)&Player2Cell=\(Player2Cell)&Player3Cell=\(Player3Cell)&Player4Cell=\(Player4Cell)&Player5Cell=\(Player5Cell)&Player6Cell=\(Player6Cell)&Player7Cell=\(Player7Cell)&Player8Cell=\(Player8Cell)&Player9Cell=\(Player9Cell)&Player10Cell=\(Player10Cell)
*/
//NSLog("PostData: %@",post);

let url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/NewGame.php")!

let postData:Data = post.data(using: String.Encoding.ascii)!

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

////NSLog("Response code: %ld", res?.statusCode);

if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
{
let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!

//NSLog("Response ==> %@", responseData);

    print("Respone New Game Post: \(responseData)")
    
//var error: NSError?

let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary


let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
NewGameID = jsonData.value(forKey: "gameid") as! NSInteger

print("THE NEW GAME ID = \(NewGameID)")
//[jsonData[@"success"] integerValue];

//NSLog("Success: %ld", success);

if(success == 1)
{
//NSLog("New Game SUCCESS");
//self.dismissViewControllerAnimated(true, completion: nil)

let alertView:UIAlertView = UIAlertView()
alertView.title = "Success!"
alertView.message = "Your Game has been created.  Each player is getting a message now about the new game now."
alertView.delegate = self
alertView.addButton(withTitle: "OK")
// alertView.show()

if DoUploadImage {

if MediaType == "audio" {

print("SHOULD UPLOAD AUDIO NOW")
UploadGameFileData(NewGameAudioData as String, FileName: "Game\(NewGameID)Turn1", Type: "audio")
} else if MediaType == "gif" {
UploadGameFileData(NewGamePictureData as String, FileName: "Game\(NewGameID)Turn1", Type: "gif")
} else {

print("SHOULD UPLOAD IMAGE NOW")
UploadGameFileData(NewGamePictureData as String, FileName: "Game\(NewGameID)Turn1", Type: "image")
}
} else {
    
    let TempImageCurrent = CreateTempImage(NewGameQuote as String)
    
    UploadGameFile(TempImageCurrent, FileName: "Game\(NewGameID)Turn1", Type: "image")
    
    
    }
//  self.performSegueWithIdentifier("Turn_Complete", sender: self)

//NEED TO ADD NSNotification to go back to Home



    
    

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
alertView.addButton(withTitle: "OK")
//  alertView.show()

}

} else {
let alertView:UIAlertView = UIAlertView()
alertView.title = "Sign Up Failed!"
alertView.message = "Connection Failed"
alertView.delegate = self
alertView.addButton(withTitle: "OK")
//   alertView.show()
}
}  else {
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
        
        
        DispatchQueue.main.async(execute: {
            
            
            let theAlert = SCLAlertView()
            
            theAlert.addButton("Facebook", action: {
                
                self.FBShared = true
                
                self.AddToFaceBook(self.NewGameID.description as NSString, theMediaType: self.MediaType)
                
                
                
                
                })
            
            theAlert.addButton("Twitter", action: {
                self.TwitterShared = true
                self.ShareOnTwitter(self.NewGameID.description as NSString, theMediaType: self.MediaType)
                
            })
            
            theAlert.addButton("No Thanks", action: {
                
                
                DispatchQueue.main.async(execute: {
                    self.NewGameProgressHUD.removeFromSuperview()
                    self.performSegue(withIdentifier: "Turn_Complete", sender: self)
                })
                //self.ShareOnTwitter(self.NewGameID.description, theMediaType: self.MediaType)
                
            })
                theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Share", subTitle: "Share public game with your friends?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
        })

        
        /*
dispatch_async(dispatch_get_main_queue(), {
self.NewGameProgressHUD.removeFromSuperview()
self.performSegueWithIdentifier("Turn_Complete", sender: self)

        })
        
        */
//

// NSNotificationCenter.defaultCenter().postNotificationName("NewGameStarted", object: nil)

/*
dispatch_async(dispatch_get_main_queue(),{

var numPoints = Int()
var LevelUpTime = Bool()
(numPoints, LevelUpTime) = UPData(self.username, userid: self.userID, type: "add", points: "0", levelpoints: "1")
//numPoints = FilterUPData(UPurldata)
print("number of points = \(numPoints)")

// let AC = JSController("Pixie Points!", MyMessage: "You earn Points to level up your Pixie by Liking Turns.  You just earned one!",Color: "Green")


let alertController = UIAlertController(title: "Pixie Points!", message: "You earn Points to level up your Pixie by starting a new game.  You just earned one!", preferredStyle: .Alert)

let OkAction = UIAlertAction(title: "Ok", style: .Default) { (action:UIAlertAction) in
print("Ok button pressed")


if LevelUpTime {
var PointsNew = NSInteger()
var LevelNew = NSInteger()

(PointsNew, LevelNew) = UserLevelUp(self.username, userid: self.myID, type: "add", level: "1")

let AC = JSController("Level \(LevelNew.description) - Level Up!", MyMessage: "You just got a Level up on your Pixie! Congrats",Color: "Green")
self.presentViewController(AC, animated: true, completion:
{
NSNotificationCenter.defaultCenter().postNotificationName("updatePixie", object: nil)
}

)

//  self.LevelPlayer?.play()


}


}



alertController.addAction(OkAction);

self.presentViewController(alertController, animated: true, completion: nil)

})
*/

//}


        /*

        dispatch_async(dispatch_get_main_queue(), {
            self.NewGameProgressHUD.removeFromSuperview()
            self.performSegueWithIdentifier("Turn_Complete", sender: self)
        })
        
        */
            
        

 }


    @IBAction func startBTNpublic(_ sender: AnyObject) {
        
        
        if userID != "guest" {
        
        
        
        if ContentRatingSelected.isEqual(to: "") {
            
            let AC = JSController("Content Rating", MyMessage: "Please select a game content rating.",Color: "Red")
            //   self.presentViewController(AC, animated: true, completion: nil)
            
            
            DispatchQueue.main.async(execute: {
                
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Content Rating", subTitle: "Please select a game content rating", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            })
            
            
            return
            
            
        } else {
        
        
            if prefs.value(forKey: "ISADMIN") != nil {
            
        let Admin = prefs.value(forKey: "ISADMIN") as! NSString

        DispatchQueue.main.async(execute: {


           let theAlert =  SCLAlertView()


            theAlert.addButton("Create Game", action: {



                if self.username.isEqual(to: "") || self.userID.isEqual(to: "") {

                    let AC = JSController("Error Loading User Profile", MyMessage: "Please confirm you are logged in before starting a new game.",Color: "Red")
                    //self.presentViewController(AC, animated: true, completion: nil)


                    let theAlert = SCLAlertView()
                    theAlert.addButton("Ok") {
                    }
                    theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor.red, title: "Error Loading User Profile", subTitle: "Please confirm you are logged in")


                } else {

                    self.view.addSubview(self.NewGameProgressHUD)

                     DispatchQueue.main.async(execute: {
                    
                    self.CreatePublicGame("no")
                        
                    })

                }

            })
            
            if Admin == "yes" {
                
                theAlert.addButton("Create As Pixie", action: {
                    
                    
                    
                    if self.username.isEqual(to: "") || self.userID.isEqual(to: "") {
                        
                        let AC = JSController("Error Loading User Profile", MyMessage: "Please confirm you are logged in before starting a new game.",Color: "Red")
                        //self.presentViewController(AC, animated: true, completion: nil)
                        
                        
                        let theAlert = SCLAlertView()
                        theAlert.addButton("Ok") {
                        }
                        theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor.red, title: "Error Loading User Profile", subTitle: "Please confirm you are logged in")
                        
                        
                    } else {
                        
                        self.view.addSubview(self.NewGameProgressHUD)
                        
                        DispatchQueue.main.async(execute: {
                            
                            self.CreatePublicGame(Admin)
                            
                        })
                        
                    }
                    
                })
                
                
            }
            

            theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Public Game", subTitle: "This will create a game where any player may join", duration: nil, completeText: "Cancel", style: .custom, colorStyle: 1, colorTextButton: 1)
        })
        
            } else {
                
                
                 DispatchQueue.main.async(execute: {
                    
               SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "Please Confirm you are logged in", duration: nil, completeText: "OK", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
            }
        
        
    }
            
        } else {
            
            DispatchQueue.main.async(execute: {
                
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Log In", subTitle: "Please login to start a new game", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            })
            
            
        }

    }





    @IBAction func startBTN(_ sender: AnyObject) {

        
        if userID != "guest" {

        if Reachability.isConnectedToNetwork() {


        //var titleready = false
        //var quoteready = false
        //var picready = false
        //var numplayersready = false
        //var turntimeready = false

        if username.isEqual(to: "") || userID.isEqual(to: "") {

            DispatchQueue.main.async(execute: {


                let Alert2 = SCLAlertView()

                // if WasProfileUpdated {
                Alert2.addButton("Ok", action: {


                })

                Alert2.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Center", subTitle: "We're having trouble verifying your username.  Please try logging into game center from the home menu", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)

            })

        } else {



        if ContentRatingSelected.isEqual(to: "") {

            let AC = JSController("Content Rating", MyMessage: "Please select a game content rating.",Color: "Red")
         //   self.presentViewController(AC, animated: true, completion: nil)


            DispatchQueue.main.async(execute: {


                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Content Rating", subTitle: "Please select a game content rating", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            })


            return


        } else {

        print("Content Rating selected is \(ContentRatingSelected)")

        NewGameTitle = GameTitleTXT.text! as NSString
        NewGameQuote = QuoteBox.text! as NSString
        print("Start Button: New Game Quote = \(NewGameQuote)")
        //NewGamePlayers = PlayerCountSTPR.value


       // self.performSegueWithIdentifier("start_game", sender: self)


        if NewGameTitle.isEqual(to: "") {




            let AC = JSController("Missing Item", MyMessage: "You must enter a game Title",Color: "Red")
            self.present(AC, animated: true, completion: nil)



            return
            
        } else {
            
            titleready = true
            
            
        }
        
        if NewGamePlayers < 2 {
          
            let AC = JSController("Not Enough Players", MyMessage: "You need atleast 2 people to play",Color: "Red")
            self.present(AC, animated: true, completion: nil)

            
           // exit(0)
            return
            
        } else {
         numplayersready = true
        }
        
        if NewGameFirstTurn == "quote" {
            picready = true
            
            
        if  MediaType == "quote" {
            
        if NewGameQuote.isEqual(to: "")  {
            
            let AC = JSController("Missing Quote", MyMessage: "You forgot to enter your first quote",Color: "Red")
            self.present(AC, animated: true, completion: nil)

            
            return
            } else {
            quoteready = true
             //MediaType = "quote"
            }
        } else  {
           
            if RecordedData.isEqual(to: "") {
                let AC = JSController("Missing Audio Clip", MyMessage: "No Audio Clip is selected",Color: "Red")
                self.present(AC, animated: true, completion: nil)
   
                return
            } else {
            quoteready = true
            NewGameAudioData = RecordedData
              // print("NEw Game Audio Data From NGVC = \(NewGameAudioData)")
               // NewGamePictureData = RecordedData.base64EncodedStringWithOptions([])

                prefs.setValue(NewGameAudioData, forKey: "AUDIODATAD")
                
                print("Audio Data has been saved")
                
            }
            }
        } else if NewGameFirstTurn == "picture" {
            quoteready = true
            
            if !PictureAdded  {
               
               
                let theAlert2 = SCLAlertView()
                theAlert2.addButton("Ok") {
                }
                
                theAlert2.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Missing Image or Quote", subTitle: "You forgot to enter a Quote or Image.")
                
                //alertView.show()
              //  exit(0)
                //return
                
            } else {

                
                if MediaType == "gif" {
                    
                    //MediaType = "picture"
                    
                
                } else {
                
                print("Converting Picture")
                
                UIGraphicsBeginImageContext(PicPreview.bounds.size)
                PicPreview.image?.draw(in: CGRect(x: 0, y: 0,
                    width: PicPreview.frame.size.width, height: PicPreview.frame.size.height))
                
                image = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
                
               
                
                
                let smallImage = PicPreview.image!.resize(0.5)
                

                let imageData = UIImageJPEGRepresentation(smallImage, 0.6)
                
                NewGamePictureData = imageData!.base64EncodedString(options: []) as NSString
        
                
                prefs.setValue(NewGamePictureData, forKey: "PICTUREDATAD")
                
                print("New Game Picture added \(NewGamePictureData)")
                    
                NewGameImage = PicPreview.image!
                    
                    
                    
                    MediaType = "picture"
                    
                }
                picready = true
            }
        }
        
        if NewGameTurnTime.isEqual(to: "") {
           
            let AC = JSController("Select Turn Time", MyMessage: "You forgot to select the Time between each player's turn",Color: "Red")
            self.present(AC, animated: true, completion: nil)
            
            //exit(0)
           // return
            
        } else {
            
            turntimeready = true
        }
        
        print("about to start game")
        
        print("titleready = \(titleready)")
        print("quoteready = \(quoteready)")
        print("picready = \(picready)")
        print("numplayersready = \(numplayersready)")
        print("turntime ready = \(turntimeready)")
        
        if quoteready {
            picready = true
        } else if picready {
            quoteready = true
        }
        
     
        if titleready && quoteready && picready && numplayersready && turntimeready {
            
     self.performSegue(withIdentifier: "start_game", sender: self)
            print("shoud have started game")
            
        }
   
      }
       
            
        }
        
        
    } else {
    
    DispatchQueue.main.async(execute: {
    
    
    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Connection Error!", subTitle: "Check your network settings", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
    
    })
    
    }
        
        
        
    } else {
    
    DispatchQueue.main.async(execute: {
    
    
    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Log In", subTitle: "Please login to start a new game", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
    })
    
    
    }

    
    
    }

    @IBAction func TurnTimeBTN(_ sender: AnyObject) {
        
       // view.endEditing(true)
        
       // QuoteBox.hidden = true
        //GameTitleBTN.hidden = true
        PictureINFO.isHidden = true
        QuoteINFO.isHidden = true
        //startBTN.hidden = true
        GameTitleINFO.isHidden = true
        
        if !ViewTurnTime {
            
            UIView.animate(withDuration: 0.3, animations: {
         self.TimeView.center.y = (self.TimeView.center.y + 500)
         self.TimeViewTop.constant = 50
                //  self.TurnTimeCountLBL.center.y = self.TurnTimeCountLBL.center.y - 65
                
            })
            ViewTurnTime = true
        } else {
            UIView.animate(withDuration: 0.3, animations: {
            self.TimeView.center.y = (self.TimeView.center.y - 500)
            //self.TurnTimeCountLBL.center.y = self.TurnTimeCountLBL.center.y - 65
            })
            ViewTurnTime = false
        }
        
 view.endEditing(true)
        
    }
    
    @IBAction func TurnTimeBTN2(_ sender: AnyObject) {
        
        if !ViewTurnTime {
            
            UIView.animate(withDuration: 0.3, animations: {
              //  self.TimeView.center.y = self.TimeView.center.y - 500
                self.TurnTimeCountLBL.center.y = self.TurnTimeCountLBL.center.y + 35
                
            })
            ViewTurnTime = true
        } else {
             UIView.animate(withDuration: 0.3, animations: {
            //self.TimeView.center.y = self.TimeView.center.y + 500
            self.TurnTimeCountLBL.center.y = self.TurnTimeCountLBL.center.y - 35
        })
        ViewTurnTime = false
    }
    
    
    
}
    
    
    
    @IBAction func PlayerCountBTN(_ sender: AnyObject) {
        
        if !ViewNumPlayers {
            /*
            self.PlayerCountSTPR.center.y = self.PlayerCountLBL.center.y + 365
            self.PlayerCountSTPR.hidden = false
            
            self.PlayerCountLBL.center.y = self.PlayerCountLBL.center.y + 365
            self.PlayerCountLBL.hidden = false
          */
            UIView.animate(withDuration: 0.3, animations: {
                
      
                self.PlayerCountSTPR.center.y = self.PlayerCountSTPR.center.y + 40
                
                

                self.PlayerCountLBL.center.y = self.PlayerCountLBL.center.y + 40
                
                
          //      self.PlayerCountSTPR.center.y = self.PlayerCountSTPR.center.y + 35
          //      self.PlayerCountLBL.center.y = self.PlayerCountLBL.center.y + 35
            })
            ViewNumPlayers = true
        } else {
            
            
            UIView.animate(withDuration: 0.3, animations: {
                
                self.PlayerCountSTPR.center.y = self.PlayerCountLBL.center.y - 40
              //  self.PlayerCountSTPR.hidden = true
              //  self.PlayerCountSTPR.center.y = self.PlayerCountSTPR.center.y - 365
                
                
                self.PlayerCountLBL.center.y = self.PlayerCountLBL.center.y - 40
              //  self.PlayerCountLBL.hidden = true
              //  self.PlayerCountLBL.center.y = self.PlayerCountLBL.center.y - 365
                
               // self.PlayerCountSTPR.center.y = self.PlayerCountSTPR.center.y - 35
              //  self.PlayerCountLBL.center.y = self.PlayerCountLBL.center.y - 35
            })
            ViewNumPlayers = false

        }
     

    }

    @IBAction func GameTitleInfo(_ sender: AnyObject) {
       
        DispatchQueue.main.async(execute: {
            
            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Game Title", subTitle: "Please enter a title for your game.  It can be anything you would like.  This will make identifing this specific game much easier in the future", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        })
        
        /*UIView.animateWithDuration(0.3, animations: {
           // self.turntimeBTN.center.y = self.turntimeBTN.center.y + 65
        })
*/
        
    }
    
    @IBAction func TurnTimeInfo(_ sender: AnyObject) {
        
       
        DispatchQueue.main.async(execute: {
            
            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Turn Time", subTitle: "Here you can choose the time each player has before the turn is opened up for any player. If you choose Unlimited no other player may play until the assigned player takes their turn.  Choosing No Limit allows any player to immediately take the next turn.  This is designed to speed up game play if you don't want to wait on others.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        })
        
        
       /* UIView.animateWithDuration(0.3, animations: {
         //   self.turntimeBTN.center.y = self.turntimeBTN.center.y + 65
        })
        */
    }
    
    
    
    @IBAction func QuoteINFO(_ sender: AnyObject) {
        
        
        DispatchQueue.main.async(execute: {
            
            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Starting Quote", subTitle: "Enter the Game Starting Quote.  This is the starting point of the game.  The next player will submit a picture based on this quote...or you can submit a picture first to start the game by tapping the image button below", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        })
        
    }
    
    @IBAction func PictureINFO(_ sender: AnyObject) {
        
        
        DispatchQueue.main.async(execute: {
            
            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Starting Picture", subTitle: "Submit the Game starting picture. This image will be the starting point of the game.  The next player will write a quote to describe this picture...or you can write a quote first to start the game by tapping the quote button below", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        })
    
    }
    
    
    @IBAction func PlayerCountInfo(_ sender: AnyObject) {
   

        
        DispatchQueue.main.async(execute: {
            
            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Players", subTitle: "To play you must have at least 2 players (including you) to play.  The maximum number of players allowed is 10.  Please select the number of players for your game (Don't worry, you can add or delete players to this game later)", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        })
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == picker2 {
            if component == 0 {
                return "\(MinData[row]) Min"
            } else {
                
                return "\(SecData[row]) Sec"
            }

        } else {
        return pickerData[row]
        }
}
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == picker2 {
            if component == 0 {
                MinSelected = MinData[row]
            }  else {
                SecSelected = SecData[row]
            }

        } else {
        TimeLimitPick = pickerData[row]

        switch pickerData[row] {
            case "No Limit":
            TimeConfirmedLBL.text = "There is no Time limit between turns.  Any player may take the next turn available"
            case "2:00":
            TimeConfirmedLBL.text = "The next player has 2 Hours to take their turn, then any player may take the available turn"
            case "1:30":
            TimeConfirmedLBL.text = "The next player has 1 Hour and 30 Minutes to take their turn, then any player may take the available turn"
            case "1:00":
                TimeConfirmedLBL.text = "The next player has 1 Hour to take their turn, then any player may take the available turn"
            case "0:30":
                TimeConfirmedLBL.text = "The next player has 30 Minutes to take their turn, then any player may take the available turn"
            case "0:15":
                TimeConfirmedLBL.text = "The next player has 15 Minutes to take their turn, then any player may take the available turn"
            case "0:05":
                TimeConfirmedLBL.text = "The next player has 5 Minutes to take their turn, then any player may take the available turn"
            case "Unlimited":
            TimeConfirmedLBL.text = "There is Unlimited time between turns, no other player may take the next turn except the assigned player"
            default:
            TimeConfirmedLBL.text = "Please select the Time between each player turn"
          }
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == picker2 {
            return 2
        } else {
        return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == picker2 {
            if component == 0 {
                return MinData.count
            } else {
                return SecData.count
            }
        } else {
        return pickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        var attributedString: NSAttributedString!
        
        if pickerView == TurnTimePKR {
        
        
        attributedString = NSAttributedString(string: pickerData[row], attributes: [NSForegroundColorAttributeName : UIColor.white])
        

        return attributedString
        /*
        switch component {
        case 0: attributedString = NSAttributedString(string: arrayOne[row], attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
            
        case 1: attributedString = NSAttributedString(string: arrayOne[row], attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        }
*/
        } else {
            
            if component == 0 {
               attributedString = NSAttributedString(string: MinData[row].description, attributes: [NSForegroundColorAttributeName : UIColor.white])
            } else {
                
               attributedString = NSAttributedString(string: SecData[row].description, attributes: [NSForegroundColorAttributeName : UIColor.white])
            }

            
            

            return attributedString

        }
        
    }
    

    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
       
            
        let pickerLabel = UILabel()
        var titleData = String()
        
         if pickerView == TurnTimePKR {
            
        switch pickerData[row] {
        case "No Time Limit":
            titleData = pickerData[row]
        case "2:00":
            titleData = "\(pickerData[row]) hours"
        case "1:30":
            titleData = "\(pickerData[row]) hours"
        case "1:00":
            titleData = "\(pickerData[row]) hour"
        case "0:30":
        titleData = "\(pickerData[row]) mins"
        case "0:15":
           titleData = "\(pickerData[row]) mins"
        case "0:05":
           titleData = "\(pickerData[row]) mins"
        case "Unlimited":
           titleData = pickerData[row]
            default:
        titleData = pickerData[row]
           // break
        }
        
       // let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData) //, attributes)
        pickerLabel.attributedText = myTitle
        return pickerLabel
            
        } else {
           
            
            if component == 0 {
                titleData =  "\(MinData[row]) Min"
            } else {
                
                titleData =  "\(SecData[row]) Sec"
            }
            
            let myTitle = NSAttributedString(string: titleData) //, attributes)
            pickerLabel.attributedText = myTitle
            return pickerLabel
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if pickerView == TurnTimePKR {
        return 100
        } else {
            return 50
        }
    }
    
    
   
 

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "NewPorQ" {
            let PQ2ViewController = segue.destination 
            
            //PQ2ViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            
            PQ2ViewController.popoverPresentationController!.delegate = self
            PQ2ViewController.presentationController?.delegate = self
            
            
        }
        
        
        
        if segue.identifier == "browseimage" {
            if let destination = segue.destination as? BrowseImageViewController {
                // let AudioBrowseViewController = segue.destinationViewController
                destination.FromNVC = true
                //PQ2ViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
                
                // PQ2ViewController.popoverPresentationController!.delegate = self
                //  PQ2ViewController.presentationController?.delegate = self
            }
            
            
        }


        if segue.identifier == "HowTo" {
            
            if let destination = segue.destination as? HowToSecondViewController {
                // let AudioBrowseViewController = segue.destinationViewController
                destination.theTopic = "New Game"
                //PQ2ViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
                
                // PQ2ViewController.popoverPresentationController!.delegate = self
                //  PQ2ViewController.presentationController?.delegate = self
            }
            
        }

        
        
        if segue.identifier == "start_game" {
            if let destination = segue.destination as? ConfirmPlayersViewController {
                

            destination.NewGameTitle = NewGameTitle
                print("num players = \(self.NewGamePlayers)")
            destination.NewGamePlayers = NewGamePlayers
            destination.NewGameTurnTime = NewGameTurnTime
            destination.NewGameFirstTurn = NewGameFirstTurn
            destination.NewGameImage = NewGameImage
            destination.NewGameQuote = NewGameQuote
            destination.NewGamePictureData = NewGamePictureData
            destination.NewGameAudioData = NewGameAudioData
            destination.MediaType = MediaType
            destination.NewGameContentRating = ContentRatingSelected
                //destination
            //destination.mainImageView.image = PicPreview.image
                
                //self.messageFrame.removeFromSuperview()
            }
        }
        
        if segue.identifier == "login" {
            if let destination = segue.destination as? LoginViewController {
                destination.FromNewGame = true
            }
        }
    
    }
    
    
    
   // @IBOutlet weak var myImageView: UIImageView!

    
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    //MARK: - Actions
    //get a photo from the library. We present as a popover on iPad, and fullscreen on smaller devices.
    
    
    
    
    
    @IBAction func photoFromLibary(_ sender: AnyObject){
        
               
        if username.isEqual(to: "") {
            
            let Alert = SCLAlertView()
            Alert.addButton("Log in Now", action: {
                
                
                //   self.IsPlayerLoggedIn = self.LogIntoGameCenter()
                
                
                DispatchQueue.main.async(execute: {
                    
                    LogIntoGameCenterNew()
                    
                })
                
            })
            
            Alert.addButton("Later", action: {
                
                
                DispatchQueue.main.async(execute: {
                    
                    SCLAlertView().showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Center", subTitle: "Without being logged into Game Center many of this games features are disabled.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
                
                
            })
            
            Alert.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Game Center", subTitle: "You need to be logged into Game Center to view your games.  Please log in now", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
            
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
                        
                        self.TheProduct = "image"
                        self.purchaseitems()
                    }
                    
        
                    theAlert.addButton("Later") {
                        
                    }
                    
                    //theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Import Photos", subTitle: "Add to your toolbox?")
                    theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Import Photos", subTitle: "Add photos any time for only $0.99?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                    
                }
               
                theAlert2.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Use Your Tokens?", subTitle: "Use 10 tokens to add an image?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                
              
                
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
                
                theAlert2.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Great news!", subTitle: "Try it for Free", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
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
                    
                    self.TheProduct = "image"
                    self.purchaseitems()
                }
                
             
                theAlert.addButton("Later") {
                    
                }
                
                //theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Import Photos", subTitle: "Add to your toolbox?")
                theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Import Photos", subTitle: "Add photos any time for only $0.99?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            }
          }
            
        }
        
    }
    
    }

    
    //take a picture, check if we have a camera first.
    
    @IBAction func shootPhoto(_ sender: AnyObject) {
        
        
        //let uname = prefs.valueForKey("USERNAME") as! NSString
        
        if username.isEqual(to: "") {
            
            /*
            
            let Alert = SCLAlertView()
            Alert.addButton("Log in Now", action: {
                
                
                //   self.IsPlayerLoggedIn = self.LogIntoGameCenter()
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    LogIntoGameCenterNew()
                    
                })
                
            })
            
            Alert.addButton("Later", action: {
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    SCLAlertView().showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Center", subTitle: "Without being logged into Game Center many of this games features are disabled.", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                    
                })
                
                
            })
            
            Alert.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Game Center", subTitle: "You need to be logged into Game Center to view your games.  Please log in now", duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
            
            */
            
        } else {
        
       // ImageViewLBL.hidden = true
        if (prefs.bool(forKey: "CameraPurchased")){
            
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
            (numPoints, LevelUpTime) = UPData(self.username, userid: self.userID, type: "get", points: "0",levelpoints: "0")
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
                        
                        self.TheProduct = "image"
                        self.purchaseitems()
                    }
                    
                    // theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Use Your Camera", subTitle: "Add to your toolbox?")
                    
                    theAlert.addButton("Later") {
                        
                    }
                    
                    //theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Import Photos", subTitle: "Add to your toolbox?")
                    theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Use Camera", subTitle: "Add photos any time for only $0.99?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                    
                }
                // theAlert2.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Use Your Tokens?", subTitle: "Use 10 tokens to proceed?")
                
                
                theAlert2.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Use Your Tokens?", subTitle: "Use 10 tokens to add an image?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                
      
                
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
                
                theAlert2.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Great News!", subTitle: "Try it for Free", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
              
                
            } else {
                
                let theAlert = SCLAlertView()
                theAlert.addButton("Let's do it") {
                    self.TheProduct = "image"
                    self.purchaseitems()
                }
                
                
          
                theAlert.addButton("Later") {
                    
                }
                
                //theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Import Photos", subTitle: "Add to your toolbox?")
                theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Import Photos", subTitle: "Add photos any time for only $0.99?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                
             
            }
          }
        }
    }
}
    
    
    func purchaseitems(){
        
        print("About to fetch the products");
    
    if TheProduct.isEqual(to: "image") {
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
        
        
    } else {
        if (SKPaymentQueue.canMakePayments())
        {
            let productID:NSSet = NSSet(object: self.product_id_audio!);
            let productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>);
            productsRequest.delegate = self;
            productsRequest.start();
            print("Fething Products");
        }else{
            print("can't make purchases");
        }
        
    }
    
        
    }
    
    
    
    func buyProduct(_ product: SKProduct){
        print("Sending the Payment Request to Apple");
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment);
        
    }
    

    
    func productsRequest (_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        
         if TheProduct.isEqual(to: "image") {
        
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
            
         } else {
            
            
            
            let count : Int = response.products.count
            if (count>0) {
                var validProducts = response.products
                let validProduct: SKProduct = response.products[0]
                if (validProduct.productIdentifier == self.product_id_audio as! String) {
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
    }
    
    

    
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Error Fetching product information");
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction])    {
        print("Received Payment Transaction Response from Apple");
        
        
          if TheProduct.isEqual(to: "image") {
        print("the product is an image")
        
        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
                switch trans.transactionState {
                case .purchased:
                    print("Image Product Purchased");
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    prefs.set(true , forKey: "Purchased")
                    prefs.set(true, forKey: "CameraPurchased")
                    let UserUpdate = UserStatusCheck(username, userID: userID, status: "photo", action: "update")
                    if UserUpdate{
                        print("user profile updated")
                    } else {
                        print("user profile not updated")
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
                    let UserUpdate = UserStatusCheck(username, userID: userID, status: "photo", action: "update")
                    if UserUpdate{
                        print("user profile updated")
                    } else {
                        print("user profile not updated")
                    }
                    
                default:
                    break;
                }
            }
        }
            
          } else {
            
            
               print("the product is audio")
            
            for transaction:AnyObject in transactions {
                if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
                    
                  //  print("the transaction state = \(trans.transactionState)")
                  //   print("the transaction date = \(trans.transactionDate)")
                    
                    switch trans.transactionState {
                      //  print("the transaction state = \(trans.transactionState)")
                      //  print("the transaction date = \(trans.transactionDate)")
   
                   // case .
                        
                    case .purchased:
                        print("Audio Product Purchased");
                        SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                        prefs.set(true , forKey: "Purchased")
                        prefs.set(true, forKey: "AudioPurchased")
                        let UserUpdate = UserStatusCheck(username, userID: userID, status: "audio", action: "update")
                        if UserUpdate{
                            print("user profile updated")
                        } else {
                            print("user profile not updated")
                        }
                        
                        self.QuoteBox.text = "AUDIO CLIP SELECTED"
                        self.QuoteBox.textColor = UIColor.green

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
                        prefs.set(true, forKey: "AudioPurchased")
                        let UserUpdate = UserStatusCheck(username, userID: userID, status: "audio", action: "update")
                        if UserUpdate{
                            print("user profile updated")
                        } else {
                            print("user profile not updated")
                        }
                        
                        self.QuoteBox.text = "AUDIO CLIP SELECTED"
                        self.QuoteBox.textColor = UIColor.green

                        
                    default:
                        break;
                    }
                }
            }

        }
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        //
        print("Did finish picking image, ready to edit")
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
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
                
                var imageView = UIImageView(frame: self.view.bounds)
                
                assetLib.asset(for: imageURL, resultBlock: { (asset) in
                let fetchResult = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
                
                //let phAssetTWO = fetchResult.lastObject as? PHAsset
                let phAssetTWO = fetchResult.lastObject
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
                        
                    //   GIFData = Data(bytes: UnsafePointer(Bytes!), count: Length!)
                       
                        
                        //SWIFT 3 ERROR NEED TO FIX
                         // GIFData = Data(bytes: UnsafePointer<UInt8>(Bytes!), count: Length!)
                        GIFData = Data(bytes: Bytes!, count: Length!)
                        if 1 == 1 {
                            
                        } else {
                        
//                       var values = [UInt8](repeating:0, count:(imageData?.count)!)
  //                     GIFData = Data.Bytes(to: &values, count: imageData?.count)
                        
                        
                    // GIFData = Data.
                       // GIFData = [UInt8](imageData?)
                        //GIFData = Data.withUnsafeBytes { OutputStream.write(Bytes!, maxLength: Length!) }
                       
                        //  GIFData = NSData(bytes: Bytes.!, length: Length!)
                        
                        self.MediaType = "gif"
                        self.PicPreview.image = UIImage.animatedImage(withAnimatedGIFData: GIFData)
                        
                        
                        self.NewGamePictureData = GIFData.base64EncodedString(options: []) as NSString
                        print("GIF Data = \(self.NewGamePictureData)")
                        
                        self.prefs.setValue(self.NewGamePictureData, forKey: "PICTUREDATAD")
                        
                        print("New Game Picture added \(self.NewGamePictureData)")
                        
                        self.NewGameImage = self.PicPreview.image!
                        
                        }
                        //   GIFData = (contentsOfURL: NSURL(string: tempURL)!)!
                        // ...
                    }
                }
                }, failureBlock: nil)
                
                //SWIFT 3 ERROR
                /*
                assetLib.asset(for: imageURL, resultBlock: { (asset : ALAsset!) -> Void in

                    let fetchResult = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
                    
                    let phAssetTWO = fetchResult.lastObject as? PHAsset
                    
                    print("phAssetTWO = \(phAssetTWO)")
                    if let phAsset = fetchResult.firstObject as? PHAsset {
                        
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
                            
                            
                          GIFData = Data(bytes: UnsafePointer<UInt8>(Bytes!), count: Length!)
                         //  GIFData = NSData(bytes: Bytes.!, length: Length!)
                            
                        self.MediaType = "gif"
                        self.PicPreview.image = UIImage.animatedImage(withAnimatedGIFData: GIFData)
                            
                            
                            self.NewGamePictureData = GIFData.base64EncodedString(options: [])
                            print("GIF Data = \(self.NewGamePictureData)")
                            
                            self.prefs.setValue(self.NewGamePictureData, forKey: "PICTUREDATAD")
                            
                            print("New Game Picture added \(self.NewGamePictureData)")
                            
                            self.NewGameImage = self.PicPreview.image!
                            
                            //   GIFData = (contentsOfURL: NSURL(string: tempURL)!)!
                            // ...
                        }
                    }

                    
                    
                    }, failureBlock:  nil)
                */
                
                
               
                
                
                DispatchQueue.main.async(execute: {
                    
                    self.MediaType = "gif"
                    self.PicPreview.image = UIImage.animatedImage(withAnimatedGIFData: GIFData)
                })
                
                
                
                           } else {
                
                let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
                

                PicPreview.contentMode = .scaleAspectFit //3
                // myImageView.image = chosenImage
                PicPreview.image = chosenImage//4
                MediaType = "picture"
            
            }
            
            
        }
        
         
            

      /*
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2

        PicPreview.contentMode = .ScaleAspectFit //3
        // myImageView.image = chosenImage
        PicPreview.image = chosenImage//4
        MediaType = "picture"
*/
    
    
        
        PictureAdded = true
      //  (StartSegment.subviews[0] ).tintColor = UIColor(red: 0.4, green: 1, blue: 0.69, alpha: 1.0)

        print("Picture add = \(PictureAdded)")
        picready = true
        
        ViewImageViewLBL = false
        ImageViewLBL.isHidden = true
        
        dismiss(animated: true, completion: nil) //5
        
        
       // dismissViewControllerAnimated(true, completion: nil) //5
        
    }
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
   func GroupPick() {
        
        let savingsInformationViewController = storyboard?.instantiateViewController(withIdentifier: "Group Picker") as! GroupPickerViewController
        
        //let savingsInformationViewController = WeaponsViewController(nibName: "WeaponsMenu", bundle: nil)
        //  savingsInformationViewController.delegate=self
        
        //   savingsInformationViewController.weaponPKLabel=weaponLabel.text
        savingsInformationViewController.adelegate = self
        
        
        savingsInformationViewController.modalPresentationStyle = .popover
        if let popoverController2 = savingsInformationViewController.popoverPresentationController {
            // popoverController2.sourceView = sender as! UIView
            popoverController2.sourceView = self.view
            // popoverController2.sourceView = getgroupsBTN.self as! UIView
            //popoverController2.sourceRect = sender.bounds
            popoverController2.sourceRect = CGRect(x: 100,y: 100,width: 0,height: 0)
            
          //  popoverController2.permittedArrowDirections = nil
            popoverController2.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
            
            popoverController2.delegate = self
        }
        present(savingsInformationViewController, animated: true, completion: nil)
        
        
        
    }
    
       

    
    func DismissKeyboard(){
        
      /*
        if GameTitleTXT.text.isEmpty {
            GameTitleBTN.layer.backgroundColor = UIColor(red: 0.99, green: 0.69, blue: 0.35, alpha: 1.0).CGColor
            
        } else  {
            GameTitleBTN.layer.backgroundColor = UIColor.greenColor().CGColor
        }
      */
   
        view.endEditing(true)
    }

    
    var counter:Int = 0 {
        didSet {
            let fractionalProgress = Float(counter) /  100.0
            let animated = counter != 0
            //  progressView.setProgress(fractionalProgress, animated: animated)
            //
        }
    }

    
    func HanldeImportedFile(_ notification:Notification){
        
        let resultdict = (notification as NSNotification).userInfo
        
        //as! NSDictionary
        print("Result Dict: \(resultdict)")
        // let data : NSArray = resultdict.objectForKey("data") as! NSArray
        
        // let Audiodata  = resultdict!["data"] as! NSURL
        
        //print("Audio Data = \(Audiodata)")
        
        self.ImportedFileData = resultdict!["data"] as! NSString
        self.ImportedFileType = resultdict!["type"] as! NSString
        
        
        print("Imported File Type = \(self.ImportedFileType)")
       
       
        
    }
    
    
    
    
    @IBAction func SelectContentE(_ sender: AnyObject) {
        
        
        
        if isFun.isEqual(to: "no") {
            
            contentE.setImage(UIImage(named: "ContentEasy_Check.png"), for: UIControlState())
            contentM.setImage(UIImage(named: "ContentHard.png"), for: UIControlState())
            contentT.setImage(UIImage(named: "ContentMedium.png"), for: UIControlState())
            
        } else {
        
        contentE.setImage(contentE_YES, for: UIControlState())
        contentM.setImage(contentM_NO, for: UIControlState())
        contentT.setImage(contentT_NO, for: UIControlState())

        }
        
        ContentRatingSelected = "E"
            
            
            

    }
    
    
    @IBAction func SelectContentT(_ sender: AnyObject) {
        
        
        if isFun.isEqual(to: "no") {
            
            contentE.setImage(UIImage(named: "ContentEasy.png"), for: UIControlState())
            contentM.setImage(UIImage(named: "ContentHard.png"), for: UIControlState())
            contentT.setImage(UIImage(named: "ContentMedium_Check.png"), for: UIControlState())
            
        } else {
        
        contentE.setImage(contentE_NO, for: UIControlState())
        contentM.setImage(contentM_NO, for: UIControlState())
        contentT.setImage(contentT_YES, for: UIControlState())
            
        }
         ContentRatingSelected = "T"
    }

    
    @IBAction func SelectContentM(_ sender: AnyObject) {
        
        if isFun.isEqual(to: "no") {
            
            contentE.setImage(UIImage(named: "ContentEasy.png"), for: UIControlState())
            contentM.setImage(UIImage(named: "ContentHard_Check.png"), for: UIControlState())
            contentT.setImage(UIImage(named: "ContentMedium.png"), for: UIControlState())
            
        } else {
        
        contentE.setImage(contentE_NO, for: UIControlState())
        contentM.setImage(contentM_YES, for: UIControlState())
        contentT.setImage(contentT_NO, for: UIControlState())
            
        }
        
         ContentRatingSelected = "M"
    }
    
    func bannerViewWillLoadAd(_ banner: ADBannerView!) {
        print("bannerViewWillLoadAd")
    }
    
    
    func bannerViewDidLoadAd(_ banner: ADBannerView!) {
      //  bannerView1.hidden = false
        print("Did Load Ad")
    }
    
    func bannerView(_ banner: ADBannerView!, didFailToReceiveAdWithError error: Error!) {
      //  bannerView1.hidden = true
        print("Failed to receive Ad")
    }
    
    
    @IBAction func googleSearch(_ sender: AnyObject) {
        
        
        if username.isEqual(to: "") {
            
            let Alert = SCLAlertView()
            Alert.addButton("Log in Now", action: {
                
                
                //   self.IsPlayerLoggedIn = self.LogIntoGameCenter()
                
                
                DispatchQueue.main.async(execute: {
                    
                    LogIntoGameCenterNew()
                    
                })
                
            })
            
            Alert.addButton("Later", action: {
                
                
                DispatchQueue.main.async(execute: {
                    
                    SCLAlertView().showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Center", subTitle: "Without being logged into Game Center many of this games features are disabled.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
                
                
            })
            
            Alert.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Game Center", subTitle: "You need to be logged into Game Center to view your games.  Please log in now", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        } else {
            
            // ImageViewLBL.hidden = true
            if (prefs.bool(forKey: "CameraPurchased")){
                
                DispatchQueue.main.async(execute: {
                    self.performSegue(withIdentifier: "browseimage", sender: self)
                })
                
                //overlayView.hidden = true
            } else if (!prefs.bool(forKey: "CameraPurchased")){
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
                            
                            self.TheProduct = "image"
                            self.purchaseitems()
                        }
                        
                        // theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Use Your Camera", subTitle: "Add to your toolbox?")
                        
                        theAlert.addButton("Later") {
                            
                        }
                        
                        //theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Import Photos", subTitle: "Add to your toolbox?")
                        theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Image Search", subTitle: "Add photos any time for only $0.99?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                        
                        
                    }
                    // theAlert2.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Use Your Tokens?", subTitle: "Use 10 tokens to proceed?")
                    
                    
                    theAlert2.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Use Your Tokens?", subTitle: "Use 10 tokens to add an image?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                    
                    
                } else {
                    
                    
                    let check = UserStatusCheck(username, userID: userID, status: "photo", action: "check")
                    
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
                            self.TheProduct = "image"
                            self.purchaseitems()
                        }
                        
                        
                        
                        
                        theAlert.addButton("Later") {
                            
                        }
                        
                        //theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Import Photos", subTitle: "Add to your toolbox?")
                        theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Image Search", subTitle: "Add photos any time for only $0.99?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                        
                        
                    }
                }
            }
        }
        
        
        
        
       
    }
    
    
    func CreateTempImage (_ TempQuote: String) -> UIImage {
        // let font = UIFont(name: "ChalkboardSE-Regular", size: 11.0)
        
        let QBoxImage = UIImage(named: "QuoteBoxImage.png")
        
        print("Creating image with quote = \(TempQuote)")
        var TempImage = UIImage()
        
        
        let font = UIFont(name: "DK Cool Crayon", size: 30.0)
        
        let fontTitle = UIFont(name: "Chalkduster", size: 30.0)
        
        
        let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.center
        
        let textColor = UIColor.black
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.white
        shadow.shadowOffset = CGSize(width: 0,height: 1)
        // let textColorShadow = UIColor.whiteColor()
        
        var textFontAttributes: [String : AnyObject]?
        
        
        if let actualFont = font {
            textFontAttributes = [NSFontAttributeName: actualFont, NSForegroundColorAttributeName: textColor, NSParagraphStyleAttributeName: textStyle]
            
        }
        
        let ih = QBoxImage!.size.height
        let iw = QBoxImage!.size.width
        
        let newSize = CGSize(width: iw, height: ih)
        
        
        UIGraphicsBeginImageContext(newSize)
        
        
        
        let Rect2 = CGRect(x: 0,y: 0,width: iw,height: ih)
        
        
        let picRect = CGRect(x: 25,y: 85,width: iw,height: ih)
        
        QBoxImage!.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
        
        
        let qRect1 = CGRect(x: 10,y: 130,width: iw-20,height: ih)
        
        //  let PreviousQTemp = "\(PreviousQuote) -\(CurrentPlayer)"
        
        TempQuote.draw(in: qRect1, withAttributes: textFontAttributes)
        TempImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        return TempImage
        
    }
    
    
    @IBAction func backBTN(_ sender: AnyObject) {
    
    self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func AddToFaceBook (_ gameid: NSString, theMediaType: NSString) {
        
        //theMediaType = self.MediaType
        var MediaSuf = NSString()
        
        print("the media type for facebook = \(theMediaType)")
        let theTurnNumber = "1"
        
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
        
        let createdImagePHP = CreateImagePHP(gameid, mediaType: theMediaType, turnNumber: theTurnNumber as NSString)
        
        //let url = NSURL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game548Turn1.jpg")
        let url = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(gameid)Turn1.\(MediaSuf)")
        let data = try? Data(contentsOf: url!)
        
        
        DispatchQueue.main.async(execute: {
        
        /*
        let photo : FBSDKSharePhoto = FBSDKSharePhoto()
        photo.image = UIImage(data: data!)
        photo.userGenerated = true
        photo.caption = "Join this game!"
        // photo.capt

        
        
        //let linkContent : FBSDKShareLinkContent = FBSDKShareLinkContent()
            
            
        //  let photo : FBSDKSharePhoto = FBSDKSharePhoto()
            /*
        linkContent.contentURL = NSURL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(gameid)Turn1.php")
        
        linkContent.contentTitle = "Pics & Quotes"
        linkContent.contentDescription = "Join this game!"
        linkContent.imageURL = NSURL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(gameid)Turn1.\(MediaSuf)")
            */
            
            
            let photolinkContent : FBSDKSharePhotoContent = FBSDKSharePhotoContent()

            photolinkContent.contentURL = NSURL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(gameid)Turn1.php")
            
            //linkContent.contentTitle = "Pics & Quotes"
            // photolinkContent.
           // linkContent.imageURL = NSURL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(gameid)Turn1.\(MediaSuf)")

            
       
        photolinkContent.photos = [photo]
       
        
        
        print("Facebook Image URL = http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(gameid)Turn1.\(MediaSuf)")
        
        
        let Share : FBSDKShareDialog = FBSDKShareDialog()
        Share.mode = .Native
        Share.fromViewController = self
 
        //Share.shareContent = content
        Share.shareContent = photolinkContent
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

        
        
        
        
        
     
            
            
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
            
            let FBSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            
            //FBSheet.setInitialText("I'm Playing Pics & Quotes")
            
           // FBSheet.set
           // FBSheet.
            
            //  FBSheet.addURL(NSURL(string: "http://\(ServerInfo.sharedInstance)/Apps/Pics&Quotes/GoToApp.php"))
            
            //let FBImage2 = self.TheFinalImageTwo
            
            
            
           // FBSheet.addImage(FBImage)
            FBSheet.add(UIImage(data: data!))
            // FBSheet.addImage(FBImage2)
            
            FBSheet.add(URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(gameid)Turn1.php"))
            
            FBSheet.completionHandler = {
                result -> Void in
                
                //var fbImage2 = theimage
                let getResult = result as SLComposeViewControllerResult;
                switch(getResult.rawValue){
                case SLComposeViewControllerResult.cancelled.rawValue:
                    print("Cancelled")
                    
                    if self.TwitterShared || self.FBShared {
                        self.ShareCancelMessage = "All Set"
                    } else {
                        self.ShareCancelMessage = "No Thanks"
                    }
                    
                    if self.TwitterShared {
                        DispatchQueue.main.async(execute: {
                            self.NewGameProgressHUD.removeFromSuperview()
                            self.performSegue(withIdentifier: "Turn_Complete", sender: self)
                        })
                    } else {
                        
                        
                        DispatchQueue.main.async(execute: {
                            
                            
                            let theAlert = SCLAlertView()
                            
                            theAlert.addButton("Facebook", action: {
                                
                                self.FBShared = true
                                
                                self.AddToFaceBook(self.NewGameID.description as NSString, theMediaType: self.MediaType)
                                
                                
                                
                                
                            })
                            
                            theAlert.addButton("Twitter", action: {
                                self.TwitterShared = true
                                self.ShareOnTwitter(self.NewGameID.description as NSString, theMediaType: self.MediaType)
                                
                            })
                            
                        
                            
                            theAlert.addButton(self.ShareCancelMessage, action: {
                                
                                
                                DispatchQueue.main.async(execute: {
                                    self.NewGameProgressHUD.removeFromSuperview()
                                    self.performSegue(withIdentifier: "Turn_Complete", sender: self)
                                })
                                //self.ShareOnTwitter(self.NewGameID.description, theMediaType: self.MediaType)
                                
                            })
                            
                            
                            theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Share", subTitle: "Share public game with your friends?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                        })
                    }
                    
                case SLComposeViewControllerResult.done.rawValue:
                    self.FBShared = true
                    print("it's done")
                    print("Adding Points")
                    let  numPoints = UPData(self.username, userid: self.userID, type: "add", points: "5", levelpoints: "5")
                    //numPoints = FilterUPData(UPurldata)
                    print("number of points after Add = \(numPoints)")
                    
                    
                    if self.TwitterShared || self.FBShared {
                        self.ShareCancelMessage = "All Set"
                    } else {
                        self.ShareCancelMessage = "No Thanks"
                    }
                    /*
                    dispatch_async(dispatch_get_main_queue(), {
                    
                    
                    let AC = JSController("Tokens Earned!", MyMessage: "You Just earned 5 tokens for Sharing this turn on Facebook!",Color: "Green")
                    self.presentViewController(AC, animated: true, completion: {
                    
                    NSNotificationCenter.defaultCenter().postNotificationName("updatePixie", object: nil)
                    
                    })
                    })
                    
                    */
                    /*
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        let theAlert = SCLAlertView()
                        
                        theAlert.addButton("OK", action: {
                            NSNotificationCenter.defaultCenter().postNotificationName("updatePixie", object: nil)
                        })
                        
                        theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Tokens Earned!", subTitle: "You Just earned 5 tokens for Sharing this turn on Facebook!", duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
                    })
                    */
                //dispatch_async(dispatch_get_main_queue(), {
                    if self.TwitterShared {
                        DispatchQueue.main.async(execute: {
                            self.NewGameProgressHUD.removeFromSuperview()
                            self.performSegue(withIdentifier: "Turn_Complete", sender: self)
                        })
                    } else {
                        
                        
                        DispatchQueue.main.async(execute: {
                            
                            
                            let theAlert = SCLAlertView()
                            
                            theAlert.addButton("Facebook", action: {
                                
                                self.FBShared = true
                                
                                self.AddToFaceBook(self.NewGameID.description as NSString, theMediaType: self.MediaType)
                                
                                
                                
                                
                            })
                            
                            theAlert.addButton("Twitter", action: {
                                self.TwitterShared = true
                                self.ShareOnTwitter(self.NewGameID.description as NSString, theMediaType: self.MediaType)
                                
                            })
                            
                            theAlert.addButton(self.ShareCancelMessage, action: {
                                
                                
                                DispatchQueue.main.async(execute: {
                                    self.NewGameProgressHUD.removeFromSuperview()
                                    self.performSegue(withIdentifier: "Turn_Complete", sender: self)
                                })
                                //self.ShareOnTwitter(self.NewGameID.description, theMediaType: self.MediaType)
                                
                            })
                            theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Share", subTitle: "Share public game with your friends?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                        })
                    }
               // })
                
                    
                default:
                    print("error!")
                    
                    if self.TwitterShared || self.FBShared {
                        self.ShareCancelMessage = "All Set"
                    } else {
                        self.ShareCancelMessage = "No Thanks"
                    }
                    
                DispatchQueue.main.async(execute: {
                    
                    if self.TwitterShared {
                        DispatchQueue.main.async(execute: {
                            self.NewGameProgressHUD.removeFromSuperview()
                            self.performSegue(withIdentifier: "Turn_Complete", sender: self)
                        })
                    } else {
                        
                        
                        DispatchQueue.main.async(execute: {
                            
                            
                            let theAlert = SCLAlertView()
                            
                            theAlert.addButton("Facebook", action: {
                                
                                self.FBShared = true
                                
                                self.AddToFaceBook(self.NewGameID.description as NSString, theMediaType: self.MediaType)
                                
                                
                                
                                
                            })
                            
                            theAlert.addButton("Twitter", action: {
                                self.TwitterShared = true
                                self.ShareOnTwitter(self.NewGameID.description as NSString, theMediaType: self.MediaType)
                                
                            })
                            
                            theAlert.addButton(self.ShareCancelMessage, action: {
                                
                                
                                DispatchQueue.main.async(execute: {
                                    self.NewGameProgressHUD.removeFromSuperview()
                                    self.performSegue(withIdentifier: "Turn_Complete", sender: self)
                                })
                                //self.ShareOnTwitter(self.NewGameID.description, theMediaType: self.MediaType)
                                
                            })
                            theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Share", subTitle: "Share public game with your friends?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                        })
                    }
                })
                }
                self.dismiss(animated: true, completion: nil)
            }
            
            // FBSheet.
            
            self.present(FBSheet, animated: true, completion: nil)
            
            
            
            
        } else {
            /*
            let alert = UIAlertController(title: "Accounts", message: "Please login to Facebook", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            */
            
            DispatchQueue.main.async(execute: {
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Accounts", subTitle: "Please login to Facebook", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            })
            
            
        }
            

            
    })
        
        
    }
    
    func ShareOnTwitter(_ gameid: NSString, theMediaType: NSString) {
     var MediaSuf = NSString()
        
        let theTurnNumber = "1"
        
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
                    
                    if self.TwitterShared || self.FBShared {
                        self.ShareCancelMessage = "All Set"
                    } else {
                        self.ShareCancelMessage = "No Thanks"
                    }
                    
                    
                    if self.FBShared {
                        DispatchQueue.main.async(execute: {
                            self.NewGameProgressHUD.removeFromSuperview()
                            self.performSegue(withIdentifier: "Turn_Complete", sender: self)
                        })
                    } else {
                        
                        
                        DispatchQueue.main.async(execute: {
                            
                            
                            let theAlert = SCLAlertView()
                            
                            theAlert.addButton("Facebook", action: {
                                
                                self.FBShared = true
                                
                                self.AddToFaceBook(self.NewGameID.description as NSString, theMediaType: self.MediaType)
                                
                                
                                
                                
                            })
                            
                            theAlert.addButton("Twitter", action: {
                                self.TwitterShared = true
                                self.ShareOnTwitter(self.NewGameID.description as NSString, theMediaType: self.MediaType)
                                
                            })
                            
                            theAlert.addButton(self.ShareCancelMessage, action: {
                                
                                
                                DispatchQueue.main.async(execute: {
                                    self.NewGameProgressHUD.removeFromSuperview()
                                    self.performSegue(withIdentifier: "Turn_Complete", sender: self)
                                })
                                //self.ShareOnTwitter(self.NewGameID.description, theMediaType: self.MediaType)
                                
                            })
                            theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Share", subTitle: "Share public game with your friends?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                        })
                    }
                    
                    print("Cancelled")
                case SLComposeViewControllerResult.done.rawValue:
                    print("it's done")
                    self.TwitterShared = true
                    let  numPoints = UPData(self.username, userid: self.userID, type: "add", points: "5", levelpoints: "0")
                    //numPoints = FilterUPData(UPurldata)
                    print("number of points = \(numPoints)")
                    
                    if self.TwitterShared || self.FBShared {
                        self.ShareCancelMessage = "All Set"
                    } else {
                        self.ShareCancelMessage = "No Thanks"
                    }
                    
                    if self.FBShared {
                        DispatchQueue.main.async(execute: {
                            self.NewGameProgressHUD.removeFromSuperview()
                            self.performSegue(withIdentifier: "Turn_Complete", sender: self)
                        })
                    } else {
                    
                        
                        DispatchQueue.main.async(execute: {
                            
                            
                            let theAlert = SCLAlertView()
                            
                            theAlert.addButton("Facebook", action: {
                                
                                self.FBShared = true
                                
                                self.AddToFaceBook(self.NewGameID.description as NSString, theMediaType: self.MediaType)
                                
                                
                                
                                
                            })
                            
                            theAlert.addButton("Twitter", action: {
                                self.TwitterShared = true
                                self.ShareOnTwitter(self.NewGameID.description as NSString, theMediaType: self.MediaType)
                                
                            })
                            
                            theAlert.addButton(self.ShareCancelMessage, action: {
                                
                                
                                DispatchQueue.main.async(execute: {
                                    self.NewGameProgressHUD.removeFromSuperview()
                                    self.performSegue(withIdentifier: "Turn_Complete", sender: self)
                                })
                                //self.ShareOnTwitter(self.NewGameID.description, theMediaType: self.MediaType)
                                
                            })
                            theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Share", subTitle: "Share public game with your friends?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                        })
                    }
                    
                    /*
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        
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
                        
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            
                            let theAlert = SCLAlertView()
                            
                            theAlert.addButton("OK", action: {
                                NSNotificationCenter.defaultCenter().postNotificationName("updatePixie", object: nil)
                            })
                            
                            theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Tokens Earned!", subTitle: "You Just earned 5 tokens for Sharing this turn on Twitter!", duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
                        })
                        
                        
                        
                        /*
                        let AC = JSController("Tokens Earned!", MyMessage: "You Just earned 5 tokens for Sharing this turn on Twitter!",Color: "Green")
                        self.presentViewController(AC, animated: true, completion: {
                        NSNotificationCenter.defaultCenter().postNotificationName("updatePixie", object: nil)
                        }
                        
                        )
                        */
                    })
                    */
                    
                default:
                    print("error!")
                    
                    if self.TwitterShared || self.FBShared {
                        self.ShareCancelMessage = "All Set"
                    } else {
                        self.ShareCancelMessage = "No Thanks"
                    }
                    
                    if self.FBShared {
                        DispatchQueue.main.async(execute: {
                            self.NewGameProgressHUD.removeFromSuperview()
                            self.performSegue(withIdentifier: "Turn_Complete", sender: self)
                        })
                    } else {
                        
                        
                        DispatchQueue.main.async(execute: {
                            
                            
                            let theAlert = SCLAlertView()
                            
                            theAlert.addButton("Facebook", action: {
                                
                                self.FBShared = true
                                
                                self.AddToFaceBook(self.NewGameID.description as NSString, theMediaType: self.MediaType)
                                
                                
                                
                                
                            })
                            
                            theAlert.addButton("Twitter", action: {
                                self.TwitterShared = true
                                self.ShareOnTwitter(self.NewGameID.description as NSString, theMediaType: self.MediaType)
                                
                            })
                            
                            theAlert.addButton(self.ShareCancelMessage, action: {
                                
                                
                                DispatchQueue.main.async(execute: {
                                    self.NewGameProgressHUD.removeFromSuperview()
                                    self.performSegue(withIdentifier: "Turn_Complete", sender: self)
                                })
                                //self.ShareOnTwitter(self.NewGameID.description, theMediaType: self.MediaType)
                                
                            })
                            theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Share", subTitle: "Share public game with your friends?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                        })
                    }
                    
                }
                self.dismiss(animated: true, completion: nil)
            }
            
            let createdImagePHP = CreateImagePHP(gameid, mediaType: theMediaType, turnNumber: theTurnNumber as NSString)
            
            
            twitterSheet.setInitialText("I'm Playing Pics & Quotes")
            
            
            
            // let TwitterImage = self.theimage
            if theMediaType == "quote" {
            twitterSheet.add(TempImageCurrent)
            } else {
            twitterSheet.add(NewGameImage)
            }
            //twitterSheet.a
            
            twitterSheet.add(URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(gameid)Turn\(theTurnNumber).php"))
            
            self.present(twitterSheet, animated: true, completion: nil)
            
        } else {
            /*
            let alert = UIAlertController(title: "Accounts", message: "Please login to Twitter", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            */
            DispatchQueue.main.async(execute: {
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Accounts", subTitle: "Please login to Twitter", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            })
            
            
        }
        
    }
    
    
    func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable: Any])
    {
        
        if TwitterShared {
            DispatchQueue.main.async(execute: {
                self.NewGameProgressHUD.removeFromSuperview()
                self.performSegue(withIdentifier: "Turn_Complete", sender: self)
            })

        } else {
            
            DispatchQueue.main.async(execute: {
                
                
                let theAlert = SCLAlertView()
                
                theAlert.addButton("Facebook", action: {
                    
                    self.FBShared = true
                    
                    self.AddToFaceBook(self.NewGameID.description as NSString, theMediaType: self.MediaType)
                    
                    
                    
                    
                })
                
                theAlert.addButton("Twitter", action: {
                    self.TwitterShared = true
                    self.ShareOnTwitter(self.NewGameID.description as NSString, theMediaType: self.MediaType)
                    
                })
                
                theAlert.addButton("No Thanks", action: {
                    
                    
                    DispatchQueue.main.async(execute: {
                        self.NewGameProgressHUD.removeFromSuperview()
                        self.performSegue(withIdentifier: "Turn_Complete", sender: self)
                    })
                    //self.ShareOnTwitter(self.NewGameID.description, theMediaType: self.MediaType)
                    
                })
                theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Share", subTitle: "Share public game with your friends?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
            })
            
        }
        
        print("sharer didCompleteWithResults, results.count\(results.count)")
        print(results)
        // still cannot get post id from photo upload
    }
    
    
    func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {
        
        
        if TwitterShared {
            DispatchQueue.main.async(execute: {
                self.NewGameProgressHUD.removeFromSuperview()
                self.performSegue(withIdentifier: "Turn_Complete", sender: self)
            })
            
        } else {
            
            DispatchQueue.main.async(execute: {
                
                
                let theAlert = SCLAlertView()
                
                theAlert.addButton("Facebook", action: {
                    
                    self.FBShared = true
                    
                    self.AddToFaceBook(self.NewGameID.description as NSString, theMediaType: self.MediaType)
                    
                    
                    
                    
                })
                
                theAlert.addButton("Twitter", action: {
                    self.TwitterShared = true
                    self.ShareOnTwitter(self.NewGameID.description as NSString, theMediaType: self.MediaType)
                    
                })
                
                theAlert.addButton("No Thanks", action: {
                    
                    
                    DispatchQueue.main.async(execute: {
                        self.NewGameProgressHUD.removeFromSuperview()
                        self.performSegue(withIdentifier: "Turn_Complete", sender: self)
                    })
                    //self.ShareOnTwitter(self.NewGameID.description, theMediaType: self.MediaType)
                    
                })
                theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Share", subTitle: "Share public game with your friends?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
            })
            
        }
        
        
        print("sharer NSError")
     //   print(error.description)
       // print(error.d)
        
    }
    
    func sharerDidCancel(_ sharer: FBSDKSharing!) {
        
        
        if TwitterShared {
            DispatchQueue.main.async(execute: {
                self.NewGameProgressHUD.removeFromSuperview()
                self.performSegue(withIdentifier: "Turn_Complete", sender: self)
            })
            
        } else {
            
            DispatchQueue.main.async(execute: {
                
                
                let theAlert = SCLAlertView()
                
                theAlert.addButton("Facebook", action: {
                    
                    self.FBShared = true
                    
                    self.AddToFaceBook(self.NewGameID.description as NSString, theMediaType: self.MediaType)
                    
                    
                    
                    
                })
                
                theAlert.addButton("Twitter", action: {
                    self.TwitterShared = true
                    self.ShareOnTwitter(self.NewGameID.description as NSString, theMediaType: self.MediaType)
                    
                })
                
                theAlert.addButton("No Thanks", action: {
                    
                    
                    DispatchQueue.main.async(execute: {
                        self.NewGameProgressHUD.removeFromSuperview()
                        self.performSegue(withIdentifier: "Turn_Complete", sender: self)
                    })
                    //self.ShareOnTwitter(self.NewGameID.description, theMediaType: self.MediaType)
                    
                })
                theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Share", subTitle: "Share public game with your friends?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
            })
            
        }
        
        print("sharerDidCancel")
        
    }
    
    
    @IBAction func unwindToNewGame(_ unwindSegue: UIStoryboardSegue) {
        if let blueViewController = unwindSegue.source as? QuoteViewController {
            print("Coming from Quote")
        }
        else if let redViewController = unwindSegue.source as? ImageViewController {
            print("Coming from Image")
        }
        else if let CompleteViewController = unwindSegue.source as? PageIntroViewController {
            print("Coming from Completed")
        }
        else if let theGameStartedViewController = unwindSegue.source as? GameStartedViewController {
            
            let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromRight, UIViewAnimationOptions.showHideTransitionViews]
            
            UIView.transition(from: self.View2Quote, to: self.View1, duration: 0.1, options: animationOptions, completion: nil)
            
            
            self.PicPreview.image = nil
            self.QuoteBox.text = "Enter Your Quote Here"
            self.QuoteBox.textColor = UIColor.lightGray
            self.QuoteBox.textAlignment = .center
            
            print("View is unwinding from Game Started VC, should now move Confirm View and View 1")
            
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.ViewConfirm.center.y = self.ViewConfirm.center.y + 1500
                
                self.ViewConfirmTOP.constant = 1500
                
                self.theView.center.y = self.theView.center.y - 1500
                
                
                /*
                if !self.FromMyGamesView {
                    self.View1TOP.constant = middleY
                } else {
                    self.View1TOP.constant = middleY + 30
                }
                
                */
                
                //  self.View1TOP.constant = middleY
                
            })
            
            
            //view1Top
            let DeviceH = self.view.frame.height
            let middleScreenY = DeviceH / 2
            let middleY = middleScreenY - 250
            
            self.View1TOP.constant = middleY
            self.theView2TOP.constant = 1500
            self.ViewConfirmTOP.constant = 1500
            self.TimeViewTOP.constant = 1500
            self.theViewNumPlayersTOP.constant = 1500
            
            
            print("Coming From GameStartedViewController")
        }
        
    }

    
    

}


extension UIImage {
    func resize(_ scale:CGFloat)-> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width*scale, height: size.height*scale)))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
    func resizeToWidth(_ width:CGFloat)-> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
}

extension NewViewController : GroupPickerViewControllerDelegate {
    func GroupPickerViewControllerFinished(_ newgrouppickerviewController: GroupPickerViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
       // self.GroupData = grouppickerviewController.GroupData
        
        
        //NameData = GroupData[0] as! [(NSString)]
        //println("Member Data Name = \(NameData)")
        //ContactData = GroupData[1] as! [(NSString)]
        //println("Member Data Contact = \(ContactData)")
        
        self.NewGameQuote = newgrouppickerviewController.TheGroup
        
        
        //println("The group \(GroupSelected) was selected")
        
        if self.NewGameQuote != "" {
            self.QuoteSelected = true
        } else {
            self.QuoteSelected = false
        }
        
        //self.performSegueWithIdentifier("Add_Quote", sender: self)
        //= // self.armorBTN.setImage(armorviewController.armorPKimage, forState:.Normal)
        
        
        //= settingsViewController.weaponPKimage
        
    }
}

extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension NewViewController {
    
//}: NewPorQViewControllerDelegate {
    func NewPorQViewControllerFinished(_ newporqviewController: NewPorQViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        self.NewGameQuote = newporqviewController.QuoteSelected
        
        self.QuoteBox.text = newporqviewController.QuoteSelected as String
        
        
        self.StartSegment.selectedSegmentIndex = newporqviewController.PQInt
        
    }
}

extension UIViewController {
    
    func createBlur(_ effectStyle: UIBlurEffectStyle = .dark) {
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            view.backgroundColor = UIColor.clear
            
            let blurView = UIVisualEffectView(effect: UIBlurEffect(style: effectStyle))
            blurView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
            blurView.frame = view.bounds
            
            view.insertSubview(blurView, at: 0)
        }
    }
    
}
