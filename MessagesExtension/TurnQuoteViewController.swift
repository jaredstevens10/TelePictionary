//
//  TurnQuoteViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 10/27/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import Messages
import ImageIO

class TurnQuoteViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var reportBTN: UIButton!
    
    
    @IBOutlet weak var quoteTitle: UILabel!
    
    let prefs:UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var newGameInfoLBL: UILabel!
    @IBOutlet weak var ImageHolderLBL: UILabel!
    var newGame = Bool()
    var isNewGame = NSString()
    
    var currentTurnNumber = NSString()
    var newTurnNumber = NSString()
    
    var TempTurnNumber = NSString()
    //@IBOutlet var textViewTap: UITapGestureRecognizer!
    
    
    let SaveProgressHUD = ProgressHUD(text: "Saving Turn...")
    weak var delegate: TurnQuoteViewControllerDelegate?
    @IBOutlet weak var SmallViewTOP: NSLayoutConstraint!
    
    
    @IBOutlet weak var SmallView: UIView!
    
    static let storyboardIdentifier = "TurnQuoteViewController"

    @IBOutlet weak var submitBTN: UIButton!
   // var base64Image = String()
    @IBOutlet weak var QuoteBoxtxt: UITextView!
    
    var mediaType = NSString()
    var theImage = UIImage()
    
    var GameID = NSString()
    var currentTurn = NSString()
    
    @IBOutlet weak var imageViewHolder: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    //var tapTerm = UIGestureRecognizer()
    
    //var tapTerm:UITapGestureRecognizer = UITapGestureRecognizer()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let DeviceW = self.view.frame.width
        let DeviceH = self.view.frame.height
        
        let FontSizeTemp = DeviceW / 10
        
        self.quoteTitle.font.withSize(FontSizeTemp)
        
        self.imageViewHolder.alpha = 1.0
        self.imageViewHolder.isHidden = true
        self.newGameInfoLBL.isHidden = true
        // self.SmallViewTOP.constant = 100
        
        QuoteBoxtxt.layer.cornerRadius = 5
        
        QuoteBoxtxt.text = "Enter Your Quote Here..."
        QuoteBoxtxt.textColor = UIColor.lightGray
        QuoteBoxtxt.textAlignment = .center
        QuoteBoxtxt.delegate = self
        
       // view.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        
        self.submitBTN.layer.cornerRadius = 30
        self.submitBTN.layer.borderColor = UIColor.white.cgColor
        self.submitBTN.layer.borderWidth = 1
        
        self.imageViewHolder.layer.cornerRadius = 10
        self.imageViewHolder.clipsToBounds = true
        self.imageViewHolder.layer.masksToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(TurnQuoteViewController.UpdateQuoteFrameView(_:)), name: NSNotification.Name(rawValue: "UpdateQuoteFrameView"),  object: nil)
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TurnQuoteViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        
    }
    /*
    func handleTap(tap: UITapGestureRecognizer) {
        if (tap.state == UIGestureRecognizerState.ended) {
            
            QuoteBoxtxt.text = ""
            QuoteBoxtxt.textColor = UIColor.black
            QuoteBoxtxt.textAlignment = .left
        }
    }
    */
 
   /*
    func tapTextView(_ sender: AnyObject) {
        
        QuoteBoxtxt.text = ""
        QuoteBoxtxt.textColor = UIColor.black
        QuoteBoxtxt.textAlignment = .left
        
    }
    */
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
    
    func tapTextView(sender:UITapGestureRecognizer) {
        print("tapped term – but blocking the tap for textView :-/")
        
        QuoteBoxtxt.text = ""
        QuoteBoxtxt.textColor = UIColor.black
        QuoteBoxtxt.textAlignment = .left
    
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if QuoteBoxtxt.text == "Enter Your Quote Here..." {
            
            QuoteBoxtxt.text = ""
            QuoteBoxtxt.textColor = UIColor.black
            QuoteBoxtxt.textAlignment = .left
            
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if QuoteBoxtxt.text == "" {
            
            QuoteBoxtxt.text = "Enter Your Quote Here..."
            QuoteBoxtxt.textColor = UIColor.lightGray
            QuoteBoxtxt.textAlignment = .center
            
        }
        
    }
    
    func keyboardWasShown(_ notification: Notification) {
        
        submitBTN.isHidden = true
        
       // var info = (notification as NSNotification).userInfo!
        
        
      //  let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        

        
        
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
        
        /*
        //    let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            // self.textBoxBOTTOM.constant = 5
            
            
            //  self.emailBOTTOM.constant = 10
            //self.QuoteLabelTop.constant = 50
            //self.qbDoneBOTTOM.constant = (keyboardFrame.size.height + 5) + self.GameTitleTXT.frame.size.height
            
            self.doneBTNBOTTOM.constant = -100
        })
        
        */
        
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
    
    
    func UpdateQuoteFrameView(_ notification:Notification) {
        
        let userInfo:Dictionary<String,String?> = (notification as NSNotification).userInfo as! Dictionary<String,String?>
        
        var jsonAlert = JSON(userInfo)
        print("JSON ALERT \(jsonAlert)")

        let RawValue = jsonAlert["rawValue"].stringValue
        print("in Quote, presentation value = \(RawValue)")
        switch RawValue {
            case "1":
                UIView.animate(withDuration: 1.0, animations: { () -> Void in
                    
                    
                    self.SmallView.center.y = self.SmallView.center.y + 100
                    self.SmallViewTOP.constant = 100
                    
                })
                
            
            case "0":
                
                UIView.animate(withDuration: 1.0, animations: { () -> Void in
                    
                    
                    self.SmallView.center.y = self.SmallView.center.y - 100
                     self.SmallViewTOP.constant = 0
                    
                })
                
            
        default:
            break
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("TURN QUOTE APPEARED")
        
        print("Turn Quote VC - GameID = \(GameID)")
        
         print("NewGame: \(newGame)")
        
        if newGame {
            isNewGame = "yes"
            
            self.reportBTN.isHidden = true
            self.imageViewHolder.alpha = 0.0
            self.imageViewHolder.isHidden = false
            
            UIView.animate(withDuration: 2.50, animations: {
                self.imageViewHolder.alpha = 1.0
            })
            
            self.ImageHolderLBL.text = "Start A New Game!"
            self.newGameInfoLBL.isHidden = false
            
        } else {
            self.reportBTN.isHidden = false
            self.imageViewHolder.alpha = 0.0
            self.imageViewHolder.isHidden = false
            
            UIView.animate(withDuration: 2.50, animations: {
                self.imageViewHolder.alpha = 1.0
            })
            
            self.ImageHolderLBL.text = "Image To Describe"
            self.newGameInfoLBL.isHidden = true
            
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
            
            
            if prefs.value(forKey: "TURNINFO_GAMEID") != nil {
                
                
            
            let TempGameID = prefs.value(forKey: "TURNINFO_GAMEID") as! NSString
                
                if TempGameID == "NA" {
            print("Nothing Happens because the GameID = NA")
                    
                } else {
                    
            print("temp game id = \(TempGameID)")
            print("temp turn number = \(TempTurnNumber)")
            var TheImageURL = NSString()
            var TheImageURL2 = NSString()
            (mediaType, theImage, TheImageURL) = LoadImage(GameID_Orig: TempGameID, GameTurn: self.newTurnNumber)
                    
                    
                    
                    if mediaType == "gif" {
                        
                        print("Get GIF from URL")
                        
                        TheImageURL2 = "\(TheImageURL).gif" as NSString
                        let url = URL(string: TheImageURL2 as String)
                        let data = try? Data(contentsOf: url!)
                        
                       //self.imageView.image = UIImage.gifWithData(data!)
                        self.imageView.image = UIImage.animatedImage(withAnimatedGIFData: data)
                        
                    } else {

            self.imageView.image = theImage
            self.imageView.contentMode = UIViewContentMode.scaleAspectFit
                        
                    }
                    
                }
                
            } else {
                
                
                
                
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
    
    
    @IBAction func submitBTN(_ sender: AnyObject) {
        
        
    
        
        
        
        let Quote:NSString = QuoteBoxtxt.text as NSString
        let QorA = "quote"
        let turnStyle = "quote"
        
        
        if ( Quote.isEqual(to: "") || Quote.isEqual(to: "Enter Your Quote Here...") ) {
            
            /*
             var alertview = JSSAlertView().show(self, title: "Please enter your quote describing the picture below", buttonText: "Ok", color: UIColorFromHex(0x66b2ff, alpha:1))
             alertview.setTextTheme(.Light)
             */
            
            
            
            let alertController = UIAlertController(title: "Error", message: "Please enter your quote describing the picture below.", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action:UIAlertAction!) in
                // println("you have pressed the Cancel button");
            }
            alertController.addAction(cancelAction)
            
            /*
            let OKAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction!) in
                
                
                
                //println("you have pressed OK button");
            }
            alertController.addAction(OKAction)
            */
            self.present(alertController, animated: true, completion:nil)
            
            
            /*
            
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
            */
            
        } else {
            
            
            
            let alertController = UIAlertController(title: "Submit Turn", message: "Are you sure you want to submit this \(QorA)?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Not Yet", style: .cancel) { (action:UIAlertAction!) in
               // println("you have pressed the Cancel button");
            }
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction!) in
                
                
                if Reachability.isConnectedToNetwork() {
                
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
                
                if self.newGame {
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "SendMessage"), object: nil, userInfo: ["message":"Insert a picture that best illustrates this quote.","turnType":"quote","quote":"\(Quote)","imageData":"NA","currentTurnNumber":"\(self.currentTurnNumber)","gameID":"NA","mediaType":"NA","turnNumber":"NA","username":"NA","userID":"NA","turnStyle":"NA","IsCompleteInfo":"NA","newTurn":"NA","NG_GameTitle":"NA","NG_PlayerTemp":"NA","NG_FirstTurn":"quote","NG_TurnTime":"NA","NG_ContentRating":"NA","NameArrayDELETE":"NA","EmailArrayDELETE":"NA","UNIDArrayDELETE":"NA","newGame":"\(self.isNewGame)"])
                
                } else {
                    
                    let tempGameID = self.prefs.value(forKey: "TURNINFO_GAMEID") as! NSString
                    
                  NotificationCenter.default.post(name: Notification.Name(rawValue: "SendMessage"), object: nil, userInfo: ["message":"Insert a picture that best illustrates this quote.","turnType":"quote","quote":"\(Quote)","imageData":"NA","currentTurnNumber":"\(self.newTurnNumber)","gameID":"\(tempGameID)","mediaType":"quote","turnNumber":"\(self.newTurnNumber)","username":"NA","userID":"NA","turnStyle":"NA","IsCompleteInfo":"NA","newTurn":"NA","NG_GameTitle":"NA","NG_PlayerTemp":"NA","NG_FirstTurn":"quote","NG_TurnTime":"NA","NG_ContentRating":"NA","NameArrayDELETE":"NA","EmailArrayDELETE":"NA","UNIDArrayDELETE":"NA","newGame":"no"])
                    
                    
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
                

            }
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
            
            /*
            let theAlert = SCLAlertView()
            theAlert.addButton("Yes") {
                self.view.addSubview(self.SaveProgressHUD)
                
                /*dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                 */
                
                DispatchQueue.main.async(execute: {
                    
                    
                     NotificationCenter.default.post(name: Notification.Name(rawValue: "SendMessage"), object: nil, userInfo: ["message":"What picture best describes this quote?","turnType":"quote","quote":"\(Quote)"])
                    
                   // self.StartSubmitButton(Quote, turnStyle: turnStyle as NSString)
                    //self.ActInd.stopAnimating()
                    //  });
                })
            }
            theAlert.addButton("Not yet") {
            }
            // theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Submit", subTitle: "Are you sure you want to submit this \(QorA)?")
            
         //   theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Submit?", subTitle: "Are you sure you want to submit this \(QorA)?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
            
            
        */
        
        
        
        
        
         //print("SHould submit quote")
        
       
        
        
    }
    
      //  let theTurn = TurnInfo(currentUser: "currentUser", lastUser: "lastUser", TurnType: "quote", TurnURL: "turnURL")
        
       // delegate?.turnQuoteViewController(self, didSelect: theTurn)
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

    
    func DismissKeyboard(){
        view.endEditing(true)
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
    
    

}



protocol TurnQuoteViewControllerDelegate: class {
    /// Called when the user taps to select an `IceCreamPart` in the `BuildIceCreamViewController`.
    func turnQuoteViewController(_ controller: TurnQuoteViewController, didSelect previousTurn: TurnInfo)
}
