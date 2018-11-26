//
//  AudioBrowseViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 11/8/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import UIKit
import WebKit
import Foundation
import AVFoundation
import MediaPlayer
import iAd

protocol AudioBrowseViewControllerDelegate: class {
    func AudioBrowseViewControllerFinished(audiobrowseviewController: AudioBrowseViewController)
}




class AudioBrowseViewController: UIViewController, UIWebViewDelegate, ADInterstitialAdDelegate {
    
    
    var interAd: ADInterstitialAd?
    var interAdView = UIView()
    var closeButton = UIButton(type: UIButtonType.System)
    
    
    @IBOutlet weak var forwardBTN: UIButton!
    
    @IBOutlet weak var backBTN: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    var SentVC = String()
    @IBOutlet weak var SaveViewTOP: NSLayoutConstraint!
    //var YTComplete = NSString()
    @IBOutlet weak var SaveView: UIView!
    
    @IBOutlet weak var bottomViewBOTTOM: NSLayoutConstraint!
    @IBOutlet weak var bottomViewTOP: NSLayoutConstraint!
   
    
    // let SaveProgressHUD = ProgressHUD(text: "Converting Song...")
    
   // var SaveProgressHUD = SCLAlertView()
    var SaveProgessHUD = SCLAlertView()
    
   // var SaveProgessHUD: SCLAlertViewResponder?
   // let SaveProgressHUD2 = ProgressHUD(text: "Importing Song...")
    //var SaveProgressHUD2: SCLAlertViewResponder?
    var SaveProgessHUD2 = SCLAlertView()
    
    //: SCLAlertViewResponder = SCLAlertView().showSuccess("Hello World", subTitle: "This is a more descriptive text.")
    
    
  //  var SaveProgressHUD2 = SCLAlertView()
    
    @IBOutlet weak var trackView: UIView!
    
    @IBOutlet weak var SelectLinkBTN: UIButton!
    var YT_ID = NSString()
    var CanDownLoad = Bool()
    var musicPlayer: AVAudioPlayer!
    var linkURL = NSURL()
    var AudioFile = NSURL()
    var YTAudioFileTitle = NSString()
    var YTAudioFileArtist = NSString()
   @IBOutlet var ActInd: UIActivityIndicatorView!
   var YouTubeNSData = NSData()
   var audiobrowsedelegate: AudioBrowseViewControllerDelegate?
   var linkData = String()
  // var extractor = LBYouTubeExtractor()
    
   var ImportShowing = Bool()
   var SelectedYTAudio = Bool()
   var videoURL = String()
   var thewebURL = NSString()
    //var webView: WKWebView!
    
    @IBOutlet weak var webView2: UIWebView!
    @IBOutlet weak var urlText: UILabel!
    
   // @IBOutlet weak var theWebView: UIWebView!
    
    @IBOutlet weak var theWebView: UIView!
    /*
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        theWebView = webView
    }
    */
    
    
    var moviePlayer:MPMoviePlayerController!
    
 
    
    
    
    @IBAction func forwardBTN(sender: AnyObject) {
        if webView2.canGoForward{
            webView2.goForward()
        }
        
    }
    
