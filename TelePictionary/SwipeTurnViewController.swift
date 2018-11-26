//
//  SwipeTurnViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 2/15/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

private var numberOfCards: UInt = 5

class SwipeTurnViewController: UIViewController {
    
    
    let ServerURL = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/"
    
    @IBOutlet weak var kolodaView: KolodaView!
    var GamesAvailable = Bool()
    var username = NSString()
    var userID = NSString()
    var IsGameCenter = Bool()
    var SegmentValueString = NSString()
    
    var MyTotalTurns = Int()
    var NumTurnsLoaded = Int()
    
    var LastTurnUser = NSString()
    var TurnUser = NSString()
    var TurnUserID = NSString()
    var TurnURLString = NSString()
    
    var GameData = [NSArray]()
    var GameInfo = [NSArray]()
    
    var GameSearchArray = [GameTypeSwipe]()
    var GameSearchInfo = [GameTypeSwipe]()
    
     var FilteredGames = [GameTypeSwipe]()
    
     let prefs = UserDefaults.standard
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        SegmentValueString = "My Turns"
  
        
        
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
      //  actInd.startAnimating()
        
        
        
        self.IsGameCenter = UserDefaults.standard.bool(forKey: "GameCenterEnabled")
        
        if !self.IsGameCenter {
            
            //self.refreshControl.enabled = false
            
            let Alert = SCLAlertView()
            Alert.addButton("Log in Now", action: {
                
                DispatchQueue.main.async(execute: {
                    
                    LogIntoGameCenterNew()
                    
                })
                
            })
            
            Alert.addButton("Later", action: {
                
                
                DispatchQueue.main.async(execute: {
                    
                    SCLAlertView().showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Center", subTitle: "Without being logged into Game Center many of this games features are disabled.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                    // self.NoGamesLBL.hidden = true
                   // self.restartMyGames.hidden = true
                   // self.NoGamesLBL.text = "No User Is Signed In"
                    
                  //  self.actInd.stopAnimating()
                    
                })
                
                
            })
            
            Alert.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Game Center", subTitle: "You need to be logged into Game Center to view your games.  Please log in now", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
            
            
            
        } else {
            
            //NSUserDefaults.standardUserDefaults().setBool(true, forKey: "GameCenterEnabled")
            
            
            
            
           // RemoveGameArrayData()
            
            // self.TableView.reloadData()
            
          //  print("game array = \(GameNameInfo)")
            
            
            
            
            //  let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
            if prefs.value(forKey: "USERNAME") != nil {
                
                username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            } else  {
                username = "tempName"
            }
            
            if GamesAvailable {
                
                
                
            }
            
          //  DeletedGameIDs.removeAll()
          //  GetDeletedGamesData()
            
            
         //   print("Retrieved All hidden Games: \(DeletedGameIDs)")
            
            
            if Reachability.isConnectedToNetwork() {
                
                
                // var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
                // view.addGestureRecognizer(tap)
                
                
                //println("Username value check: \(username)")
                
                // dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_UTILITY.rawValue), 0)) {
                DispatchQueue.main.async(execute: {
                    
                    
                    if self.prefs.value(forKey: "USERNAME") != nil {
                        
                        let URLData = GetUserGameData(self.username, userID: self.userID, type: self.SegmentValueString)
                        //println(test)
                        (self.GameInfo, self.GameSearchArray) = self.FilterGameData(URLData)
                        
                        // print("GameSearchArray: \(self.GameSearchArray[0].GameName)")
                        
                        //  print("Game Search Info Count = \(self.GameSearchArray.count)")
                        
                        if self.GameSearchArray.count < 1 {
                           // self.NoGamesLBL.hidden = false
                         //   self.restartMyGames.hidden = false
                            
                            print("showing no games label")
                        } else {
                            
                            print("hidding no games label")
                          //  self.NoGamesLBL.hidden = true
                          //  self.restartMyGames.hidden = true
                        }
                        
                        //println("Game Info: \(GameInfo)")
                        
                        
                        
                        DispatchQueue.main.async(execute: {
                            
                         //   self.AddGameArrayInfo(self.GameInfo)
                            
                            DispatchQueue.main.async(execute: {
                                
                              //  self.TableView.reloadData()
                              //  self.actInd.stopAnimating()
                            })
                            
                            
                            
                        })
                        
                        
                        
                    //    print("Users turn info =\(self.UsersTurnInfo)")
                   //     print("Users turn ID info =\(self.UsersTurnIDInfo)")
                        //print(GameNameInfo)
                        
                    } else {
                        
                        print("no games available")
                        
                    }
                    
                })
                
               
                
                
                
            }
                
            else
                
            {
                

                SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Network Error", subTitle: "Please Confirm Your Network Settings", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
                
            }
            
        }
        // self.TableView.reloadData()
        //   actInd.stopAnimating()
    }
    
    func FilterGameData(_ urlData: Data) -> ([NSArray], [GameTypeSwipe]) {
        GameData.removeAll()
        GameSearchInfo.removeAll()
        
        /*
        var contentArray = [NSString]()
        var gnameArray = [NSString]()
        var GameIdArray = [NSString]()
        var Player1Array = [NSString]()
        var Player2Array = [NSString]()
        var Player3Array = [NSString]()
        var Player4Array = [NSString]()
        var Player5Array = [NSString]()
        var Player6Array = [NSString]()
        var Player7Array = [NSString]()
        var Player8Array = [NSString]()
        var Player9Array = [NSString]()
        var Player10Array = [NSString]()
        var Player1IDArray = [NSString]()
        var Player2IDArray = [NSString]()
        var Player3IDArray = [NSString]()
        var Player4IDArray = [NSString]()
        var Player5IDArray = [NSString]()
        var Player6IDArray = [NSString]()
        var Player7IDArray = [NSString]()
        var Player8IDArray = [NSString]()
        var Player9IDArray = [NSString]()
        var Player10IDArray = [NSString]()
        var Turn1Array = [NSString]()
        var Turn2Array = [NSString]()
        var Turn3Array = [NSString]()
        var Turn4Array = [NSString]()
        var Turn5Array = [NSString]()
        var Turn6Array = [NSString]()
        var Turn7Array = [NSString]()
        var Turn8Array = [NSString]()
        var Turn9Array = [NSString]()
        var Turn10Array = [NSString]()
        var TurnNumberArray = [NSString]()
        var IsCompleteArray = [NSString]()
        var UsersTurnArray = [NSString]()
        var UsersTurnIDArray = [NSString]()
        var LastTurnTimeArray = [NSString]()
        var TimeLimitArray = [NSString]()
        var CanTakeTurnArray = [NSString]()
        var GameStyleArray = [NSString]()
        var GameVisibleArray = [NSString]()
        var TotalLikesArray = [NSString]()
        var commentArray = [NSString]()
        var GameLikeArrayTemp = [NSString]()
        var GameFailArrayTemp = [NSString]()
        */
        //  var traits = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        
        
        
        
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        // println("Json valueJSON: \(json)")
        
        //if pickerItem {
        
        var MyTotalTurnsTemp = json["totalGames"].stringValue
        if MyTotalTurnsTemp == "" {
            MyTotalTurnsTemp = "0"
        }
        MyTotalTurns = Int(MyTotalTurnsTemp)!
        
        print("My Total Turns = \(MyTotalTurns.description)")
        
        
        
        for result in json["Data"].arrayValue {
            
            
            if ( result["id"] != "0") {
                
                let gameID = result["id"].stringValue
                print("Found GameID = \(gameID)")
                
                // if DeletedGameIDs.!contains(gameID) {
                
                if 1 == 1 {
                
                //if !DeletedGameIDs.contains(gameID) {
                    
                    let gname = result["GameName"].stringValue
                    print("Accepted GameID = \(gameID)")
                    
                    let player1 = result["User1"].stringValue
                    
                    let player2 = result["User2"].stringValue
                    
                    let player3 = result["User3"].stringValue
                    let player4 = result["User4"].stringValue
                    let player5 = result["User5"].stringValue
                    
                    let player6 = result["User6"].stringValue
                    
                    let player7 = result["User7"].stringValue
                    
                    let player8 = result["User8"].stringValue
                    let player9 = result["User9"].stringValue
                    let player10 = result["User10"].stringValue
                    
                    let player1ID = result["User1ID"].stringValue
                    
                    let player2ID = result["User2ID"].stringValue
                    
                    let player3ID = result["User3ID"].stringValue
                    let player4ID = result["User4ID"].stringValue
                    let player5ID = result["User5ID"].stringValue
                    
                    let player6ID = result["User6ID"].stringValue
                    
                    let player7ID = result["User7ID"].stringValue
                    
                    let player8ID = result["User8ID"].stringValue
                    let player9ID = result["User9ID"].stringValue
                    let player10ID = result["User10ID"].stringValue
                    
                    //      var turn1 = result["Turn1"].stringValue
                    
                    //      var turn2 = result["Turn2"].stringValue
                    
                    //      var turn3 = result["Turn3"].stringValue
                    //      var turn4 = result["Turn4"].stringValue
                    //      var turn5 = result["Turn5"].stringValue
                    
                    //      var turn6 = result["Turn6"].stringValue
                    
                    //      var turn7 = result["Turn7"].stringValue
                    
                    //      var turn8 = result["Turn8"].stringValue
                    //      var turn9 = result["Turn9"].stringValue
                    //      var turn10 = result["Turn10"].stringValue
                    
                    let isComplete = result["isComplete"].stringValue
                    let turnNumber = result["TurnNumber"].stringValue
                    let LastTurnTime = result["LastTurnTime"].stringValue
                    
                    
                    let TimeLimit = result["TimeLimit"].stringValue
                    let CanTakeTurn = result["CanTakeTurn"].stringValue
                    
                    let gameliketemp = result["GameLike"].stringValue
                    let gamefailtemp = result["GameFail"].stringValue
                    
                    
                    print("Can Take Turn = \(CanTakeTurn)")
                    
                    let GameStyle = result["gamestyle"].stringValue
                    let GameVisible1 = result["gameVisible"].stringValue
                    
                    var GameVisible = NSString()
                    
                    if GameVisible1 == "yes" {
                        GameVisible = "Public"
                    } else {
                        GameVisible = "Private"
                    }
                    
                    let GameSettingP = result["gameSetting"].stringValue
                    
                    let totalLikes = result["totalLikes"].stringValue
                    let commentTemp = result["comments"].stringValue
                    
                    let Turn1MediaType = result["turn1mediatype"].stringValue
                    
                    
                    let Turn1URLStringTemp = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(gameID)Turn1"
                    
                    var Turn1URLString = String()
                    
                    switch Turn1MediaType {
                        
                    case "audio":
                        
                        Turn1URLString = "\(Turn1URLStringTemp).mp3"
                        
                    case "image":
                        
                        Turn1URLString = "\(Turn1URLStringTemp).jpg"
                        
                    case "quote":
                        
                        Turn1URLString = "\(Turn1URLStringTemp).jpg"
                        
                    case "gif":
                        
                        Turn1URLString = "\(Turn1URLStringTemp).gif"
                        
                        
                    default:
                        break
                    }
                    
                    print("Turn1MediaType = \(Turn1MediaType)")
                    
                    switch turnNumber
                    {
                    case "1":
                        LastTurnUser = player1 as NSString
                        TurnUser = player1 as NSString
                        TurnUserID = player1ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn1" as NSString
                        //TurnUser2 = "User1"
                    case "2":
                        LastTurnUser = player1 as NSString
                        TurnUser = player2 as NSString
                        TurnUserID = player2ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn2" as NSString
                    case "3":
                        LastTurnUser = player2 as NSString
                        TurnUser = player3 as NSString
                        TurnUserID = player3ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn3" as NSString
                    case "4":
                        LastTurnUser = player3 as NSString
                        TurnUser = player4 as NSString
                        TurnUserID = player4ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn4" as NSString
                    case "5":
                        LastTurnUser = player4 as NSString
                        TurnUser = player5 as NSString
                        TurnUserID = player5ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn5" as NSString
                    case "6":
                        LastTurnUser = player5 as NSString
                        TurnUser = player6 as NSString
                        TurnUserID = player6ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn6" as NSString
                    case "7":
                        LastTurnUser = player6 as NSString
                        TurnUser = player7 as NSString
                        TurnUserID = player7ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn7" as NSString
                    case "8":
                        LastTurnUser = player7 as NSString
                        TurnUser = player8 as NSString
                        TurnUserID = player8ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn8" as NSString
                    case "9":
                        LastTurnUser = player8 as NSString
                        TurnUser = player9 as NSString
                        TurnUserID = player9ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn9" as NSString
                    case "10":
                        LastTurnUser = player9 as NSString
                        TurnUser = player10 as NSString
                        TurnUserID = player10ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn10" as NSString
                    default:
                        LastTurnUser = player10 as NSString
                        TurnURLString = "NA"
                        print("Error")
                    }
                    
                    
                    let theSearchString = "\(player1) \(player2) \(player3) \(player4) \(player5) \(player6) \(player7) \(player8) \(player9) \(player10) \(gname)"
                    
                    let ContentRating = result["contentrating"].stringValue
                    
                    
                    
                    if isComplete == "yes" {
                        GameSearchInfo.append(GameTypeSwipe(GameCategory: "Complete", GameName: gname, GameID: gameID, GamePlayer1: player1, GamePlayer2: player2, GamePlayer3: player3, GamePlayer4: player4, GamePlayer5: player5, GamePlayer6: player6, GamePlayer7: player7, GamePlayer8: player8, GamePlayer9: player9, GamePlayer10: player10, GameTurnNumber: turnNumber, GameIsComplete: isComplete, GameUsersTurn: TurnUser as String, GameLastTurnTime: LastTurnTime, GameTimeLimit: TimeLimit, GameCanTakeTurn: CanTakeTurn, GameGameStyle: GameStyle, GameGameVisible: GameVisible as String, GameTotalLikes: totalLikes, GameCommentInfo: commentTemp, GameGameLikeArray: gameliketemp, GameGameFailArray: gamefailtemp, GamePlayer1ID: player1ID, GamePlayer2ID: player2ID, GamePlayer3ID: player3ID, GamePlayer4ID: player4ID, GamePlayer5ID: player5ID, GamePlayer6ID: player6ID, GamePlayer7ID: player7ID, GamePlayer8ID: player8ID, GamePlayer9ID: player9ID, GamePlayer10ID: player10ID, GameUsersTurnID: TurnUserID as String, GameContent: ContentRating, GameSearchString: theSearchString, Turn1MediaType: Turn1MediaType, Turn1URLString: Turn1URLString, LastTurnUser: LastTurnUser as String, GameSetting: GameSettingP, TurnURL: TurnURLString as String))
                        //         GameSearchArray.append(GameType(category: "Complete", name: gname, turnUser: TurnUser as String))
                    } else {
                        //    GameSearchArray.append(GameType(category: "In Process", name: gname, turnUser: TurnUser as String))
                        GameSearchInfo.append(GameTypeSwipe(GameCategory: "In Process", GameName: gname, GameID: gameID, GamePlayer1: player1, GamePlayer2: player2, GamePlayer3: player3, GamePlayer4: player4, GamePlayer5: player5, GamePlayer6: player6, GamePlayer7: player7, GamePlayer8: player8, GamePlayer9: player9, GamePlayer10: player10, GameTurnNumber: turnNumber, GameIsComplete: isComplete, GameUsersTurn: TurnUser as String, GameLastTurnTime: LastTurnTime, GameTimeLimit: TimeLimit, GameCanTakeTurn: CanTakeTurn, GameGameStyle: GameStyle, GameGameVisible: GameVisible as String, GameTotalLikes: totalLikes, GameCommentInfo: commentTemp, GameGameLikeArray: gameliketemp, GameGameFailArray: gamefailtemp, GamePlayer1ID: player1ID, GamePlayer2ID: player2ID, GamePlayer3ID: player3ID, GamePlayer4ID: player4ID, GamePlayer5ID: player5ID, GamePlayer6ID: player6ID, GamePlayer7ID: player7ID, GamePlayer8ID: player8ID, GamePlayer9ID: player9ID, GamePlayer10ID: player10ID, GameUsersTurnID: TurnUserID as String, GameContent: ContentRating, GameSearchString: theSearchString, Turn1MediaType: Turn1MediaType, Turn1URLString: Turn1URLString, LastTurnUser: LastTurnUser as String, GameSetting: GameSettingP, TurnURL: TurnURLString as String))
                        
                        
                    }
                    
                    /*
                    contentArray.append(ContentRating)
                    gnameArray.append(gname)
                    GameIdArray.append(gameID)
                    Player1Array.append(player1)
                    Player2Array.append(player2)
                    Player3Array.append(player3)
                    Player4Array.append(player4)
                    Player5Array.append(player5)
                    Player6Array.append(player6)
                    Player7Array.append(player7)
                    Player8Array.append(player8)
                    Player9Array.append(player9)
                    
                    Player10Array.append(player10)
                    
                    Player1IDArray.append(player1ID)
                    Player2IDArray.append(player2ID)
                    Player3IDArray.append(player3ID)
                    Player4IDArray.append(player4ID)
                    Player5IDArray.append(player5ID)
                    Player6IDArray.append(player6ID)
                    Player7IDArray.append(player7ID)
                    Player8IDArray.append(player8ID)
                    Player9IDArray.append(player9ID)
                    Player10IDArray.append(player10ID)
                    
                    //      Turn1Array.append(turn1)
                    //      Turn2Array.append(turn2)
                    //      Turn3Array.append(turn3)
                    //      Turn4Array.append(turn4)
                    //      Turn5Array.append(turn5)
                    //      Turn6Array.append(turn6)
                    //      Turn7Array.append(turn7)
                    //      Turn8Array.append(turn8)
                    //      Turn9Array.append(turn9)
                    //      Turn10Array.append(turn10)
                    TurnNumberArray.append(turnNumber)
                    IsCompleteArray.append(isComplete)
                    UsersTurnArray.append(TurnUser)
                    UsersTurnIDArray.append(TurnUserID)
                    
                    
                    LastTurnTimeArray.append(LastTurnTime)
                    TimeLimitArray.append(TimeLimit)
                    CanTakeTurnArray.append(CanTakeTurn)
                    GameStyleArray.append(GameStyle)
                    GameVisibleArray.append(GameVisible)
                    TotalLikesArray.append(totalLikes)
                    commentArray.append(commentTemp)
                    GameLikeArrayTemp.append(gameliketemp)
                    GameFailArrayTemp.append(gamefailtemp)
                    */
                    
                }
            }
            
        }
        
        
        /*
        GameData.append(gnameArray)
        GameData.append(GameIdArray)
        GameData.append(Player1Array)
        GameData.append(Player2Array)
        GameData.append(Player3Array)
        GameData.append(Player4Array)
        GameData.append(Player5Array)
        GameData.append(Player6Array)
        GameData.append(Player7Array)
        GameData.append(Player8Array)
        GameData.append(Player9Array)
        GameData.append(Player10Array)
        //   GameData.append(Turn1Array)
        //   GameData.append(Turn2Array)
        //   GameData.append(Turn3Array)
        //   GameData.append(Turn4Array)
        //   GameData.append(Turn5Array)
        //   GameData.append(Turn6Array)
        //   GameData.append(Turn7Array)
        //   GameData.append(Turn8Array)
        //   GameData.append(Turn9Array)
        //   GameData.append(Turn10Array)
        GameData.append(TurnNumberArray)
        GameData.append(IsCompleteArray)
        GameData.append(UsersTurnArray)
        GameData.append(LastTurnTimeArray)
        GameData.append(TimeLimitArray)
        GameData.append(CanTakeTurnArray)
        GameData.append(GameStyleArray)
        GameData.append(GameVisibleArray)
        GameData.append(TotalLikesArray)
        GameData.append(commentArray)
        GameData.append(GameLikeArrayTemp)
        GameData.append(GameFailArrayTemp)
        
        GameData.append(Player1IDArray)
        GameData.append(Player2IDArray)
        GameData.append(Player3IDArray)
        GameData.append(Player4IDArray)
        GameData.append(Player5IDArray)
        GameData.append(Player6IDArray)
        GameData.append(Player7IDArray)
        GameData.append(Player8IDArray)
        GameData.append(Player9IDArray)
        GameData.append(Player10IDArray)
        GameData.append(UsersTurnIDArray)
        GameData.append(contentArray)
        
        */
        //GameData.append(GameSearchArray)
        
        return (GameData, GameSearchInfo)
        
    }
    
    
    //MARK: IBActions
    @IBAction func leftButtonTapped() {
        kolodaView?.swipe(SwipeResultDirection.left)
    }
    
    @IBAction func rightButtonTapped() {
        kolodaView?.swipe(SwipeResultDirection.right)
    }
    
    @IBAction func undoButtonTapped() {
        kolodaView?.revertAction()
    }
    
    
    
    
    struct GameTypeSwipe {
        let GameCategory : String
        let GameName : String
        let GameID : String
        let GamePlayer1 : String
        let GamePlayer2 : String
        let GamePlayer3 : String
        let GamePlayer4 : String
        let GamePlayer5 : String
        let GamePlayer6 : String
        let GamePlayer7 : String
        let GamePlayer8 : String
        let GamePlayer9 : String
        let GamePlayer10 : String
        let GameTurnNumber : String
        let GameIsComplete : String
        let GameUsersTurn : String
        let GameLastTurnTime : String
        let GameTimeLimit : String
        let GameCanTakeTurn : String
        let GameGameStyle : String
        let GameGameVisible : String
        let GameTotalLikes : String
        let GameCommentInfo : String
        let GameGameLikeArray : String
        let GameGameFailArray : String
        let GamePlayer1ID : String
        let GamePlayer2ID : String
        let GamePlayer3ID : String
        let GamePlayer4ID : String
        let GamePlayer5ID : String
        let GamePlayer6ID : String
        let GamePlayer7ID : String
        let GamePlayer8ID : String
        let GamePlayer9ID : String
        let GamePlayer10ID : String
        let GameUsersTurnID : String
        let GameContent : String
        let GameSearchString : String
        let Turn1MediaType: String
        let Turn1URLString: String
        let LastTurnUser: String
        let GameSetting: String
        let TurnURL: String
    }
    
}

