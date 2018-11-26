//
//  NewViewControllerExtension.swift
//  TelePictionary
//
//  Created by Jared Stevens on 11/17/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer

extension NewViewController {


func YTCompleteTrim2(_ notification:Notification){
    
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
    
}
    
    
    @IBAction func CancelMusicView(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if MusicViewShowing {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
              //  self.MusicView1TOP.constant = middleY
                
                self.ViewHolderMusic.center.y = self.ViewHolderMusic.center.y + 1000
                
                self.ViewHolderMusicTOP.constant = 964
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            RecordedMessage = false
            MusicViewShowing = false
            //checkHeadphones()
        }
         self.revealViewController().panGestureRecognizer().isEnabled = true
    }
    @IBAction func ShowMusicView(_ sender: AnyObject) {
        
        ShowMusicViewNow()
        
    }
    func ShowMusicViewNow() {
        self.revealViewController().panGestureRecognizer().isEnabled = false
      
        
        //  if !choosingMusic {
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            self.chooseMusicViewTOP.constant = 964
            
            self.chooseMusicView.center.y = self.chooseMusicView.center.y + 1000
            
            //  self.ViewHolderMusicTOP.constant = 0
            //self.ViewShowing = true
            // ShowingInfo = true
            
            // self.ViewTransTOP.constant = 0
        })
        choosingMusic = false
        
        
        if !MusicViewShowing {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
              //  self.MusicView1TOP.constant = middleY
                
                self.ViewHolderMusic.center.y = self.ViewHolderMusic.center.y - 1000
                
                self.ViewHolderMusicTOP.constant = -64
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
        
       // let DeviceH = self.view.frame.height
       // let middleScreenY = DeviceH / 2
        //let middleY = middleScreenY - 200
        
        
        if !choosingMusic {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.chooseMusicView.center.y = self.chooseMusicView.center.y - 1000
                
                self.chooseMusicViewTOP.constant = -64     //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            choosingMusic = true
        }  //  }
    }
    
    @IBAction func closeImageSelect(_ sender: AnyObject) {
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            self.chooseMusicViewTOP.constant = 964
            
            self.chooseMusicView.center.y = self.chooseMusicView.center.y + 1000
            
        })
        choosingMusic = false
        
    }
    @IBAction func BrowseYTBTN(_ sender: AnyObject) {
        
        // pe
        self.performSegue(withIdentifier: "browseYT2", sender: self)
        
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            self.chooseMusicViewTOP.constant = 964
            
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
            
            self.chooseMusicViewTOP.constant = 964
            
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
                
                self.ViewHolder2TOP.constant = -64
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
        //    submitBTN.setTitle("Submit Audio", forState: .Normal)
        } else {
        //    submitBTN.setTitle("Submit Quote", forState: .Normal)
        }
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if RecordViewShowing {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.RecordView1TOP.constant = middleY
                
                self.ViewHolder2.center.y = self.ViewHolder2.center.y + 1000
                
                self.ViewHolder2TOP.constant = 964
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
          //  submitBTN.setTitle("Submit Audio", forState: .Normal)
        } else {
          //  submitBTN.setTitle("Submit Quote", forState: .Normal)
        }
        
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if RecordViewShowing {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.RecordView1TOP.constant = middleY
                
                self.ViewHolder2.center.y = self.ViewHolder2.center.y + 1000
                
                self.ViewHolder2TOP.constant = 964
                
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
                
                 MediaType = "audio"
                let CheckAudioReturn = CheckAudioPurchase()
                
                
                
               
               
              print("Recorded message = \(RecordedMessage)")
                
                 DispatchQueue.main.async(execute: {
                
                let CheckAudioReturnNew = self.prefs.bool(forKey: "ISAUDIOCLIP")
                    
                    print("CHECK AUDIO RETURN FINAL = \(CheckAudioReturnNew)")
                    
                if CheckAudioReturnNew {
                    self.QuoteBox.text = "AUDIO CLIP SELECTED"
                    self.QuoteBox.textColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)

                }  else {
                    print("its false")
                    self.QuoteBox.text = "Enter Your Quote Here"
                    self.QuoteBox.textColor = UIColor.lightGray
                    self.QuoteBox.textAlignment = .center
                    
                }
                
                 })
             
                
            }  else {
                print("cancelling record view")
                // url = self.soundFileURL!
            }
            RecordViewShowing = false
        }
        
        
    }

    @IBAction func HideSaveMusicView(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if RecordedMessage {
            /*
            submitBTN.setTitle("Submit Audio", forState: .Normal)
            
            QuoteBoxtxt.text = "(Audio Clip)"
            QuoteBoxtxt. textColor = UIColor.lightGrayColor()
            QuoteBoxtxt.textAlignment = .Center
*/
            
        } else {
          //  submitBTN.setTitle("Submit Quote", forState: .Normal)
        }
        
        if MusicViewShowing {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
              //  self.MusicView1TOP.constant = middleY
                
                self.ViewHolderMusic.center.y = self.ViewHolderMusic.center.y + 1000
                
                self.ViewHolderMusicTOP.constant = 964
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            RecordedMessage = true
            MediaType = "audio"
            MusicViewShowing = false
            let CheckAudioReturn = CheckAudioPurchase()
            
            
            
            DispatchQueue.main.async(execute: {
                
                let CheckAudioReturnNew = self.prefs.bool(forKey: "ISAUDIOCLIP")
                
                print("CHECK AUDIO RETURN FINAL = \(CheckAudioReturnNew)")
                
                if CheckAudioReturnNew {
            
          //  if CheckAudioReturn {
                self.QuoteBox.text = "AUDIO CLIP SELECTED"
                self.QuoteBox.textColor = UIColor.green
                
            } else {
                print("its false")
                self.QuoteBox.text = "Enter Your Quote Here"
                self.QuoteBox.textColor = UIColor.lightGray
                self.QuoteBox.textAlignment = .center
                
            }

            
            })
            
            
            
            stopPlayingAudio()
            
            //checkHeadphones()
        }
         self.revealViewController().panGestureRecognizer().isEnabled = true
        NewGameFirstTurn = "quote"
    }
    
    
    func CheckAudioPurchase() -> Bool {
        
        
        var CheckReturn = Bool()

      
        
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
        
       // var CheckReturn = Bool()
        
        if RecordedMessage {
            // @IBAction func shootPhoto(sender: AnyObject) {
            
            if (prefs.bool(forKey: "AudioPurchased")){
                RecordedMessage = true
                CheckReturn = true
                
             //   let CheckAudioReturnNew = boolForKey("ISAUDIOCLIP")
                prefs.set(true, forKey: "ISAUDIOCLIP")
                self.QuoteBox.text = "AUDIO CLIP SELECTED"
                self.QuoteBox.textColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
                
                
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
                    theAlert.addButton("Yes") {
                        print("Settings pushed")
                        
                        self.pointsUsed = true
                        
                        self.RecordedMessage = true
                        //   let CheckAudioReturnNew = boolForKey("ISAUDIOCLIP")
                        self.prefs.set(true, forKey: "ISAUDIOCLIP")
                        
                        self.QuoteBox.text = "AUDIO CLIP SELECTED"
                        self.QuoteBox.textColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
                        
                        CheckReturn = true
                        //return CheckReturn
                        
                    }
                    //, target:self, selector:Selector("Settings"))
                    theAlert.addButton("No") {
                        
                        let theAlert2 = SCLAlertView()
                        theAlert2.addButton("Let's Do it!") {
                            self.TheProduct = "audio"
                           // self.RecordedMessage = true
                            self.purchaseitems()

                        }
                        
                         theAlert2.addButton("Later") {
                            self.RecordedMessage = false
                            //   let CheckAudioReturnNew = boolForKey("ISAUDIOCLIP")
                            self.prefs.set(false, forKey: "ISAUDIOCLIP")
                            CheckReturn = false
                           // return CheckReturn
                            
                        }
                  
                    

                        
                       // theAlert2.showCustom(UIImage(named: "alertcontent.png")!, color: UIColor.blueColor(), title: "Import Audio", subTitle: "Add to your Toolbox?")
                         theAlert2.showCustomOK(UIImage(named: "musicIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Import Audio", subTitle: "Add Audio any time for only $1.99?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                        
                    }
                    
                   
                    
                  //  theAlert.showCustom(UIImage(named: "alertcontent.png")!, color: UIColor.blueColor(), title: "Use your Tokens!", subTitle: "Use 10 tokens to proceed?")
                    
                     theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0), title: "Use your Tokens!", subTitle: "Use your tokens to import an audio clip?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                    
                    
                    
                    
                    
                    
                    
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
                        
                        CheckReturn = true
                     //   return CheckReturn
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
                           // self.submitBTN.setTitle("Submit Quote", forState: .Normal)
                            
                            self.RecordedMessage = false
                            CheckReturn = false
                            //return CheckReturn
                            
                        }
                        actionSheetController.addAction(cancelAction)
                        //Create and an option action
                        let nextAction: UIAlertAction = UIAlertAction(title: "Let's do it", style: .Default) { action -> Void in
                            self.TheProduct = "audio"
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
                        
                        
                        
                        
                        
                        
                        
                        
                        let theAlert = SCLAlertView()
                        theAlert.addButton("Thanks") {
                            print("Settings pushed")
                            
                            self.RecordedMessage = true
                            //   let CheckAudioReturnNew = boolForKey("ISAUDIOCLIP")
                            self.prefs.set(true, forKey: "ISAUDIOCLIP")
                            
                            self.QuoteBox.text = "AUDIO CLIP SELECTED"
                            self.QuoteBox.textColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
                            
                            CheckReturn = true
                            
                        }
                        //, target:self, selector:Selector("Settings"))
        
                        theAlert.showCustom(UIImage(named: "alertcontent.png")!, color: UIColor.blue, title: "Great News!", subTitle: "Try it out?")
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
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
                            // Quote = self.RecordedData
                            // self.TheType = "audio"
                            // self.QorA = "Audio Clip"
                            // self.PerformSubmitButton(Quote)
                            
                            CheckReturn = true
                            //return CheckReturn
                            
                        }
                        
                        actionSheetController.addAction(nextAction)
                        
                        self.presentViewController(actionSheetController, animated: true, completion: nil)
                        
                        */
                        
                    } else {
                        
                        
                        
                        
                        let theAlert2 = SCLAlertView()
                        theAlert2.addButton("Let's Do it!") {
                            self.TheProduct = "audio"
                            self.purchaseitems()
                            
                        }
                        
                        theAlert2.addButton("Later") {
                            self.RecordedMessage = false
                            //   let CheckAudioReturnNew = boolForKey("ISAUDIOCLIP")
                            self.prefs.set(false, forKey: "ISAUDIOCLIP")
                            CheckReturn = false
                            //return CheckReturn
                            
                        }
                        
                        
                        
                        
                        theAlert2.showCustomOK(UIImage(named: "musicIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Import Audio", subTitle: "Add Audio any time for only $1.99?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                        
                        
                        /*
                        
                        
                        let actionSheetController: UIAlertController = UIAlertController(title: "Use Audio", message: "Would you like to add the 'Audio Clips' option to your Pencil Toolbox?", preferredStyle: .Alert)
                        
                        //Create and add the Cancel action
                        let cancelAction: UIAlertAction = UIAlertAction(title: "No thanks", style: .Cancel) { action -> Void in
                            //Do some stuff
                           // self.submitBTN.setTitle("Submit Quote", forState: .Normal)
                            
                            self.RecordedMessage = false
                            
                            CheckReturn = false
                          //  return CheckReturn
                            
                        }
                        actionSheetController.addAction(cancelAction)
                        //Create and an option action
                        let nextAction: UIAlertAction = UIAlertAction(title: "Let's do it", style: .Default) { action -> Void in
                            
                            self.TheProduct = "audio"
                            self.purchaseitems()
                            
                        }
                        
                        actionSheetController.addAction(nextAction)
                        
                        self.presentViewController(actionSheetController, animated: true, completion: nil)
                        
                        */
                    }
                    
                    //   }
                    
                    //   }
                    
                }
                print("CheckReturn = \(CheckReturn)")
                return CheckReturn
                
            } else {
                
                print("Audio not being used")
                
                print("CheckReturn = \(CheckReturn)")
                return CheckReturn
                //PerformSubmitButton(Quote)
            }
        }
        
       // dispatch_async(dispatch_get_main_queue(), {
         
        }
        
        return CheckReturn
            
      //  })
        
    // }
        
   }
    
    @IBAction func ImportMusic(_ sender: AnyObject) {
        
        displayMediaPickerAndPlayItem()
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
        
        print("music playback time = \(myMusicPlayer?.currentPlaybackTime)")
        
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
        
        //stop()
        
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
    
    
    
    
    func stop() {
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
            url = self.YTAudioFile as URL
        } else {
            url = self.soundFileURL! as URL
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
                        selector:#selector(NewViewController.updateAudioMeter(_:)),
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
                     //   NSLog("could not remove \(path)")
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
                  //  NSLog("could not remove \(path)")
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
            selector:#selector(NewViewController.background(_:)),
            name:NSNotification.Name.UIApplicationWillResignActive,
            object:nil)
        
        NotificationCenter.default.addObserver(self,
            selector:#selector(NewViewController.foreground(_:)),
            name:NSNotification.Name.UIApplicationWillEnterForeground,
            object:nil)
        
        NotificationCenter.default.addObserver(self,
            selector:#selector(NewViewController.routeChange(_:)),
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
            
            if aMediaItem.value(forProperty: MPMediaItemPropertyAssetURL) == nil {
                self.dismiss(animated: true, completion: {
                    self.SelectSongProgressHUD.removeFromSuperview()
                    
                    
                    let AC = JSController("Audio File Error", MyMessage: "This Audio File cannot be used, as it is not stored directly on your device.  Please select another file.",Color: "Green")
                 //   self.presentViewController(AC, animated: true, completion: nil)
                    
                    
                    SCLAlertView().showError("Audio File Erro", subTitle: "This Audio File cannot be used, as it is not stored directly on your device.  Please select another file.", closeButtonTitle: "Ok", duration: 1.0, colorStyle: 1, colorTextButton: 1)
                    
                })
                
            } else {
            
            print("media item = \(aMediaItem)")
            self.mediaItem = aMediaItem
            
            //  do {
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
            
            self.picker2.reloadAllComponents()
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
                    selector: #selector(NewViewController.musicPlayerStateChanged(_:)),
                    name: NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange,
                    object: nil)
                
                /* Get notified when the playback moves from one item
                to the other. In this recipe, we are only going to allow
                our user to pick one music file */
                NotificationCenter.default.addObserver(self,
                    selector: #selector(NewViewController.nowPlayingItemIsChanged(_:)),
                    name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange,
                    object: nil)
                
                /* And also get notified when the volume of the
                music player is changed */
                NotificationCenter.default.addObserver(self,
                    selector: #selector(NewViewController.volumeIsChanged(_:)),
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
        
        let audioAsset = AVURLAsset(url: audioURL! as URL, options: nil)
        
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
        
        self.picker2.reloadAllComponents()
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
            self.myYTPlayer = try AVAudioPlayer(contentsOf: MusicURL as URL)
            self.stopMusic.isEnabled = true
            self.myYTPlayer.delegate = self
            self.myYTPlayer.prepareToPlay()
            self.myYTPlayer.volume = 1.0
            
            self.pauseMusic.isEnabled = true
            
            self.myYTPlayer.play()
            
            self.musicTimer = Timer.scheduledTimer(timeInterval: self.timeInterval,
                target:self,
                selector:#selector(NewViewController.updateMusicMeter(_:)),
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
                selector:#selector(NewViewController.updateMusicMeter(_:)),
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
                
               // let isTimerValue = musicTimer.valid
                
                if (musicTimer != nil) {
                musicTimer.invalidate()
                }
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
           // self.presentViewController(AC, animated: true, completion: nil)
            
            
            DispatchQueue.main.async(execute: {
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Audip Clip", subTitle: "Your trimmed audio clip cannot exceed 10 seconds", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
            
        } else {
            //ActInd.startAnimating()
            
            self.view.addSubview(self.SelectSongTrimProgressHUD)
            print("adding song select progress view")
            
            deleteAllRecordings()
            if let asset = AVAsset(url: MusicURL as URL) as? AVAsset {
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
                
                
                let AC = JSController("Success", MyMessage: "You have successfully trimmed the audio file.", Color: "Green")
                //self.presentViewController(AC, animated: true, completion: nil)
                
                DispatchQueue.main.async(execute: {
                    
                    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Success", subTitle: "You have successfully trimmed the audio file.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
                
                
                // self.ActInd.stopAnimating()
                self.MusicSaveBTN.isHidden = false
                self.MusicSaveBTN.isEnabled = true
            }
        })
        print("animating should stop")
        
        
        self.MusicSaveBTN.isHidden = false
        self.MusicSaveBTN.isEnabled = true
        self.SelectSongTrimProgressHUD.removeFromSuperview()
        print("removing song select progress view")
        
        /*
        QuoteBox.text = "AUDIO CLIP SELECTED"
        QuoteBox.textColor = UIColor.greenColor()
        self.RecordedMessage = true
        // ActInd.stopAnimating()
*/
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
            
            
            self.pickerViewTOP.constant = 36
            
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
            
            self.pickerViewTOP.constant = 964
            
        })
        
        ShowingPicker = false
        rangeSlider1.isHidden = false
    }
    
    func createPickerData(){
        
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
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder,
        successfully flag: Bool) {
            
            /*
            print("finished recording \(flag)")
            stopButton.enabled = false
            playButton.enabled = true
            recordButton.setTitle("Record", forState:.Normal)
            
            // iOS8 and later
            let alert = UIAlertController(title: "Recorder",
                message: "Finished Recording",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Keep", style: .Default, handler: {action in
                print("keep was tapped")
                self.PLAYAUDIO = "recorded"
            }))
            alert.addAction(UIAlertAction(title: "Delete", style: .Default, handler: {action in
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

   
   

    func googleImageNVC(_ notification:Notification) {
        
        fromGoogleImage = true
        picready = true
        PictureAdded = true
        MediaType = "picture"
        NewGameFirstTurn = "picture"
        print("Setting image from google")
        let data = (notification as NSNotification).userInfo
        let googleImageData2 = data!["data"] as! Data
        
        useGoogleImage = true
        
        
        fromGoogle = true
        //WasPasted = false
        
        
        
        let image = UIImage(data: googleImageData2)
        //  tempImageView.image = image
        
        
        self.PicPreview.image = image
        
        
       // let smallImage = PicPreview.image!.resize(0.5)
        
        
        let imageData = UIImageJPEGRepresentation(image!, 0.6)
        
        NewGamePictureData = imageData!.base64EncodedString(options: []) as NSString
        
        
        self.prefs.setValue("", forKey: "GOOGLEDATAD")
        
       
        
    }
    
    

}