    @IBAction func backBTN(sender: AnyObject) {
        if webView2.canGoBack{
            webView2.goBack()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        webView2.delegate = self
        trackView.layer.cornerRadius = 10
        SelectLinkBTN.hidden = true
        SelectLinkBTN.layer.cornerRadius = 10
        
        self.bottomViewBOTTOM.constant = -60
        
        backBTN.enabled = false
        forwardBTN.enabled = false
        urlText.text = "Please Select A Video Below"
        let url = NSURL(string: "https://www.youtube.com")!
       // SaveView.hidden = true
        //self.bottomViewTOP.constant = -60
        
        webView2.keyboardDisplayRequiresUserAction = true
        
      //  let url = NSBundle.mainBundle().URLForResource("index", withExtension: "html")
        let request = NSURLRequest(URL: url)
        webView2.loadRequest(request)
        ActInd.stopAnimating()
        
        
        
     //   SaveProgessHUD = SCLAlertView().showSuccess("Hello World", subTitle: "This is a more descriptive text.")
        
     //   SaveProgessHUD2 = SCLAlertView().showSuccess("Hello World", subTitle: "This is a more descriptive text.")
        
        self.interstitialPresentationPolicy = ADInterstitialPresentationPolicy.Automatic
        
        
        /*
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            //  self.SaveViewTOP.constant = 10
            
            self.bottomView.center.y = self.bottomView.center.y + 60
            
            self.bottomViewTOP.constant = -60
            //self.ViewShowing = true
            // ShowingInfo = true
            // self.ViewTransTOP.constant = 0
        })
*/
       // webView2.loadHTMLString(html, baseURL: NSBundle.mainBundle().bundleURL)
      //  self.webView = WKWebView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeBTN(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    @IBAction func HowToBTN(sender: AnyObject) {
        
        let AC = JSController("Youtube Audio", MyMessage: "Broswe Youtube for an Audio clip to insert as your 'Quote'.  Tap the 'Import Audio' button, which will appear when you select a video, to import the audio clip to the audio trimming tool.",Color: "Red")
        self.presentViewController(AC, animated: true, completion: nil)
    }
    
    func saveYTVideo(videoURL: String) {
        
     
        
        
        let ytnsdata2 = YouTubeGet(videoURL)
        
//        print(ytnsdata2)
        
        FilterYTLinkData(ytnsdata2)
        do {
           
            linkURL = NSURL(string: linkData)!
            
            ConvertYTVid(linkURL)
         //   musicPlayer = try AVAudioPlayer(contentsOfURL: linkURL)
            
           // var url:NSURL = NSURL(string: "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v")
            
            /*
            
            moviePlayer = MPMoviePlayerController(contentURL: linkURL)
            moviePlayer.view.frame = CGRect(x: 20, y: 100, width: 200, height: 150)
            
            self.view.addSubview(moviePlayer.view)
            moviePlayer.fullscreen = true
            
            moviePlayer.controlStyle = MPMovieControlStyle.Embedded
            

*/
            
          //  moviePlayer.prepareToPlay()
          //  moviePlayer.play()
           // musicPlayer.numberOfLoops = -1
         //   musicPlayer.prepareToPlay()
          //  musicPlayer.play()
            
        } catch {
            print(error)
        }

    }
    
    func ConvertYTVid(YTLink: NSURL) {
        
        let data = NSData(contentsOfURL: YTLink)
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        
        
        let tempTYVideo = (documentDirectory as NSString).stringByAppendingString("/tempYTVideo.mp4")
    //let tempTYVideo = (documentDirectory as NSString).stringByAppendingString("/tempYTVideo.mov")
        if NSFileManager.defaultManager().fileExistsAtPath(tempTYVideo as String) {
            print("Deleting existing file\n")
            
            do {
                
                try NSFileManager.defaultManager().removeItemAtPath(tempTYVideo as String)
                
                
                
                
            } catch {
                print("Error = \(error)")
            }
        }

        
        
        
        do {
            
   //     try data?.writeToFile(tempTYVideo, options: NSDataWritingOptions.AtomicWrite)
            
        try data?.writeToURL(NSURL(fileURLWithPath: tempTYVideo), atomically: true)
        print("File saved to path = \(tempTYVideo)")
        } catch {
            print("ERROR Saving Temp Video = \(error)")
        }
        
        
        
        print("Temp Video Saved at path = \(tempTYVideo)")
        
      //  let savePath = (documentDirectory as NSString).stringByAppendingString("/tempYTAudio.m4a")

     //   dispatch_async(dispatch_get_main_queue(), {
        
        self.createVideoNow(YTLink)
            
    //    })
        
    }
    
        func createVideoNow(YTLink: NSURL) {
    
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]

        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .ShortStyle
        let date = dateFormatter.stringFromDate(NSDate())
        
        var newAudioAsset = AVMutableComposition()
       //var dstCompositionTrack = AVMutableCompositionTrack
        
        //let VideoAsset = AVURLAsset(URL: NSURL(fileURLWithPath: tempTYVideo), options: nil) as AVAsset
        
        let VideoAsset = AVURLAsset(URL: YTLink, options: nil) as AVAsset
        
    //    let VideoAsset = AVURLAsset(fileURLWithpath: YTLink, options: nil) as AVAssetTrack
        print("Video Asset Duration = \(VideoAsset.duration)")
        
     //   let vtrack = VideoAsset.tracksWithMediaType(AVMediaTypeVideo)
   //  print("video track count = \(vtrack.count)")
       // let VideoAsset = AVURLAsset(URL: YTLink, options: nil) as AVAsset
        let atrack = VideoAsset.tracksWithMediaType(AVMediaTypeAudio)
     // dstCompositionTrack = newAudioAsset.tracksWithMediaType(AVMediaTypeAudio)
       // let dstCompositionTrack = newAudioAsset.tracksWithMediaType(AVMediaTypeAudio)
        
        
        let test = VideoAsset.tracks
        
        print("TRACKS =      \(test)")
        
        //, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        //, newAudioAsset.trackWithTrackID(kCMPersistentTrackID_Invalid)
       // dstCompositionTrack
     //   let videoTrack:AVAssetTrack = vtrack[0]
        
        var audioTrack: AVAssetTrack?
        var compVideoTrack: AVMutableCompositionTrack
        print("audio track searching")
        
        print("Track count = \(atrack.count)")
        
        if atrack.count == 0 {
            print("no tracks found")
            
            
            
            let theAlert = SCLAlertView()
            theAlert.addButton("Ok") {
                
                  self.SaveProgessHUD.removeFromParentViewController()
                print("Cancel pushed")
            }
            theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor.redColor(), title: "Invalid Format", subTitle: "Select another video.")
            
            
            /*
            
            let alertController = UIAlertController(title: "Invalid Format", message: "This Youtube Video is in an invalid Format.  Select another video.", preferredStyle: .Alert)
            
           // let CancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action:UIAlertAction) in
             //   print("Cancel button pressed")
                
            //}
            
            let OkAction = UIAlertAction(title: "Ok", style: .Default) { (action:UIAlertAction) in
                print("OK button pressed")
                
        //   self.SaveProgressHUD.removeFromSuperview()
           // self.SaveProgessHUD.close()
                self.SaveProgessHUD.removeFromParentViewController()
            }
            alertController.addAction(OkAction);
            
            alertController.view.tintColor = UIColor.blackColor();
           
            
            self.presentViewController(alertController, animated: true, completion: nil)
            */
            
            //   }

       // compVideoTrack = newAudioAsset.addMutableTrackWithMediaType(AVMediaTypeAudio, preferredTrackID: (kCMPersistentTrackID_Invalid))
            
            
        }  else {
            
            print("tracks found")
        
    //    self.SaveProgressHUD.removeFromSuperview()
      //  self.SaveProgressHUD.removeFromParentViewController()
         self.SaveProgessHUD.removeFromParentViewController()
            
      //  self.view.addSubview(self.SaveProgressHUD2)
        
   self.SaveProgessHUD2.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor.redColor(), title: "Importing Song...", subTitle: "We're almost done.")
            
            
        audioTrack = atrack[0]
        compVideoTrack = newAudioAsset.addMutableTrackWithMediaType(AVMediaTypeAudio, preferredTrackID: 0)
      
            
        