//MARK: KolodaViewDelegate
extension SwipeTurnViewController: KolodaViewDelegate {
    
    func koloda(_ koloda: KolodaView, didSwipedCardAtIndex index: UInt, inDirection direction: SwipeResultDirection) {
        //Example: loading more cards
        
        print("Swiped card in direction \(direction)")
        if index >= 3 {
            numberOfCards = 6
            kolodaView.reloadData()
        }
    }
    
    func koloda(kolodaDidRunOutOfCards koloda: KolodaView) {
        //Example: reloading
        kolodaView.resetCurrentCardNumber()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAtIndex index: UInt) {
        
        let Alert = SCLAlertView()
        Alert.addButton("Yes", action: {
            /*
            dispatch_async(dispatch_get_main_queue(), {
                
                LogIntoGameCenterNew()
                
            })
            */
        })
        
        Alert.addButton("Nevermind", action: {
            
            /*
            dispatch_async(dispatch_get_main_queue(), {
                
                SCLAlertView().showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Center", subTitle: "Without being logged into Game Center many of this games features are disabled.", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                
                // self.NoGamesLBL.hidden = true
                // self.restartMyGames.hidden = true
                // self.NoGamesLBL.text = "No User Is Signed In"
                
                //  self.actInd.stopAnimating()
                
            })
           */
            
        })
        
        Alert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Take Turn", subTitle: "Take this turn?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
        
     //   UIApplication.sharedApplication().openURL(NSURL(string: "http://yalantis.com/")!)
    }
}

