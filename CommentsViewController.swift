//
//  CommentsViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 10/20/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var commentDataTemp = [NSArray]()
    var userIDArrayTemp = [NSString]()
    var userIDArrayInfo = [NSString]()
    var userArrayTemp = [NSString]()
    var idArrayTemp = [NSString]()
    var commentArrayTemp = [NSString]()
    var dateArrayTemp = [NSString]()
    var datetimeArrayTemp = [NSString]()
    var gameidArrayTemp = [NSString]()
    var userID = NSString()
    var CommentIDSelected = NSString()
    var NumComments = NSString()
    var GameID = NSString()
    var username = NSString()
    var userArrayInfo = [NSString]()
    var idArrayInfo = [NSString]()
    var commentArrayInfo = [NSString]()
    var dateArrayInfo = [NSString]()
    var datetimeArrayInfo = [NSString]()
    var gameidArrayInfo = [NSString]()
    var Reply = NSString()
    var ReplyUser = NSString()
    var ReplyUserID = NSString()
    var theComment = NSString()
    var CommentDataInfo = [NSArray]()
   // var timestamp = NSString()
    var refreshControl:UIRefreshControl!
    //var UserIDSelected = NSString()
    
    var wasNotified = Bool()
    

    @IBOutlet var NoCommentsLBL: UILabel!
    var timestamp: NSString {
        return "\(Date().timeIntervalSince1970 * 1000)" as NSString
    }
    
    @IBOutlet var doneBTN: UIButton!
    @IBOutlet var commentTXT: UITextView!
    
    @IBOutlet var doneBTNBOTTOM: NSLayoutConstraint!
    @IBOutlet var TableView: UITableView!
    
    @IBOutlet var submitBTN: UIButton!
    
    @IBOutlet var TableViewTOP: NSLayoutConstraint!
    
    
    @IBOutlet var actInd: UIActivityIndicatorView!
    let prefs:UserDefaults = UserDefaults.standard
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBTN.isHidden = true
        self.refreshControl = UIRefreshControl()
        doneBTN.layer.cornerRadius = 10
        
        if GameID.isEqual(to: "") {
            GameID = (prefs.value(forKey: "COMMENTGAMEID") as? NSString)!
        }
        
        NoCommentsLBL.isHidden = true
       // var timestamp = NSString()
        if prefs.value(forKey: "USERNAME") != nil {
            
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString

        } else  {
            username = "tempName"
            userID = "tempID"
        }
        
        submitBTN.layer.cornerRadius = 10
        submitBTN.layer.borderWidth = 1
        submitBTN.layer.borderColor = UIColor.black.cgColor
        commentTXT.layer.cornerRadius = 5
        commentTXT.layer.borderWidth = 1
        commentTXT.layer.borderColor = UIColor.black.cgColor
        
        TableView.dataSource = self
        TableView.delegate = self
        
        self.TableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.refreshControl.addTarget(self, action: #selector(CommentsViewController.RefreshCommentData(_:)), for: UIControl.Event.valueChanged)
        self.TableView.addSubview(refreshControl)
    
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CommentsViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CommentsViewController.keyboardWasShown(_:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(CommentsViewController.keyboardWillHide(_:)), name:UIResponder.keyboardWillHideNotification, object: nil);
        
self.TableViewTOP.constant = 5
        // Do any additional setup after loading the view.
    }
    
    
    
    @objc  func DismissKeyboard(){
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        if Reachability.isConnectedToNetwork() {
     
            
            if prefs.value(forKey: "USERNAME") != nil {
               
                print("adding array data")
                let URLData = GetCommentData(GameID)
                //println(test)
                CommentDataInfo = FilterCommentData(URLData)
                print("Aboue to sync CommentData = \(CommentDataInfo)")
                
                idArrayInfo = CommentDataInfo[0] as! [(NSString)]
                
                userArrayInfo = CommentDataInfo[1] as! [(NSString)]
                commentArrayInfo = CommentDataInfo[2] as! [(NSString)]
                
                dateArrayInfo = CommentDataInfo[3] as! [(NSString)]
                datetimeArrayInfo = CommentDataInfo[4] as! [(NSString)]
                
                gameidArrayInfo = CommentDataInfo[5] as! [(NSString)]
                userIDArrayInfo = CommentDataInfo[6] as! [(NSString)]
                
                print("Game id array = \(gameidArrayInfo)")
                
            //    self.TableView.reloadData()
                
                if commentArrayInfo.count == 0 {
                    NoCommentsLBL.isHidden = false
                } else {
                    NoCommentsLBL.isHidden = true
                }

                
             //   refreshData()
            
        }
            
        else
            
        {
            
            
            let AC = JSController("Network Error", MyMessage: "Please Confirm Your Network Settings",Color: "Red")
            self.present(AC, animated: true, completion: nil)
            
        }
        
        self.TableView.reloadData()
        actInd.stopAnimating()
    }
    
    }
    @objc func keyboardWasShown(_ notification: Notification) {
        print("KeyboardShown1")
        //EditingGameTitle = false
        
       submitBTN.isHidden = false
        
        var info = (notification as NSNotification).userInfo!
        
        
        //let keyboardFrame: CGRect = (info UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            
            self.doneBTNBOTTOM.constant = keyboardFrame.size.height + 20
            self.TableViewTOP.constant = 100
        })
        
        
        print("keyboard was shown")
        // if textView.textColor == UIColor.lightGrayColor() {
        
        if commentTXT.text == "Join the discussion..." {
            //println("textbox textcolor is light gray")
            commentTXT.text = ""
            commentTXT.textColor = UIColor.black
            commentTXT.textAlignment = .center //.Left
        }
        
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
 
        var info = (notification as NSNotification).userInfo!
        //var rect: CGRect = (info UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let rect: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            
            self.doneBTNBOTTOM.constant = -100
            self.TableViewTOP.constant = 5
         
        })

        submitBTN.isHidden = true

        if commentTXT.text.isEmpty {
            //if NewGameQuote.isEqualToString("Enter Your Quote Here") {
            //(StartSegment.subviews[0] as! UIView).tintColor = UIColor.greenColor()
            commentTXT.text = "Join the discussion..."
            commentTXT.textColor = UIColor.lightGray
            commentTXT.textAlignment = .center
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    
    @objc func RefreshCommentData(_ sender:AnyObject) {
        print("removing array data")
        idArrayInfo.removeAll()
        userArrayInfo.removeAll()
        commentArrayInfo.removeAll()
        dateArrayInfo.removeAll()
        datetimeArrayInfo.removeAll()
        gameidArrayInfo.removeAll()
        CommentDataInfo.removeAll()
        userIDArrayInfo.removeAll()
        
        print("adding array data")
        let URLData = GetCommentData(GameID)
        //println(test)
        CommentDataInfo = FilterCommentData(URLData)
        
        
        idArrayInfo = CommentDataInfo[0] as! [(NSString)]
        
        userArrayInfo = CommentDataInfo[1] as! [(NSString)]
        commentArrayInfo = CommentDataInfo[2] as! [(NSString)]
        
        dateArrayInfo = CommentDataInfo[3] as! [(NSString)]
        datetimeArrayInfo = CommentDataInfo[4] as! [(NSString)]
        
        gameidArrayInfo = CommentDataInfo[5] as! [(NSString)]
        userIDArrayInfo = CommentDataInfo[6] as! [(NSString)]
        
        print("Game id array = \(gameidArrayInfo)")
        
        self.TableView.reloadData()
        
        if commentArrayInfo.count == 0 {
            NoCommentsLBL.isHidden = false
        } else {
            NoCommentsLBL.isHidden = true
        }

        self.refreshControl.endRefreshing()
    }

    func refreshData() {
        print("removing array data")
        idArrayInfo.removeAll()
        userArrayInfo.removeAll()
        commentArrayInfo.removeAll()
        dateArrayInfo.removeAll()
        datetimeArrayInfo.removeAll()
        gameidArrayInfo.removeAll()
        CommentDataInfo.removeAll()
        idArrayTemp.removeAll()
        userArrayTemp.removeAll()
        userIDArrayTemp.removeAll()
        userIDArrayInfo.removeAll()
        commentArrayTemp.removeAll()
        dateArrayTemp.removeAll()
        datetimeArrayTemp.removeAll()
        gameidArrayTemp.removeAll()
        commentDataTemp.removeAll()
        
        print("adding array data")
        let URLData = GetCommentData(GameID)
        //println(test)
        CommentDataInfo = FilterCommentData(URLData)
        
        
        idArrayInfo = CommentDataInfo[0] as! [(NSString)]
        
        userArrayInfo = CommentDataInfo[1] as! [(NSString)]
        commentArrayInfo = CommentDataInfo[2] as! [(NSString)]
        
        dateArrayInfo = CommentDataInfo[3] as! [(NSString)]
        datetimeArrayInfo = CommentDataInfo[4] as! [(NSString)]
        
        gameidArrayInfo = CommentDataInfo[5] as! [(NSString)]
        userIDArrayInfo = CommentDataInfo[6] as! [(NSString)]
        print("Game id array = \(gameidArrayInfo)")
        
        self.TableView.reloadData()
        
        if commentArrayInfo.count == 0 {
            NoCommentsLBL.isHidden = false
        } else {
            NoCommentsLBL.isHidden = true
        }
    }
    
    @IBAction func submitBTN(_ sender: AnyObject) {
        theComment = commentTXT.text as NSString
        
        if theComment.isEqual(to: "") {
            let AC = JSController("No Comment", MyMessage: "Please enter a comment to post",Color: "Red")
            self.present(AC, animated: true, completion: nil)
        } else {
            saveComment(theComment)
           
        }
        
    }
    
    func saveComment(_ comment: NSString) {
        
        SaveCommentData(GameID, username: username, date: timestamp, comment: comment, reply: Reply, replyuser: ReplyUser, userid: userID, replyuserid: ReplyUserID)
        commentTXT.text = ""
        refreshData()
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func FilterCommentData(_ urlData: Data) -> [NSArray] {
        
        //  var traits = [NSString]()
  
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary

        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        // println("Json valueJSON: \(json)")
        
        
        
        for result in json["Data"].arrayValue {
            
            
            if ( result["id"] != "NA") {
                
                let idtemp = result["id"].stringValue
                let gameIDtemp = result["gameid"].stringValue
         let userIDTemp = result["userid"].stringValue
                let userTemp = result["username"].stringValue
                let commentTemp3 = result["comment"].stringValue
                
                let commentTemp2 = Data(base64Encoded: commentTemp3 as String, options: NSData.Base64DecodingOptions(rawValue: 0))!

                let commentTemp = NSString(data: commentTemp2, encoding: String.Encoding.utf8.rawValue)!
                
                
                
                
                let dateTemp = result["datestamp"].stringValue
                let datetimeTemp = result["datetimestamp"].stringValue
                //let Temp = result["username"].stringValue
                //let userTemp = result["username"].stringValue
               idArrayTemp.append(idtemp as NSString)
               userArrayTemp.append(userTemp as NSString)
               commentArrayTemp.append(commentTemp)
               dateArrayTemp.append(dateTemp as NSString)
               datetimeArrayTemp.append(datetimeTemp as NSString)
               gameidArrayTemp.append(gameIDtemp as NSString)
                userIDArrayTemp.append(userIDTemp as NSString)

            
            }
        }
            commentDataTemp.append(idArrayTemp as NSArray)
              commentDataTemp.append(userArrayTemp as NSArray)
              commentDataTemp.append(commentArrayTemp as NSArray)
             commentDataTemp.append(dateArrayTemp as NSArray)
              commentDataTemp.append(datetimeArrayTemp as NSArray)
              commentDataTemp.append(gameidArrayTemp as NSArray)
        commentDataTemp.append(userIDArrayTemp as NSArray)
            
          //  }
        print("Comment Data count = \(commentDataTemp)")
     return commentDataTemp
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
   
            return commentArrayInfo.count;
            
        
    }
    
    func ReplyClicked(_ sender: UIButton!) {
        Reply = "yes"
        let CommentRowSelected = sender.tag
        print("the comment rowselected: \(sender.tag)")
        
    ReplyUserID = userIDArrayInfo[CommentRowSelected]
        
       let usernameSelected = userArrayInfo[CommentRowSelected]
        commentTXT.text = "\(usernameSelected) said - \(commentArrayInfo[CommentRowSelected])        "
        Reply = "no"
        
        
        
    }
    
    @objc func DeleteCommentClicked(_ sender: UIButton!) {
        
        
        let theAlert = SCLAlertView()
        theAlert.addButton("Yes") {
            
            let CommentRowSelected = sender.tag
            print("the comment rowselected: \(sender.tag)")
            
            self.CommentIDSelected = self.idArrayInfo[CommentRowSelected]
            
            DeleteCommentData(self.CommentIDSelected)
            self.refreshData()

            
        }
        
        theAlert.addButton("Cancel") {
            
            print("Cancel pushed")
        }
        
        theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor.red, title: "Delete Comment?", subTitle: "Are you sure you want to delete this comment?")
        
        
        
        /*
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Delete Comment?", message: "Are you sure you want to delete this comment?", preferredStyle: .Alert)
        
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Yes", style: .Default) { action -> Void in

            let CommentRowSelected = sender.tag
            print("the comment rowselected: \(sender.tag)")
            
            self.CommentIDSelected = self.idArrayInfo[CommentRowSelected]
            
            DeleteCommentData(self.CommentIDSelected)
            self.refreshData()
            
        }
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Do some stuff
        }
        
        actionSheetController.addAction(nextAction)
        actionSheetController.addAction(cancelAction)
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)

        
        */
        
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
        
        cell.backgroundColor = UIColor.clear
        
        
        cell.titleLabel?.text = userArrayInfo[(indexPath as NSIndexPath).row] as String
        cell.subtitleLabel?.text = datetimeArrayInfo[(indexPath as NSIndexPath).row] as String
        cell.TurnLabel?.text = commentArrayInfo[(indexPath as NSIndexPath).row] as String
        

        cell.deleteCommentBTN?.tag = (indexPath as NSIndexPath).row
            
        cell.lblView?.layer.cornerRadius = 5
        
        cell.deleteCommentBTN?.addTarget(self, action: #selector(CommentsViewController.DeleteCommentClicked(_:)), for: .touchUpInside)

        
        //  cell.TurnLabel!.text = self.UsersTurnInfo[indexPath.row] as String
        
        //TableView.rowHeight = 85
        return cell
        
    }

    @IBAction func closeBTN(_ sender: AnyObject) {
        
        if wasNotified {
            
      //  self.dismissViewControllerAnimated(true, completion: {
            /*
            let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UIViewController = sb.instantiateViewControllerWithIdentifier("start") as UIViewController
            
            let window = UIApplication.sharedApplication().windows[0] as UIWindow;
            

            UIView.transitionFromView((window.rootViewController?.view)!, toView: vc.view, duration: 0.65, options: .TransitionCrossDissolve, completion: {
                finished in window.rootViewController = vc
                */
                self.dismiss(animated: true, completion: {

                    self.performSegue(withIdentifier: "restart", sender: self)
                    })

                
                print("should restart the app")
          //  })
      //  })

                } else {
        
        self.dismiss(animated: true, completion: nil)
            
        }
    }
}