        //print("audio track found")
        //let vocalStartMarker = CMTimeMake((int)(floor(0 * 100)), 100);
        let timeRange = audioTrack!.timeRange
        
        
       // let mixComposition = AVMutableComposition()
        
       // let compVideoTrack = newAudioAsset.addMutableTrackWithMediaType(AVMediaTypeVideo, preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
  print("setting up comp video")
        
        
       // let compVideoTrack = newAudioAsset.addMutableTrackWithMediaType(AVMediaTypeAudio, preferredTrackID: 0)
        
        do {
            try compVideoTrack.insertTimeRange(timeRange, ofTrack: audioTrack! , atTime: kCMTimeZero)
        } catch {
            print("Audio Error = \(error)")
        }
        
/*
        var allAudioParams = AVMutableAudioMixInputParameters()
        let audioZeroMix : AVMutableAudioMix = AVMutableAudioMix()
        audioZeroMix.inputParameters = [allAudioParams]
  */
 
        
      //  let compAudioTrack = mixComposition.addMutableTrackWithMediaType(AVMediaTypeAudio, preferredTrackID: 0)
        
        
        
        let aud_duration = audioTrack!.timeRange.duration
        print("Audio Duration = \(aud_duration)")
        
        
      //  let gameComposition1 = AVMutableVideoComposition()
      //  let YTComposition = AVMutableAudioMix()

        
        
        let exporter = AVAssetExportSession(asset: newAudioAsset, presetName: AVAssetExportPresetAppleM4A)
        
        let savePath = (documentDirectory as NSString).stringByAppendingString("/tempYTAudio.m4a")
        
        //REMOVE ANY PREVIOUS FILES
       
        
        
        print("Save Path = \(savePath)")
        
