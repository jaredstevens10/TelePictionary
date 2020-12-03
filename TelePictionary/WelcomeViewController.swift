//
//  WelcomeViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 8/30/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import AVFoundation

class WelcomeViewController: UIViewController {
    
    var myPlayer: AVAudioPlayer!
    //let audioURL = NSBundle.mainBundle().URLForResource("MrTPain", withExtension: ".mp3")
    
    var ShowSwipe = Bool()
    @IBOutlet weak var swipeIMG: UIImageView!
    
    @IBOutlet weak var swipeRIGHT: NSLayoutConstraint!
    
    @IBOutlet var LogoImage: UIImageView!
    var theLogo = UIImage()
    @IBOutlet var HowToLBL: UILabel!
    @IBOutlet var HowToImage: UIImageView!
    var ShowLogo = Bool()
    @IBOutlet weak var closeBTN: UIButton!
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet var PlayButton: UIButton!
    var PlayHidden = Bool()
    
    var ImageTitleText = NSString()
    @IBOutlet weak var ImageTitleLBL: UILabel!
    @IBOutlet var label3: UILabel!
    var ShowHowToPic = Bool()
    var testLBL = NSString()
    var HowToText = NSString()
    var Label3Text = NSString()
    var strLabel = UILabel()
    var messageFrame = UIView()
    var HowToPic = UIImage()
    
    var ActivityInd = UIActivityIndicatorView()
    
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var FrameImageView: UIImageView!
    
    @IBOutlet weak var QuoteBoxImage: UIImageView!
    
    //TITLE LABEL
    @IBOutlet weak var labelTXT: UILabel!
    
    @IBOutlet weak var Quotetxt: UILabel!
    
    var pageIndex = Int()
    var titleText = NSString()
    var imageName = UIImage()
    var ImageFrame = UIImage()
    var QuoteImageName = UIImage()
    var QuoteText = String()
    func progressBarDisplayer(_ msg:String, _ indicator:Bool){
        print(msg)
        strLabel = UILabel(frame: CGRect(x:50, y: 0, width: 200, height: 50))
        strLabel.text = msg
        strLabel.textColor = UIColor.white
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25 , width: 180, height: 50))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        if indicator {
            ActivityInd = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
            ActivityInd.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            ActivityInd.startAnimating()
            messageFrame.addSubview(ActivityInd)
        }
        messageFrame.addSubview(strLabel)
        view.addSubview(messageFrame)
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        labelTXT.isHidden = true
        
        /*
        do {
            try myPlayer = AVAudioPlayer(contentsOfURL: audioURL!)
        } catch {
            print("player not available")
        }
        
        */
       // myPlayer.prepareToPlay()

        swipeIMG.layer.cornerRadius = 20
        self.testLabel.text = testLBL.description
        //self.HowToImage.layer.cornerRadius = 10
        //HowToImage.layer.masksToBounds = true
        closeBTN.layer.cornerRadius = 90
        closeBTN.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        self.ImageTitleLBL.text = ImageTitleText as String
      //  self.ImageView.image = imageName
//        self.ImageView.image = UIImage(named: "chalkboard bg.png")
          self.ImageView.image = UIImage(named: "CSBackgroundTileNew4.png")
        self.labelTXT.text = titleText.description
        //self.LabelTXT.
        self.HowToImage.image = HowToPic
        self.HowToImage.isHidden = ShowHowToPic
        self.HowToLBL.text = HowToText as String
        self.LogoImage.image = theLogo
        self.LogoImage.isHidden = ShowLogo
        print("logo image hidden = \(ShowLogo)")
        self.label3.text = Label3Text as String
        closeBTN.imageView?.image = UIImage(named: "left arrow white.png")
        PlayButton.isHidden = PlayHidden
        
        closeBTN.imageView?.layer.borderWidth = 1
        closeBTN.imageView?.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        
        closeBTN.imageView?.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        
        closeBTN.imageView?.layer.cornerRadius = 20
         self.swipeRIGHT.constant = -89
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeBTN(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if ShowSwipe {
            
        
            UIView.animate(withDuration: 9.0, animations: { () -> Void in
                
                
                self.swipeIMG.center.x = self.swipeIMG.center.x - 20
                
                self.swipeRIGHT.constant = -69
                
                UIView.animate(withDuration: 1.0, animations: { () -> Void in
                    
                    
                    self.swipeIMG.center.x = self.swipeIMG.center.x - 70
                    
                    self.swipeRIGHT.constant = 11
                    
                })
                
            })

            
        /*
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            
            self.swipeIMG.center.x = self.swipeIMG.center.x - 70
            
            self.swipeRIGHT.constant = 11
            
        })
*/
        }
    }

    @IBOutlet weak var CloseBTn: UIButton!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func PlayAudioClip(_ sender: AnyObject) {
        
       // myPlayer.play()
    }
}