//MARK: KolodaViewDataSource
extension SwipeTurnViewController: KolodaViewDataSource {
    
    func koloda(kolodaNumberOfCards koloda:KolodaView) -> UInt {
        //return numberOfCards
        return UInt(GameSearchInfo.count)
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        
         var gametype : GameTypeSwipe
        
        gametype = GameSearchInfo[Int(index)]
        
        let theImage = LoadTurnImage(gametype.TurnURL, index: index)
        
        
        
        return UIImageView(image: theImage)
//        return UIImageView(image: UIImage(named: "Card_like_\(index + 1)"))
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView",
            owner: self, options: nil)?[0] as? OverlayView
    }
    
    func fileExists(_ url : URL!) -> Bool {
        
        let req = NSMutableURLRequest(url: url)
        req.httpMethod = "HEAD"
        req.timeoutInterval = 1.0 // Adjust to your needs
        
        var response : URLResponse?
        var responseError: NSError?
        
        do {
            try NSURLConnection.sendSynchronousRequest(req as URLRequest, returning:&response)
        } catch let error as NSError {
            responseError = error
            // urlData = nil
        }
       
        //NSURLConnection.sendSynchronousRequest(req, returningResponse: &response, error: nil)
        
        return ((response as? HTTPURLResponse)?.statusCode ?? -1) == 200
    }
    
    
    func LoadTurnImage(_ URLString: String, index: UInt) -> UIImage {
        
        var theImage = UIImage()
        
        var URLTemp: URL?
        
        var request = URLRequest(url: URLTemp!)
        
        let requestJPG = URL(string: "\(URLString).jpg")!
        let requestGIF = URL(string: "\(URLString).gif")!
        let requestMP3 = URL(string: "\(URLString).mp3")!
        
        var loadImage = Bool()
        
        if fileExists(requestJPG) {
            print("JPG exists")
            request = URLRequest(url: requestJPG)
            loadImage = true
        } else if fileExists(requestGIF) {
            print("gif exists")
            request = URLRequest(url: requestGIF)
            loadImage = true
        } else if fileExists(requestMP3) {
            print("mp3 exists")
            request = URLRequest(url: requestMP3)
            loadImage = true
        } else {
            print("no file exists at the url \(URLString)")
            loadImage = false
        }
        
        
        
        
       // let request: NSURLRequest = NSURLRequest(URL: NSURL(string: URLString)!)
        
        if loadImage {
        
        let mainQueue = OperationQueue.main
        NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
            if error == nil {
                // Convert the downloaded data in to a UIImage object
                var image = UIImage(data: data!)
                // Store the imge in to our cache
                //  self.imageCache[urlString] = image
                // Update the cell
                DispatchQueue.main.async(execute: {
                   
                    theImage = image!
                   // if let cellToUpdate = self.
                    
                })
            } else {
                
             theImage = UIImage(named: "noImage.png")!
                
                print("Error: \(error!.localizedDescription)")
            }
        })
        
        
        
        } else {
            theImage = UIImage(named: "noImage.png")!
}
    return theImage
}
    
}

