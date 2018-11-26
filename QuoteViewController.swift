//
//  QuoteViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/9/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import StoreKit


protocol QuoteViewControllerDelegate: class {
    func QuoteViewControllerFinished(_ quoteviewController: QuoteViewController)
}


    
   
class QuoteViewController: UIViewController, MPMediaPickerControllerDelegate, AVAudioPlayerDelegate, SKPaymentTransactionObserver, SKProductsRequestDelegate, UIPickerViewDataSource, UIPickerViewDelegate, BrowseAudioViewControllerDelegate {
    
    var DoUploadImage = Bool()
    var IsHandlingAlertMessage = Bool()
    
    @IBOutlet weak var View1BGimage: UIImageView!
    let SentVC = "quoteview"
    var PLAYAUDIO = String()
    var YTComplete = NSString()
    var browseaudioviewcontroller: BrowseAudioViewController = BrowseAudioViewController()
    
    var choosingMusic = Bool()
    //var ImportedAudioURL =
    @IBOutlet weak var choseMusicSubView: UIView!
    @IBOutlet weak var BrowseYTBTN: UIButton!
    var pointsUsed = Bool()
    @IBOutlet var progressView: UIProgressView!
    var YTAudioFile: URL!
    var YTAudioFileTitle = NSString()
    var YTAudioFileArtist = NSString()
    let SaveProgressHUD = ProgressHUD(text: "Saving Turn...")
  
    let SelectSongProgressHUD = ProgressHUD(text: "Loading Song...")
    
    let SelectSongTrimProgressHUD = ProgressHUD(text: "Trimming Audio...")
    var userID = NSString()
    var HasHours = Bool()
    var ShowingPicker = Bool()
    
    @IBOutlet var ShowPickerBTN: UIButton!
    var MinSelected = Int()
    var SecSelected = Int()
    var MinData = Array(0...9)
    var SecData = Array(0...59)
    var HourData = [Int]()
    
    var QorA = NSString()
    
    @IBOutlet weak var QuotetoDrawView: UIView!
    
    @IBOutlet weak var QuoteToDraw: UILabel!
    
    @IBOutlet weak var ShowQuoteView: UIView!
    
    @IBOutlet weak var ShowQuoteView2: UIView!
    
    @IBOutlet weak var ShowQuoteViewTOP: NSLayoutConstraint!
    
    var ShowingQuoteView = Bool()
    
    @IBOutlet weak var chooseMusicView: UIView!
    
    @IBOutlet weak var chooseMusicViewTOP: NSLayoutConstraint!
    
    
    
    @IBOutlet var pickerViewTOP: NSLayoutConstraint!
    
    @IBOutlet var pickerView: UIView!
    
    @IBOutlet var picker: UIPickerView!
    
    @IBOutlet var pickerCloseBTN: UIButton!
    
    let rangeSlider1 = RangeSlider(frame: CGRect.zero)
    let rangeSlider2 = RangeSlider(frame: CGRect.zero)
    
    @IBOutlet var TrackCurrentTimeLBL: UILabel!
    var PlayPushed = Bool()
    
    var MediaType = NSString()
    var Image64Data2 = NSString()
    
    @IBOutlet var TrimAudio: UIButton!
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
    @IBOutlet var TrimStartLBL: UILabel!
    
    @IBOutlet var MediaView: UIView!
    
    @IBOutlet var TrimStopLBL: UILabel!
    var product_id_audio: NSString?;
    

    @IBOutlet var pauseMusic: UIButton!
    let timeInterval:TimeInterval = 0.1
    let timeIntervalReverse:TimeInterval = 1.0
    let timerEnd:TimeInterval = 10.0
    var timeCount:TimeInterval = 0.0
    var timeCountRecord:TimeInterval = 10.0
    
    @IBOutlet var playMusic: UIButton!
    
    @IBOutlet var stopMusic: UIButton!
    
    @IBOutlet var MediaTitleLBL: UILabel!
    @IBOutlet var MediaSlider: UISlider!
    
    @IBOutlet var MediaArtistLBL: UILabel!
    @IBOutlet var MediaLengthLBL: UILabel!
    @IBOutlet var SelectAudioBTN: UIButton!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var saveBTN: UIButton!
    
    @IBOutlet var stopButton: UIButton!
    
    @IBOutlet var playButton: UIButton!
    
    @IBOutlet var statusLabel: UILabel!
    
    var meterTimer:Timer!
    var musicTimer:Timer!
    
    var soundFileURL:URL?
    
    var RecordViewShowing = false
    
    @IBOutlet var MusicSaveBTN: UIButton!
    
    var RecordingTitle = NSString()
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var ViewHowTo = Bool()
    
    @IBOutlet var CloseBTN: UIButton!
    @IBOutlet var ViewHolder: UIView!
    
    @IBOutlet var View1: UIView!
    @IBOutlet var View1TOP: NSLayoutConstraint!
    @IBOutlet var ViewHolderTOP: NSLayoutConstraint!
    @IBOutlet var doneBTNBOTTOM: NSLayoutConstraint!
    @IBOutlet var doneBTN: UIButton!
    
    var fdelegate: QuoteViewControllerDelegate?
    
    @IBOutlet var ViewHolder2: UIView!
    
    @IBOutlet var RecordView1TOP: NSLayoutConstraint!
    @IBOutlet var RecordView1: UIView!
    @IBOutlet var ViewHolder2TOP: NSLayoutConstraint!
    
    
    @IBOutlet var ViewHolderMusic: UIView!
    @IBOutlet var ViewHolderMusicTOP: NSLayoutConstraint!
    
    @IBOutlet var MusicView1: UIView!
    @IBOutlet var MusicView1TOP: NSLayoutConstraint!
    
    let prefs = UserDefaults.standard
    var username = NSString()

    var GameTurn = NSString()
    var GameID_Orig = NSString()
    var GameID = NSString()
    var NewTurn = Int()
    var IsComplete = NSString()
    var TurnNumber = NSString()
    var IsCompleteInfo = NSString()
    var CurTurnNumber = NSString()
    var TheType = NSString()
    var dismissVC = Bool()
    
    var UseImageURL = NSString()
    var TheImageURL = NSString()
    

    @IBOutlet weak var submitBTN: UIButton!
    var AlertType = "yourTurn"
    @IBOutlet weak var ImagePic: UIImageView!
    
    @IBOutlet weak var QuoteBoxtxt: UITextView!
    @IBOutlet weak var QuoteLabel: UILabel!
    
    var TurnInfo = NSString()
    var DeviceTKN = NSString()
    
    var RecordedData = NSString()
    
    @IBOutlet weak var ImageLoading: UIActivityIndicatorView!
    
    @IBOutlet var ActInd: UIActivityIndicatorView!
    
    @IBAction func ImportMusic(_ sender: AnyObject) {
        
        displayMediaPickerAndPlayItem()
    }
    
