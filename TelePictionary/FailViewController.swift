//
//  FailViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 10/21/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import UIKit

protocol FailViewControllerDelegate: class {
    func FailViewControllerFinished(_ failviewController: FailViewController)
}



class FailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var commentDataTemp = [NSArray]()
    var TotalFails = Int()
    var userArrayTemp = [NSString]()
    var idArrayTemp = [NSString]()
    var userArrayInfo = [NSString]()
  //  var turnArrayTemp = [NSString]()
  //  var turnArrayInfo = [NSString]()
    var idArrayInfo = [NSString]()
    var CommentDataInfo = [NSArray]()
    var replyuser = NSString()
    var replyuserid = NSString()
    var userID = NSString()
    var pageIndex = Int()
   // var userNames = [NSString]()
    @IBOutlet var actInd: UIActivityIndicatorView!
    let prefs:UserDefaults = UserDefaults.standard
    
    
    
    @IBOutlet var TableView: UITableView!
    
    var faildelegate: FailViewControllerDelegate?
    var gameid = NSString()
    var turnnumber = NSString()
    var username = NSString()
    var refreshControl:UIRefreshControl!
    
    
   

    
    override func viewDidLoad() {
        
        self.navigationController?.popoverPresentationController?.backgroundColor = UIColor.lightGray
        
        self.TableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(FailViewController.RefreshFailData(_:)), for: UIControl.Event.valueChanged)
        
        self.TableView.addSubview(refreshControl)
        
        print("GameID = \(gameid)")
        print("Turn Number = \(turnnumber)")
        
        super.viewDidLoad()
        if prefs.value(forKey: "USERNAME") != nil {
            
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
        } else  {
            username = "tempName"
        }

        
        if Reachability.isConnectedToNetwork() {
            
        
                
            }
                
            else
                
            {
                
                
                let AC = JSController("Network Error", MyMessage: "Please Confirm Your Network Settings",Color: "Red")
                self.present(AC, animated: true, completion: nil)
                
            }
            
            self.TableView.reloadData()
         //   actInd.stopAnimating()
            
            
               // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
     //   actInd.startAnimating()
        if Reachability.isConnectedToNetwork() {
            
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
            self.present(AC, animated: true, completion: nil)
            
        }
        
        self.TableView.reloadData()
        actInd.stopAnimating()
        
    }
    @objc func RefreshFailData(_ sender:AnyObject) {
        print("removing array data")
        idArrayInfo.removeAll()
        userArrayInfo.removeAll()
        CommentDataInfo.removeAll()
        
        print("adding array data")
        let URLData = GetLikeFailData(gameid, type: "fail", turnnumber: turnnumber)
        //println(test)
        CommentDataInfo = FilterFailData(URLData)
        
        
        idArrayInfo = CommentDataInfo[0] as! [(NSString)]
        
        userArrayInfo = CommentDataInfo[1] as! [(NSString)]
        
        TotalFails = idArrayInfo.count
        //    gameidArrayInfo = CommentDataInfo[5] as! [(NSString)]
        //print("Game id array = \(gameidArrayInfo)")
        
        self.TableView.reloadData()
        
        if idArrayInfo.count == 0 {
            //  NoCommentsLBL.hidden = false
        } else {
            //  NoCommentsLBL.hidden = true
        }
        
        self.refreshControl.endRefreshing()
    }
    
    func refreshData() {
        print("removing array data")
        idArrayInfo.removeAll()
        userArrayInfo.removeAll()
        CommentDataInfo.removeAll()
        idArrayTemp.removeAll()
        userArrayTemp.removeAll()
        commentDataTemp.removeAll()
        
        print("adding array data")
        let URLData = GetLikeFailData(gameid, type: "fail", turnnumber: turnnumber)
        //println(test)
        CommentDataInfo = FilterFailData(URLData)
        
        
        idArrayInfo = CommentDataInfo[0] as! [(NSString)]
        
        userArrayInfo = CommentDataInfo[1] as! [(NSString)]
        
        
        //  gameidArrayInfo = CommentDataInfo[5] as! [(NSString)]
        //print("Game id array = \(gameidArrayInfo)")
        
        self.TableView.reloadData()
        
        if idArrayInfo.count == 0 {
            //  NoCommentsLBL.hidden = false
        } else {
            //  NoCommentsLBL.hidden = true
        }
        
         TotalFails = idArrayInfo.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userArrayInfo.count
    }
    
    @objc func DeleteFailClicked(_ sender: UIButton) {
        
        _ = idArrayInfo[sender.tag]
        
        
      //  DeleteLikeFailData(likeID.description)
        DeleteLikeFailData(gameid, username: username, turn: turnnumber, type: "fail")
        self.refreshData()
        
      //  TotalFails = idArrayInfo.count
        
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "DeleteFail"), object: nil, userInfo: ["fails":"1","index":"\(pageIndex)"])
        
        
        
        
        DispatchQueue.main.async(execute: {
            
            
            let  numPoints = UPData(self.username, userid: self.userID, type: "delete", points: "0", levelpoints: "1")
            //numPoints = FilterUPData(UPurldata)
            print("number of points = \(numPoints)")
            
            let AC = JSController("Pixie Points..", MyMessage: "If you cancel your 'Fail' you lose the Pixie Points you earned by 'Failing' this Turn in the first place.  Hand'em over.",Color: "Green")
            self.present(AC, animated: true, completion: nil)
            
        })
        

        self.faildelegate?.FailViewControllerFinished(self)
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
        
        cell.backgroundColor = UIColor.clear
     
        
        cell.titleLabel?.text = userArrayInfo[(indexPath as NSIndexPath).row] as String
        
        
        cell.deleteCommentBTN?.tag = (indexPath as NSIndexPath).row
        
        cell.lblView?.layer.cornerRadius = 5
        
        
        

        
        
        if userArrayInfo[(indexPath as NSIndexPath).row] as String == username as String {
            cell.deleteCommentBTN?.isHidden = false
            cell.deleteCommentBTN?.addTarget(self, action: #selector(FailViewController.DeleteFailClicked(_:)), for: .touchUpInside)
        } else {
            cell.deleteCommentBTN?.isHidden = true
        }
        
        
        //  cell.titleLabel?.text = userArrayInfo[indexPath.row] as String
        
        // Configure the cell...
        
        return cell
    }
    
    @IBAction func AddFailBTN(_ sender: AnyObject) {
     
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Fail", message: "What were they thinking?", preferredStyle: .alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Do some stuff
        }
        actionSheetController.addAction(cancelAction)
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Fail", style: .default) { action -> Void in
            
            //self.ActInd.startAnimating()
            
            //let submitResults =  self.SubmitPic()
            SaveLikeFailData(self.gameid, username: self.username, turn: self.turnnumber, type: "fail", replyuser: self.replyuser, userID: self.userID, replyuserid: self.replyuserid, mediaType:  "")
            
            
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
        
        self.present(actionSheetController, animated: true, completion: nil)
 
        
        
    }
    
    func FilterFailData(_ urlData: Data) -> [NSArray] {
        
        //  var traits = [NSString]()
        
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        
        for result in json["Data"].arrayValue {
            
            
            if ( result["id"] != "NA") {
                
                let idtemp = result["id"].stringValue
                // let gameIDtemp = result["gameid"].stringValue
                
                let userTemp = result["username"].stringValue
               // let turnTemp = result["turn"].stringValue
                //let Temp = result["username"].stringValue
                //let userTemp = result["username"].stringValue
              //  turnArrayTemp.append(turnTemp)
                idArrayTemp.append(idtemp as NSString)
                userArrayTemp.append(userTemp as NSString)
                //  gameidArrayTemp.append(gameIDtemp)
                
                
            }
        }
        commentDataTemp.append(idArrayTemp as NSArray)
        commentDataTemp.append(userArrayTemp as NSArray)
      //  commentDataTemp.append(turnArrayTemp)
        
        //    commentDataTemp.append(gameidArrayTemp)
        
        //  }
        print("Comment Data count = \(commentDataTemp)")
        return commentDataTemp
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
