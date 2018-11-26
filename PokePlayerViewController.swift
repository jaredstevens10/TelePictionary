//
//  PokePlayerViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 11/3/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//


    import UIKit
    
    protocol PokePlayerViewControllerDelegate: class {
        func PokePlayerViewControllerFinished(_ pokeplayeriewController: PokePlayerViewController)
    }
    
    
    
    class PokePlayerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
       // var commentDataTemp = [NSArray]()
       // var TotalFails = Int()
        var PlayerArrayTemp = [NSString]()
        var PlayerIDArrayTemp = [NSString]()
        var playerNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        var TurnInt = Int()
      //  var idArrayTemp = [NSString]()
      //  var userArrayInfo = [NSString]()
        //  var turnArrayTemp = [NSString]()
        //  var turnArrayInfo = [NSString]()
       // var idArrayInfo = [NSString]()
        //var CommentDataInfo = [NSArray]()
        var replyuser = NSString()
        var replyuserid = NSString()
        var userID = NSString()
        var PlayerTurnIndex = [Bool]()
        // var userNames = [NSString]()
        @IBOutlet var actInd: UIActivityIndicatorView!
        let prefs:UserDefaults = UserDefaults.standard
        
        @IBOutlet var TableView: UITableView!
        
        var pokedelegate: PokePlayerViewControllerDelegate?
        var player1 = NSString()
        var player2 = NSString()
        var player3 = NSString()
        var player4 = NSString()
        var player5 = NSString()
        var player6 = NSString()
        var player7 = NSString()
        var player8 = NSString()
        var player9 = NSString()
        var player10 = NSString()
        
        var player1ID = NSString()
        var player2ID = NSString()
        var player3ID = NSString()
        var player4ID = NSString()
        var player5ID = NSString()
        var player6ID = NSString()
        var player7ID = NSString()
        var player8ID = NSString()
        var player9ID = NSString()
        var player10ID = NSString()
        
        var gameid = NSString()
        var turnnumber = NSString()
        var username = NSString()
         var gamestyle = NSString()
        var refreshControl:UIRefreshControl!
        
        override func viewDidLoad() {
            
            
            self.navigationController?.popoverPresentationController?.backgroundColor = UIColor.lightGray
            
            self.TableView.separatorStyle = UITableViewCellSeparatorStyle.none
         /*
            self.refreshControl = UIRefreshControl()
            self.refreshControl.addTarget(self, action: "RefreshFailData:", forControlEvents: UIControlEvents.ValueChanged)
          */
            
            PlayerArrayTemp.append(player1)
            PlayerArrayTemp.append(player2)
            PlayerArrayTemp.append(player3)
            PlayerArrayTemp.append(player4)
            PlayerArrayTemp.append(player5)
            PlayerArrayTemp.append(player6)
            PlayerArrayTemp.append(player7)
            PlayerArrayTemp.append(player8)
            PlayerArrayTemp.append(player9)
            PlayerArrayTemp.append(player10)
            
            PlayerIDArrayTemp.append(player1ID)
            PlayerIDArrayTemp.append(player2ID)
            PlayerIDArrayTemp.append(player3ID)
            PlayerIDArrayTemp.append(player4ID)
            PlayerIDArrayTemp.append(player5ID)
            PlayerIDArrayTemp.append(player6ID)
            PlayerIDArrayTemp.append(player7ID)
            PlayerIDArrayTemp.append(player8ID)
            PlayerIDArrayTemp.append(player9ID)
            PlayerIDArrayTemp.append(player10ID)
            
            print("player id =\(PlayerIDArrayTemp)")
            
         //   self.TableView.addSubview(refreshControl)
            
            
            
            print("GameID = \(gameid)")
            TurnInt = Int(turnnumber as String)!
            print("Turn Number = \(turnnumber)")
            
            super.viewDidLoad()
            if prefs.value(forKey: "USERNAME") != nil {
                
                username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
      userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
            } else  {
                username = "tempName"
                userID = "tempID"
            }
            
            
            switch turnnumber {
                
              case "2":
                PlayerTurnIndex = [false, true, false, false, false, false, false, false, false, false]
              //case "3":
               //  PlayerTurnIndex = [false, false, true, false, false, false, false, false, false, false]
              case "3":
                 PlayerTurnIndex = [false, false, true, false, false, false, false, false, false, false]
                print("is turn 3")
                
            case "4":
                PlayerTurnIndex = [false, false, false, true, false, false, false, false, false, false]
                print("is turn 3")
              case "5":
                
                 PlayerTurnIndex = [false, false, false, false, true, false, false, false, false, false]
               case "6":
               
               PlayerTurnIndex = [false, false, false, false, false, true, false, false, false, false]
                case "7":
                PlayerTurnIndex = [false, false, false, false, false, false, true, false, false, false]
                case "8":
                  PlayerTurnIndex = [false, false, false, false, false, false, false, true, false, false]
                case "9":
                PlayerTurnIndex = [false, false, false, false, false, false, false, false, true, false]
                case "10":
                 PlayerTurnIndex = [false, false, false, false, false, false, false, false, false, true]
                case "11":
                  PlayerTurnIndex = [false, false, false, false, false, false, false, false, false, false]
            default:
                break
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
                
                /*
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
                self.presentViewController(AC, animated: true, completion: nil)
                
            }
*/
            
            self.TableView.reloadData()
         //   actInd.stopAnimating()
            
        }
    }
        /*
        func RefreshFailData(sender:AnyObject) {
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
        
            */
        
        func PokeClicked(_ sender: UIButton){
            let tag = sender.tag
            print("Tag = \(tag)")
            print("Poked  Clicked")
            
            
            
            
            let DeviceTKN = "FIND"
            let TurnInfoTest = self.PlayerArrayTemp[tag]
            let UserTurnID = self.PlayerIDArrayTemp[tag]

            
            
            let theAlert = SCLAlertView()
            theAlert.addButton("Soft Poke") {
                print("Settings pushed")
                
                let AlertType = "pokeSoft"
                
                SendTurnNotice(TurnInfoTest, token: DeviceTKN as NSString, gameid: self.gameid, turninfo: self.turnnumber, alertType: AlertType as NSString, gameType: self.gamestyle, turninfoID: UserTurnID, myID: self.userID)
                
            }
            //, target:self, selector:Selector("Settings"))
            theAlert.addButton("Medium Poke") {
                
                let AlertType = "pokeMedium"
                //  self.ClearHiddenYes()
                SendTurnNotice(TurnInfoTest, token: DeviceTKN as NSString, gameid: self.gameid, turninfo: self.turnnumber, alertType: AlertType as NSString, gameType: self.gamestyle, turninfoID: UserTurnID, myID: self.userID)
                
                
                
            }
            
            theAlert.addButton("Hard Poke") {
                
                let AlertType = "pokeHard"
                //  self.ClearHiddenYes()
                SendTurnNotice(TurnInfoTest, token: DeviceTKN as NSString, gameid: self.gameid, turninfo: self.turnnumber, alertType: AlertType as NSString, gameType: self.gamestyle, turninfoID: UserTurnID, myID: self.userID)
                
                
                
            }
            
            theAlert.addButton("Nevermind") {
                
               
                
                
            }
            
           // theAlert.showCustom(UIImage(named: "alertcontent.png")!, color: UIColor.blueColor(), title: "Poke \(self.PlayerArrayTemp[tag])?", subTitle: "How hard would you like to them?")
            
            theAlert.showCustomOK(UIImage(named: "pokeIconWhite.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Poke \(self.PlayerArrayTemp[tag])?", subTitle: "How hard would you like to them?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
            
            
            
            /*
            
            let alertController = UIAlertController(title: "Poke \(self.PlayerArrayTemp[tag]) to take their turn?", message: "How hard would you like to them?", preferredStyle: .Alert)
            let CancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action:UIAlertAction) in
                print("Cancel button pressed")
                
            }
            
            
            
            var DeviceTKN = "FIND"
            var TurnInfoTest = self.PlayerArrayTemp[tag]
            var UserTurnID = self.PlayerIDArrayTemp[tag]
           
            
            let SoftAction = UIAlertAction(title: "Soft Poke", style: .Default) { (action:UIAlertAction) in
                print("Soft button pressed")
                
                // self.ClearHiddenYes()
                let AlertType = "pokeSoft"
                
                SendTurnNotice(TurnInfoTest, token: DeviceTKN, gameid: self.gameid, turninfo: self.turnnumber, alertType: AlertType, gameType: self.gamestyle, turninfoID: UserTurnID, myID: self.userID)
                
                
            }
            
            let MedAction = UIAlertAction(title: "Regular Poke", style: .Default) { (action:UIAlertAction) in
                print("Soft button pressed")
                
                let AlertType = "pokeMedium"
                //  self.ClearHiddenYes()
                SendTurnNotice(TurnInfoTest, token: DeviceTKN, gameid: self.gameid, turninfo: self.turnnumber, alertType: AlertType, gameType: self.gamestyle, turninfoID: UserTurnID, myID: self.userID)
                
            }
            
            let HardAction = UIAlertAction(title: "HARD Poke", style: .Default) { (action:UIAlertAction) in
                print("Soft button pressed")
                
                let AlertType = "pokeHard"
                SendTurnNotice(TurnInfoTest, token: DeviceTKN, gameid: self.gameid, turninfo: self.turnnumber, alertType: AlertType, gameType: self.gamestyle, turninfoID: UserTurnID, myID: self.userID)          //  self.ClearHiddenYes()
                
            }
            alertController.addAction(SoftAction);
            alertController.addAction(MedAction);
            
            alertController.addAction(HardAction);
            alertController.addAction(CancelAction);        alertController.view.tintColor = UIColor.blackColor();
            //alertController.view.backgroundColor = UIColor(red: 0.4, green: 1, blue: 0.69, alpha: 1.0)
            //CHANGE ERROR
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
            
            */
        
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
            return PlayerArrayTemp.count
        }
        
        func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
            
            let tag = (indexPath as NSIndexPath).row
            
            let alertController = UIAlertController(title: "Poke Player to take their turn?", message: "How hard would you like to them?", preferredStyle: .alert)
            let CancelAction = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction) in
                print("Cancel button pressed")
                
            }
            
            let DeviceTKN = "FIND"
            let TurnInfoTest = self.PlayerArrayTemp[tag]
            let UserTurnID = self.PlayerIDArrayTemp[tag]
            
            
            let SoftAction = UIAlertAction(title: "Soft Poke", style: .default) { (action:UIAlertAction) in
                print("Soft button pressed")
                
                // self.ClearHiddenYes()
                let AlertType = "pokeSoft"
                
                SendTurnNotice(TurnInfoTest, token: DeviceTKN as NSString, gameid: self.gameid, turninfo: self.turnnumber, alertType: AlertType as NSString, gameType: self.gamestyle, turninfoID: UserTurnID, myID: self.userID)
                
                
            }
            
            let MedAction = UIAlertAction(title: "Regular Poke", style: .default) { (action:UIAlertAction) in
                print("Soft button pressed")
                
                let AlertType = "pokeMedium"
                //  self.ClearHiddenYes()
                SendTurnNotice(TurnInfoTest, token: DeviceTKN as NSString, gameid: self.gameid, turninfo: self.turnnumber, alertType: AlertType as NSString, gameType: self.gamestyle, turninfoID: UserTurnID, myID: self.userID)
                
            }
            
            let HardAction = UIAlertAction(title: "HARD Poke", style: .default) { (action:UIAlertAction) in
                print("Soft button pressed")
                
                let AlertType = "pokeHard"
                SendTurnNotice(TurnInfoTest, token: DeviceTKN as NSString, gameid: self.gameid, turninfo: self.turnnumber, alertType: AlertType as NSString, gameType: self.gamestyle, turninfoID: UserTurnID, myID: self.userID)          //  self.ClearHiddenYes()
                
            }
            alertController.addAction(SoftAction);
            alertController.addAction(MedAction);
            
            alertController.addAction(HardAction);
            alertController.addAction(CancelAction);        alertController.view.tintColor = UIColor.black;
            //alertController.view.backgroundColor = UIColor(red: 0.4, green: 1, blue: 0.69, alpha: 1.0)
            //CHANGE ERROR
            /*
            var subView = alertController.view.subviews.first as! UIView
            var contentView = subView.subviews.first as! UIView
            var contentView2 = subView.subviews.last as! UIView
            
            contentView.backgroundColor = UIColor(red: 0.807, green: 0.576, blue: 0.58, alpha: 1.0)
            contentView.tintColor = UIColor(red: 0.929, green: 0.113, blue: 0.145, alpha: 1.0)
            // contentView.
            contentView2.tintColor = UIColor(red: 0.929, green: 0.113, blue: 0.145, alpha: 1.0)
            */
            
            self.present(alertController, animated: true, completion: nil)
           // self.dismissViewControllerAnimated(true, completion: nil)
        }
      
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
            
           // cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            
            
            
            
            cell.backgroundColor = UIColor.clear
            
            if PlayerTurnIndex[(indexPath as NSIndexPath).row] as Bool {
                cell.backgroundColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
                
                
            }
            
            
            cell.titleLabel?.text = PlayerArrayTemp[(indexPath as NSIndexPath).row] as String
            
            
            cell.pokeBTN?.tag = (indexPath as NSIndexPath).row
            
           // cell.lblView?.layer.cornerRadius = 5
            if ((playerNumbers[(indexPath as NSIndexPath).row] as Int) < TurnInt) {
                  cell.pokeBTN?.imageView!.image = UIImage(named: "GreenCheck40.png")
            } else {
            
            
            if PlayerArrayTemp[(indexPath as NSIndexPath).row] as String == username as String {
                cell.pokeBTN?.isHidden = true
                
            } else {
                cell.pokeBTN?.imageView!.image = UIImage(named: "pokeIcon.png")
                
                cell.pokeBTN?.isHidden = false
                cell.pokeBTN?.addTarget(self, action: #selector(PokePlayerViewController.PokeClicked(_:)), for: .touchUpInside)
            }
            
            }
            
            //  cell.titleLabel?.text = userArrayInfo[indexPath.row] as String
            
            // Configure the cell...
            
            return cell
        }
        
            
}