    @IBAction func HIdeQuoteView(_ sender: AnyObject) {
        
        if ShowingQuoteView {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                // self.ShowQuoteViewTOP.constant = middleY
                
                self.ShowQuoteView.center.y = self.ShowQuoteView.center.y + 1000
                
                self.ShowQuoteViewTOP.constant = 1000
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            ShowingQuoteView = false
        }
    }
    
    
    @IBAction func HideSaveMusicView(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if RecordedMessage {
            submitBTN.setTitle("Submit Audio", for: UIControlState())
            
            QuoteBoxtxt.text = "(Audio Clip)"
            QuoteBoxtxt.textColor = UIColor.lightGray
            QuoteBoxtxt.textAlignment = .center
            
        } else {
              submitBTN.setTitle("Submit Quote", for: UIControlState())
        }
        
        
        
        if MusicViewShowing {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.MusicView1TOP.constant = middleY
                
                self.ViewHolderMusic.center.y = self.ViewHolderMusic.center.y + 1000
                
                self.ViewHolderMusicTOP.constant = 1000
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            
            MusicViewShowing = false
            let CheckAudioReturn = CheckAudioPurchase()
            
            DispatchQueue.main.async(execute: {
            
            if CheckAudioReturn {
                self.QuoteBoxtxt.text = "(Audio Clip)"
                self.QuoteBoxtxt.textColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
                //UIColor.greenColor()
                self.submitBTN.setTitle("Submit Audio", for: UIControlState())

                self.RecordedMessage = true
                
            } else {
                print("its false")
                self.QuoteBoxtxt.text = "Enter Your Quote Here..."
                self.QuoteBoxtxt.textColor = UIColor.lightGray
                self.QuoteBoxtxt.textAlignment = .center
                self.RecordedMessage = false
                self.submitBTN.setTitle("Submit Quote", for: UIControlState())
            }
            
                    
                })
            
              player?.stop()
            myMusicPlayer?.stop()
            myYTPlayer?.stop()
           // StopPlayingAudio()
            
            
            //checkHeadphones()
        }
    }
    
    
    func CheckAudioPurchase() -> Bool {
        
         var CheckReturn = Bool()
        
        if RecordedMessage {
            // @IBAction func shootPhoto(sender: AnyObject) {

            if (prefs.bool(forKey: "AudioPurchased")){
                RecordedMessage = true
                CheckReturn = true
                return CheckReturn

                print("Audio already purchased")
                
            } else if (!prefs.bool(forKey: "AudioPurchased")){
                
                
                var numPoints = 0;
                var LevelUpTime = Bool()
                (numPoints, LevelUpTime) = UPData(self.username, userid: self.userID, type: "get", points: "0", levelpoints: "0")
                //numPoints = FilterUPData(UPurldata)
                print("number of points = \(numPoints)")
                
                if numPoints > 9 {
                
             //   let check = UserStatusCheck(username, status: "audio", action: "check")
                
             //  if check{
                    
                    let theAlert = SCLAlertView()
                    theAlert.addButton("Yes", action: {
                        
                        self.pointsUsed = true
                        
                        self.RecordedMessage = true
                        print("Check Return should be true")
                        
                        
                        self.QuoteBoxtxt.text = "(Audio Clip)"
                        self.QuoteBoxtxt.textColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
                        //UIColor.greenColor()
                        self.submitBTN.setTitle("Submit Audio", for: UIControlState())
                        self.RecordedMessage = true
                        
                        //self.QuoteBoxtxt.text = "(Audio Clip)"
                        //self.QuoteBoxtxt.textColor = UIColor.greenColor()
                        
                        CheckReturn = true

                        
                    })
                    
                    theAlert.addButton("No", action: {
                        
                        
                        
                        
                         DispatchQueue.main.async(execute: {
                        
                        let theAlert2 = SCLAlertView()
                            
                            
                            theAlert2.addButton("Lets do it", action: {
                                
                                self.purchaseitems()
                                
                            })
                            
                        theAlert2.addButton("Later", action: {
                            
                            self.submitBTN.setTitle("Submit Quote", for: UIControlState())
                            
                            self.RecordedMessage = false
                            CheckReturn = false
                            
                            self.QuoteBoxtxt.text = "Enter Your Quote Here..."
                            self.QuoteBoxtxt.textColor = UIColor.lightGray
                            self.QuoteBoxtxt.textAlignment = .center
                            self.RecordedMessage = false
                            self.submitBTN.setTitle("Submit Quote", for: UIControlState())
                            
                        })
                        
                        
                            
                        theAlert2.showCustomOK(UIImage(named: "musicIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Import Audio", subTitle: "Add Audio any time for only $1.99?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                            
                        })
                        
                    })
                        
                    
                    
                     theAlert.showCustomOK(UIImage(named: "musicIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Use your Tokens?", subTitle: "Use 10 tokens to add Audio?  *earn more by starting new games", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                    
                    /*
                    
                    
                    let actionSheetController: UIAlertController = UIAlertController(title: "Use your Tokens!", message: "With \(numPoints) tokens, You have enough tokens to use an audio clip for this turn.  Would you like to use 10 tokens to proceed?", preferredStyle: .Alert)
                    
                    //Create and add the Cancel action
                    // let cancelAction: UIAlertAction = UIAlertAction(title: "No thanks", style: .Cancel) { action -> Void in
                    //Do some stuff
                    //  }
                    //  actionSheetController.addAction(cancelAction)
                    //Create and an option action
                    let yesAction: UIAlertAction = UIAlertAction(title: "Yes", style: .Default) { action -> Void in
                        
                       
                        /*
                        var numPoints = 0;
                        numPoints = UPData(self.username, userid: self.userID, type: "delete", points: "10")
                        //numPoints = FilterUPData(UPurldata)
                        print("number of points = \(numPoints)")
                        */
                        self.pointsUsed = true
                        
                        self.RecordedMessage = true
                        print("Check Return should be true")
                        
                        
                        self.QuoteBoxtxt.text = "(Audio Clip)"
                        self.QuoteBoxtxt.textColor = UIColor.greenColor()
                        self.submitBTN.setTitle("Submit Audio", forState: .Normal)
                        self.RecordedMessage = true
                        
                        //self.QuoteBoxtxt.text = "(Audio Clip)"
                       //self.QuoteBoxtxt.textColor = UIColor.greenColor()
                        
                        CheckReturn = true
                      //  return CheckReturn
                        // Quote = self.RecordedData
                        // self.TheType = "audio"
                        // self.QorA = "Audio Clip"
                        // self.PerformSubmitButton(Quote)
                        
                    }
                    
                    let noAction: UIAlertAction = UIAlertAction(title: "no", style: .Default) { action -> Void in
                        
                        
                        
                        
                        let actionSheetController: UIAlertController = UIAlertController(title: "Add 'Import Audio' to your Toolbox?", message: "Would you like to add the 'Audio Clips' option to your Pencil Toolbox?", preferredStyle: .Alert)
                        
                        //Create and add the Cancel action
                        let cancelAction: UIAlertAction = UIAlertAction(title: "No thanks", style: .Cancel) { action -> Void in
                            //Do some stuff
                            self.submitBTN.setTitle("Submit Quote", forState: .Normal)
                            
                            self.RecordedMessage = false
                                CheckReturn = false
                            
                            self.QuoteBoxtxt.text = "Enter Your Quote Here..."
                            self.QuoteBoxtxt.textColor = UIColor.lightGrayColor()
                            self.QuoteBoxtxt.textAlignment = .Center
                            self.RecordedMessage = false
                            self.submitBTN.setTitle("Submit Quote", forState: .Normal)

                            
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
                    
                    
                  //  {
                    print("Audio not purchased")
                    
                    
                    let check = UserStatusCheck(username, userID: userID, status: "audio", action: "check")
                    
                    if check{
                    
                    /*
                    let actionSheetController: UIAlertController = UIAlertController(title: "Great News!", message: "Right now, For Select users, we are offering a free trial of the option to import Audio and you've been selected.  Try it out. ", preferredStyle: .Alert)
                    
                    //Create and add the Cancel action
                    // let cancelAction: UIAlertAction = UIAlertAction(title: "No thanks", style: .Cancel) { action -> Void in
                    //Do some stuff
                    //  }
                    //  actionSheetController.addAction(cancelAction)
                    //Create and an option action
                    let nextAction: UIAlertAction = UIAlertAction(title: "Thanks", style: .Default) { action -> Void in
                    
                    self.RecordedMessage = true
                        CheckReturn = true
                        
                        self.QuoteBoxtxt.text = "(Audio Clip)"
                        self.QuoteBoxtxt.textColor = UIColor.greenColor()
                        self.submitBTN.setTitle("Submit Audio", forState: .Normal)
                        
                        self.RecordedMessage = true
                        
                        
                    // Quote = self.RecordedData
                    // self.TheType = "audio"
                    // self.QorA = "Audio Clip"
                    // self.PerformSubmitButton(Quote)
                    
                    }
                    
                    actionSheetController.addAction(nextAction)
                    
                    self.presentViewController(actionSheetController, animated: true, completion: nil)
                        
                        
                        */
                        
                        DispatchQueue.main.async(execute: {
                            
                            let theAlert2 = SCLAlertView()
                        
                            
                            theAlert2.addButton("Thanks", action: {
                                
                        self.RecordedMessage = true
                        CheckReturn = true
                        
                        self.QuoteBoxtxt.text = "(Audio Clip)"
                        self.QuoteBoxtxt.textColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
                                //UIColor.greenColor()
                        self.submitBTN.setTitle("Submit Audio", for: UIControlState())
                        
                        self.RecordedMessage = true
                        
                            })
                            
                            theAlert2.showCustomOK(UIImage(named: "musicIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Great News!", subTitle: "Try using audio clips for free!", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                            
                        })

                        
                        
                    
                    } else {
                    
                        
                        /*
                    let actionSheetController: UIAlertController = UIAlertController(title: "Use Audio", message: "Would you like to add the 'Audio Clips' option to your Pencil Toolbox?", preferredStyle: .Alert)
                    
                    //Create and add the Cancel action
                    let cancelAction: UIAlertAction = UIAlertAction(title: "No thanks", style: .Cancel) { action -> Void in
                    //Do some stuff
                    self.submitBTN.setTitle("Submit Quote", forState: .Normal)
                    
                    self.RecordedMessage = false
                        CheckReturn = false
                        
                        self.QuoteBoxtxt.text = "Enter Your Quote Here..."
                        self.QuoteBoxtxt.textColor = UIColor.lightGrayColor()
                        self.QuoteBoxtxt.textAlignment = .Center
                        self.RecordedMessage = false
                        self.submitBTN.setTitle("Submit Quote", forState: .Normal)

                    
                    }
                    actionSheetController.addAction(cancelAction)
                    //Create and an option action
                    let nextAction: UIAlertAction = UIAlertAction(title: "Let's do it", style: .Default) { action -> Void in
                    
                    self.purchaseitems()
                    
                    }
                    
                    actionSheetController.addAction(nextAction)
                    
                    self.presentViewController(actionSheetController, animated: true, completion: nil)
                        */
                        
                        DispatchQueue.main.async(execute: {
                            
                            let theAlert2 = SCLAlertView()
                            
                            theAlert2.addButton("Lets do it", action: {
                                
                                self.purchaseitems()
                                
                            })
                            
                            theAlert2.addButton("No", action: {
                                
                                self.submitBTN.setTitle("Submit Quote", for: UIControlState())
                                
                                self.RecordedMessage = false
                                CheckReturn = false
                                
                                self.QuoteBoxtxt.text = "Enter Your Quote Here..."
                                self.QuoteBoxtxt.textColor = UIColor.lightGray
                                self.QuoteBoxtxt.textAlignment = .center
                                self.RecordedMessage = false
                                self.submitBTN.setTitle("Submit Quote", for: UIControlState())
                                
                            })
                            
                           
                            
                            
                            
                            theAlert2.showCustomOK(UIImage(named: "musicIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Import Audio", subTitle: "Add Audio any time for only $1.99?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                            
                           
                            
                        })
                        
                        
                    }

             //   }
               
           //   }
                
            }
                
        } else {
            
            print("Audio not being used")
            //PerformSubmitButton(Quote)
        }
      }
        return CheckReturn
    }
    
    
    @IBAction func CancelMusicView(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if MusicViewShowing {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.MusicView1TOP.constant = middleY
                
                self.ViewHolderMusic.center.y = self.ViewHolderMusic.center.y + 1000
                
                self.ViewHolderMusicTOP.constant = 1000
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
             RecordedMessage = false
            MusicViewShowing = false
            //checkHeadphones()
        }
    }
    @IBAction func ShowMusicView(_ sender: AnyObject) {
        
     ShowMusicViewNow()
        
    }
        func ShowMusicViewNow() {
        
      //  if !choosingMusic {
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            self.chooseMusicViewTOP.constant = 1000
            
            self.chooseMusicView.center.y = self.chooseMusicView.center.y + 1000
            
          //  self.ViewHolderMusicTOP.constant = 0
            //self.ViewShowing = true
            // ShowingInfo = true
            
            // self.ViewTransTOP.constant = 0
        })
       choosingMusic = false
        
        
        if !MusicViewShowing {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.MusicView1TOP.constant = middleY
                
                self.ViewHolderMusic.center.y = self.ViewHolderMusic.center.y - 1000
                
                self.ViewHolderMusicTOP.constant = 0
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            
            
       
            
            MusicViewShowing = true
            stopMusic.isEnabled = false
            pauseMusic.isEnabled = false
            
            MusicSaveBTN.isEnabled = false
            
            if SelectedYTAudio {
                
            } else {
                
            playMusic.isEnabled = false
            TrimAudio.isEnabled = false
            }
            //checkHeadphones()
        }
    }
    
    @IBAction func ShowChooseMusicView(_ sender: AnyObject) {
    
    let DeviceH = self.view.frame.height
    let middleScreenY = DeviceH / 2
    let middleY = middleScreenY - 200
    

    if !choosingMusic {
    UIView.animate(withDuration: 1.0, animations: { () -> Void in
    
    self.chooseMusicView.center.y = self.chooseMusicView.center.y - 1000
    
    self.chooseMusicViewTOP.constant = 0     //self.ViewShowing = true
    // ShowingInfo = true
    
    // self.ViewTransTOP.constant = 0
    })
        choosingMusic = true
    }  //  }
    }
    
    @IBAction func closeImageSelect(_ sender: AnyObject) {
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            self.chooseMusicViewTOP.constant = 1000
            
            self.chooseMusicView.center.y = self.chooseMusicView.center.y + 1000
           
        })
        choosingMusic = false
        
    }
    @IBAction func BrowseYTBTN(_ sender: AnyObject) {
        
       // pe
        self.performSegue(withIdentifier: "browseAudio", sender: self)
    

    UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            self.chooseMusicViewTOP.constant = 1000
            
            self.chooseMusicView.center.y = self.chooseMusicView.center.y + 1000
            
            //  self.ViewHolderMusicTOP.constant = 0
            //self.ViewShowing = true
            // ShowingInfo = true
            
            // self.ViewTransTOP.constant = 0
        })
        choosingMusic = false
    }
    
    @IBAction func ShowRecordView(_ sender: AnyObject) {

            let DeviceH = self.view.frame.height
            let middleScreenY = DeviceH / 2
            let middleY = middleScreenY - 200
        
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            self.chooseMusicViewTOP.constant = 1000
            
            self.chooseMusicView.center.y = self.chooseMusicView.center.y + 1000
            
            //  self.ViewHolderMusicTOP.constant = 0
            //self.ViewShowing = true
            // ShowingInfo = true
            
            // self.ViewTransTOP.constant = 0
        })
        choosingMusic = false
        
            if !RecordViewShowing {
                UIView.animate(withDuration: 1.0, animations: { () -> Void in
                    
                    self.RecordView1TOP.constant = middleY
                    
                    self.ViewHolder2.center.y = self.ViewHolder2.center.y - 1000
                    
                    self.ViewHolder2TOP.constant = 0
                    //self.ViewShowing = true
                    // ShowingInfo = true
                    
                    // self.ViewTransTOP.constant = 0
                })
                playMusic.isEnabled = false
                stopMusic.isEnabled = false
                 RecordViewShowing = true
                checkHeadphones()
            }
    }
    
    @IBAction func CancelRecordView(_ sender: AnyObject) {
        
        
        if RecordedMessage {
            submitBTN.setTitle("Submit Audio", for: UIControlState())
        } else {
            submitBTN.setTitle("Submit Quote", for: UIControlState())
        }
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if RecordViewShowing {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.RecordView1TOP.constant = middleY
                
                self.ViewHolder2.center.y = self.ViewHolder2.center.y + 1000
                
                self.ViewHolder2TOP.constant = 1000
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
           
             RecordedMessage = false
            RecordViewShowing = false
        }
        
        
    }
    
    @IBAction func HideRecordView(_ sender: AnyObject) {
        
        if RecordedMessage {
            submitBTN.setTitle("Submit Audio", for: UIControlState())
        } else {
            submitBTN.setTitle("Submit Quote", for: UIControlState())
        }
        
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if RecordViewShowing {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.RecordView1TOP.constant = middleY
                
                self.ViewHolder2.center.y = self.ViewHolder2.center.y + 1000
                
                self.ViewHolder2TOP.constant = 1000
           
            })
            
            var url:URL?
            if self.recorder != nil {
                url = self.recorder.url
            
            print("playing \(url)")
            
         //   let error: NSError?
            
        
            var recordedFile = Data()
        
            do {

           recordedFile =  try! Data(contentsOf: url!)

                
            } catch {
            print(error)
                RecordedMessage = false
                print("Recorded Message Error")
            }

                  let RecordedDataPrelim = recordedFile.base64EncodedString(options: [])

                
           
                
                self.RecordedData = RecordedDataPrelim as NSString
  
            RecordedMessage = true
                let CheckAudioReturn = CheckAudioPurchase()
                
                
                
                if CheckAudioReturn {
                    self.QuoteBoxtxt.text = "(Audio Clip)"
                    self.QuoteBoxtxt.textColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
                    //UIColor.greenColor()
                    
                } else {
                    print("its false")
                    self.QuoteBoxtxt.text = "Enter Your Quote Here"
                    self.QuoteBoxtxt.textColor = UIColor.lightGray
                    self.QuoteBoxtxt.textAlignment = .center
                    
                }

                
            }  else {
                print("cancelling record view")
               // url = self.soundFileURL!
            }
            RecordViewShowing = false
        }
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        if GameID_Orig == "demo" {
            
            MediaType = "quote"
            UseImageURL = "no"
            //Image64Data = "This is your Demo Quote"
            ImagePic.image = UIImage(named: "CharacterPirate.png")!
            ImagePic.contentMode = UIViewContentMode.scaleAspectFit
            TheImageURL = "NA"
            
            ImagePic.layer.cornerRadius = 0
            
            ImageLoading.stopAnimating()
            
        } else {
        
        print("Selected YT Audio = \(SelectedYTAudio)")
        print("YT Complete = \(YTComplete)")
        // ShowPickerBTN.enabled = false
        ImageLoading.startAnimating();
        
        (Image64Data2, MediaType, UseImageURL, TheImageURL) = GetGameData(GameID_Orig, turn: GameTurn)
        
       // print("Image64Data2 = \(Image64Data2)")
        
        if UseImageURL == "no" {

        let Image64NSData = Data(base64Encoded: Image64Data2 as String, options: NSData.Base64DecodingOptions(rawValue: 0))
        
        
      //  print("Image64NSData = \(Image64NSData!)")
        
        let Image64Data = NSString(data: Image64NSData!, encoding: String.Encoding.utf8.rawValue)!
    
        print("IMAGE 64 DATA =           \(Image64Data)")
        
        
      let decodedData = Data(base64Encoded: Image64Data as String, options: NSData.Base64DecodingOptions(rawValue: 0))
        

        print("DECODED DATA =         \(decodedData)")
        print("Setting Image")
        
        let image = UIImage(data: decodedData!)
         
        
        
        ImagePic.image = image
            
        ImagePic.contentMode = UIViewContentMode.scaleAspectFit
            
        ImagePic.layer.cornerRadius = 0
        
        ImageLoading.stopAnimating()
            
            
            
        } else {
            
            var TheImageURL2 = NSString()
            
            
            
            if MediaType == "gif" {
            
                print("Get GIF from URL")
                
            TheImageURL2 = "\(TheImageURL).gif" as NSString
            let url = URL(string: TheImageURL2 as String)
            let data = try? Data(contentsOf: url!)
                
                ImagePic.image = UIImage.animatedImage(withAnimatedGIFData: data)
               
            } else {
            
           TheImageURL2 = "\(TheImageURL).jpg" as NSString
            
            
            
            print("Get image from URL")
            let url = URL(string: TheImageURL2 as String)
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
            ImagePic.image = UIImage(data: data!)
            ImagePic.contentMode = UIViewContentMode.scaleAspectFit
            
        }
            
        }
        
            ImagePic.layer.cornerRadius = 0
            
              DispatchQueue.main.async(execute: {
            
            self.ImageLoading.stopAnimating()
                
            })

            //ADD Function to get URL
        }
        
        
        
        
        
        
        /*
        if GameID_Orig == "demo" {
        
      //  if !ShowingQuoteView {
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                
                // self.ShowQuoteViewTOP.constant = middleY
                
                self.ShowQuoteView.center.y = self.ShowQuoteView.center.y - 1000
                
                self.ShowQuoteViewTOP.constant = 0
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            ShowingQuoteView = true
       // }
        
        }
        */
        
    }
    
    override func viewDidLoad() {
        pickerView.layer.cornerRadius = 5
        self.View1BGimage.layer.cornerRadius = 5
        self.View1BGimage.layer.masksToBounds = true
        View1.layer.cornerRadius = 5
        View1.layer.masksToBounds = true
        browseaudioviewcontroller.browseaudiodelegate=self
       
        self.progressView.isHidden = true
        
        product_id_audio = "com.ClavenSolutions.TelePictionary.paudion"
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        choseMusicSubView.layer.cornerRadius = 10
        SKPaymentQueue.default().add(self)
        
        picker.dataSource = self
        picker.delegate = self
        
        ShowQuoteView2.layer.cornerRadius = 10
        ShowQuoteView2.layer.masksToBounds = true
     
        
        ShowQuoteView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        
        MusicSaveBTN.isHidden = true
        playMusic.isHidden = true
        TrimAudio.isHidden = true
        stopMusic.isHidden = true
        pauseMusic.isHidden = true
        ShowPickerBTN.isHidden = true
        
        /*
        if SongTitle.isEqualToString("") {
        MediaLengthLBL.text = "Please Select An Audio File"
        }
        */
        ActInd.stopAnimating();
        ActInd.isHidden = true
        rangeSlider2.trackHighlightTintColor = UIColor.red
        rangeSlider2.curvaceousness = 0.0
        
        //rangeSlider1.lowerValue = (rangeSlider1.upperValue - 10.0)
        
        MusicView1.addSubview(rangeSlider1)
       // MusicView1.addSubview(rangeSlider2)
        
        rangeSlider1.addTarget(self, action: #selector(QuoteViewController.rangeSliderValueChanged(_:)), for: .valueChanged)
        rangeSlider1.isHidden = true
        TrimAudio.layer.cornerRadius = 10
        
        MediaSlider.minimumValue = 0
        MediaSlider.isHidden = true
        saveBTN.layer.cornerRadius = 10
        RecordView1.layer.cornerRadius = 10
        
        chooseMusicView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        
        ViewHolder.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        
        ViewHolder2.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        
        ViewHolderMusic.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        
        MusicView1.layer.cornerRadius = 10
        
        dismissVC = true
    
        /*
        
        var Image64Data = GetGameData(GameID_Orig, GameTurn)
        
        
        let decodedData = NSData(base64EncodedString: Image64Data as! String, options: NSDataBase64DecodingOptions(rawValue: 0))
        
        
        println("Decoded Data: \(decodedData)")
        println("Setting Image")
        
        let image = UIImage(data: decodedData!)


        ImagePic.image = image
*/
        MediaView.layer.cornerRadius = 10
       // ImagePic.image = UIImage(named: "pencilpic.png")
        // Do any additional setup after loading the view.
        
        SelectAudioBTN.layer.cornerRadius = 10
        MusicSaveBTN.layer.cornerRadius = 10
        
        ImagePic.layer.cornerRadius = 5
        ImagePic.layer.borderWidth = 2
        ImagePic.layer.backgroundColor = UIColor.white.cgColor
        ImagePic.layer.borderColor = UIColor.lightGray.cgColor
        ImagePic.clipsToBounds = true
        ImagePic.layer.masksToBounds = true
        
        QuoteBoxtxt.layer.cornerRadius = 5
        
        submitBTN.layer.cornerRadius = 5
        submitBTN.layer.borderWidth = 2
        submitBTN.layer.borderColor = UIColor.white.cgColor
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(QuoteViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        if GameID_Orig == "demo" {
            username = "demoName"
            userID = "demoID"
        } else {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
        }

        
        //username = prefs.valueForKey("USERNAME") as! NSString as String
       // userID = prefs.valueForKey("PLAYERID") as! NSString as String
        
        switch GameTurn {
        case "1":
            TurnNumber = "Turn1"
            NewTurn = 2
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(QuoteViewController.keyboardWasShown(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(QuoteViewController.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        
        doneBTN.layer.cornerRadius = 10
        
        QuoteBoxtxt.text = "Enter Your Quote Here..."
        QuoteBoxtxt.textColor = UIColor.lightGray
        QuoteBoxtxt.textAlignment = .center
        View1.layer.cornerRadius = 10
        CloseBTN.layer.cornerRadius = 10
        
        
        ViewHolder.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
      
        let AlreadySeenHowTo = prefs.bool(forKey: "DidShowHowTo_Quote")
        
        if !AlreadySeenHowTo {
            
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            self.View1TOP.constant = middleY
            
            self.ViewHolder.center.y = self.ViewHolder.center.y - 1000
            
            self.ViewHolderTOP.constant = 0
            //self.ViewShowing = true
            // ShowingInfo = true
            
            // self.ViewTransTOP.constant = 0
            self.ViewHowTo = true
        })
      }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "StopTimerNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(QuoteViewController.YTCompleteTrim(_:)), name: NSNotification.Name(rawValue: "YTTrim"), object: nil);
         NotificationCenter.default.addObserver(self, selector: #selector(QuoteViewController.HandleAlertMessageQVC(_:)), name: NSNotification.Name(rawValue: "HandleAlertMessageQVC"),  object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(QuoteViewController.displayForegroundDetails), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
       
    }
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    /*
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "PostData", object: nil);
        
    }
*/
    
    func YTCompleteTrim(_ notification:Notification){
        
        let resultdict = (notification as NSNotification).userInfo
            
            //as! NSDictionary
        print("Result Dict: \(resultdict)")
        // let data : NSArray = resultdict.objectForKey("data") as! NSArray
        
       // let Audiodata  = resultdict!["data"] as! NSURL
        
        //print("Audio Data = \(Audiodata)")
        
        self.YTAudioFile = resultdict!["data"] as! URL
        self.YTAudioFileTitle = resultdict!["title"] as! NSString
        self.YTAudioFileArtist = ""
        print("Audio Data = \(self.YTAudioFile)")
        self.SelectedYTAudio = true
        self.PLAYAUDIO = "yt"
        YTAudioMusic()
        ShowMusicViewNow()
        
        
        //let data = notification.userInfo.
        
        //   ObjectForKey("data") as [AlbumModel];
       
    }

    
    
    @IBAction func View1CloseBTN(_ sender: AnyObject) {
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if ViewHowTo {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.View1TOP.constant = middleY
                
                self.ViewHolder.center.y = self.ViewHolder.center.y + 1000
                
                self.ViewHolderTOP.constant = 1000
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            
            ViewHowTo = false
        }
  
        self.prefs.set(true, forKey: "DidShowHowTo_Quote")
      
    }
    
    @IBAction func ViewHowTo(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if !ViewHowTo {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.View1TOP.constant = middleY
                
                self.ViewHolder.center.y = self.ViewHolder.center.y - 1000
                
                self.ViewHolderTOP.constant = 0
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            
            ViewHowTo = true
        }
        
    }
    
    
    func keyboardWasShown(_ notification: Notification) {
        
        submitBTN.isHidden = true
        
        var info = (notification as NSNotification).userInfo!
        
        
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            //  self.textBoxBOTTOM.constant = keyboardFrame.size.height + 10
            
            
            //self.emailBOTTOM.constant = (keyboardFrame.size.height - 160) + 15
            
            
            //self.QuoteLabelTop.constant = 50
            //self.qbDoneBOTTOM.constant = (keyboardFrame.size.height + 5) + self.GameTitleTXT.frame.size.height
            
            self.doneBTNBOTTOM.constant = keyboardFrame.size.height + 5
        })
        
               
        if QuoteBoxtxt.text == "Enter Your Quote Here..." || QuoteBoxtxt.text == "(Audio Clip)" {
            //if NewGameQuote.isEqualToString("Enter Your Quote Here") {
            //(StartSegment.subviews[0] as! UIView).tintColor = UIColor.greenColor()
            QuoteBoxtxt.text = ""
            QuoteBoxtxt.textColor = UIColor.black
            QuoteBoxtxt.textAlignment = .center
        }
    }
    
    
    func keyboardWillHide(_ notification: Notification) {
        submitBTN.isHidden = false
        
       // var info = notification.userInfo!
        
        
    //    let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
           // self.textBoxBOTTOM.constant = 5
            
            
          //  self.emailBOTTOM.constant = 10
            //self.QuoteLabelTop.constant = 50
            //self.qbDoneBOTTOM.constant = (keyboardFrame.size.height + 5) + self.GameTitleTXT.frame.size.height
            
            self.doneBTNBOTTOM.constant = -100
        })
        
        if QuoteBoxtxt.text.isEmpty || QuoteBoxtxt.text == "Enter Your Quote Here..." {
            
            if QuoteBoxtxt.text == "(Audio Clip)" {
                QuoteBoxtxt.text = "(Audio Clip)"
                QuoteBoxtxt.textColor = UIColor.lightGray
                QuoteBoxtxt.textAlignment = .center
            } else {//if NewGameQuote.isEqualToString("Enter Your Quote Here") {
            //(StartSegment.subviews[0] as! UIView).tintColor = UIColor.greenColor()
            QuoteBoxtxt.text = "Enter Your Quote Here..."
            QuoteBoxtxt.textColor = UIColor.lightGray
            QuoteBoxtxt.textAlignment = .center
            }
        }
        
      
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func SubmitButton(_ Quote: NSString) {
        
       //
       // var GameType = NSString()
        
        var Quote:NSString = QuoteBoxtxt.text as NSString
        
        let turnStyle = "quote"
        
        
        if RecordedMessage {
            // @IBAction func shootPhoto(sender: AnyObject) {
            
            Quote = RecordedData
            TheType = "audio"
            QorA = "Audio Clip"
            
            print("point used = \(pointsUsed)")
            if pointsUsed {
                // var numPoints = 0;
                let TakePoints = UPData(self.username, userid: self.userID, type: "delete", points: "10", levelpoints: "0")
                //numPoints = FilterUPData(UPurldata)
                print("number of points after use = \(TakePoints)")
            }            //overlayView.hidden = true
            
        } else {
            
            TheType = "quote"
            QorA = "Quote"
            
        }
        
        
        if ( Quote.isEqual(to: "") || Quote.isEqual(to: "Enter Your Quote Here...") ) {
            
            /*
            var alertview = JSSAlertView().show(self, title: "Please enter your quote describing the picture below", buttonText: "Ok", color: UIColorFromHex(0x66b2ff, alpha:1))
            alertview.setTextTheme(.Light)
            */
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Error!"
            alertView.message = "Please enter your quote describing the picture below."
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
           // alertView.show()
            
            
           // let theAlert = SCLAlertView()
           // theAlert.addButton("Ok") {
           // }
            //theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.99, green: 0.69, blue: 0.35, alpha: 1.0), title: "Quote?", subTitle: "You forgot to enter a quote..")
            
            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Quote?", subTitle: "You forgot to enter a quote..", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
            
        } else {
            
            let theAlert = SCLAlertView()
            theAlert.addButton("Yes") {
                self.view.addSubview(self.SaveProgressHUD)
                
                /*dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                */
                
                DispatchQueue.main.async(execute: {
                    
                    
                    self.StartSubmitButton(Quote, turnStyle: turnStyle as NSString)
                    //self.ActInd.stopAnimating()
                    //  });
                })
            }
            theAlert.addButton("Not yet") {
            }
           // theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Submit", subTitle: "Are you sure you want to submit this \(QorA)?")
            
            theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Submit?", subTitle: "Are you sure you want to submit this \(QorA)?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
            
      

            /*
            
            let alertController = UIAlertController(title: "Submit \(QorA)?", message: "Are you sure you want to submit this \(QorA)?", preferredStyle: .Alert)
            let CancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action:UIAlertAction) in
                print("Cancel button pressed")
                
            }
            
            alertController.addAction(CancelAction);
        
            let OkAction = UIAlertAction(title: "Yes", style: .Default) { (action:UIAlertAction) in
                print("OK button pressed")
        
       
                
       // self.progressView.setProgress(0, animated: true)
       // self.progressView.hidden = false
                
        self.view.addSubview(self.SaveProgressHUD)
      
                /*dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            */
                
                dispatch_async(dispatch_get_main_queue(), {


            self.StartSubmitButton(Quote, turnStyle: turnStyle)
            //self.ActInd.stopAnimating()
      //  });
                })
                
            }
                alertController.addAction(OkAction);
                
                alertController.view.tintColor = UIColor.blackColor();
                //alertController.view.backgroundColor = UIColor(red: 0.4, green: 1, blue: 0.69, alpha: 1.0)
                /*
                var subView = alertController.view.subviews.first as! UIView
                var contentView = subView.subviews.first as! UIView
                var contentView2 = subView.subviews.last as! UIView
                
                contentView.backgroundColor = UIColor(red: 0.807, green: 0.576, blue: 0.58, alpha: 1.0)
                contentView.tintColor = UIColor(red: 0.929, green: 0.113, blue: 0.145, alpha: 1.0)
                // contentView.
                contentView2.tintColor = UIColor(red: 0.929, green: 0.113, blue: 0.145, alpha: 1.0)
                */
                
            
                self.presentViewController(alertController, animated: true, completion: nil)
                
                
         //   }
            
            
        //    ActInd.stopAnimating();
            
            
            */
            print("Turn Complete Segue")
        
        
    }
    
    
}
    
    func StartSubmitButton(_ Quote: NSString, turnStyle: NSString) {
       // ActInd
       // ActInd.hidden = false
      //  ActInd.startAnimating();

        var GameType = NSString()
         //   let progressHUD = ProgressHUD(text: "Saving Game Data")
         //   self.view.addSubview(progressHUD)
                
        var post = NSString()
                
        if self.TheType == "audio" {
            
            
            DoUploadImage = true
            
            
            if DoUploadImage {
                
                if GameID_Orig != "demo" {
                
                print("SHOULD UPLOAD IMAGE NOW")
                print("BASE 64 DATA IS = \(Quote)")
                UploadGameFileData(Quote as String, FileName: "Game\(self.GameID_Orig)\(self.TurnNumber)", Type: "audio")
                
                }
                // UploadGameFile(imageData, FileName: "TestTurn1")
            } else {
                
                let TempImageCurrent = CreateTempImage(Quote as String)
                
                DispatchQueue.main.async(execute: {
                
                UploadGameFile(TempImageCurrent, FileName: "Game\(self.GameID_Orig)\(self.TurnNumber)", Type: "image")
                    
                })
                
                
            }

            
        let post_old:NSString = "GameID=\(self.GameID_Orig)&TurnNumber=\(self.TurnNumber)&IsComplete=\(self.IsCompleteInfo)&NewTurn=\(self.NewTurn)&turnstyle=\(turnStyle)&username=\(self.username)&mediatype=\(self.TheType)&userID=\(userID)" as NSString
            
            post = post_old.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
            
            
           //UNCOMMENT TO INSERT AUDIO RAW DATA
           // post = "\(post)&ImageData=\(Quote)"
            post = "\(post)&ImageData=Game\(self.GameID_Orig)\(self.TurnNumber)" as NSString
            
            print("AUDIO POST = \(post)")
            
                    
            } else {
            
            
            
            
            let TempImageCurrent = CreateTempImage(Quote as String)
            
            //dispatch_async(dispatch_get_main_queue(), {
                
                UploadGameFile(TempImageCurrent, FileName: "Game\(self.GameID_Orig)\(self.TurnNumber)", Type: "image")
                
            //})
            
            
            
            let post_old:NSString = "GameID=\(self.GameID_Orig)&TurnNumber=\(self.TurnNumber)&IsComplete=\(self.IsCompleteInfo)&NewTurn=\(self.NewTurn)&turnstyle=\(turnStyle)&username=\(self.username)&mediatype=\(self.TheType)&ImageData=\(Quote)&userID=\(userID)" as NSString
            
            post = post_old.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
            
            print("QUOTE POST = \(post)")
           // post = "\(post)&ImageData=\(Quote)"
            
                }
            
            
        //NSLog("PostData: %@",post);
        
        let url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/UpdateGame.php")!
        
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
        } catch {
            fatalError()
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
                
                
                self.TurnInfo = jsonData.value(forKey: "turn") as! NSString
                
                self.DeviceTKN = jsonData.value(forKey: "token") as! NSString
                
               // var tokenNew = DeviceTKN.stringByReplacingOccurrencesOfString("'", withString: "")
                self.CurTurnNumber = jsonData.value(forKey: "turnInfo") as! NSString
                
                GameType = jsonData.value(forKey: "gametype") as! NSString
                
                print("JSON TurnInfo - \(self.TurnInfo)")
                

                
             //   SendTurnNotice(TurnInfo, DeviceTKN, GameID_Orig, CurTurnNumber, AlertType)
                
                
                //[jsonData[@"success"] integerValue];
                
                //NSLog("Success: %ld", success);
                
                if(success == 1)
                {
                    //NSLog("Sign Up SUCCESS");

                    
              
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Success!"
                    alertView.message = "Your \(self.QorA) has been saved."
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                   // alertView.show()
                    
                    
               
                    if GameID_Orig != "demo" {
                        
                        let GameData = MyTurnsCount(username, userID: userID)
                    
                    
                    if self.TurnInfo == "NA" && self.DeviceTKN == "NA" && self.CurTurnNumber == "NA" && GameType == "NA" {
                        print("Game Complete Notice Sent")
                        
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Game Complete!"
                        alertView.message = "You have completed this game.  All Players have been sent a notice that the game is complete."
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        //alertView.show()
                        
                        
                        
                        let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc: UIViewController = sb.instantiateViewController(withIdentifier: "start") as UIViewController
                        
                        let window = UIApplication.shared.windows[0] as UIWindow;
                        
                        /* UIView.transition.FromView(window.rootViewController.view, toView: vc.view, duration: 0.65, options .TransitionCrossDissolve, completion: { finished in window.rootViewController = vc })
                        */
                        
                        self.SaveProgressHUD.removeFromSuperview()
                        self.progressView.isHidden = true
                        self.QuoteBoxtxt.text = ""
                        
                        //  self.dismissViewControllerAnimated(true, completion: {
                        
                        
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "DismissVC"), object: nil, userInfo: nil);
                        //   dispatch_async(dispatch_get_main_queue(), {
                        
                        self.dismiss(animated: true, completion: nil)
                        
                        
                        /*
                        UIView.transitionFromView((window.rootViewController?.view)!, toView: vc.view, duration: 0.65, options: .TransitionCrossDissolve, completion: {
                            
                            
                            
                            
                            finished in window.rootViewController = vc
                            
                          //  SendTurnNotice(self.TurnInfo, token: self.DeviceTKN, gameid: self.GameID_Orig, turninfo: self.CurTurnNumber, alertType: self.AlertType, gameType: GameType, turninfoID: "test")
                            
                        })

                        */
                        
                        
                        
                        
                    } else {
                    
                    /*
                        SendTurnNotice(self.TurnInfo, token: self.DeviceTKN, gameid: self.GameID_Orig, turninfo: self.CurTurnNumber, alertType: self.AlertType, gameType: GameType, turninfoID: "test")
                        */
                        
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Success!"
                        alertView.message = "Your \(self.QorA) has been saved."
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        
                        alertView.tintColor = UIColor.green
                        
                         //alertView.show()
                        
                        
                        
                        
                        
                        
                        let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc: UIViewController = sb.instantiateViewController(withIdentifier: "start") as UIViewController
                        
                        let window = UIApplication.shared.windows[0] as UIWindow;
                        
                        /* UIView.transition.FromView(window.rootViewController.view, toView: vc.view, duration: 0.65, options .TransitionCrossDissolve, completion: { finished in window.rootViewController = vc })
                        */
                        
                        self.SaveProgressHUD.removeFromSuperview()
                        self.progressView.isHidden = true
                        self.QuoteBoxtxt.text = ""
                        
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "DismissVC"), object: nil, userInfo: nil);
                        
                          self.dismiss(animated: true, completion: {
                        
                     //   UIView.transitionFromView((window.rootViewController?.view)!, toView: vc.view, duration: 0.65, options: .TransitionCrossDissolve, completion: {
                            
                            
                            
                            
                         //   finished in window.rootViewController = vc
                            
                            
                            
                        
                          SendTurnNotice(self.TurnInfo, token: self.DeviceTKN, gameid: self.GameID_Orig, turninfo: self.CurTurnNumber, alertType: self.AlertType as NSString, gameType: GameType, turninfoID: "test", myID: self.userID)
                            
                        })
                        /*
                        let AC = JSController("Success!", "Your Quote has been saved.","Green")
                        self.presentViewController(AC, animated: true, completion: nil)
                        */
                        
                        
                    }
                   
                    } else {
                        self.dismiss(animated: true, completion: nil)
                    }
                   /*
                    let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc: UIViewController = sb.instantiateViewControllerWithIdentifier("start") as UIViewController
                    
                    let window = UIApplication.sharedApplication().windows[0] as UIWindow;
                    
                    /* UIView.transition.FromView(window.rootViewController.view, toView: vc.view, duration: 0.65, options .TransitionCrossDissolve, completion: { finished in window.rootViewController = vc })
                    */
                    
                    self.SaveProgressHUD.removeFromSuperview()
                    self.progressView.hidden = true
                    self.QuoteBoxtxt.text = ""
                    
                    //  self.dismissViewControllerAnimated(true, completion: {
                    
                    UIView.transitionFromView((window.rootViewController?.view)!, toView: vc.view, duration: 0.65, options: .TransitionCrossDissolve, completion: {
                    
                    
                    
                    
                    finished in window.rootViewController = vc
                    
                    SendTurnNotice(self.TurnInfo, token: self.DeviceTKN, gameid: self.GameID_Orig, turninfo: self.CurTurnNumber, alertType: self.AlertType, gameType: GameType, turninfoID: "test")
                    
                    })
                    
                    */
                    
                    
                  } else {
                    var error_msg:NSString
                    
                    if jsonData["error_message"] as? NSString != nil {
                        error_msg = jsonData["error_message"] as! NSString
                    } else {
                        error_msg = "Unknown Error"
                    }
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Error!"
                    alertView.message = error_msg as String
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                    
                }
                
            } else {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Error!"
                alertView.message = "Connection Failed"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
            }
        }  else {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Error!"
            alertView.message = "Connection Failure"
            if let error = reponseError {
                alertView.message = (error.localizedDescription)
            }
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
        }
            
        //    dispatch_async(dispatch_get_main_queue()) {
               // self.performSegueWithIdentifier("Turn_Complete", sender: self)
                
                
                //self.performSegueWithIdentifier("Turn_Complete", sender: self)
                /*
                let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: UIViewController = sb.instantiateViewControllerWithIdentifier("start") as UIViewController
                
                let window = UIApplication.sharedApplication().windows[0] as UIWindow;
                
                /* UIView.transition.FromView(window.rootViewController.view, toView: vc.view, duration: 0.65, options .TransitionCrossDissolve, completion: { finished in window.rootViewController = vc })
                */
                
                self.SaveProgressHUD.removeFromSuperview()
                self.progressView.hidden = true
                self.QuoteBoxtxt.text = ""
                
              //  self.dismissViewControllerAnimated(true, completion: {
                    
                    UIView.transitionFromView((window.rootViewController?.view)!, toView: vc.view, duration: 0.65, options: .TransitionCrossDissolve, completion: {finished in window.rootViewController = vc })
             //   })
                */
              //  }
            
                
        }
            
           
   // }
    
    func DismissKeyboard(){
        view.endEditing(true)
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func canPerformUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, withSender sender: Any) -> Bool {
        return true
    }
    
    
    @IBAction func BackButton(_ sender: AnyObject) {
        
        
        print("dismiss VC from quote view = \(dismissVC)")
        ///Users/jaredstevens1/Desktop/IOS Projects/Pics&Quotes/TelePictionary/TelePictionary
        dismissVC = true
        
        
        let theAlert = SCLAlertView()
        
        theAlert.addButton("Go To Menu") {
            
            self.dismissVC = true
            
            print("trying to perform go back button")
             NotificationCenter.default.post(name: Notification.Name(rawValue: "DismissVC"), object: nil, userInfo: nil);
            // self.dismissViewControllerAnimated(true, completion: nil)
            
            if self.GameID_Orig != "demo" {
                
                
                
                /*
                
                let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: UIViewController = sb.instantiateViewControllerWithIdentifier("start") as UIViewController
                
                let window = UIApplication.sharedApplication().windows[0] as UIWindow;
                
                UIView.transitionFromView((window.rootViewController?.view)!, toView: vc.view, duration: 0.65, options: .TransitionCrossDissolve, completion: {
                
                
                
                
                finished in window.rootViewController = vc
                
                //  SendTurnNotice(self.TurnInfo, token: self.DeviceTKN, gameid: self.GameID_Orig, turninfo: self.CurTurnNumber, alertType: self.AlertType, gameType: GameType, turninfoID: "test")
                
                })
                
                */
                
                
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
        
        
        
        
        print("dismiss VC from quote view = \(dismissVC)")
        ///Users/jaredstevens1/Desktop/IOS Projects/Pics&Quotes/TelePictionary/TelePictionary
        dismissVC = true
        
  
        
    
        /*
        if GameID_Orig != "demo" {
            
           
            
            
              self.performSegueWithIdentifier("Turn_Complete", sender: self)
        
    } else {
    self.dismissViewControllerAnimated(true, completion: nil)
    }
    
        */
        
    }
    func updateAudioMeter(_ timer:Timer) {
        
        
        if recorder.isRecording {
            //let min = Int(recorder.currentTime / 60)
            //let sec = Int(recorder.currentTime % 60)
            //let s = String(format: "%02d:%02d", min, sec)
            //statusLabel.text = s
            //timeCount = 10
            timeCountRecord = timeCountRecord - timeInterval
            let min = Int(timeCountRecord / 60)
            let sec = Int(timeCountRecord.truncatingRemainder(dividingBy: 60))
            
            let s2 = String(format: "%02d:%02d", min, sec)
            //let s2 = timeCountRecord.description
            statusLabel.text = s2
            if (timeCountRecord <  5) {
                statusLabel.textColor = UIColor.red
            } else {
                statusLabel.textColor = UIColor.white
            }
            if (timeCountRecord <= 0) {
            //if (timeCount >= timerEnd) {
                
                recorder.stop()
                print("Exceeded 10 seconds")
            }
            
            recorder.updateMeters()
            // if you want to draw some graphics...
            //var apc0 = recorder.averagePowerForChannel(0)
            //var peak0 = recorder.peakPowerForChannel(0)
        }
    }
    
    func updateMusicMeter(_ timer:Timer) {
        
        
      //  if recorder.recording {
        if self.PLAYAUDIO == "yt" {
            
            let min = Int((myYTPlayer?.currentTime)! / 60)
            
            let sec = Int((myYTPlayer?.currentTime)!.truncatingRemainder(dividingBy: 60))
            
            let s = String(format: "%02d:%02d", min, sec)
            TrackCurrentTimeLBL.text = s

            
        } else {
        
            let min = Int((myMusicPlayer?.currentPlaybackTime)! / 60)
        
            let sec = Int((myMusicPlayer?.currentPlaybackTime)!.truncatingRemainder(dividingBy: 60))
        
            let s = String(format: "%02d:%02d", min, sec)
            TrackCurrentTimeLBL.text = s
        }
        
        /*
        if let row = MinData.indexOf(min) {
            if !HasHours {
             picker.selectRow(row, inComponent: 0, animated: false)
            }
        }
        if let rowSec = SecData.indexOf(sec) {
            if !HasHours {
                picker.selectRow(rowSec, inComponent: 1, animated: false)
            }
        }
       */
            /*
            timeCount = timeCount + timeInterval
            if (timeCount >= timerEnd) {
                print("Exceeded 10 seconds")
            }
*/
            
            //recorder.updateMeters()
            // if you want to draw some graphics...
            //var apc0 = recorder.averagePowerForChannel(0)
            //var peak0 = recorder.peakPowerForChannel(0)
       // }
    }
    
        
    @IBAction func removeAll(_ sender: AnyObject) {
        deleteAllRecordings()
    }
    
    @IBAction func record(_ sender: UIButton) {
        saveBTN.isEnabled = false
        if player != nil && player.isPlaying {
            player.stop()
        }
        
        if recorder == nil {
            print("recording. recorder nil")
            recordButton.setTitle("Pause", for:UIControlState())
            playButton.isEnabled = false
            stopButton.isEnabled = true
            recordWithPermission(true)
            return
        }
        
        if recorder != nil && recorder.isRecording {
            print("pausing")
            recorder.pause()
            recordButton.setTitle("Continue", for:UIControlState())
            
        } else {
            print("recording")
            recordButton.setTitle("Pause", for:UIControlState())
            playButton.isEnabled = false
            stopButton.isEnabled = true
            //            recorder.record()
            recordWithPermission(false)
        }
    }
    
    @IBAction func stop(_ sender: UIButton) {
        print("stop")
        
        recorder?.stop()
        player?.stop()
        saveBTN.isEnabled = true
        meterTimer.invalidate()
        timeCountRecord = 10.0
        statusLabel.text = timeCountRecord.description
        statusLabel.textColor = UIColor.black
        
        recordButton.setTitle("Record", for:UIControlState())
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setActive(false)
            playButton.isEnabled = true
            stopButton.isEnabled = false
            recordButton.isEnabled = true
        } catch let error as NSError {
            print("could not make session inactive")
            print(error.localizedDescription)
        }
        
        //recorder = nil
    }
    
    func stopRecorder() {
        
        recorder?.stop()
        player?.stop()
        saveBTN.isEnabled = true
        meterTimer.invalidate()
        timeCountRecord = 10.0
        statusLabel.text = timeCountRecord.description
        statusLabel.textColor = UIColor.black
        
        recordButton.setTitle("Record", for:UIControlState())
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setActive(false)
            playButton.isEnabled = true
            stopButton.isEnabled = false
            recordButton.isEnabled = true
        } catch let error as NSError {
            print("could not make session inactive")
            print(error.localizedDescription)
        }
        
    }
    
    
    @IBAction func play(_ sender: UIButton) {
        play()
    }
    
    func play() {
        
        print("YT Audio Selected = \(SelectedYTAudio)")
        print("PLAYAUDIO = \(PLAYAUDIO)")
        
        
        var url:URL?
        if self.recorder != nil {
            url = self.recorder.url
        } else if SelectedYTAudio {
            url = self.YTAudioFile
        } else {
            url = self.soundFileURL!
        }
        print("playing \(url)")
        
        do {
            self.player = try AVAudioPlayer(contentsOf: url!)
            stopButton.isEnabled = true
            player.delegate = self
            player.prepareToPlay()
            player.volume = 1.0
            player.play()
        } catch let error as NSError {
            self.player = nil
            print(error.localizedDescription)
        }
        
    }
    
    
    func setupRecorder() {
        let format = DateFormatter()
        format.dateFormat="yyyy-MM-dd-HH-mm-ss"
        let currentFileName = "recording-\(format.string(from: Date())).m4a"
        print(currentFileName)
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let soundFileURL = documentsDirectory.appendingPathComponent(currentFileName)
        
        if FileManager.default.fileExists(atPath: soundFileURL.absoluteString) {
           
            print("soundfile \(soundFileURL.absoluteString) exists")
        }
        
        let recordSettings:[String : AnyObject] = [
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless as UInt32),
            AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue as AnyObject,
            AVEncoderBitRateKey : 320000 as AnyObject,
            AVNumberOfChannelsKey: 2 as AnyObject,
            AVSampleRateKey : 44100.0 as AnyObject
        ]
        
        do {
            recorder = try AVAudioRecorder(url: soundFileURL, settings: recordSettings)
            recorder.delegate = self
            recorder.isMeteringEnabled = true
            recorder.prepareToRecord() // creates/overwrites the file at soundFileURL
        } catch let error as NSError {
            recorder = nil
            print(error.localizedDescription)
        }
        
    }
    
    func recordWithPermission(_ setup:Bool) {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        // ios 8 and later
        if (session.responds(to: #selector(AVAudioSession.requestRecordPermission(_:)))) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    print("Permission to record granted")
                    self.setSessionPlayAndRecord()
                    if setup {
                        self.setupRecorder()
                    }
                    self.recorder.record()
                    
                    self.meterTimer = Timer.scheduledTimer(timeInterval: self.timeInterval,
                        target:self,
                        selector:#selector(QuoteViewController.updateAudioMeter(_:)),
                        userInfo:nil,
                        repeats:true)
                    
                } else {
                    print("Permission to record not granted")
                }
            })
        } else {
            print("requestRecordPermission unrecognized")
        }
    }
    
    func setSessionPlayback() {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(AVAudioSessionCategoryPlayback)
        } catch let error as NSError {
            print("could not set session category")
            print(error.localizedDescription)
        }
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print("could not make session active")
            print(error.localizedDescription)
        }
    }
    
    func setSessionPlayAndRecord() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError {
            print("could not set session category")
            print(error.localizedDescription)
        }
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print("could not make session active")
            print(error.localizedDescription)
        }
    }
    
    func deleteAllRecordings() {
        let docsDir =
        NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        let fileManager = FileManager.default
        
        do {
            let files = try fileManager.contentsOfDirectory(atPath: docsDir)
            var recordings = files.filter( { (name: String) -> Bool in
                
                /*
                if name.containsString("tempTYAudio") {
                    print("Path containts tempTYAudio")
                return false
                } else {
                    */
                return name.hasSuffix("m4a")
               // }
            })
            
            for i in 0 ..< recordings.count {
                let path = docsDir + "/" + recordings[i]
                
                print("removing \(path)")
                
                if path.contains("tempYTAudio") {
                    print("Path containts tempYTAudio")
                } else {
                do {
                    try fileManager.removeItem(atPath: path)
                } catch let error as NSError {
                    //NSLog("could not remove \(path)")
                    print(error.localizedDescription)
                 }
                }
            }
            
        } catch let error as NSError {
            print("could not get contents of directory at \(docsDir)")
            print(error.localizedDescription)
        }
        
    }
    
    func deleteAllRecordingsYT_All() {
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

    
    func askForNotifications() {
        
        NotificationCenter.default.addObserver(self,
            selector:#selector(QuoteViewController.background(_:)),
            name:NSNotification.Name.UIApplicationWillResignActive,
            object:nil)
        
        NotificationCenter.default.addObserver(self,
            selector:#selector(QuoteViewController.foreground(_:)),
            name:NSNotification.Name.UIApplicationWillEnterForeground,
            object:nil)
        
        NotificationCenter.default.addObserver(self,
            selector:#selector(QuoteViewController.routeChange(_:)),
            name:NSNotification.Name.AVAudioSessionRouteChange,
            object:nil)
    }
    
    func background(_ notification:Notification) {
        print("background")
    }
    
    func foreground(_ notification:Notification) {
        print("foreground")
    }
    
    
    func routeChange(_ notification:Notification) {
        print("routeChange \((notification as NSNotification).userInfo)")
        
        if let userInfo = (notification as NSNotification).userInfo {
            //print("userInfo \(userInfo)")
            if let reason = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt {
                //print("reason \(reason)")
                switch AVAudioSessionRouteChangeReason(rawValue: reason)! {
                case AVAudioSessionRouteChangeReason.newDeviceAvailable:
                    print("NewDeviceAvailable")
                    print("did you plug in headphones?")
                    checkHeadphones()
                case AVAudioSessionRouteChangeReason.oldDeviceUnavailable:
                    print("OldDeviceUnavailable")
                    print("did you unplug headphones?")
                    checkHeadphones()
                case AVAudioSessionRouteChangeReason.categoryChange:
                    print("CategoryChange")
                case AVAudioSessionRouteChangeReason.override:
                    print("Override")
                case AVAudioSessionRouteChangeReason.wakeFromSleep:
                    print("WakeFromSleep")
                case AVAudioSessionRouteChangeReason.unknown:
                    print("Unknown")
                case AVAudioSessionRouteChangeReason.noSuitableRouteForCategory:
                    print("NoSuitableRouteForCategory")
                case AVAudioSessionRouteChangeReason.routeConfigurationChange:
                    print("RouteConfigurationChange")
                    
                }
            }
        }
        
   
    }
    
    func checkHeadphones() {

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
    
    
    
    func musicPlayerStateChanged(_ notification: Notification){
        
        print("Player State Changed")
        
        /* Let's get the state of the player */
        let stateAsObject =
        (notification as NSNotification).userInfo!["MPMusicPlayerControllerPlaybackStateKey"]
            as? NSNumber
        
        if let state = stateAsObject{
            
            /* Make your decision based on the state of the player */
            switch MPMusicPlaybackState(rawValue: state.intValue)!{
            case .stopped:
                /* Here the media player has stopped playing the queue. */
                print("Stopped")
            case .playing:
                /* The media player is playing the queue. Perhaps you
                can reduce some processing that your application
                that is using to give more processing power
                to the media player */
                print("Paused")
            case .paused:
                /* The media playback is paused here. You might want
                to indicate by showing graphics to the user */
                print("Paused")
            case .interrupted:
                /* An interruption stopped the playback of the media queue */
                print("Interrupted")
            case .seekingForward:
                /* The user is seeking forward in the queue */
                print("Seeking Forward")
            case .seekingBackward:
                /* The user is seeking backward in the queue */
                print("Seeking Backward")
            }
            
        }
    }
    
    func nowPlayingItemIsChanged(_ notification: Notification){
        
        print("Playing Item Is Changed")
        
        let key = "MPMusicPlayerControllerNowPlayingItemPersistentIDKey"
        
        let persistentID =
        (notification as NSNotification).userInfo![key] as? NSString
        
        if let id = persistentID{
            /* Do something with Persistent ID */
            print("Persistent ID = \(id)")
        }
        
    }
    
    func volumeIsChanged(_ notification: Notification){
        print("Volume Is Changed")
        /* The userInfo dictionary of this notification is normally empty */
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController,
        didPickMediaItems mediaItemCollection: MPMediaItemCollection){
            
            

            self.view.addSubview(self.SelectSongProgressHUD)
            print("adding song select progress view")
            
         /*   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
          */
            
            self.ShowPickerBTN.isEnabled = true
            self.SelectedYTAudio = false
            print("YT Audio Selected = \(SelectedYTAudio)")
            
            PLAYAUDIO = "library"
            print("Media Picker returned")
            
            /* Instantiate the music player */
    
            self.myMusicPlayer = MPMusicPlayerController()
            
            let aMediaItem = mediaItemCollection.items[0] as MPMediaItem
            
            
            
            print("media item = \(aMediaItem)")
            self.mediaItem = aMediaItem
            
          //  do {
            if aMediaItem.value(forProperty: MPMediaItemPropertyAssetURL) == nil {
                self.dismiss(animated: true, completion: {
                self.SelectSongProgressHUD.removeFromSuperview()
                let AC = JSController("Audio File Error", MyMessage: "This Audio File cannot be used, as it is not stored directly on your device.  Please select another file.",Color: "Green")
                   
                    
                    
                       DispatchQueue.main.async(execute: {
                    
                    
                    
                         SCLAlertView().showCustomOK(UIImage(named: "musicIcon.png")!, color: UIColor(red: 0.99, green: 0.69, blue: 0.35, alpha: 1.0), title: "Audio File Error", subTitle: "Error Loading this Audio File", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                        
                    })
                    
               // self.presentViewController(AC, animated: true, completion: nil)
                })
                
            } else {
                
            
            
            let audioURL = aMediaItem.value(forProperty: MPMediaItemPropertyAssetURL) as! URL
            
            self.MusicURL = audioURL
                
            let audioAsset = AVURLAsset(url: audioURL, options: nil)
            
            let audioDuration: CMTime = audioAsset.duration
            
            print("Song Duration = \(audioDuration)")
            
            self.SongLength = CMTimeGetSeconds(audioDuration)
            print("song seconds = \(self.SongLength)")
            
            self.SongTitle = aMediaItem.title! as NSString
            print("Song Title = \(self.SongTitle)")
            
            self.SongArtist = aMediaItem.albumArtist! as NSString
            
            self.MediaArtistLBL.text = self.SongArtist as String
            
            self.rangeSlider1.isHidden = false
            self.rangeSlider1.lowerValue = 0.1
            self.rangeSlider1.upperValue = 1.0
                /// (SongLength / 10.0)
            
            self.SongMaxLength = 1.0 / (self.SongLength / 10.0)
            
            self.MediaTitleLBL.text = self.SongTitle as String
            
            let (h,m,s) = self.secondsToHoursMinutesSeconds(self.SongLength)
                
           
            
            let h2 = Int(h)
            let m2 = Int(m)
            let s2 = Int(s)
            var h3 = String()
            var m3 = String()
            var s3 = String()
            
            if m2 < 10 {
                m3 = ("0\(m2)")
            } else {
                m3 = m2.description
            }
            if s2 < 10 {
                s3 = ("0\(s2)")
            } else {
                s3 = s2.description
            }
            
            if h2 < 10 {
                h3 = ("0\(h2)")
            } else {
                h3 = h2.description
            }
            
           // MediaLengthLBL.text = ("\(Double(round(1*h)/1)):\(Double(round(1*m)/1)):\(Double(round(1*s)/1))")
            
            if h2 == 0 {
                self.HasHours = false
                self.MinData = Array(0...(m2))
                // SecData = Array(arrayLiteral: 0...s3)
            self.MediaLengthLBL.text = ("Track Length: \(m3):\(s3)")
            } else {
            self.MediaLengthLBL.text = ("Track Length: \(h3):\(m3):\(s3)")
                self.HasHours = true
                self.HourData = Array(0...(h2))
                self.MinData = Array(0...(m2))
            
            }
                
                
                if h2 == 0 {
                    self.TrimStartLBL.text = ("00:00")
                } else {
                    self.TrimStartLBL.text = ("00:00:00")
                }
                
                if h2 == 0 {
                    self.TrimStopLBL.text = ("\(m3):\(s3)")
                } else {
                    self.TrimStopLBL.text = ("\(h3):\(m3):\(s3)")
                }
                
            print("Mid data = \(self.MinData)")
            print("Sec Data = \(self.SecData)")
                
                self.picker.reloadAllComponents()
           // MediaLengthLBL.text = Double(round(1000*(SongLength / 60)/100)).description
            
              self.MediaSlider.maximumValue = Float(Int(self.SongLength)) as Float
                
                self.TrimAudio.isEnabled = true
                self.playMusic.isEnabled = true
                
                if ( self.rangeSlider1.upperValue - self.rangeSlider1.lowerValue ) > self.SongMaxLength {
                    self.rangeSlider1.trackHighlightTintColor = UIColor.red
                } else {
                    self.rangeSlider1.trackHighlightTintColor = UIColor.green
                }
                
      /*
                
            } catch {
                
                print("audio ULR has eror \(error)")
            
            }
     */                    // .URLAssetWithURL(mediaItem, options: nil)
            
            if let player = self.myMusicPlayer{
                player.beginGeneratingPlaybackNotifications()
                
                /* Get notified when the state of the playback changes */
                NotificationCenter.default.addObserver(self,
                    selector: #selector(QuoteViewController.musicPlayerStateChanged(_:)),
                    name: NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange,
                    object: nil)
                
                /* Get notified when the playback moves from one item
                to the other. In this recipe, we are only going to allow
                our user to pick one music file */
                NotificationCenter.default.addObserver(self,
                    selector: #selector(QuoteViewController.nowPlayingItemIsChanged(_:)),
                    name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange,
                    object: nil)
                
                /* And also get notified when the volume of the
                music player is changed */
                NotificationCenter.default.addObserver(self,
                    selector: #selector(QuoteViewController.volumeIsChanged(_:)),
                    name: NSNotification.Name.MPMusicPlayerControllerVolumeDidChange,
                    object: nil)
                
                /* Start playing the items in the collection */
                player.setQueue(with: mediaItemCollection)
               
                //player.play()
                
                /* Finally dismiss the media picker controller */
                mediaPicker.dismiss(animated: true, completion: nil)
                
            }
        DispatchQueue.main.async {
                  self.SelectSongProgressHUD.removeFromSuperview()
            print("removing song select progress view")
           // self.MusicSaveBTN.hidden = false
            self.playMusic.isHidden = false
            self.TrimAudio.isHidden = false
            self.stopMusic.isHidden = false
            self.pauseMusic.isHidden = false
            self.ShowPickerBTN.isHidden = false
            
                }
           // stopMusic.enabled = true
           // pauseMusic
               // self.StartSubmitButton(Quote, turnStyle: turnStyle)
                //self.ActInd.stopAnimating()
        // });
                
                /*
            } else {
                
            }
          */
        }
    }
    
    func YTAudioMusic() {
        
     //   do {
       self.SelectAudioBTN.isHidden = true
        
         PLAYAUDIO = "yt"
          self.ShowPickerBTN.isEnabled = true
          print("Media Picker returned")
        
        /* Instantiate the music player */
        
//           self.myMusicPlayer = MPMusicPlayerController()
        
        self.myYTPlayer = AVAudioPlayer()
       // self.playMusic.enabled = true
        print("play music is enabled")
        
            let audioURL = YTAudioFile
            self.MusicURL = audioURL
            
            let audioAsset = AVURLAsset(url: audioURL!, options: nil)
            
            let audioDuration: CMTime = audioAsset.duration
            
            print("Song Duration = \(audioDuration)")
            
            self.SongLength = CMTimeGetSeconds(audioDuration)
            print("song seconds = \(self.SongLength)")
            
            self.SongTitle = YTAudioFileTitle
            print("Song Title = \(self.SongTitle)")
            
            self.SongArtist = YTAudioFileArtist
            
            self.MediaArtistLBL.text = self.SongArtist as String
            
            self.rangeSlider1.isHidden = false
            self.rangeSlider1.lowerValue = 0.1
            self.rangeSlider1.upperValue = 1.0
            /// (SongLength / 10.0)
            
            self.SongMaxLength = 1.0 / (self.SongLength / 10.0)
            
            self.MediaTitleLBL.text = self.SongTitle as String
            
            let (h,m,s) = self.secondsToHoursMinutesSeconds(self.SongLength)
            
            
            
            let h2 = Int(h)
            let m2 = Int(m)
            let s2 = Int(s)
            var h3 = String()
            var m3 = String()
            var s3 = String()
            
            if m2 < 10 {
                m3 = ("0\(m2)")
            } else {
                m3 = m2.description
            }
            if s2 < 10 {
                s3 = ("0\(s2)")
            } else {
                s3 = s2.description
            }
            
            if h2 < 10 {
                h3 = ("0\(h2)")
            } else {
                h3 = h2.description
            }
            
            // MediaLengthLBL.text = ("\(Double(round(1*h)/1)):\(Double(round(1*m)/1)):\(Double(round(1*s)/1))")
            
            if h2 == 0 {
                self.HasHours = false
                self.MinData = Array(0...(m2))
                // SecData = Array(arrayLiteral: 0...s3)
                self.MediaLengthLBL.text = ("Track Length: \(m3):\(s3)")
            } else {
                self.MediaLengthLBL.text = ("Track Length: \(h3):\(m3):\(s3)")
                self.HasHours = true
                self.HourData = Array(0...(h2))
                self.MinData = Array(0...(m2))
                
            }
            
            
            if h2 == 0 {
                self.TrimStartLBL.text = ("00:00")
            } else {
                self.TrimStartLBL.text = ("00:00:00")
            }
            
            if h2 == 0 {
                self.TrimStopLBL.text = ("\(m3):\(s3)")
            } else {
                self.TrimStopLBL.text = ("\(h3):\(m3):\(s3)")
            }
            
            print("Mid data = \(self.MinData)")
            print("Sec Data = \(self.SecData)")
            
            self.picker.reloadAllComponents()
            // MediaLengthLBL.text = Double(round(1000*(SongLength / 60)/100)).description
            
            self.MediaSlider.maximumValue = Float(Int(self.SongLength)) as Float
            
            self.TrimAudio.isEnabled = true
            self.playMusic.isEnabled = false
            self.pauseMusic.isEnabled = true
            self.stopMusic.isEnabled = true
            if ( self.rangeSlider1.upperValue - self.rangeSlider1.lowerValue ) > self.SongMaxLength {
                self.rangeSlider1.trackHighlightTintColor = UIColor.red
            } else {
                self.rangeSlider1.trackHighlightTintColor = UIColor.green
            }
            
            
   /*
        } catch {
            
            print("audio ULR has eror \(error)")
            
        }
*/
// .URLAssetWithURL(mediaItem, options: nil)
        
        /*
        
        if let player = self.myYTPlayer{
            player.beginGeneratingPlaybackNotifications()
            
            /* Get notified when the state of the playback changes */
            NSNotificationCenter.defaultCenter().addObserver(self,
                selector: "musicPlayerStateChanged:",
                name: MPMusicPlayerControllerPlaybackStateDidChangeNotification,
                object: nil)
            
            /* Get notified when the playback moves from one item
            to the other. In this recipe, we are only going to allow
            our user to pick one music file */
            NSNotificationCenter.defaultCenter().addObserver(self,
                selector: "nowPlayingItemIsChanged:",
                name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification,
                object: nil)
            
            /* And also get notified when the volume of the
            music player is changed */
            NSNotificationCenter.defaultCenter().addObserver(self,
                selector: "volumeIsChanged:",
                name: MPMusicPlayerControllerVolumeDidChangeNotification,
                object: nil)
            
            /* Start playing the items in the collection */
            //player.setQueueWithItemCollection(mediaItemCollection)
            
            player.play()
            
            /* Finally dismiss the media picker controller */
            //mediaPicker.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
        */
        
        
        do {
            self.myYTPlayer = try AVAudioPlayer(contentsOf: MusicURL)
            self.stopMusic.isEnabled = true
            self.myYTPlayer.delegate = self
            self.myYTPlayer.prepareToPlay()
            self.myYTPlayer.volume = 1.0
            
            self.pauseMusic.isEnabled = true
           // self.myYTPlayer.
            self.playMusic.isEnabled = false
            self.myYTPlayer.play()
            
            self.musicTimer = Timer.scheduledTimer(timeInterval: self.timeInterval,
                target:self,
                selector:#selector(QuoteViewController.updateMusicMeter(_:)),
                userInfo:nil,
                repeats:true)

        } catch let error as NSError {
            self.myYTPlayer = nil
            print(error.localizedDescription)
        }
        
      
        
        DispatchQueue.main.async {
         //   self.SelectSongProgressHUD.removeFromSuperview()
            print("removing song select progress view")
            // self.MusicSaveBTN.hidden = false
            self.playMusic.isHidden = false
            self.TrimAudio.isHidden = false
            self.stopMusic.isHidden = false
            self.pauseMusic.isHidden = false
            self.ShowPickerBTN.isHidden = false
            self.stopMusic.isEnabled = true
            self.pauseMusic.isEnabled = true
            
            
        }
        // stopMusic.enabled = true
        // pauseMusic
        // self.StartSubmitButton(Quote, turnStyle: turnStyle)
        //self.ActInd.stopAnimating()
        // });
        

        
        
    }
  
    func secondsToHoursMinutesSeconds(_ seconds : Double) -> (Double, Double, Double) {
        
        let (hr, minf) = modf (seconds / 3600)
        
        let (min, secf) = modf (60 * minf)
        
        return (hr, min, 60 * secf)
        
    }
    
    
    @IBAction func PauseAudio(_ sender: AnyObject) {
        
        
        if self.PLAYAUDIO == "yt" {
            
        if let player = myYTPlayer{
                
                player.pause()
                playMusic.isEnabled = true
                pauseMusic.isEnabled = false
                PlayPushed = false
                musicTimer.invalidate()
            }

        } else {
        
        
        if let player = myMusicPlayer{
            
            player.pause()
            playMusic.isEnabled = true
            pauseMusic.isEnabled = false
            PlayPushed = false
            musicTimer.invalidate()
         }
        }
    }
    
    @IBAction func PlayAudio(_ sender: AnyObject) {
        if SongTitle.isEqual(to: "") {
            
        } else {
        //let player = myMusicPlayer
        
            if self.PLAYAUDIO == "yt" {
               // myYTPlayer.c
            myYTPlayer!.currentTime = (rangeSlider1.lowerValue * SongLength)
            myYTPlayer!.play()
                
            } else {
            
            myMusicPlayer!.currentPlaybackTime = (rangeSlider1.lowerValue * SongLength)
            myMusicPlayer!.play()
                
            }
                
            //myMusicPlayer!.play()
            playMusic.isEnabled = false
            pauseMusic.isEnabled = true
            stopMusic.isEnabled = true
            PlayPushed = true
            
            self.musicTimer = Timer.scheduledTimer(timeInterval: self.timeInterval,
                target:self,
                selector:#selector(QuoteViewController.updateMusicMeter(_:)),
                userInfo:nil,
                repeats:true)
        }
        
    }
    
    @IBAction func StopAudio(_ sender: AnyObject) {
       stopMusic.isEnabled = false
        stopPlayingAudio()
        /*if SongTitle.isEqualToString("") {
            
        } else {
        myMusicPlayer!.stop()
        }
*/
    }
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        /* The media picker was cancelled */
        print("Media Picker was cancelled")
        mediaPicker.dismiss(animated: true, completion: nil)
    }
    
    func stopPlayingAudio(){
        
        NotificationCenter.default.removeObserver(self)
        
        if self.PLAYAUDIO == "yt" {
            print("Stopping YT Player")
            // myYTPlayer.c
            if let player = myYTPlayer{
                
                player.stop()
                playMusic.isEnabled = true
                PlayPushed = false
                musicTimer.invalidate()
            }

            
        } else {

        print("Stopping Library Player")

        if let player = myMusicPlayer{
            
            player.stop()
            playMusic.isEnabled = true
            PlayPushed = false
            musicTimer.invalidate()
        }
    }
        
    }
    
    func displayMediaPickerAndPlayItem(){
        
        mediaPicker = MPMediaPickerController(mediaTypes: .anyAudio)
        
        if let picker = mediaPicker{
            
            
            print("Successfully instantiated a media picker")
            picker.delegate = self
            picker.allowsPickingMultipleItems = false
            picker.showsCloudItems = true
            picker.prompt = "Pick a song please..."
            //view.addSubview(picker.view)
            
            present(picker, animated: true, completion: nil)
            
        } else {
            print("Could not instantiate a media picker")
        }
        
    }
    
    
    @IBAction func TrimAudioBTN(_ sender: AnyObject) {

        trim()
    }
    
    /*
    func getBufferListFromData(data: NSData) -> AudioBufferList {
        if data.length > 0 {
            var len: Int = data.length
            var byteData = malloc(len)
            memcpy(byteData, data.bytes, len)
            //if byteData{
                var theDataBuffer: AudioBufferList = malloc(sizeof(AudioBufferList) * 1)
                theDataBuffer->mNumberBuffers = 1
                theDataBuffer->mBuffer[0].mDataByteSize = len
                theDataBuffer->mBuffers[0].mNumberChangels = 1
                theDataBuffer->mBuffers[0].mData = byteData
                return theDataBuffer
           // }
        }
        return nil
    }
  */  
    func trim() {
        
        if ( rangeSlider1.upperValue - rangeSlider1.lowerValue ) > SongMaxLength {
            
            let AC = JSController("Exceeded Audio Duration Max", MyMessage: "Your trimmed audio clip cannot exceed 10 seconds", Color: "Red")
         //   self.presentViewController(AC, animated: true, completion: nil)
            
             DispatchQueue.main.async(execute: {
         
            
             SCLAlertView().showCustomOK(UIImage(named: "musicIcon.png")!, color: UIColor(red: 0.99, green: 0.69, blue: 0.35, alpha: 1.0), title: "Exceeded Max Audio Duration", subTitle: "Your trimmed audio clip cannot exceed 10 seconds", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            

        } else {
        //ActInd.startAnimating()
            
            self.view.addSubview(self.SelectSongTrimProgressHUD)
            print("adding song select progress view")
            
            deleteAllRecordings()
            if let asset = AVAsset(url: MusicURL) as? AVAsset {
                exportAsset(asset, fileName: "musicTrim.m4a")
            }
            RecordedMessage = true
        }
        
}
    
   // func exportAsset(
    
    func exportAsset(_ asset:AVAsset, fileName:String) {
        print("loading animation started")

        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let trimmedSoundFileURL = documentsDirectory.appendingPathComponent(fileName)
        print("saving to \(trimmedSoundFileURL.absoluteString)")
        
        let filemanager = FileManager.default
        if filemanager.fileExists(atPath: trimmedSoundFileURL.absoluteString) {
            print("sound exists")
        }
        
        let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetAppleM4A)
        exporter!.outputFileType = AVFileTypeAppleM4A
        exporter!.outputURL = trimmedSoundFileURL
        
        
        print("Asset = \(asset)")
        //print("Asset URL = \(asset.)")
        print("exporter.outpuURL = \(trimmedSoundFileURL)")
        
        let duration = CMTimeGetSeconds(asset.duration)
        if (duration < 1.0) {
            print("sound is not long enough")
            self.SelectSongTrimProgressHUD.removeFromSuperview()
            return
        }
        // e.g. the first 5 seconds
       // let startTime = CMTimeMake(0, 1)
        let startTime = StartTrim
        //let stopTime = CMTimeMake(5, 1)
        let stopTime = StopTrim
        
        
        let exportTimeRange = CMTimeRangeFromTimeToTime(startTime, stopTime)
        exporter!.timeRange = exportTimeRange
        
        
        // do it
        exporter!.exportAsynchronously(completionHandler: {
            switch exporter!.status {
            case  AVAssetExportSessionStatus.failed:
                print("export failed \(exporter!.error)")
                
                
            case AVAssetExportSessionStatus.cancelled:
                print("export cancelled \(exporter!.error)")
                
                
            default:
                print("export complete")
                
                print("File URl - trimmed file = \(trimmedSoundFileURL)")
                

              
                let recordedFile =  try! Data(contentsOf: trimmedSoundFileURL)

                
             //   print("Trimmed FILE NSDATA = \(recordedFile)")

                
                let RecordedDataPrelim = recordedFile.base64EncodedString(options: [])
                
                
                self.RecordedData = RecordedDataPrelim as NSString
                
                self.RecordedMessage = true
                
                
              //  let AC = JSController("Success", MyMessage: "You have successfully trimmed the audio file.", Color: "Green")
               // self.presentViewController(AC, animated: true, completion: nil)
               
              
                
                  DispatchQueue.main.async(execute: {
                
                    /*
                    let theAlert = SCLAlertView()
                theAlert.addButton("Ok") {
                }
                    
                    
                theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Success", subTitle: "You have successfully trimmed the audio file.")
                    */
                    
                    SCLAlertView().showCustomOK(UIImage(named: "musicIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Success", subTitle: "You have successfully trimmed the audio file.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)

                    
                    self.MusicSaveBTN.isHidden = false
                    self.MusicSaveBTN.isEnabled = true
                    
                })

                
               // self.ActInd.stopAnimating()
              
            }
        })
        print("animating should stop")
        
        
        self.MusicSaveBTN.isHidden = false
        self.MusicSaveBTN.isEnabled = true
        self.SelectSongTrimProgressHUD.removeFromSuperview()
        print("removing song select progress view")
        
        
        self.RecordedMessage = true
       // ActInd.stopAnimating()
    }
    

    
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
        //let width = view.bounds.width -
        
      //  rangeSlider1.
        rangeSlider1.frame = CGRect(x: margin, y: margin + topLayoutGuide.length + 150,
            width: 250, height: 31.0)
        
        rangeSlider2.frame = CGRect(x: margin + 20, y: 5 * margin + topLayoutGuide.length + 100,
            width: width - 40, height: 40)
    }

    
    func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        
        StartTrim = CMTimeMake(Int64((rangeSlider.lowerValue * SongLength)), 1)
        print("Start Trim Time = \(StartTrim)")
        
       
        StopTrim = CMTimeMake(Int64((rangeSlider.upperValue * SongLength)), 1)
        
        let Starttemp =  Double(rangeSlider.lowerValue * SongLength)
        
        var (h,m,s) = secondsToHoursMinutesSeconds(Starttemp)
        
        var h2 = Int(h)
        var m2 = Int(m)
        var s2 = Int(s)
        var h3 = String()
        var m3 = String()
        var s3 = String()
        
        if m2 < 10 {
            m3 = ("0\(m2)")
        } else {
            m3 = m2.description
        }
        if s2 < 10 {
            s3 = ("0\(s2)")
        } else {
            s3 = s2.description
        }
        
        if h2 < 10 {
            h3 = ("0\(h2)")
        } else {
            h3 = h2.description
        }
        
        
        if h2 == 0 {
            TrimStartLBL.text = ("\(m3):\(s3)")
        } else {
            TrimStartLBL.text = ("\(h3):\(m3):\(s3)")
        }

        
        let Stoptemp = Double(rangeSlider.upperValue * SongLength)
        
        
         (h,m,s) = secondsToHoursMinutesSeconds(Stoptemp)
        
         h2 = Int(h)
         m2 = Int(m)
         s2 = Int(s)
         h3 = String()
         m3 = String()
         s3 = String()
        
        if m2 < 10 {
            m3 = ("0\(m2)")
        } else {
            m3 = m2.description
        }
        if s2 < 10 {
            s3 = ("0\(s2)")
        } else {
            s3 = s2.description
        }
        
        if h2 < 10 {
            h3 = ("0\(h2)")
        } else {
            h3 = h2.description
        }
        
        
        if h2 == 0 {
            TrimStopLBL.text = ("\(m3):\(s3)")
        } else {
            TrimStopLBL.text = ("Track Length: \(h3):\(m3):\(s3)")
        }
    
        
        print("Stop Trim Time = \(StopTrim)")
        
        print("Slider Value for Max Song Length = \(SongMaxLength)")
        
        if ( rangeSlider.upperValue - rangeSlider.lowerValue ) > SongMaxLength {
            rangeSlider.trackHighlightTintColor = UIColor.red
        } else {
            rangeSlider.trackHighlightTintColor = UIColor.green
        }
        
        print("Range slider value changed: (\(rangeSlider.lowerValue) , \(rangeSlider.upperValue))")
        
       
        
        if PlayPushed {
            if self.PLAYAUDIO == "yt" {
                
                print("Playing YT Player")
                
                myYTPlayer!.currentTime = (rangeSlider1.lowerValue * SongLength)
                
                myYTPlayer!.play()
                
            } else {
        
        myMusicPlayer!.currentPlaybackTime = (rangeSlider1.lowerValue * SongLength)
        
        myMusicPlayer!.play()
                
        }
        
        }
            
        
    }
    
    func purchaseitems(){
        
        print("About to fetch the products");
        
        if (SKPaymentQueue.canMakePayments())
        {
            let productID:NSSet = NSSet(object: self.product_id_audio!);
            let productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>);
            
            
            productsRequest.delegate = self;
            productsRequest.start();
            print("Fething Products");
        }else{
            print("can't make purchases");
            self.submitBTN.setTitle("Submit Quote", for: UIControlState())
            self.RecordedMessage = false
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
            self.submitBTN.setTitle("Submit Quote", for: UIControlState())
            self.RecordedMessage = false
        }
    }
    
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Error Fetching product information");
        self.submitBTN.setTitle("Submit Quote", for: UIControlState())
         self.RecordedMessage = false
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
                    prefs.set(true, forKey: "AudioPurchased")
                    
                    
                    let UpdateUserPurchase = UserStatusCheck(username, userID: userID, status: "audio", action: "update")
                    
                    if UpdateUserPurchase {
                        print("successful profile update")
                    } else {
                        print("Did not update user profile")
                    }
                     self.RecordedMessage = true
                    self.QuoteBoxtxt.text = "(Audio Clip)"
                    self.QuoteBoxtxt.textColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
                    //UIColor.greenColor()
                    self.submitBTN.setTitle("Submit Audio", for: UIControlState())

                    //PerformSubmitButton(Quote)
                    
                    //   overlayView.hidden = true
                    break;
                case .failed:
                    print("Purchased Failed");
                    self.submitBTN.setTitle("Submit Quote", for: UIControlState())
                    self.RecordedMessage = false
                    
                    
                    if self.QuoteBoxtxt.text == "(Audio Clip)" {
                        self.QuoteBoxtxt.text = "Enter Your Quote Here..."
                        self.QuoteBoxtxt.textColor = UIColor.lightGray
                        self.QuoteBoxtxt.textAlignment = .center
                        self.RecordedMessage = false
                    }
                    
                    self.submitBTN.setTitle("Submit Quote", for: UIControlState())

                    
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break;
                    
                    
                    
                case .restored:
                    print("Already Purchased");
                    SKPaymentQueue.default().restoreCompletedTransactions()
                    prefs.set(true , forKey: "Purchased")
                    prefs.set(true, forKey: "AudioPurchased")
                    
                    let UpdateUserPurchase = UserStatusCheck(username, userID: userID, status: "audio", action: "update")
                    
                    if UpdateUserPurchase {
                        print("successful profile update")
                    } else {
                        print("Did not update user profile")
                    }
                    
                    self.RecordedMessage = true
                    self.QuoteBoxtxt.text = "(Audio Clip)"
                    self.QuoteBoxtxt.textColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
                    //UIColor.greenColor()
                    self.submitBTN.setTitle("Submit Audio", for: UIControlState())

                default:
                    break;
                }
            }
        }
        
    }
    
    
    @IBAction func showPickerView(_ sender: AnyObject) {
        
        if self.PLAYAUDIO == "yt" {
            
        print("Pausing YT Player")
            // myYTPlayer.c
             myYTPlayer!.pause()
            
        } else {
        
        myMusicPlayer!.pause()
        
        }
        
        
        playMusic.isEnabled = true
        pauseMusic.isEnabled = false
        
        if PlayPushed{
            
            if (musicTimer != nil) {
                musicTimer.invalidate()
            }
       // musicTimer.invalidate()
        }
        
        PlayPushed = false
        ShowingPicker = true
        rangeSlider1.isHidden = true
            
        
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
    
            self.pickerViewTOP.constant = 100
            
        })
        
    }
    
    @IBAction func closePickerView(_ sender: AnyObject) {
         let TempTime = (MinSelected * 60) + SecSelected
        
        
        rangeSlider1.lowerValue = Double(TempTime) / SongLength

        if (Double(TempTime) + 9.0) > SongLength {
            self.rangeSlider1.upperValue = 1.0
        } else {
        self.rangeSlider1.upperValue = (Double(TempTime) + 9.0) / SongLength
        }
       
        
        StartTrim = CMTimeMake(Int64((rangeSlider1.lowerValue * SongLength)), 1)

        StopTrim = CMTimeMake(Int64((rangeSlider1.upperValue * SongLength)), 1)
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
    
            self.pickerViewTOP.constant = 1000
           
        })

        ShowingPicker = false
        rangeSlider1.isHidden = false
    }
    
    func createPickerData(){
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return MinData.count
        } else {
            return SecData.count
        }
    
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
             return "\(MinData[row]) Min"
        } else {
        
        return "\(SecData[row]) Sec"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
        MinSelected = MinData[row]
        }  else {
          SecSelected = SecData[row]
        }
        
    }
    
    func startCount() {
        self.counter = 0
        for i in 0..<100 {
            DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background).async(execute: {
                sleep(1)
                DispatchQueue.main.async(execute: {
                    self.counter += 1
                    return
                    
                })
            })
        }
    }
    var counter:Int = 0 {
        didSet {
            let fractionalProgress = Float(counter) /  100.0
            let animated = counter != 0
            progressView.setProgress(fractionalProgress, animated: animated)
            //
        }
    }
    
    
    var CommentsGameID = NSString()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowComments" {
            if let destination = segue.destination as? CommentsViewController {
                // destination.GameName = GameNameInfo[GameIndex]
                destination.GameID = CommentsGameID
                destination.wasNotified = true
                
            }
            
        }
       // var CommentsGameID = NSString()
        
        if segue.identifier == "browseAudio" {
            if let destination = segue.destination as? BrowseAudioViewController {
                destination.SentVC = SentVC as NSString
            }
        }

        
        if segue.identifier == "BackToMyGames" {
            
            let controller = segue.destination as! GameViewController
            controller.IsUnwinding = true
        }

        
    }
    
    
    
    
    func HandleAlertMessageQVC(_ notification:Notification)  {
        
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
                    
                    self.performSegue(withIdentifier: "ShowComents", sender: self)
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
                if viewController.isKind(of: QuoteViewController.self) {
                    
                    
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

}

// MARK: AVAudioRecorderDelegate
extension QuoteViewController : AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder,
        successfully flag: Bool) {
            print("finished recording \(flag)")
            stopButton.isEnabled = false
            playButton.isEnabled = true
            recordButton.setTitle("Record", for:UIControlState())
            
            
            /*
            // iOS8 and later
            let alert = UIAlertController(title: "Quote Recorder",
                message: "Finished Recording",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Keep Recording", style: .Default, handler: {action in
                print("keep was tapped")
                self.PLAYAUDIO = "recorded"
            }))
            alert.addAction(UIAlertAction(title: "Delete Recording", style: .Default, handler: {action in
                print("delete was tapped")
                self.recorder.deleteRecording()
            }))
            self.presentViewController(alert, animated:true, completion:nil)
    */
    
    
            DispatchQueue.main.async(execute: {
                
                let theAlert2 = SCLAlertView()
                theAlert2.addButton("No, try again", action: {
                    
                     self.recorder.deleteRecording()
                    
                })
                
                theAlert2.addButton("Yes", action: {
                    
                   self.PLAYAUDIO = "recorded"
                    
                })
                
                theAlert2.showCustomOK(UIImage(named: "musicIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Quote Recorder", subTitle: "Use this recording?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
    
            
    
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder,
        error: Error?) {
            
            if let e = error {
                print("\(e.localizedDescription)")
            }
    }


}
//

// MARK: AVAudioPlayerDelegate
extension QuoteViewController  {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("finished playing \(flag)")
        recordButton.isEnabled = true
        stopButton.isEnabled = false
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        if let e = error {
            print("\(e.localizedDescription)")
        }
        
    }
}

    


extension NSString {
    func stringByAddingPercentEncodingForURLQueryValue() -> NSString? {
        let characterSet = NSMutableCharacterSet.alphanumeric()
        characterSet.addCharacters(in: "-._* ")
        return addingPercentEncoding(withAllowedCharacters: characterSet as CharacterSet)?.replacingOccurrences(of: " ", with: "+") as NSString?
    }
    
    func stringByAddingPercentEncodingForURLQueryValue2() -> NSString? {
        let characterSet = NSMutableCharacterSet.alphanumeric()
        characterSet.addCharacters(in: "-._* ")
        return addingPercentEncoding(withAllowedCharacters: characterSet as CharacterSet)?.replacingOccurrences(of: "%2F", with: "/") as NSString?
    }
    

    
    
    
}

extension QuoteViewController {
    //}: FBFriendsViewControllerDelegate {
    func BrowseAudioViewControllerFinished(_ browseaudioviewController: BrowseAudioViewController) {
        
        /*
        
        self.YTComplete = audiobrowseviewController.YTComplete
        print("Youtube Search Dismiss")
        self.SelectedYTAudio = audiobrowseviewController.SelectedYTAudio
        self.YTAudioFile = audiobrowseviewController.AudioFile
        self.YTAudioFileTitle = audiobrowseviewController.YTAudioFileTitle
        self.YTAudioFileArtist = audiobrowseviewController.YTAudioFileArtist
        
        if self.SelectedYTAudio{
        print("Youtube Audio Selected")
        
        ShowMusicViewNow()
        } else {
        print("Youtube Audio Not Selected")
        }
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        //self.FBFriendName = fbfriendsviewController.FBFriendName
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
        
        self.YTComplete = audiobrowseviewController.YTComplete
        print("YT COMPLETE FROM AB Finished = \(self.YTComplete)")
        
        
        })
        
        */
    }
}


/*

{ () -> Void in


ShowPickerBTN.enabled = true
print("Media Picker returned")

/* Instantiate the music player */

myMusicPlayer = MPMusicPlayerController()

let aMediaItem = mediaItemCollection.items[0] as MPMediaItem



print("media item = \(aMediaItem)")
self.mediaItem = aMediaItem

do {
let audioURL = try aMediaItem.valueForProperty(MPMediaItemPropertyAssetURL) as! NSURL

MusicURL = audioURL

let audioAsset = AVURLAsset(URL: audioURL, options: nil)

let audioDuration: CMTime = audioAsset.duration

print("Song Duration = \(audioDuration)")

SongLength = CMTimeGetSeconds(audioDuration)
print("song seconds = \(SongLength)")

SongTitle = aMediaItem.title!
print("Song Title = \(SongTitle)")

SongArtist = aMediaItem.albumArtist!

MediaArtistLBL.text = SongArtist as String

rangeSlider1.hidden = false
rangeSlider1.lowerValue = 0.1
rangeSlider1.upperValue = 1.0
/// (SongLength / 10.0)

SongMaxLength = 1.0 / (SongLength / 10.0)

MediaTitleLBL.text = SongTitle as String

let (h,m,s) = secondsToHoursMinutesSeconds(SongLength)



let h2 = Int(h)
let m2 = Int(m)
let s2 = Int(s)
var h3 = String()
var m3 = String()
var s3 = String()

if m2 < 10 {
m3 = ("0\(m2)")
} else {
m3 = m2.description
}
if s2 < 10 {
s3 = ("0\(s2)")
} else {
s3 = s2.description
}

if h2 < 10 {
h3 = ("0\(h2)")
} else {
h3 = h2.description
}

// MediaLengthLBL.text = ("\(Double(round(1*h)/1)):\(Double(round(1*m)/1)):\(Double(round(1*s)/1))")

if h2 == 0 {
HasHours = false
MinData = Array(0...(m2))
// SecData = Array(arrayLiteral: 0...s3)
MediaLengthLBL.text = ("Track Length: \(m3):\(s3)")
} else {
MediaLengthLBL.text = ("Track Length: \(h3):\(m3):\(s3)")
HasHours = true
HourData = Array(0...(h2))
MinData = Array(0...(m2))

}


if h2 == 0 {
TrimStartLBL.text = ("00:00")
} else {
TrimStartLBL.text = ("00:00:00")
}

if h2 == 0 {
TrimStopLBL.text = ("\(m3):\(s3)")
} else {
TrimStopLBL.text = ("\(h3):\(m3):\(s3)")
}

print("Mid data = \(MinData)")
print("Sec Data = \(SecData)")

picker.reloadAllComponents()
// MediaLengthLBL.text = Double(round(1000*(SongLength / 60)/100)).description

MediaSlider.maximumValue = Float(Int(SongLength)) as Float

TrimAudio.enabled = true
playMusic.enabled = true

if ( rangeSlider1.upperValue - rangeSlider1.lowerValue ) > SongMaxLength {
rangeSlider1.trackHighlightTintColor = UIColor.redColor()
} else {
rangeSlider1.trackHighlightTintColor = UIColor.greenColor()
}



} catch {

print("audio ULR has eror \(error)")

}
// .URLAssetWithURL(mediaItem, options: nil)

if let player = myMusicPlayer{
player.beginGeneratingPlaybackNotifications()

/* Get notified when the state of the playback changes */
NSNotificationCenter.defaultCenter().addObserver(self,
selector: "musicPlayerStateChanged:",
name: MPMusicPlayerControllerPlaybackStateDidChangeNotification,
object: nil)

/* Get notified when the playback moves from one item
to the other. In this recipe, we are only going to allow
our user to pick one music file */
NSNotificationCenter.defaultCenter().addObserver(self,
selector: "nowPlayingItemIsChanged:",
name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification,
object: nil)

/* And also get notified when the volume of the
music player is changed */
NSNotificationCenter.defaultCenter().addObserver(self,
selector: "volumeIsChanged:",
name: MPMusicPlayerControllerVolumeDidChangeNotification,
object: nil)

/* Start playing the items in the collection */
player.setQueueWithItemCollection(mediaItemCollection)

//player.play()

/* Finally dismiss the media picker controller */
mediaPicker.dismissViewControllerAnimated(true, completion: nil)

}

// stopMusic.enabled = true
// pauseMusic
// self.StartSubmitButton(Quote, turnStyle: turnStyle)
//self.ActInd.stopAnimating()
}

*/