        if NSFileManager.defaultManager().fileExistsAtPath(savePath as String) {
            print("Deleting existing file\n")
            
            do {
                
                try NSFileManager.defaultManager().removeItemAtPath(savePath as String)
            } catch {
                print("Error = \(error)")
            }
        }

        
        let SaveUrl = NSURL(fileURLWithPath: savePath)
       // exporter!.audioMix = audioZeroMix
        exporter!.outputURL = SaveUrl
        exporter!.outputFileType = AVFileTypeAppleM4A
        
       // exporter!.outputFileType = AVFil
       // exporter!.timeRange = CMTimeRangeFromTimeToTime(kCMTimeZero, aud_duration)
      //  exporter!.shouldOptimizeForNetworkUse = true
        
        
        exporter!.exportAsynchronouslyWithCompletionHandler() {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                // let progressHUD = ProgressHUD(text: "Creating Video, Please Wait...")
                //   self.view.addSubview(progressHUD)
               self.exportDidFinish(exporter!)
                
            //  progressHUD.removeFromSuperview()
            })
        }
        
        if SelectedYTAudio {
          print("Browse showing selected audio file")
            
            /*
            self.dismissViewControllerAnimated(true, completion: nil)
            self.audiobrowsedelegate?.AudioBrowseViewControllerFinished(self)
*/
            
        }
        
      }
        
    }
    
    func exportDidFinish(session: AVAssetExportSession)  {
        switch (session.status) {
        case AVAssetExportSessionStatus.Completed :
            print("Complete")
             self.SelectedYTAudio = true
            print("export complete, selected yt audio = \(SelectedYTAudio)")
            self.AudioFile = session.outputURL!
            //self.SelectedYTAudio = true
          //self.YTComplete = "yes"
            
            
            dispatch_async(dispatch_get_main_queue(),{
                
                self.SaveProgessHUD2.removeFromParentViewController()
                
            
            
            
            self.dismissViewControllerAnimated(true, completion: nil)
          //  self.audiobrowsedelegate?.AudioBrowseViewControllerFinished(self)
            
            

            if self.SentVC == "quoteview" {
            NSNotificationCenter.defaultCenter().postNotificationName("YTTrim", object: nil, userInfo: ["data":self.AudioFile, "title":self.YTAudioFileTitle]);
            } else {
               NSNotificationCenter.defaultCenter().postNotificationName("YTTrim2", object: nil, userInfo: ["data":self.AudioFile, "title":self.YTAudioFileTitle]);  
            }
                
            })
            
        case AVAssetExportSessionStatus.Exporting:
            print("Exporting")
        case AVAssetExportSessionStatus.Failed:
            print("Failed error = \(session.error)")
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Error!"
            alertView.message = "There was an error converting this audio.  Please try again or select another video."
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
           // alertView.show()
            
            
            dispatch_async(dispatch_get_main_queue(),{


            SCLAlertView().showCustomOK(UIImage(named: "musicIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Error Converting", subTitle: "Please try again", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
            
            })
            
          //  return false
        case AVAssetExportSessionStatus.Unknown:
            print("Unknown")
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Error!"
            alertView.message = "There was an error converting this audio.  Please try again or select another video."
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
          //  alertView.show()
            
            dispatch_async(dispatch_get_main_queue(),{
                
                
                SCLAlertView().showCustomOK(UIImage(named: "musicIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Error Converting", subTitle: "Please try again", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
            
          //  return false
        case AVAssetExportSessionStatus.Waiting:
            print("Waiting")
           // return false
        default:
            print("Default")
          //  return false
        }
        
        //self.SaveProgressHUD2.removeFromSuperview()
       // self.SaveProgressHUD2.close()
        
        dispatch_async(dispatch_get_main_queue(),{
        
          self.SaveProgessHUD2.removeFromParentViewController()
            
        })
        
        
        //green - UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
        //blue - UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0)
        //red - UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0)

        
        
       // self.dismissViewControllerAnimated(true, completion: nil)
        
       // self.audiobrowsedelegate?.AudioBrowseViewControllerFinished(self)
        

        /*
        if SelectedYTAudio {
            //self.dismissViewControllerAnimated(true, completion: {
                self.audiobrowsedelegate?.AudioBrowseViewControllerFinished(self)
          //  })
self.dismissViewControllerAnimated(true, completion: nil)
        }
*/
        
        
    }

        
        
        /*
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let destinationPath2 = NSURL(fileURLWithPath: documentsPath).URLByAppendingPathComponent("youtubeTemp.m4v")
        
        do {
        let destinationPath = try String(contentsOfURL: destinationPath2)        //) documentsPath.stringByAppendingPathComponent("youtubeTemp.mp3")
       // UIImageJPEGRepresentation(image,1.0).writeToFile(destinationPath, atomically: true)
        // var stringURL: String = videoURL
        
    let url: NSURL = NSURL(string: videoURL)!
        print("video URL to save = \(videoURL)")
    let urlData: NSData = NSData(contentsOfURL: url)!
   // urlData.writeToURL(url, atomically: true)
        urlData.writeToFile(destinationPath, atomically: true)
            
        } catch {
            print(error)
        }

*/
//    }
//}
   
    /*
    
    func setupVideo(YTURL: String) {
        SSYoutubeParser.h264videosWithYoutubeID(YTURL) { (videoDictionary) -> Void in
            let videoSmallURL = videoDictionary["small"]
            let videoMediumURL = videoDictionary["medium"]
            let videoHD720URL = videoDictionary["hd720"]
            
            
            
            if let urlStr = videoMediumURL {
                print("urlstring = \(urlStr)")
                
                if let playerItem:AVPlayerItem = AVPlayerItem(URL: NSURL(string: urlStr)!) {
                    //self.avPlayerView.player = AVPlayer(playerItem: playerItem)
                    //playerItem.addObserver(self, forKeyPath: "status", options: [.New,.Old,.Initial], context: nil)
                }
            }
        }
    }
    
   */
    
    @IBAction func SelectLinkBTN(sender: AnyObject) {
  
        self.SaveProgessHUD.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor.redColor(), title: "Converting Song...", subTitle: "This may take a few minutes...")
        
      // self.view.addSubview(self.SaveProgressHUD)
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in

        
        if Reachability.isConnectedToNetwork() {

      //  setupVideo(thewebURL as String)
       self.saveYTVideo(self.YT_ID as String)
            
        } else {
           // self.SaveProgressHUD.close()
            
            dispatch_async(dispatch_get_main_queue(),{
            
            self.SaveProgessHUD.removeFromParentViewController()
//            self.SaveProgressHUD.removeFromSuperview()
           // self.SaveProgressHUD2.removeFromSuperview()
            let AC = JSController("Network Connection Error", MyMessage: "Please check your network settings, you'll need access to play",Color: "Red")
           // self.presentViewController(AC, animated: true, completion: nil)
            
            dispatch_async(dispatch_get_main_queue(),{
                
                
                SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.99, green: 0.69, blue: 0.35, alpha: 1.0), title: "Network Connection Error", subTitle: "Please check your network settings.", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
            })

           
           }
        })
    }

   func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    
    print("did finish loading web page")
    print("request = \(request.URL)")
    
    
    //thewebURL = request.description
   // urlText.text = thewebURL as String
        return true
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        print("did finish navigation")
    }
    
  
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        self.backBTN.enabled = true
        self.forwardBTN.enabled = true
        
        /*
        if webView2.canGoBack{
            self.backBTN.enabled = true
        } else {
            self.backBTN.enabled = false
        }

        if webView2.canGoForward{
            self.forwardBTN.enabled = true
        }
        
        else {
            self.forwardBTN.enabled = false
        }

        */
        let currentURL = self.webView2.request!.URL?.absoluteString
        
        print("Current URL = \(currentURL)")
        
        //urlText.text = currentURL
        YT_ID = YouTubeID(currentURL!)
        
        print("YoutubeID = \(YT_ID)")
        
        if YT_ID.isEqualToString("") {
            
            urlText.text = "PLEASE SELECT A VIDEO BELOW"
            
            trackView.layer.backgroundColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
.CGColor
            
            if ImportShowing {
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                
                //  self.SaveViewTOP.constant = 10
                
                self.bottomView.center.y = self.bottomView.center.y + 60
                
                self.bottomViewBOTTOM.constant = -60
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
                ImportShowing = false
            }
            
        } else {
            YouTubeNSData = YouTubeData(YT_ID)
            //let YouTubeArray =
            
            FilterYTData(YouTubeNSData)
            CanDownLoad = true
            trackView.layer.backgroundColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).CGColor
            SaveView.hidden = false
            SelectLinkBTN.hidden = false
            thewebURL = currentURL!
            
            if !ImportShowing {
            
            
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                
              //  self.SaveViewTOP.constant = 10
                
                self.bottomView.center.y = self.bottomView.center.y - 60
                
                self.bottomViewBOTTOM.constant = 0
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
                
                ImportShowing = true
                
        }
     print("YouTube NSData = \(YouTubeNSData)")
     }
    
    }

    func webViewDidStartLoad(webView: UIWebView) {
        print("stared loading web view")
    }
    
    
    
    func YouTubeID(youtubeURL: String) -> String {
       // var error: NSError?
        let pattern: String = "(?<=v(=|/))([-a-zA-Z0-9_]+)|(?<=youtu.be/)([-a-zA-Z0-9_]+)"
        do {
        let regex = try NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
            
            if let regexMatch = regex.firstMatchInString(youtubeURL, options: NSMatchingOptions(), range: NSRange(location: 0, length: youtubeURL.characters.count)) {
                return (youtubeURL as NSString).substringWithRange(regexMatch.range)
              }
            return ""
            
        } catch {
            print(error)
            return ""
        }
    }
    
    func FilterYTData(urlData: NSData) {
        print("filtering data")
//    }-> [NSString] {
        
        // var traits = [NSString]()
        
        let jsonData:NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(urlData, options:NSJSONReadingOptions.MutableContainers )) as! NSDictionary
        
      //  let YT_Array = [NSString]()
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        print("Json valueJSON: \(json)")
        
        
       // let duration = json["duration"].stringValue
        
        for result in json["items"].arrayValue {
            print("Items found")
            
            let title2 = result["kind"].stringValue
            print("kind = \(title2)")
            
            
           // for result2 in result["snippet"].arrayValue {
           // print("snippet found")
                let title = result["snippet"]["title"].stringValue
            print("Title = \(title)")
            urlText.text = "Title: \(title as String)"
            YTAudioFileTitle = title
            YTAudioFileArtist = ""
          //  }
        }
      
        //return YT_Array
        
    }
    
    
    
    func FilterYTLinkData(urlData: NSData) {
        print("filtering data")
        //    }-> [NSString] {
        
        // var traits = [NSString]()
        
        let jsonData:NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(urlData, options:NSJSONReadingOptions.MutableContainers )) as! NSDictionary
        
        //  let YT_Array = [NSString]()
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        print("Json valueJSON: \(json)")
        
        
        // let duration = json["duration"].stringValue
        
        linkData =  json["link"].stringValue
      
        
        //return YT_Array
        
    }
    
    
    func prepareAd() {
        print(" --- AD: Try Load ---")
        // Attempt to load a new ad:
        interAd = ADInterstitialAd()
        interAd?.delegate = self
    }
    
    func showAd() -> Bool {
        if interAd != nil && interAd!.loaded {
            interAdView = UIView()
            interAdView.frame = self.view!.bounds
            self.view?.addSubview(interAdView)
            
            interAd!.presentInView(interAdView)
            UIViewController.prepareInterstitialAds()
            
            interAdView.addSubview(closeButton)
        }
        
        // Return true if we're showing an ad, false if an ad can't be displayed:
        return interAd?.loaded ?? false
    }
    
    // When the user clicks the close button, route to the adFinished function:
    func closeAd(sender: UIButton) {
        adFinished()
    }
    
    // A function of common functionality to run when the user returns to your app:
    func adFinished() {
        closeButton.removeFromSuperview()
        interAdView.removeFromSuperview()
        // (Do whatever is next in your app)
    }
    
    // The ad loaded successfully (we don't need to do anything for the basic implementation)
    func interstitialAdDidLoad(interstitialAd: ADInterstitialAd!) {
        print(" --- AD: Load Success ---")
    }
    
    // The ad unloaded (we don't need to do anything for the basic implementation)
    func interstitialAdDidUnload(interstitialAd: ADInterstitialAd!) {
        print(" --- AD: Unload --- ")
    }
    
    // This is called if the user clicks into the interstitial, and then finishes interacting with the ad
    // We'll call our adFinished function since we're returning to our app:
    func interstitialAdActionDidFinish(interstitialAd: ADInterstitialAd!) {
        print(" --- ADD: Action Finished --- ")
        adFinished()
    }
    
    func interstitialAdActionShouldBegin(interstitialAd: ADInterstitialAd!, willLeaveApplication willLeave: Bool) -> Bool {
        return true
    }
    
    // Error in the ad load, print out the error
    func interstitialAd(interstitialAd: ADInterstitialAd!, didFailWithError error: NSError!) {
        print(" --- AD: Error --- ")
        print(error.localizedDescription)
    }
    
    private func showIntersitialAd() { //call this method whenever you want to show an interstitial
        self.requestInterstitialAdPresentation()
    }



}
