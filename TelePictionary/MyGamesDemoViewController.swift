//
//  MyGamesDemoViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 2/13/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class MyGamesDemoViewController: UIViewController, AKPickerViewDelegate, AKPickerViewDataSource, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating,  UIPopoverPresentationControllerDelegate, UIScrollViewDelegate {
    
    
    
    @IBOutlet weak var howtoLBL1: UILabel!
    
    @IBOutlet weak var howtoLBL2: UILabel!
    
    var AlreadySeenView1 = Bool()
    var AlreadySeenView2 = Bool()
    var AlreadySeenView3 = Bool()
    var AlreadySeenView4 = Bool()
    
    
    @IBOutlet weak var swipeTOP: NSLayoutConstraint!
    
    var LastHowToView = Int()
    
    @IBOutlet weak var view4TOP2: NSLayoutConstraint!
    @IBOutlet weak var view1TOP2: NSLayoutConstraint!
    
    @IBOutlet weak var view2TOP2: NSLayoutConstraint!
    
    @IBOutlet weak var view3TOP2: NSLayoutConstraint!
    
    @IBOutlet weak var titleLBL: UILabel!
  
    @IBOutlet weak var closeBTN: UIButton!
    
    var isFun = NSString()
    @IBOutlet weak var swipeIconRIGHT: NSLayoutConstraint!
    @IBOutlet weak var swipeIcon: UIImageView!
    
    var pickerIsAllGames = Bool()
    var SegmentValueString = NSString()
    
    var SearchBarShowing = Bool()
    
    @IBOutlet var segmentControl : ADVSegmentedControl!
    
    
    
    @IBOutlet weak var gameSegment: ADVSegmentedControl!
    
    
    @IBOutlet weak var segmentControlTOP: NSLayoutConstraint!
    var MyTotalTurns = Int()
    var NumTurnsLoaded = Int()
    let threshold: CGFloat = 100.0
    let Topthreshold: CGFloat = 0.0
    var isLoadingMore = Bool()
    var isRefreshing = Bool()
    var TableYPos = CGFloat()
    
    var blurEffectView = UIVisualEffectView()
    
    var IsGameCenter = Bool()
    let titles = ["My Games", "All Games"]
    
    @IBOutlet weak var pickerView: AKPickerView!
    
    
    var pickerItem = Bool()
    @IBOutlet weak var contentView: UIView!
    var pokeplayerviewcontroller: PokePlayerViewController = PokePlayerViewController()
    
    @IBOutlet weak var restartMyGames: UIButton!
    @IBOutlet weak var TableViewTOP: NSLayoutConstraint!
    
    
    let prefs = UserDefaults.standard
    
    let RefreshHUD = ProgressHUD(text: "Refreshing games...")
    
    
    @IBOutlet var HowToMyGamesLBL: UILabel!
    @IBOutlet var HowToMyGamesLBL2: UILabel!
    @IBOutlet var HowToMyGamesLBL3: UILabel!
    @IBOutlet var HowToMyGamesLBL4: UILabel!
    
    @IBOutlet weak var closeView1: UIButton!
    @IBOutlet weak var closeView2: UIButton!
    @IBOutlet weak var closeView3: UIButton!
    
    
    var NumComments = NSString()
    
    var ViewHowTo = Bool()
    @IBOutlet var ViewHolder: UIView!
    
    @IBOutlet var ViewHolderTOP: NSLayoutConstraint!
    var JustViewingPlayers = Bool()
    @IBOutlet var View4: UIView!
    @IBOutlet var View3: UIView!
    
    @IBOutlet var View2: UIView!
    @IBOutlet var View1: UIView!
    @IBOutlet var View1TOP: NSLayoutConstraint!
    
    @IBOutlet var View1CloseBTN: UIButton!
    @IBOutlet var View2BTN: UIButton!
    
    @IBOutlet var View1BTN: UIButton!
    @IBOutlet var subViewHolder: UIView!
    
    @IBOutlet var View3BTN: UIButton!
    @IBOutlet var View4BTN: UIButton!
    // @IBOutlet weak var lblView: UIView!
    @IBOutlet var View2TOP: NSLayoutConstraint!
    
    @IBOutlet var View3TOP: NSLayoutConstraint!
    @IBOutlet var subViewHolderTOP: NSLayoutConstraint!
    
    @IBOutlet var View4TOP: NSLayoutConstraint!
    
    let dateFormater = DateFormatter()
    var refreshControl:UIRefreshControl!
    var DeletedGameIDs = [NSString]()
    
    var username = NSString()
    var userID = NSString()
    var GameSegue = "Select_Game"
    
    @IBOutlet weak var TableView: UITableView!
    
    @IBOutlet weak var NoGamesLBL: UILabel!
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    
    //@IBOutlet weak var editBTN: UIBarButtonItem!
    
    @IBOutlet weak var editBTN: UIButton!
    
    var CurrentUserInfoBTN = NSString()
    var UserTurnIDInfoBTN = NSString()
    @IBOutlet weak var toolbarBottom: UIToolbar!
    
    var GameRowSelected = Int()
    var GameSelected = NSString()
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var LastTurnUser = NSString()
    var TurnUser = NSString()
    var TurnUserID = NSString()
    
    var GameData = [NSArray]()
    var GameInfo = [NSArray]()
    let dateFormatter = DateFormatter()
    
    var GameSearchArray = [GameType]()
    var GameSearchInfo = [GameType]()
    var FilteredGames = [GameType]()
    
    var theContent = NSString()
    var theVisibility = NSString()
    var thePlayer1 = NSString()
    var thePlayer2 = NSString()
    var thePlayer3 = NSString()
    var thePlayer4 = NSString()
    var thePlayer5 = NSString()
    var thePlayer6 = NSString()
    var thePlayer7 = NSString()
    var thePlayer8 = NSString()
    var thePlayer9 = NSString()
    var thePlayer10 = NSString()
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
    var GameLikeArrayInfo = [NSString]()
    var GameFailArrayInfo = [NSString]()
    var GameIDInfo = [NSString]()
    
    var Player1Info  = [NSString]()
    
    var Player2Info = [NSString]()
    var Player3Info = [NSString]()
    var Player4Info = [NSString]()
    var Player5Info = [NSString]()
    var Player6Info = [NSString]()
    var Player7Info = [NSString]()
    var Player8Info = [NSString]()
    var Player9Info = [NSString]()
    var Player10Info = [NSString]()
    var Player1IDInfo = [NSString]()
    var Player2IDInfo = [NSString]()
    var Player3IDInfo = [NSString]()
    var Player4IDInfo = [NSString]()
    var Player5IDInfo = [NSString]()
    var Player6IDInfo = [NSString]()
    var Player7IDInfo = [NSString]()
    var Player8IDInfo = [NSString]()
    var Player9IDInfo = [NSString]()
    var Player10IDInfo = [NSString]()
    var Turn1Info = [NSString]()
    var Turn2Info = [NSString]()
    var Turn3Info = [NSString]()
    var Turn4Info = [NSString]()
    var Turn5Info = [NSString]()
    var Turn6Info = [NSString]()
    var Turn7Info = [NSString]()
    var Turn8Info = [NSString]()
    var Turn9Info = [NSString]()
    var Turn10Info = [NSString]()
    var TurnNumberInfo = [NSString]()
    var IsCompleteInfo = [NSString]()
    var UsersTurnInfo = [NSString]()
    var UsersTurnIDInfo = [NSString]()
    var LastTurnTimeInfo = [NSString]()
    var TimeLimitInfo = [NSString]()
    var CanTakeTurnInfo = [NSString]()
    var GameStyleInfo = [NSString]()
    var GameVisibleInfo = [NSString]()
    var TotalLikesInfo = [NSString]()
    var commentInfo = [NSString]()
    var contentInfo = [NSString]()
    
    var GameNameInfoBTN = NSString()
    var GameIDInfoBTN = NSString()
    var TurnNumberInfoBTN = NSString()
    var IsCompleteInfoBTN = NSString()
    var GameStyleInfoBTN = NSString()
    var CanTakeTurnInfoBTN = NSString()
    var ContentInfoBTN = NSString()
    
    // var resultSearchController: UISearchController!
    var resultSearchController = UISearchController()
    var searchBar = UISearchBar()
    
    var selectedScope = "All"
    
    var GameNameInfo = [NSString]()
    
    var GamesAvailable = Bool()
    
    var FunQuoteBox = [UIImage]()
    var BlurryImages = [UIImage]()
    
    var HowToStep = NSString()
    
    var contentImage1 = UIImage()
    var contentImage2 = UIImage()
    var contentImage3 = UIImage()
    //let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    // var dateaptArray = [NSString]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LastHowToView = 0
        self.titleLBL.text = "Games"
        //isFun = prefs.valueForKey("ISFUN") as! NSString
        
        HowToStep = "0"
        
        isFun = "yes"
        
        
        SegmentValueString = "My Turns"
        swipeIcon.layer.cornerRadius = 25
        
        
        
        segmentControl.items = ["All", "My Turns", "Completed"]
        segmentControl.font = UIFont(name: "DK Cool Crayon", size: 12)
        segmentControl.borderColor = UIColor(white: 1.0, alpha: 0.3)
        segmentControl.selectedIndex = 1
        segmentControl.thumbColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
        segmentControl.selectedLabelColor = UIColor.white
        segmentControl.addTarget(self, action: #selector(MyGamesDemoViewController.segmentValueChanged(_:)), for: .valueChanged)
        
        
        gameSegment.items = ["My Games", "Public Games"]
        gameSegment.font = UIFont(name: "DK Cool Crayon", size: 12)
        gameSegment.borderColor = UIColor(white: 1.0, alpha: 0.3)
        gameSegment.selectedIndex = 0
        gameSegment.thumbColor = UIColor.white
        //UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
        gameSegment.selectedLabelColor = UIColor.darkGray
        gameSegment.addTarget(self, action: #selector(MyGamesDemoViewController.gamesegmentValueChanged(_:)), for: .valueChanged)
        
        
        
        FunQuoteBox.append(UIImage(named: "Q2Box1.png")!)
        FunQuoteBox.append(UIImage(named: "Q2Box2.png")!)
        FunQuoteBox.append(UIImage(named: "Q2Box3.png")!)
        FunQuoteBox.append(UIImage(named: "Q2Box4.png")!)
        
        // BlurryImages.append(UIImage(named: "blurry1.png")!)
        // BlurryImages.append(UIImage(named: "blurry2.png")!)
        BlurryImages.append(UIImage(named: "blurry3.png")!)
        BlurryImages.append(UIImage(named: "blurry4.png")!)
        BlurryImages.append(UIImage(named: "blurry5.png")!)
        
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        // self.pickerView.textColor
        self.pickerView.font = UIFont(name: "DK Cool Crayon", size: 20)!
        self.pickerView.highlightedFont = UIFont(name: "DK Cool Crayon", size: 20)!
        self.pickerView.pickerViewStyle = .wheel
        // self.pickerView.pickerViewStyle = AKPickerViewStyle.
        self.pickerView.maskDisabled = false
        self.pickerView.reloadData()
        //self.pickerView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        
        GamesAvailable = true
        username = "You"
        userID = "YouID"
        NoGamesLBL.isHidden = true
        restartMyGames.isHidden = true

        
        /*
        if self.prefs.valueForKey("USERNAME") != nil {
            GamesAvailable = true
            username = prefs.valueForKey("USERNAME") as! NSString as String
            userID = prefs.valueForKey("PLAYERID") as! NSString as String
            NoGamesLBL.hidden = true
            restartMyGames.hidden = true
            
        } else  {
            GamesAvailable = false
            username = "temp"
            NoGamesLBL.hidden = false
            userID = "temp"
            
            self.restartMyGames.hidden = false
            //restartMyGames.hidden = true
        }
        
        */
        
        //  dateFormatter.dateFormat = "MM-dd-yyyy"
        //  dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //dateFormatter.dateFormat = "MM-dd-yyyy"
        
      //  pokeplayerviewcontroller.pokedelegate=self
        
        self.searchBar.delegate = self
        
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            //   controller.delegate = self
            controller.dimsBackgroundDuringPresentation = false
            // controller.searchBar.showsScopeBar = true
            //  controller.searchBar.
            controller.searchBar.sizeToFit()
            controller.searchBar.scopeButtonTitles = ["All", "Complete", "In Process"]
            
            controller.definesPresentationContext = true
            controller.searchBar.backgroundColor = UIColor.blue
            controller.searchBar.placeholder = "Search for a Game"
            controller.searchBar.tintColor = UIColor.darkGray
            controller.searchBar.layer.backgroundColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0).cgColor
            // controller.s
            
            self.TableView.tableHeaderView = controller.searchBar
            // self.view.addSubview(controller.searchBar)
            
            return controller
        })()
        
        self.searchBar.alpha = 0.0
        //  self.resultSearchController.searchBar.showsScopeBar = true
        // self.resultSearchController.delegate = self
        
        if #available(iOS 9.0, *) {
            self.resultSearchController.loadViewIfNeeded()
        } else {
            // Fallback on earlier versions
        }
        
        
        /*
        if let font = UIFont(name: "DK Cool Crayon", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.whiteColor()]
        }
        */
        //self.navigationController!.navigationBar.titleTextAttributes = [ ]
        
        
        
        
        
        TableView.backgroundColor = UIColor.clear
        //self.resultSearchController.active = false
        
        //    if #available(iOS 9.0, *) { self.resultSearchController.loadViewIfNeeded() }
        
        self.TableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        //navigationController!.navigationBar.barTintColor = UIColor(red: 0.0, green: 0.941, blue: 0.6078, alpha: 0.1)
        
      //  navigationController!.navigationBar.barTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
        
        TableView.delegate = self
        TableView.dataSource = self
        
        
        /*
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        */
        
        self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(MyGamesDemoViewController.RefreshGameData(_:)), for: UIControlEvents.valueChanged)
        self.TableView.addSubview(refreshControl)
        
        View1.layer.cornerRadius = 10
        View1.layer.borderWidth = 1
        View1.layer.borderColor = UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0).cgColor
        View2BTN.layer.cornerRadius = 10
        View2.layer.cornerRadius = 10
        View3BTN.layer.cornerRadius = 10
        View3.layer.cornerRadius = 10
        View1BTN.layer.cornerRadius = 10
        View4.layer.cornerRadius = 10
        View4BTN.layer.cornerRadius = 10
        
        
        subViewHolder.layer.cornerRadius = 10
        
        HowToMyGamesLBL.roundCorners([.topLeft, .topRight], radius: 10)
        
        HowToMyGamesLBL.layer.masksToBounds = true
        
        HowToMyGamesLBL2.roundCorners([.topLeft, .topRight], radius: 10)
        
        HowToMyGamesLBL2.layer.masksToBounds = true
        
        HowToMyGamesLBL3.roundCorners([.topLeft, .topRight], radius: 10)
        
        HowToMyGamesLBL3.layer.masksToBounds = true
        
        HowToMyGamesLBL4.roundCorners([.topLeft, .topRight], radius: 10)
        
        HowToMyGamesLBL4.layer.masksToBounds = true
        
        
        
        View1.layer.masksToBounds = true
        View2.layer.masksToBounds = true
        View3.layer.masksToBounds = true
        View4.layer.masksToBounds = true
        
        ViewHolder.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        
        /*
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        
        
        let AlreadySeenHowTo = prefs.boolForKey("DidShowHowTo_MyGames")
        
        if !AlreadySeenHowTo {
        closeView1.hidden = true
        closeView2.hidden = true
        closeView3.hidden = true
        UIView.animateWithDuration(1.0, animations: { () -> Void in
        
        self.subViewHolderTOP.constant = middleY
        
        self.ViewHolder.center.y = self.ViewHolder.center.y - 1000
        
        self.ViewHolderTOP.constant = 0
        //self.ViewShowing = true
        // ShowingInfo = true
        
        // self.ViewTransTOP.constant = 0
        self.ViewHowTo = true
        })
        
        }
        */
        // self.TableView.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MyGamesDemoViewController.displayForegroundDetails), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        
        if isFun.isEqual(to: "no") {
            
            contentImage1 = UIImage(named: "contentEasycircle2.png")!
            contentImage2 = UIImage(named: "contentMediumcircle2.png")!
            contentImage3 = UIImage(named: "contentHardcircle2.png")!
            
        } else {
            
            contentImage1 = UIImage(named: "contentEcircle2.png")!
            contentImage2 = UIImage(named: "contentTcircle2.png")!
            contentImage3 = UIImage(named: "contentMcircle2.png")!
        }
        
       
        
        
      
        
    }
    
    
    func CreateDemoGames () {
        GameSearchInfo.removeAll()
        GameSearchArray.removeAll()
        
        
        switch self.SegmentValueString {
        
            case "All":
            
        switch self.LastHowToView {
            
        case 0:
            CreateDemoGamesImage()
            
        case 1:
            //CreateDemoGamesImage()
            CreateDemoGamesQuote()
            
        case 2:
            CreateDemoGamesImage()
            CreateDemoGamesQuote()
            CreateDemoGamesComplete()
            
        default:
            break
            
        }
            
        case "My Turns":
            
            switch self.LastHowToView {
                
            case 0:
                CreateDemoGamesImage()
                
            case 1:
                //CreateDemoGamesImage()
                CreateDemoGamesQuote()
                
            case 2:
                break
               // CreateDemoGamesImage()
               // CreateDemoGamesQuote()
               // CreateDemoGamesComplete()
                
            default:
                break
                
            }
            
        case "Complete":
            
            switch self.LastHowToView {
                
            case 0:
                //CreateDemoGamesImage()
                break
            case 1:
                //CreateDemoGamesImage()
                //CreateDemoGamesQuote()
                break
            case 2:
               // CreateDemoGamesImage()
              //  CreateDemoGamesQuote()
                CreateDemoGamesComplete()
                
            default:
                break
                
            }
        
            
        default:
            break
        }
        
        
        DispatchQueue.main.async(execute: {
            self.GameSearchArray = self.GameSearchInfo
            self.TableView.reloadData()
            self.refreshControl!.endRefreshing()
        })
    }
    
    func CreateDemoGamesAll () {
        GameSearchInfo.removeAll()
        GameSearchArray.removeAll()
        
        
        switch self.LastHowToView {
            
        case 0:
            CreateDemoGamesImage()
            
        case 1:
            //CreateDemoGamesImage()
            CreateDemoGamesQuote()
            
        case 2:
            CreateDemoGamesImage()
            CreateDemoGamesQuote()
            CreateDemoGamesComplete()
            
        default:
            break
            
        }
        
        
        
        
        DispatchQueue.main.async(execute: {
            self.GameSearchArray = self.GameSearchInfo
            self.TableView.reloadData()
            self.refreshControl!.endRefreshing()
        })
    }
    
    func CreateDemoGamesMyTurns () {
        GameSearchInfo.removeAll()
        GameSearchArray.removeAll()
        
        
        switch self.LastHowToView {
            
        case 0:
            CreateDemoGamesImage()
            
        case 1:
            CreateDemoGamesQuote()
            
        case 2:
            break
           // CreateDemoGamesComplete()
            
        default:
            break
            
        }
        
        
        
        
        DispatchQueue.main.async(execute: {
        self.GameSearchArray = self.GameSearchInfo
        self.TableView.reloadData()
        self.refreshControl!.endRefreshing()
        })
    }
    
    func CreateDemoGamesCompleted2 () {
        GameSearchInfo.removeAll()
        GameSearchArray.removeAll()
        
        
        switch self.LastHowToView {
            
        case 0:
            break
            //CreateDemoGamesImage()
            
        case 1:
            break
            //CreateDemoGamesQuote()
            
        case 2:
            CreateDemoGamesComplete()
            
        default:
            break
            
        }
        
        
        
        
        DispatchQueue.main.async(execute: {
            self.GameSearchArray = self.GameSearchInfo
            self.TableView.reloadData()
            self.refreshControl!.endRefreshing()
        })
    }
    
    func CreateDemoGamesImage () {
        
        
        let gameID = "demo"
        let gname = "First Game"
        print("Accepted GameID = \(gameID)")
        
        let player1 = "Pixie"
        
        let player2 = "TBD"
        
        let player3 = "TBD"
        let player4 = "TBD"
        let player5 = "TBD"
        
        let player6 = "TBD"
        
        let player7 = "TBD"
        
        let player8 = "TBD"
        let player9 = "JohnSmith"
        let player10 = "You"
        
        let player1ID = "0099"
        
        let player2ID = "0099"
        
        let player3ID = "0099"
        let player4ID = "0099"
        let player5ID = "0099"
        
        let player6ID = "0099"
        
        let player7ID = "0099"
        
        let player8ID = "0099"
        let player9ID = "0099"
        let player10ID = "0099"
        
        
        
        let isComplete = "no"
        let turnNumber = "10"
        let LastTurnTime = ""
        
        
        let TimeLimit = "02:00:00"
        let CanTakeTurn = "yes"
        
        let gameliketemp = "3"
        let gamefailtemp = "2"
        
        
        print("Can Take Turn = \(CanTakeTurn)")
        
        let GameStyle = ""
        let GameVisible1 = "yes"
        
        var GameVisible = NSString()
        
        if GameVisible1 == "yes" {
            GameVisible = "Public"
        } else {
            GameVisible = "Private"
        }
        
        
        let totalLikes = "2"
        let commentTemp = "0"
        
        let Turn1MediaType = "quote"
        let GameSettingP = "private"
        
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
        
        
        
        
        LastTurnUser = player9 as NSString
        TurnUser = player10 as NSString
        TurnUserID = player10ID as NSString
        //TurnUser2 = "User1"
        
        
        let theSearchString = "\(player1) \(player2) \(player3) \(player4) \(player5) \(player6) \(player7) \(player8) \(player9) \(player10) \(gname)"
        
        let ContentRating = "M"
        
        GameSearchInfo.append(GameType(GameCategory: "In Process", GameName: gname, GameID: gameID, GamePlayer1: player1, GamePlayer2: player2, GamePlayer3: player3, GamePlayer4: player4, GamePlayer5: player5, GamePlayer6: player6, GamePlayer7: player7, GamePlayer8: player8, GamePlayer9: player9, GamePlayer10: player10, GameTurnNumber: turnNumber, GameIsComplete: isComplete, GameUsersTurn: TurnUser as String, GameLastTurnTime: LastTurnTime, GameTimeLimit: TimeLimit, GameCanTakeTurn: CanTakeTurn, GameGameStyle: GameStyle, GameGameVisible: GameVisible as String, GameTotalLikes: totalLikes, GameCommentInfo: commentTemp, GameGameLikeArray: gameliketemp, GameGameFailArray: gamefailtemp, GamePlayer1ID: player1ID, GamePlayer2ID: player2ID, GamePlayer3ID: player3ID, GamePlayer4ID: player4ID, GamePlayer5ID: player5ID, GamePlayer6ID: player6ID, GamePlayer7ID: player7ID, GamePlayer8ID: player8ID, GamePlayer9ID: player9ID, GamePlayer10ID: player10ID, GameUsersTurnID: TurnUserID as String, GameContent: ContentRating, GameSearchString: theSearchString, Turn1MediaType: Turn1MediaType, Turn1URLString: Turn1URLString, LastTurnUser: LastTurnUser as String, GameSetting: GameSettingP, NewToView: false))
        
        
        
        
        
        
        
    }
    
    func CreateDemoGamesQuote () {
        
        
        let gameID = "demo"
        let gname = "Second Game"
        print("Accepted GameID = \(gameID)")
        
        let player1 = "Pixie"
        
        let player2 = "TBD"
        
        let player3 = "TBD"
        let player4 = "TBD"
        let player5 = "TBD"
        
        let player6 = "TBD"
        
        let player7 = "MarkJones47"
        
        let player8 = "MikeSmith123"
        let player9 = "MikeSmith123"
        let player10 = "You"
        
        let player1ID = "0099"
        
        let player2ID = "0099"
        
        let player3ID = "0099"
        let player4ID = "0099"
        let player5ID = "0099"
        
        let player6ID = "0099"
        
        let player7ID = "0099"
        
        let player8ID = "0099"
        let player9ID = "0099"
        let player10ID = "0099"
        
        
        
        let isComplete = "no"
        let turnNumber = "9"
        let LastTurnTime = ""
        
        
        let TimeLimit = "02:00:00"
        let CanTakeTurn = "yes"
        
        let gameliketemp = "0"
        let gamefailtemp = "0"
        
        
        print("Can Take Turn = \(CanTakeTurn)")
        
        let GameStyle = ""
        let GameVisible1 = "yes"
        
        var GameVisible = NSString()
        
        if GameVisible1 == "yes" {
            GameVisible = "Public"
        } else {
            GameVisible = "Private"
        }
        
        
        let totalLikes = "2"
        let commentTemp = "0"
        
        let Turn1MediaType = "image"
        let GameSettingP = "private"
        
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
        
        
        
        
        LastTurnUser = player7 as NSString
        TurnUser = player8 as NSString
        TurnUserID = player8ID as NSString
        //TurnUser2 = "User1"
        
        
        let theSearchString = "\(player1) \(player2) \(player3) \(player4) \(player5) \(player6) \(player7) \(player8) \(player9) \(player10) \(gname)"
        
        let ContentRating = "M"
        
        GameSearchInfo.append(GameType(GameCategory: "In Process", GameName: gname, GameID: gameID, GamePlayer1: player1, GamePlayer2: player2, GamePlayer3: player3, GamePlayer4: player4, GamePlayer5: player5, GamePlayer6: player6, GamePlayer7: player7, GamePlayer8: player8, GamePlayer9: player9, GamePlayer10: player10, GameTurnNumber: turnNumber, GameIsComplete: isComplete, GameUsersTurn: TurnUser as String, GameLastTurnTime: LastTurnTime, GameTimeLimit: TimeLimit, GameCanTakeTurn: CanTakeTurn, GameGameStyle: GameStyle, GameGameVisible: GameVisible as String, GameTotalLikes: totalLikes, GameCommentInfo: commentTemp, GameGameLikeArray: gameliketemp, GameGameFailArray: gamefailtemp, GamePlayer1ID: player1ID, GamePlayer2ID: player2ID, GamePlayer3ID: player3ID, GamePlayer4ID: player4ID, GamePlayer5ID: player5ID, GamePlayer6ID: player6ID, GamePlayer7ID: player7ID, GamePlayer8ID: player8ID, GamePlayer9ID: player9ID, GamePlayer10ID: player10ID, GameUsersTurnID: TurnUserID as String, GameContent: ContentRating, GameSearchString: theSearchString, Turn1MediaType: Turn1MediaType, Turn1URLString: Turn1URLString, LastTurnUser: LastTurnUser as String, GameSetting: GameSettingP, NewToView:  false))
        
        
        
        //  self.TableView.reloadData()
        
        
        
    }
    
    func CreateDemoGamesComplete () {
        
        
        let gameID = "demo"
        let gname = "Third Game"
        print("Accepted GameID = \(gameID)")
        
        let player1 = "Pixie"
        
        let player2 = "TBD"
        
        let player3 = "TBD"
        let player4 = "TBD"
        let player5 = "TBD"
        
        let player6 = "TBD"
        
        let player7 = "TBD"
        
        let player8 = "TBD"
        let player9 = "MikeSmith123"
        let player10 = "You"
        
        let player1ID = "0099"
        
        let player2ID = "0099"
        
        let player3ID = "0099"
        let player4ID = "0099"
        let player5ID = "0099"
        
        let player6ID = "0099"
        
        let player7ID = "0099"
        
        let player8ID = "0099"
        let player9ID = "0099"
        let player10ID = "0099"
        
       
        
        let isComplete = "yes"
        let turnNumber = "11"
        let LastTurnTime = ""
        
        
        let TimeLimit = "02:00:00"
        let CanTakeTurn = "no"
        
        let gameliketemp = "0"
        let gamefailtemp = "0"
        
        
        print("Can Take Turn = \(CanTakeTurn)")
        
        let GameStyle = ""
        let GameVisible1 = "yes"
        
        var GameVisible = NSString()
        
        if GameVisible1 == "yes" {
            GameVisible = "Public"
        } else {
            GameVisible = "Private"
        }
        
        
        let totalLikes = "2"
        let commentTemp = "0"
        
        let Turn1MediaType = "image"
        let GameSettingP = "private"
        
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
        
        
        
        
            LastTurnUser = player10 as NSString
            TurnUser = "Complete"
            TurnUserID = player10ID as NSString
            //TurnUser2 = "User1"
        
        
        let theSearchString = "\(player1) \(player2) \(player3) \(player4) \(player5) \(player6) \(player7) \(player8) \(player9) \(player10) \(gname)"
        
        let ContentRating = "M"
    
     GameSearchInfo.append(GameType(GameCategory: "In Process", GameName: gname, GameID: gameID, GamePlayer1: player1, GamePlayer2: player2, GamePlayer3: player3, GamePlayer4: player4, GamePlayer5: player5, GamePlayer6: player6, GamePlayer7: player7, GamePlayer8: player8, GamePlayer9: player9, GamePlayer10: player10, GameTurnNumber: turnNumber, GameIsComplete: isComplete, GameUsersTurn: TurnUser as String, GameLastTurnTime: LastTurnTime, GameTimeLimit: TimeLimit, GameCanTakeTurn: CanTakeTurn, GameGameStyle: GameStyle, GameGameVisible: GameVisible as String, GameTotalLikes: totalLikes, GameCommentInfo: commentTemp, GameGameLikeArray: gameliketemp, GameGameFailArray: gamefailtemp, GamePlayer1ID: player1ID, GamePlayer2ID: player2ID, GamePlayer3ID: player3ID, GamePlayer4ID: player4ID, GamePlayer5ID: player5ID, GamePlayer6ID: player6ID, GamePlayer7ID: player7ID, GamePlayer8ID: player8ID, GamePlayer9ID: player9ID, GamePlayer10ID: player10ID, GameUsersTurnID: TurnUserID as String, GameContent: ContentRating, GameSearchString: theSearchString, Turn1MediaType: Turn1MediaType, Turn1URLString: Turn1URLString, LastTurnUser: LastTurnUser as String, GameSetting: GameSettingP, NewToView: false))
        
        
        
        self.TableView.reloadData()
        
        
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        
        CreateDemoGames()
        /*
        
        let AlreadySeenHowTo = prefs.boolForKey("DidShowHowTo_MyGames")
        */
        let AlreadySeenHowTo = false
        if !AlreadySeenHowTo {
            closeView1.isHidden = true
            closeView2.isHidden = true
            closeView3.isHidden = true
            
            print("Last HowtoView = \(self.LastHowToView)")
            switch self.LastHowToView {
                
            case 0:
                self.view1TOP2.constant = 0
                self.view2TOP2.constant = 2000
                self.view3TOP2.constant = 2000
                self.view4TOP2.constant = 2000
                //self.NoGamesLBL.hidden = true
                
                self.howtoLBL1.text = "Whew...you made it just in time"
                self.howtoLBL2.text = "I'm Pixie, let's get started..."
                View1BTN.setTitle("Let's Go", for: UIControlState())
                 segmentControl.selectedIndex = 1
                
            case 1:
                self.view1TOP2.constant = 0
                self.view2TOP2.constant = 2000
                self.view3TOP2.constant = 2000
                self.view4TOP2.constant = 2000
                
                self.howtoLBL1.text = "Nice Job!"
                self.howtoLBL2.text = "Now let's try a Quote..."
                View1BTN.setTitle("Got it", for: UIControlState())
                 segmentControl.selectedIndex = 1
               // self.NoGamesLBL.hidden = true
                
            case 2:
                self.view1TOP2.constant = 0
                self.view2TOP2.constant = 2000
                self.view3TOP2.constant = 2000
                self.view4TOP2.constant = 2000
                
                self.howtoLBL1.text = "Woo hoo! Almost done."
                self.howtoLBL2.text = "Check out a Completed Game..."
                View1BTN.setTitle("Ok", for: UIControlState())
                
                 self.CreateDemoGamesCompleted2()
                
                 segmentControl.selectedIndex = 2
                
            case 3:
                self.howtoLBL1.text = "Now You're a Pro."
                self.howtoLBL2.text = "Let's play some real games..."
                View1BTN.setTitle("Great", for: UIControlState())
                 segmentControl.selectedIndex = 1
              //  self.NoGamesLBL.hidden = false
                
            default:
                break
                
            }
            
            
            
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
        
                self.subViewHolderTOP.constant = middleY
        
                self.ViewHolder.center.y = self.ViewHolder.center.y - 1000
        
                self.ViewHolderTOP.constant = 0
                
                
                
                
                
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
                self.ViewHowTo = true
            })
            
        }
        

    }
    
    func pickerView(_ pickerView: AKPickerView, configureLabel label: UILabel, forItem item: Int) {
        label.textColor = UIColor.lightGray
        label.highlightedTextColor = UIColor.white
        label.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1)
        
        /*
        label.backgroundColor = UIColor(
        hue: CGFloat(item) / CGFloat(self.titles.count),
        saturation: 1.0,
        brightness: 0.5,
        alpha: 1.0)
        
        */
    }
    
    
    func pickerView(_ pickerView: AKPickerView, marginForItem item: Int) -> CGSize {
        return CGSize(width: 40, height: 20)
    }
    
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        return self.titles.count
    }
    
    func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String {
        return self.titles[item]
    }
    
    func pickerView(_ pickerView: AKPickerView, imageForItem item: Int) -> UIImage {
        return UIImage(named: self.titles[item])!
    }
    
    // MARK: - AKPickerViewDelegate
    
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        
        switch item {
            
        case 0:
            self.RemoveGameArrayData()
            print("Mygames")
            //segmentControl.items = ["My Turns", "All", "Completed"]
            
            
            if pickerIsAllGames {
                pickerIsAllGames = false
                UIView.animate(withDuration: 1.0, animations: {
                    self.segmentControl.center.y = self.segmentControl.center.y + 40
                    self.TableView.center.y = self.TableView.center.y + 40
                    self.segmentControlTOP.constant = 0
                })
                
                pickerItem = false
                CreateDemoGames()
            //    refreshMyGames()
                
                
            }
            //false = my games
            /*
            dispatch_async(dispatch_get_main_queue(), {
            
            self.TableView.reloadData()
            
            })
            */
            
        case 1:
            //segmentControl.items = ["My Turns", "All", "Completed"]
            self.RemoveGameArrayData()
            self.SegmentValueString = "All"
            
            if !pickerIsAllGames {
                pickerIsAllGames = true
                UIView.animate(withDuration: 1.0, animations: {
                    self.segmentControl.center.y = self.segmentControl.center.y - 40
                    self.TableView.center.y = self.TableView.center.y - 40
                    self.segmentControlTOP.constant = -40
                })
                
            }
            
            print("all games")
            
            pickerItem = true
            CreateDemoGames()
        //    refreshPublicGames()
            //true = all games
            /*
            dispatch_async(dispatch_get_main_queue(), {
            
            self.TableView.reloadData()
            
            })
            */
            
        default:
            break
        }
    }
    
    func displayForegroundDetails() {
        
        
        print("APP ENTERED THE FOREGROUND")
        
        
       // _: UIWindow?
        
        
        if self.isViewLoaded && view.window != nil {
            
            
            self.view.addSubview(self.RefreshHUD)
            
            DispatchQueue.main.async(execute: {
                print("is on my games view controller, trying to refresh my games")
                self.RefreshGameData(self)
                // self.TableView.reloadData()
                DispatchQueue.main.async(execute: {
                    self.RefreshHUD.removeFromSuperview()
                    self.TableView.reloadData()
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
                if viewController.isKind(of: MyGamesViewController.self) {
                    
                    
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
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        if let superView = resultSearchController.view.superview
        {
            superView.removeFromSuperview()
        }
        
    }
    
    func RemoveGameArrayData() {
        
        GameInfo.removeAll()
        GameNameInfo.removeAll()
        GameIDInfo.removeAll()
        Player1Info.removeAll()
        Player2Info.removeAll()
        Player3Info.removeAll()
        Player4Info.removeAll()
        Player5Info.removeAll()
        Player6Info.removeAll()
        Player7Info.removeAll()
        Player8Info.removeAll()
        Player9Info.removeAll()
        Player10Info.removeAll()
        TurnNumberInfo.removeAll()
        IsCompleteInfo.removeAll()
        UsersTurnInfo.removeAll()
        LastTurnTimeInfo.removeAll()
        TimeLimitInfo.removeAll()
        CanTakeTurnInfo.removeAll()
        GameStyleInfo.removeAll()
        GameSearchInfo.removeAll()
        GameVisibleInfo.removeAll()
        TotalLikesInfo.removeAll()
        GameLikeArrayInfo.removeAll()
        GameFailArrayInfo.removeAll()
        Player1IDInfo.removeAll()
        Player2IDInfo.removeAll()
        Player3IDInfo.removeAll()
        Player4IDInfo.removeAll()
        Player5IDInfo.removeAll()
        Player6IDInfo.removeAll()
        Player7IDInfo.removeAll()
        Player8IDInfo.removeAll()
        Player9IDInfo.removeAll()
        Player10IDInfo.removeAll()
        UsersTurnIDInfo.removeAll()
        contentInfo.removeAll()
        
        self.GameSearchArray.removeAll()
        self.GameSearchInfo.removeAll()
        print("Game Info Array info after Deleting  all = \(GameInfo)")
    }
    
    func AddGameArrayInfo(_ GameInfo: [NSArray]){
        
        //  print("Game Info Array before adding all = \(GameInfo)")
        
        GameNameInfo = GameInfo[0] as! [(NSString)]
        GameIDInfo = GameInfo[1] as! [(NSString)]
        Player1Info = GameInfo[2] as! [(NSString)]
        Player2Info = GameInfo[3] as! [(NSString)]
        Player3Info = GameInfo[4] as! [(NSString)]
        Player4Info = GameInfo[5] as! [(NSString)]
        Player5Info = GameInfo[6] as! [(NSString)]
        Player6Info = GameInfo[7] as! [(NSString)]
        Player7Info = GameInfo[8] as! [(NSString)]
        Player8Info = GameInfo[9] as! [(NSString)]
        Player9Info = GameInfo[10] as! [(NSString)]
        Player10Info = GameInfo[11] as! [(NSString)]
        //    Turn1Info = GameInfo[12] as! [(NSString)]
        //    Turn2Info = GameInfo[13] as! [(NSString)]
        //    Turn3Info = GameInfo[14] as! [(NSString)]
        //    Turn4Info = GameInfo[15] as! [(NSString)]
        //    Turn5Info = GameInfo[16] as! [(NSString)]
        //    Turn6Info = GameInfo[17] as! [(NSString)]
        //    Turn7Info = GameInfo[18] as! [(NSString)]
        //    Turn8Info = GameInfo[19] as! [(NSString)]
        //    Turn9Info = GameInfo[20] as! [(NSString)]
        //    Turn10Info = GameInfo[21] as! [(NSString)]
        TurnNumberInfo = GameInfo[12] as! [(NSString)]
        IsCompleteInfo = GameInfo[13] as! [(NSString)]
        UsersTurnInfo = GameInfo[14] as! [(NSString)]
        LastTurnTimeInfo = GameInfo[15] as! [(NSString)]
        TimeLimitInfo = GameInfo[16] as! [(NSString)]
        CanTakeTurnInfo = GameInfo[17] as! [(NSString)]
        GameStyleInfo = GameInfo[18] as! [(NSString)]
        GameVisibleInfo = GameInfo[19] as! [(NSString)]
        TotalLikesInfo = GameInfo[20] as! [(NSString)]
        commentInfo = GameInfo[21] as! [(NSString)]
        GameLikeArrayInfo = GameInfo[22] as! [(NSString)]
        GameFailArrayInfo = GameInfo[23] as! [(NSString)]
        Player1IDInfo = GameInfo[24] as! [(NSString)]
        Player2IDInfo = GameInfo[25] as! [(NSString)]
        Player3IDInfo = GameInfo[26] as! [(NSString)]
        Player4IDInfo = GameInfo[27] as! [(NSString)]
        Player5IDInfo = GameInfo[28] as! [(NSString)]
        Player6IDInfo = GameInfo[29] as! [(NSString)]
        Player7IDInfo = GameInfo[30] as! [(NSString)]
        Player8IDInfo = GameInfo[31] as! [(NSString)]
        Player9IDInfo = GameInfo[32] as! [(NSString)]
        Player10IDInfo = GameInfo[33] as! [(NSString)]
        UsersTurnIDInfo = GameInfo[34] as! [(NSString)]
        contentInfo = GameInfo[35] as! [(NSString)]
        
        
        DispatchQueue.main.async(execute: {
            self.TableView.reloadData()
            print("adding array data, in function, did this come first?")
        })
        
    }
    
    
    func RefreshGameData(_ sender:AnyObject) {
        print("REFRESHING MY GAMES and removing array data")
        print("adding array data")
        
        //false = my games
        //true = all games
        
        if !pickerItem {
           // refreshMyGames()
            self.CreateDemoGames()
        } else {
          //  refreshPublicGames()
            self.CreateDemoGames()
        }
        
    }
    
    
    
    
    @IBAction func View2NextBTN(_ sender: AnyObject) {
        /*
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        subViewHolderTOP.constant = middleY
        
        /*
        View1TOP.constant = middleY
        View2TOP.constant = middleY
        View3TOP.constant = middleY
        View4TOP.constant = middleY
        ViewHolderTOP.constant = 0
        */
        let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.TransitionFlipFromRight, UIViewAnimationOptions.ShowHideTransitionViews]
        
        UIView.transitionFromView(self.View1, toView: self.View2, duration: 0.8, options: animationOptions, completion: nil)
        
        
        
        */
        
        
        
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        /*
        View1TOP.constant = 0
        View2TOP.constant = 0
        View3TOP.constant = 0
        View4TOP.constant = 0
        */
        subViewHolderTOP.constant = middleY
        
        
        if ViewHowTo {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.subViewHolderTOP.constant = middleY
                
                self.ViewHolder.center.y = self.ViewHolder.center.y + 1000
                
                self.ViewHolderTOP.constant = 1000
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            
            ViewHowTo = false
        }
        
        
        if self.LastHowToView == 3 {
            
            UserDefaults.standard.set(true, forKey: "FirstLaunch")
            
            DispatchQueue.main.async(execute: {
                 self.prefs.set(true, forKey: "DidShowHowTo_MyGamesDemo")
                
                //NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
                
            self.dismiss(animated: true, completion: nil)
            })
            
        }
        
       
        
    }
    
    @IBAction func View2BackBTN(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        
        subViewHolderTOP.constant = middleY
        
        ViewHolderTOP.constant = 0
        
        
        let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromLeft, UIViewAnimationOptions.showHideTransitionViews]
        
        UIView.transition(from: self.View2, to: self.View1, duration: 0.8, options: animationOptions, completion: nil)
    }
    @IBAction func View3NextBTN(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        subViewHolderTOP.constant = middleY
        ViewHolderTOP.constant = 0
        
        
        let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromRight, UIViewAnimationOptions.showHideTransitionViews]
        
        UIView.transition(from: self.View2, to: self.View3, duration: 0.8, options: animationOptions, completion: nil)
    }
    
    @IBAction func View3BackBTN(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        
        
        subViewHolderTOP.constant = middleY
        ViewHolderTOP.constant = 0
        
        let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromLeft, UIViewAnimationOptions.showHideTransitionViews]
        
        UIView.transition(from: self.View3, to: self.View2, duration: 0.8, options: animationOptions, completion: nil)
    }
    @IBAction func View4NextBTN(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        subViewHolderTOP.constant = middleY
        
        ViewHolderTOP.constant = 0
        
        
        let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromRight, UIViewAnimationOptions.showHideTransitionViews]
        
        UIView.transition(from: self.View3, to: self.View4, duration: 0.8, options: animationOptions, completion: nil)
    }
    
    @IBAction func View4BackBTN(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        
        subViewHolderTOP.constant = middleY
        ViewHolderTOP.constant = 0
        
        
        let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromLeft, UIViewAnimationOptions.showHideTransitionViews]
        
        UIView.transition(from: self.View4, to: self.View3, duration: 0.8, options: animationOptions, completion: nil)
    }
    
    
    @IBAction func View1CloseBTN(_ sender: AnyObject) {
        
        
        
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        /*
        View1TOP.constant = 0
        View2TOP.constant = 0
        View3TOP.constant = 0
        View4TOP.constant = 0
        */
        subViewHolderTOP.constant = middleY
        
        
        if ViewHowTo {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.subViewHolderTOP.constant = middleY
                
                self.ViewHolder.center.y = self.ViewHolder.center.y + 1000
                
                self.ViewHolderTOP.constant = 1000
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            
            ViewHowTo = false
        }
        
        
        self.prefs.set(true, forKey: "DidShowHowTo_MyGamesDemo")
        HowToStep = "1"
        
    }
    
    @IBAction func ViewHowTo(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if !ViewHowTo {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.subViewHolderTOP.constant = middleY
                
                self.ViewHolder.center.y = self.ViewHolder.center.y - 1000
                
                self.ViewHolderTOP.constant = 0
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            
            ViewHowTo = true
        }
        
    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        actInd.startAnimating()
        
        //segmentControl.selectedIndex = 1
        
        /*
        
        self.IsGameCenter = NSUserDefaults.standardUserDefaults().boolForKey("GameCenterEnabled")
        
        if !self.IsGameCenter {
            
            
            /*
            self.refreshControl.enabled = false
            
            let Alert = SCLAlertView()
            Alert.addButton("Log in Now", action: {
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    LogIntoGameCenterNew()
                    
                })
                
            })
            
            Alert.addButton("Later", action: {
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    SCLAlertView().showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Center", subTitle: "Without being logged into Game Center many of this games features are disabled.", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                    
                    // self.NoGamesLBL.hidden = true
                    self.restartMyGames.hidden = true
                    self.NoGamesLBL.text = "No User Is Signed In"
                    
                    self.actInd.stopAnimating()
                    
                })
                
                
            })
            
            Alert.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Game Center", subTitle: "You need to be logged into Game Center to view your games.  Please log in now", duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
            
            */
            
        } else {
            
            */
            
            //NSUserDefaults.standardUserDefaults().setBool(true, forKey: "GameCenterEnabled")
            
            
            
            
            RemoveGameArrayData()
           /*
            // self.TableView.reloadData()
            
            print("game array = \(GameNameInfo)")
            
            
            
            
            //  let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
            if prefs.valueForKey("USERNAME") != nil {
                
                username = prefs.valueForKey("USERNAME") as! NSString as String
            } else  {
                username = "tempName"
            }
            
            if GamesAvailable {
                
                
                
            }
            
            DeletedGameIDs.removeAll()
            GetDeletedGamesData()
            print("Retrieved All hidden Games: \(DeletedGameIDs)")
        
        */
            
            if Reachability.isConnectedToNetwork() {
                
                /*
                // var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
                // view.addGestureRecognizer(tap)
                
                
                //println("Username value check: \(username)")
                
                // dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_UTILITY.rawValue), 0)) {
                dispatch_async(dispatch_get_main_queue(), {
                    
                    
                    if self.prefs.valueForKey("USERNAME") != nil {
                        
                        let URLData = GetUserGameData(self.username, userID: self.userID, type: self.SegmentValueString)
                        //println(test)
                        (self.GameInfo, self.GameSearchArray) = self.FilterGameData(URLData)
                        
                        // print("GameSearchArray: \(self.GameSearchArray[0].GameName)")
                        
                        //  print("Game Search Info Count = \(self.GameSearchArray.count)")
                        
                        if self.GameSearchArray.count < 1 {
                            self.NoGamesLBL.hidden = false
                            self.restartMyGames.hidden = false
                            
                            print("showing no games label")
                        } else {
                            
                            print("hidding no games label")
                            self.NoGamesLBL.hidden = true
                            self.restartMyGames.hidden = true
                        }
                        
                        //println("Game Info: \(GameInfo)")
                        
                        
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            
                            self.AddGameArrayInfo(self.GameInfo)
                            
                            dispatch_async(dispatch_get_main_queue(), {
                                
                                self.TableView.reloadData()
                                self.actInd.stopAnimating()
                            })
                            
                            
                            
                        })
                        
                        
                        
                        print("Users turn info =\(self.UsersTurnInfo)")
                        print("Users turn ID info =\(self.UsersTurnIDInfo)")
                        //print(GameNameInfo)
                        
                    } else {
                        
                        print("no games available")
                        
                    }
                    
                })
                
                
                */
                
                
                DispatchQueue.main.async(execute: {
                    
                   // self.AddGameArrayInfo(self.GameInfo)
                    self.CreateDemoGames()
                    DispatchQueue.main.async(execute: {
                        
                        self.TableView.reloadData()
                        self.actInd.stopAnimating()
                    })
                    
                    
                    
                })
                
                
                switch self.LastHowToView {
                    
                case 0:
                    self.swipeTOP.constant = 300
                    self.swipeIcon.image = UIImage(named: "SwipeIconTAP")
                    segmentControl.selectedIndex = 1
                case 1:
                    self.swipeTOP.constant = 300
                    self.swipeIcon.image = UIImage(named: "SwipeIconTAP")
                     segmentControl.selectedIndex = 1
                case 2:
                    print("Should Show Completed Game")
                    self.swipeTOP.constant = 70
                    self.swipeIcon.image = UIImage(named: "SwipeIcon")
                    segmentControl.selectedIndex = 2
                DispatchQueue.main.async(execute: {
                   // self.CreateDemoGamesImage()
                   // self.CreateDemoGamesQuote()
                    self.CreateDemoGamesComplete()
                    
                    //CreateDemoGamesCompleted2()
                    //self.CreateDemoGamesCompleted2()
                    DispatchQueue.main.async(execute: {
                        
                        self.TableView.reloadData()
                        self.actInd.stopAnimating()
                    })
                        })
                default:
                    break
                    
                }
                
                let DeviceW = self.view.frame.width
                let midD = (DeviceW / 2) - 25
                
                
                let delayA = 4.0 * Double(NSEC_PER_SEC)
                let timeA = DispatchTime.now() + Double(Int64(delayA)) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: timeA) {
                UIView.animate(withDuration: 1.0, animations: { () -> Void in
                    
                    
                    
                    
                    self.swipeIcon.center.x = self.swipeIcon.center.x - (midD + 100)
                    self.swipeIconRIGHT.constant = midD
                    
                })
                
                
                }
                
                let delay = 8.5 * Double(NSEC_PER_SEC)
                let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: time) {
                    
                    
                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        
                        
                        self.swipeIcon.center.x = self.swipeIcon.center.x + (midD + 100)
                        self.swipeIconRIGHT.constant = -100
                        
                    })
                }
                
                
                
            }
                
            else
                
            {
                
                
                
                
                SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Network Error", subTitle: "Please Confirm Your Network Settings", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
                
            }
            
     //   }
        // self.TableView.reloadData()
        //   actInd.stopAnimating()
    }
    
    
    func ShowCommentsClicked(_ sender: UIButton!) {
        GameRowSelected = sender.tag
        print("the game rowselected: \(sender.tag)")
        
        var gametype: GameType
        
        if (self.resultSearchController.isActive) {
            gametype = FilteredGames[GameRowSelected]
        } else {
            gametype = GameSearchArray[GameRowSelected]
        }
        
        GameSelected = gametype.GameID as NSString
        
        
        /*
        if (self.resultSearchController.active) {
        
        GameSelected =  GameSearchArray[GameRowSelected].GameID
        
        } else  {
        GameSelected = GameIDInfo[GameRowSelected]
        
        }
        */
        //self.performSegueWithIdentifier("ShowComments", sender: self)
        
        
        
        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Comments", subTitle: "This is how you'll view the comments for each game", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
        
    }
    
    func pokeAnyClicked(_ sender: UIButton!) {
        
        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Poking", subTitle: "Poke a player to tell them to 'Hurry Up' and take their turn", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
        
        /*
        
        GameRowSelected = sender.tag
        let savingsInformationViewController = storyboard?.instantiateViewControllerWithIdentifier("pokeplayer") as! PokePlayerViewController
        
      //  savingsInformationViewController.pokedelegate = self
        
        var gametype: GameType
        
        if (self.resultSearchController.active) {
            gametype = FilteredGames[GameRowSelected]
        } else {
            gametype = GameSearchArray[GameRowSelected]
        }
        
        GameSelected = gametype.GameID
        
        //   GameSelected =  GameSearchArray[GameRowSelected].GameID
        
        savingsInformationViewController.gameid = gametype.GameID
        //  savingsInformationViewController.turnnumber = self.theTurnNumber
        
        savingsInformationViewController.player1  = gametype.GamePlayer1
        savingsInformationViewController.player2  = gametype.GamePlayer2
        savingsInformationViewController.player3  = gametype.GamePlayer3
        savingsInformationViewController.player4  = gametype.GamePlayer4
        savingsInformationViewController.player5  = gametype.GamePlayer5
        savingsInformationViewController.player6  = gametype.GamePlayer6
        
        savingsInformationViewController.player7  = gametype.GamePlayer7
        savingsInformationViewController.player8  = gametype.GamePlayer8
        savingsInformationViewController.player9  = gametype.GamePlayer9
        savingsInformationViewController.player10  = gametype.GamePlayer10
        savingsInformationViewController.player1ID = gametype.GamePlayer1ID
        savingsInformationViewController.player2ID  = gametype.GamePlayer2ID
        savingsInformationViewController.player3ID  = gametype.GamePlayer3ID
        savingsInformationViewController.player4ID  = gametype.GamePlayer4ID
        savingsInformationViewController.player5ID  = gametype.GamePlayer5ID
        savingsInformationViewController.player6ID  = gametype.GamePlayer6ID
        
        savingsInformationViewController.player7ID = gametype.GamePlayer7ID
        savingsInformationViewController.player8ID  = gametype.GamePlayer8ID
        savingsInformationViewController.player9ID  = gametype.GamePlayer9ID
        savingsInformationViewController.player10ID  = gametype.GamePlayer10ID
        
        savingsInformationViewController.turnnumber  = gametype.GameTurnNumber
        savingsInformationViewController.gamestyle  = gametype.GameGameStyle
        
        
        savingsInformationViewController.modalPresentationStyle = .Popover
        if let popoverController2 = savingsInformationViewController.popoverPresentationController {
            popoverController2.sourceView = sender as! UIView
            //  popoverController2.sourceView = self.view
            // popoverController2.sourceView = getgroupsBTN.self as! UIView
            //popoverController2.sourceRect = sender.bounds
            let DeviceW = self.view.frame.width
            let middleScreenW = DeviceW / 2
            let middleX = middleScreenW - 100
            
            
            popoverController2.sourceRect = CGRectMake(middleX,150,0,0)
            
            popoverController2.permittedArrowDirections = .Down
            popoverController2.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
            
            popoverController2.delegate = self
        }
        
        presentViewController(savingsInformationViewController, animated: true, completion: nil)
        
        
        */
        
        
    }
    
    func pokeClicked(_ sender: UIButton!) {
        
        
        
        
        
        _ = "FIND"
        _ = "Test"
        
        GameRowSelected = sender.tag
        print("the game rowselected: \(sender.tag)")
        var CurrentTurn = NSString()
        
        
        var gametype: GameType
        
        if (self.resultSearchController.isActive) {
            gametype = FilteredGames[GameRowSelected]
        } else {
            gametype = GameSearchArray[GameRowSelected]
        }
        
        GameSelected = gametype.GameID as NSString
        
        GameSelected =  gametype.GameID as NSString
        GameIDInfoBTN = gametype.GameID as NSString
        TurnNumberInfoBTN = gametype.GameTurnNumber as NSString
        IsCompleteInfoBTN = gametype.GameIsComplete as NSString
        GameStyleInfoBTN = gametype.GameGameStyle as NSString
        CanTakeTurnInfoBTN = gametype.GameCanTakeTurn as NSString
        CurrentUserInfoBTN = gametype.GameUsersTurn as NSString
        UserTurnIDInfoBTN = gametype.GameUsersTurnID as NSString
        
        
        
        //let selectedResult = indexPath.item
        CurrentTurn = gametype.GameTurnNumber as NSString
        
        
        
        
        let theAlert = SCLAlertView()
        theAlert.addButton("Soft Poke") {
            _ = "pokeSoft"
            
            
             SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Soft Poke", subTitle: "A Soft Poke politely tells the player to take their turn", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
          //  SendTurnNotice(TurnInfoTest, token: DeviceTKN, gameid: self.GameIDInfoBTN, turninfo: self.TurnNumberInfoBTN, alertType: AlertType, gameType: self.GameStyleInfoBTN, turninfoID:  self.UserTurnIDInfoBTN, myID: self.userID)
        }
        
        theAlert.addButton("Medium Poke") {
            _ = "pokeMedium"
            
            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Medium Poke", subTitle: "A Medium Poke is just a regular reminder that tells the player to take their turn", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
         //   SendTurnNotice(TurnInfoTest, token: DeviceTKN, gameid: self.GameIDInfoBTN, turninfo: self.TurnNumberInfoBTN, alertType: AlertType, gameType: self.GameStyleInfoBTN, turninfoID:  self.UserTurnIDInfoBTN, myID: self.userID)
        }
        
        theAlert.addButton("Hard Poke") {
            _ = "pokeHard"
            
            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Hard Poke", subTitle: "A Hard Poke tells the player to 'Take their turn ALREADY!..we're all waiting'", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
          //  SendTurnNotice(TurnInfoTest, token: DeviceTKN, gameid: self.GameIDInfoBTN, turninfo: self.TurnNumberInfoBTN, alertType: AlertType, gameType: self.GameStyleInfoBTN, turninfoID:  self.UserTurnIDInfoBTN, myID: self.userID)
        }
        
        
        
        
        theAlert.showCustomOK(UIImage(named: "pokeIconWhite.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Poke Player?", subTitle: "How hard would you like to them?", duration: nil, completeText: "Cancel", style: .custom, colorStyle: 1, colorTextButton: 1)
        
        
    }
    
    
    func TakeTurnClicked(_ sender: UIButton!) {
        
        
        
        GameRowSelected = sender.tag
        print("the game rowselected: \(sender.tag)")
        var lastPlayer = NSString()
        var CurrentTurn = NSString()
        
        var gametype: GameType
        
        if (self.resultSearchController.isActive) {
            gametype = FilteredGames[GameRowSelected]
        } else {
            gametype = GameSearchArray[GameRowSelected]
        }
        
        GameSelected = gametype.GameID as NSString
        
        
        //let row = indexPath.row
        let isTurnAvailable = gametype.GameCanTakeTurn
        
        print("Is Turn Available = \(isTurnAvailable)")
        
        GameNameInfoBTN = gametype.GameName as NSString
        GameIDInfoBTN = gametype.GameID as NSString
        TurnNumberInfoBTN = gametype.GameTurnNumber as NSString
        IsCompleteInfoBTN = gametype.GameIsComplete as NSString
        GameStyleInfoBTN = gametype.GameGameStyle as NSString
        CanTakeTurnInfoBTN = gametype.GameCanTakeTurn as NSString
        CurrentUserInfoBTN = gametype.GameUsersTurn as NSString
        ContentInfoBTN = gametype.GameContent as NSString
        
        //let selectedResult = indexPath.item
        CurrentTurn = gametype.GameTurnNumber as NSString
        
        print(CurrentTurn)
        
        let GameName = gametype.GameName
        //var TurnTimeLimit = TimeLimitInfo[GameRowSelected]
        
        print(GameName)
        
        //var lastPlayer = NSString()
        
        switch CurrentTurn
        {
            //case "1":
            //   lastPlayer = Player1Info[GameRowSelected]
            
            
        case "2":
            lastPlayer = gametype.GamePlayer1 as NSString
        case "3":
            lastPlayer = gametype.GamePlayer2 as NSString
        case "4":
            lastPlayer = gametype.GamePlayer3 as NSString
        case "5":
            lastPlayer = gametype.GamePlayer4 as NSString
        case "6":
            lastPlayer = gametype.GamePlayer5 as NSString
        case "7":
            lastPlayer = gametype.GamePlayer6 as NSString
        case "8":
            lastPlayer = gametype.GamePlayer7 as NSString
        case "9":
            lastPlayer = gametype.GamePlayer8 as NSString
        case "10":
            lastPlayer = gametype.GamePlayer9 as NSString
        default:
            print("Error")
        }
        
        // let lastplayerRow = GameRowSelected - 1;
        
        
        // let lastPlayer = UsersTurnInfo[lastplayerRow]
        print("Last Player = \(lastPlayer)")
        

        if lastPlayer as String == username.description {
            
            
            
            let theAlert = SCLAlertView()
            
            
            theAlert.addButton("Take it") {
                
                
                switch self.LastHowToView {
                    
                case 0:
                    self.LastHowToView = 1
                    
                case 1:
                    self.LastHowToView = 2
                    
                case 2:
                    self.LastHowToView = 3
                    
                default:
                    break
                    
                }
                
                
                switch self.GameNameInfoBTN
                {
                case "Second Game":
                    // println("Picture Time")
                    // GameSegue = "Add_Quote"
                    self.performSegue(withIdentifier: "DemoQuote", sender: self)
                case "First Game":
                    //  println("Quote Time")
                    self.performSegue(withIdentifier: "DemoDraw", sender: self)
                    // GameSegue = "Add_Picture"
                case "Third Game":
                    print("game over")
                    self.performSegue(withIdentifier: "DemoComplete", sender: self)
                default:
                    print("Error")
                }
                
                
                
                
                
            }
            
            
            //   theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Another turn?", subTitle: "You just took the last once")
            
            theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Another Turn?", subTitle: "You just took the last one", duration: nil, completeText: "Cancel", style: .custom, colorStyle: 2, colorTextButton: 1)
            
            
            
            /*
            
            let alertController = UIAlertController(title: "You took the last turn", message: "Are you sure you want to take this turn?", preferredStyle: .Alert)
            
            let CancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action:UIAlertAction) in
            print("Cancel button pressed")
            
            }
            
            
            
            let yesAction = UIAlertAction(title: "Take Turn", style: .Default) { (action:UIAlertAction) in
            
            
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
            
            
            
            switch CurrentTurn
            {
            case "2","4","6","8","10":
            // println("Picture Time")
            // GameSegue = "Add_Quote"
            self.performSegueWithIdentifier("Select_Game", sender: self)
            case "1","3","5","7","9":
            //  println("Quote Time")
            self.performSegueWithIdentifier("Select_Game", sender: self)
            // GameSegue = "Add_Picture"
            case "11":
            print("game over")
            self.performSegueWithIdentifier("Select_Game", sender: self)
            default:
            print("Error")
            }
            //        }
            
            }
            
            
            alertController.addAction(yesAction);
            
            alertController.addAction(CancelAction);
            
            alertController.view.tintColor = UIColor.blackColor();
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            */
            
            
        } else {
            
            
            switch self.LastHowToView {
                
            case 0:
                self.LastHowToView = 1
                
            case 1:
                self.LastHowToView = 2
                
            case 2:
                self.LastHowToView = 3
                
            default:
                break
                
            }
            
            switch self.GameNameInfoBTN
            {
            case "Second Game":
                // println("Picture Time")
                // GameSegue = "Add_Quote"
                self.performSegue(withIdentifier: "DemoQuote", sender: self)
            case "First Game":
                //  println("Quote Time")
                self.performSegue(withIdentifier: "DemoDraw", sender: self)
                // GameSegue = "Add_Picture"
            case "Third Game":
                print("game over")
                self.performSegue(withIdentifier: "DemoComplete", sender: self)
            default:
                print("Error")
            }
            
            
        }
        
        
        
    }
    
    func ShowRatings(_ sender: UIButton!) {
        
        
        
        //  let SaveProgressHUD = PixieHowTo(text: "Hello, I'm Pixie.", image: UIImage(named: "SillyPixie.png")!)
        // self.view.addSubview(SaveProgressHUD)
        
        //  let PView = MyWidgetView(self.view)
        //  self.view.addSubview(PView!)
        // let PView = CustomView()
        // self.view.addSubview(PView)
        
        GameRowSelected = sender.tag
        print("the game rowselected: \(sender.tag)")
        
        
        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Content Ratings", subTitle: "Here you will see the full game content guide", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
        
        
       // self.performSegueWithIdentifier("contentratings", sender: self)
        
    }
    
    func GameMailClicked2(_ sender: UIButton!) {
        
        
        JustViewingPlayers = true
        GameRowSelected = sender.tag
        print("the game rowselected: \(sender.tag)")
        
        var gametype: GameType
        
        if (self.resultSearchController.isActive) {
            gametype = FilteredGames[GameRowSelected]
        } else {
            gametype = GameSearchArray[GameRowSelected]
        }
        
        GameSelected = gametype.GameID as NSString
        theContent = gametype.GameContent as NSString
        theVisibility = gametype.GameGameVisible as NSString
        thePlayer1 = gametype.GamePlayer1 as NSString
        thePlayer2 = gametype.GamePlayer2 as NSString
        thePlayer3 = gametype.GamePlayer3 as NSString
        thePlayer4 = gametype.GamePlayer4 as NSString
        thePlayer5 = gametype.GamePlayer5 as NSString
        thePlayer6 = gametype.GamePlayer6 as NSString
        thePlayer7 = gametype.GamePlayer7 as NSString
        thePlayer8 = gametype.GamePlayer8 as NSString
        thePlayer9 = gametype.GamePlayer9 as NSString
        thePlayer10 = gametype.GamePlayer10 as NSString
        
        
        /*
        GameSelected = GameIDInfo[GameRowSelected]
        */
        
        
        // var CurrentTurn = TurnNumberInfo[GameRowSelected]
        //  println(CurrentTurn)
        //  var GameName = GameNameInfo[GameRowSelected]
        //  var TurnTimeLimit = TimeLimitInfo[GameRowSelected]
        
        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "View/Edit Players", subTitle: "View who is playing in this game OR if you created this game you may edit the players and Resend Game Invites", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
        
        
       // self.performSegueWithIdentifier("goto_gameMail", sender: self)
        // self.TableView.reloadData()
    }
    
    
    func GameMailClicked(_ sender: UIButton!) {
        
        GameRowSelected = sender.tag
        print("the game rowselected: \(sender.tag)")
        
        var gametype: GameType
        
        if (self.resultSearchController.isActive) {
            gametype = FilteredGames[GameRowSelected]
        } else {
            gametype = GameSearchArray[GameRowSelected]
        }
        
        GameSelected = gametype.GameID as NSString
        theContent = gametype.GameContent as NSString
        theVisibility = gametype.GameGameVisible as NSString
        thePlayer1 = gametype.GamePlayer1 as NSString
        thePlayer2 = gametype.GamePlayer2 as NSString
        thePlayer3 = gametype.GamePlayer3 as NSString
        thePlayer4 = gametype.GamePlayer4 as NSString
        thePlayer5 = gametype.GamePlayer5 as NSString
        thePlayer6 = gametype.GamePlayer6 as NSString
        thePlayer7 = gametype.GamePlayer7 as NSString
        thePlayer8 = gametype.GamePlayer8 as NSString
        thePlayer9 = gametype.GamePlayer9 as NSString
        thePlayer10 = gametype.GamePlayer10 as NSString
        
        JustViewingPlayers = false
        /*
        GameSelected = GameIDInfo[GameRowSelected]
        */
        // var CurrentTurn = TurnNumberInfo[GameRowSelected]
        //  println(CurrentTurn)
        //  var GameName = GameNameInfo[GameRowSelected]
        //  var TurnTimeLimit = TimeLimitInfo[GameRowSelected]
        
        
         SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "View/Edit Players", subTitle: "View who is playing in this game OR if you created this game you may edit the players and Resend Game Invites", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
        
        
      //  self.performSegueWithIdentifier("goto_gameMail", sender: self)
        // self.TableView.reloadData()
    }
    
    //func filterContentForSearchText(searchText: String, scope: String = "All") {
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        print("Search Scope = \(scope)")
        // self.TableViewTOP.constant = 50
        self.FilteredGames = self.GameSearchArray.filter({( gametype: GameType) -> Bool in
            
            
            //       print("game names = \(gametype.GameName)")
            //    print("game Category = \(gametype.GameCategory)")
            // return gametype.GameName.lowercaseString.containsString(searchText.lowercaseString)
            //     let categoryMatch = gametype.GameCategory == scope
            
            
            let categoryMatch = (scope == "All") || (gametype.GameCategory == scope)
            if categoryMatch
            {
                //       print("category: \(gametype.GameCategory) matched \(scope)")
            }
            
            // let stringMatch = gametype.GameName.rangeOfString(searchText)
            
            let stringMatch = gametype.GameSearchString.lowercased().range(of: searchText.lowercased())
            return categoryMatch && (stringMatch != nil)
            
        })
        
        
        //   print("Filtered Games = \(FilteredGames)")
        
        self.TableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        
        // print("Search Scope1 = \(scope)")
        
        //  FilteredGames.removeAll(keepCapacity: false)
        //  let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        //  let resultArray = (self.GameNameInfo as NSArray).filteredArrayUsingPredicate(searchPredicate)
        
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
        //filterContentForSearchText(searchController.searchBar.text!)
        
        self.TableView.reloadData()
    }
    
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancel Button Clicked")
    }
    
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        //   print("Scope index changed: \(selectedScope)")
        
        //   print("Scope index changed: \(searchBar.selectedScopeButtonIndex)")
        
        switch selectedScope {
            //  switch searchBar.selectedScopeButtonIndex {
        case 0:
            self.selectedScope = "All"
            //self.endEditing = yes
            self.view.endEditing(true)
            break
        case 1:
            self.selectedScope = "Complete"
            self.view.endEditing(true)
            break
        case 2:
            self.selectedScope = "In Process"
            self.view.endEditing(true)
            break
            
            
        default:
            self.selectedScope = "All"
            self.view.endEditing(true)
            break
            
        }
        
        
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
        
        print("Filtered Games, from selected scope index change = \(FilteredGames)")
        
        self.TableView.reloadData()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if resultSearchController.isActive && resultSearchController.searchBar.text != "" {
            
            //    if (self.resultSearchController.active) {
            if self.FilteredGames.count == 0 {
                switch SegmentValueString {
                case "My Turns":
                    self.NoGamesLBL.text = "No turns to take here.  Check out the public games...Tap 'Public Games' at the bottom."
                case "Completed":
                    self.NoGamesLBL.text = "No Games Available"
                case "All":
                    self.NoGamesLBL.text = "No Games Available"
                default:
                    self.NoGamesLBL.text = "No Games Available"
                }
                
                
            }
            return self.FilteredGames.count
        } else {
            
            if self.FilteredGames.count == 0 {
                switch SegmentValueString {
                case "My Turns":
                    self.NoGamesLBL.text = "No turns to take here, check out the public games...Tap 'Public Games' at the bottom."
                case "Completed":
                    self.NoGamesLBL.text = "No Games Available"
                case "All":
                    self.NoGamesLBL.text = "No Games Available"
                default:
                    self.NoGamesLBL.text = "No Games Available"
                }
                
                
            }
            
            
            return self.GameSearchArray.count;
            //            return self.GameNameInfo.count;
            //return self.GameSearchInfo.count;
            
        }
        
        // return self.GameNameInfo.count;
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        
        print("search bar should end editing")
        searchBar.showsScopeBar = true
        searchBar.sizeToFit()
        self.TableView.tableHeaderView = searchBar
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        print("search bar did begin editing")
        searchBar.showsScopeBar = true
        searchBar.sizeToFit()
        self.TableView.tableHeaderView = searchBar
        //  return true
        
    }
    
    //func s
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        print("search bar did end editing")
        searchBar.showsScopeBar = true
        searchBar.sizeToFit()
        self.TableView.tableHeaderView = searchBar
        //  return true
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        /*
        if pickerItem {
        
        let theAlert = SCLAlertView()
        
        theAlert.addButton("Yes", action: {
        
        
        let row = indexPath.row
        
        var selectedCell:BasicCell = tableView.cellForRowAtIndexPath(indexPath)! as! BasicCell
        
        // selectedCell.blurView1.alpha = 1
        selectedCell.Turn1ImageBack.hidden = false
        selectedCell.blurView1.hidden = true
        
        /*
        UIView.animateWithDuration(1.0, animations: { () -> Void in
        
        selectedCell.blurView1.alpha = 0.0
        //self.GCErrorViewTOP.constant = -50
        })
        
        */
        
        })
        theAlert.addButton("No thanks", action: {
        
        })
        
        theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Preview Game?", subTitle: "Would you like to preview this games image before taking the turn?", duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
        
        }
        
        */
        /*
        
        let row = indexPath.row
        var isTurnAvailable = CanTakeTurnInfo[row]
        
        println("Is Turn Available = \(isTurnAvailable)")
        
        
        
        let selectedResult = indexPath.item
        var CurrentTurn = TurnNumberInfo[row]
        println(CurrentTurn)
        var GameName = GameNameInfo[row]
        var TurnTimeLimit = TimeLimitInfo[row]
        
        println(GameName)
        
        var selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        selectedCell.contentView.backgroundColor = UIColor.clearColor()
        
        
        
        
        
        if CanTakeTurnInfo[row] == "no" {
        
        } else {
        
        }
        
        if isTurnAvailable == "no" {
        
        println("showing turn not available alert")
        
        let AC = JSController("It's not your turn", "The turn time limit has not ended or It's not your turn yet.","Red")
        self.presentViewController(AC, animated: true, completion: nil)
        
        //return
        
        } else {
        println("about to segue")
        
        switch CurrentTurn
        {
        case "2","4","6","8","10":
        // println("Picture Time")
        // GameSegue = "Add_Quote"
        self.performSegueWithIdentifier("Select_Game", sender: self)
        case "1","3","5","7","9":
        //  println("Quote Time")
        self.performSegueWithIdentifier("Select_Game", sender: self)
        // GameSegue = "Add_Picture"
        case "11":
        println("game over")
        self.performSegueWithIdentifier("Select_Game", sender: self)
        default:
        println("Error")
        }
        }
        
        
        
        
        */
        
    }
    
    
    @IBAction func reset(_ segue: UIStoryboardSegue) {
        
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
        cell.Turn1ImageBack.isHidden = true
        cell.Turn1Image?.isHidden = true
        
        /*
        var pulseAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale");
        pulseAnimation.duration = 30.0;
        pulseAnimation.toValue = NSNumber(float: 1.0);
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
        pulseAnimation.autoreverses = true;
        pulseAnimation.repeatCount = FLT_MAX;
        cell.TakeTurnBTN?.layer.addAnimation(pulseAnimation, forKey: nil)
        */
        
        cell.backgroundColor = UIColor.clear
        cell.contentBTN?.addTarget(self, action: #selector(MyGamesDemoViewController.ShowRatings(_:)), for: .touchUpInside)
        //cell.contentView2?.layer.cornerRadius = 5
        
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        
        _ = Date()
        
        
        var gametype : GameType
        
        
        cell.cellBottomView?.layer.masksToBounds = true
        
        cell.cellBottomView?.roundCorners([.bottomLeft, .bottomRight], radius: 5)
        cell.cellBottomView.clipsToBounds = true
        
        cell.cellViewBG?.layer.cornerRadius = 5
        cell.cellViewBG?.layer.borderWidth = 1
        cell.cellViewBG?.layer.borderColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0).cgColor
        
        //cell.cellViewBG?.layer.borderColor = UIColor.darkGrayColor().CGColor
        cell.cellViewBG?.layer.masksToBounds = true
        cell.cellViewBG?.clipsToBounds = true
        cell.lblView?.layer.cornerRadius = 5
        cell.allPlayerBTN?.addTarget(self, action: #selector(MyGamesDemoViewController.GameMailClicked2(_:)), for: .touchUpInside)
        cell.allPlayerBTN?.tag = (indexPath as NSIndexPath).row
        cell.allPlayerBTN?.layer.cornerRadius = 25
        cell.allPlayerBTN?.clipsToBounds = true
        cell.allPlayerBTN?.layer.masksToBounds = true
        cell.allPlayerBTN?.layer.borderColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0).cgColor
        cell.allPlayerBTN?.layer.borderWidth = 1
        
        cell.commentsBTN?.addTarget(self, action: #selector(MyGamesDemoViewController.ShowCommentsClicked(_:)), for: .touchUpInside)
        cell.commentsBTN?.tag = (indexPath as NSIndexPath).row
        cell.TakeTurnBTN?.layer.cornerRadius = 60
        
        //cell.TakeTurnBTN?.frame.height / 2
        
        if (self.resultSearchController.isActive && resultSearchController.searchBar.text != "") {
            gametype = FilteredGames[(indexPath as NSIndexPath).row]
        } else {
            gametype = GameSearchArray[(indexPath as NSIndexPath).row]
        }
        
        
        
        cell.commentView?.layer.cornerRadius = 25
        //  cell.commentView?.layer.borderColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0).CGColor
        //  cell.commentView?.layer.borderWidth = 1
        //  cell.commentView?.layer.masksToBounds = true
        
        //  cell.commentView?.layer.shadowColor = UIColor.blackColor().CGColor
        //  cell.commentView?.layer.shadowOpacity = 1
        //  cell.commentView?.layer.shadowOffset = CGSizeZero
        //  cell.commentView?.layer.shadowRadius = 10
        
        cell.turnView.layer.borderWidth = 1
        cell.turnView?.layer.borderColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0).cgColor
        
        
        //  ell.setupIsBlurred(true)=
        
        print("Turn1 URL String = \(gametype.Turn1URLString)")
        
        let request: URLRequest = URLRequest(url: URL(string: gametype.Turn1URLString)!)
        let mainQueue = OperationQueue.main
        NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
            if error == nil {
                // Convert the downloaded data in to a UIImage object
                var image = UIImage(data: data!)
                // Store the imge in to our cache
                //  self.imageCache[urlString] = image
                // Update the cell
                DispatchQueue.main.async(execute: {
                    //if let cellToUpdate = TableView.cellForItemAtIndexPath(indexPath) {
                    //if let cellToUpdate = TableView.cel
                    if self.TableView.cellForRow(at: indexPath) != nil {
                        
                        if gametype.Turn1MediaType == "gif" {
                            cell.blurCoverIMG?.isHidden = false
                            let randomBox = Int(arc4random_uniform(UInt32(self.BlurryImages.count)))
                            let tempBlurImage = self.BlurryImages[randomBox]
                            
                            cell.blurCoverIMG?.image = tempBlurImage
                            
                            cell.Turn1Image?.image = UIImage.animatedImage(withAnimatedGIFData: data!)
                            cell.Turn1ImageBack?.image = UIImage.animatedImage(withAnimatedGIFData: data!)
                            cell.Turn1ImageBack?.isHidden = true
                            cell.Turn1Image?.isHidden = false
                            
                        } else if gametype.Turn1MediaType == "image" {
                            
                            /*
                            cell.blurCoverIMG?.hidden = true
                            
                            
                            
                            if image == nil {
                            
                            let randomBox = Int(arc4random_uniform(UInt32(self.FunQuoteBox.count)))
                            image = self.FunQuoteBox[randomBox]
                            
                            cell.blurCoverIMG?.hidden = false
                            let randomBoxTemp = Int(arc4random_uniform(UInt32(self.BlurryImages.count)))
                            var tempBlurImage = self.BlurryImages[randomBoxTemp]
                            
                            cell.blurCoverIMG?.image = tempBlurImage
                            
                            
                            
                            //image = UIImage(named: "QuoteBoxImage.png")!
                            }
                            
                            let imageBlur = self.applyBlurEffect(image!)
                            
                            cell.Turn1Image?.image = imageBlur
                            
                            
                            */
                            
                            cell.blurCoverIMG?.isHidden = false
                            
                            let randomBox = Int(arc4random_uniform(UInt32(self.FunQuoteBox.count)))
                            image = self.FunQuoteBox[randomBox]
                            
                            cell.blurCoverIMG?.isHidden = false
                            let randomBoxTemp = Int(arc4random_uniform(UInt32(self.BlurryImages.count)))
                            let tempBlurImage = self.BlurryImages[randomBoxTemp]
                            
                            cell.blurCoverIMG?.image = tempBlurImage
                            cell.Turn1Image?.image = image
                            
                            //  cell.Turn1Image?.alpha = 0.7
                            cell.Turn1Image?.isHidden = false
                            cell.Turn1ImageBack?.image = image
                            cell.Turn1ImageBack?.isHidden = true
                            
                            
                            
                            
                            // var darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
                            // 2
                            // var blurView = UIVisualEffectView(effect: darkBlur)
                            // blurView.frame = (cell.Turn1Image?.bounds)!
                            // 3
                            // cell.Turn1Image?.addSubview(blurView)
                            
                        } else {
                            
                            
                            
                            cell.blurCoverIMG?.isHidden = false
                            let randomBoxTemp = Int(arc4random_uniform(UInt32(self.BlurryImages.count)))
                            let tempBlurImage = self.BlurryImages[randomBoxTemp]
                            
                            cell.blurCoverIMG?.image = tempBlurImage
                            
                            
                            let randomBox = Int(arc4random_uniform(UInt32(self.FunQuoteBox.count)))
                            _ = self.FunQuoteBox[randomBox]
                            
                            /*
                            let imageBlur = self.applyBlurEffect(quoteBox)
                            cell.Turn1Image?.image = imageBlur
                            */
                            
                            cell.Turn1Image?.image = image
                            cell.Turn1Image?.isHidden = false
                            //  cell.Turn1Image?.alpha = 0.7
                            cell.Turn1ImageBack?.image = UIImage(named: "QuoteBoxImage.png")!
                            cell.Turn1ImageBack?.isHidden = true
                            //   var darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Light)
                            // 2
                            //   var blurView = UIVisualEffectView(effect: darkBlur)
                            // blurView.frame = (cell.Turn1Image?.bounds)!
                            // 3
                            //  cell.Turn1Image?.addSubview(blurView)
                            
                        }
                        //let GIFData = NSData
                        
                        // cell.TurnImage?.image = UIImage.animatedImageWithAnimatedGIFData(data!)
                        //cellToUpdate.TurnImage?.image = image
                    }
                })
            }
            else {
                
                cell.blurCoverIMG?.isHidden = false
                let randomBoxTemp = Int(arc4random_uniform(UInt32(self.BlurryImages.count)))
                let tempBlurImage = self.BlurryImages[randomBoxTemp]
                
                cell.blurCoverIMG?.image = tempBlurImage
                
                
                let randomBox = Int(arc4random_uniform(UInt32(self.FunQuoteBox.count)))
                let quoteBox = self.FunQuoteBox[randomBox]
                
                /*
                let imageBlur = self.applyBlurEffect(quoteBox)
                cell.Turn1Image?.image = imageBlur
                */
                
                cell.Turn1Image?.image = quoteBox
                
                cell.Turn1Image?.isHidden = false
                //cell.Turn1Image?.image = UIImage(named: "QuoteBoxImage.png")!
                cell.Turn1ImageBack?.image = UIImage(named: "QuoteBoxImage.png")!
                cell.Turn1ImageBack?.isHidden = true
                //var darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
                // 2
                // var blurView = UIVisualEffectView(effect: darkBlur)
                // blurView.frame = (cell.Turn1Image?.bounds)!
                // 3
                //  cell.Turn1Image?.addSubview(blurView)
                
                print("Error: \(error!.localizedDescription)")
            }
        })
        
        
        
        
        // cell.contentBTN?.layer.cornerRadius = 20
        cell.contentView2?.layer.borderWidth = 1
        cell.contentView2?.layer.borderColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0).cgColor
        cell.contentView2?.layer.cornerRadius = 25
        cell.contentView2?.clipsToBounds = true
        cell.contentView2?.layer.masksToBounds = true
        
        cell.turnView?.layer.cornerRadius = 25
        
        //TURNVIEW CLIPS
        //cell.turnView?.clipsToBounds = true
        // cell.turnView?.layer.masksToBounds = true
        
        
        
        switch gametype.GameContent {
        case "E":
            //  cell.contentBTN?.imageView?.image = UIImage(named: "ContentE.png")
            cell.contentBTN?.setImage(contentImage1, for: UIControlState())
            //cell.contentBTN?.layer.cornerRadius = 100
        case "M":
            // cell.contentBTN?.imageView?.image = UIImage(named: "contentM.png")
            cell.contentBTN?.setImage(contentImage3, for: UIControlState())
        case "T":
            //  cell.contentBTN?.imageView?.image = UIImage(named: "ContentT.png")
            cell.contentBTN?.setImage(contentImage2, for: UIControlState())
        default:
            print("no rating available")
            // cell.contentBTN?.imageView?.image = UIImage(named: "ContentE.png")
        }
        
        
        
        //var tempDate = gametype.GameLastTurnTime as String
        let tempDate = Date().description
        var tempDateArray = tempDate.components(separatedBy: " ")
        var dateArray = tempDateArray[0].components(separatedBy: "-")
        print("DateArray = \(dateArray)")
        let dateTemp = "\(dateArray[1])/\(dateArray[2])/\(dateArray[0])"
        
      // var dateTemp1 = NSDate().description
        
        print("DateTemp = \(dateTemp)")
        
        //  var LastTurnTimeNew = dateFormatter.dateFromString(gametype.GameLastTurnTime as String)
        
        
        let LastTurnTimeNew = dateTemp
        
        //   var compareResult = date.timeIntervalSinceDate(LastTurnTimeNew!)
        
        // print("Compare time = \(compareResult)")
        
        cell.commentsLBL?.text = gametype.GameCommentInfo as String
        
        if gametype.GamePlayer1 == username.description {
            
            if (gametype.GameIsComplete == "no") {
                
                /*
                var darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
                // 2
                var blurView = UIVisualEffectView(effect: darkBlur)
                blurView.frame = (cell.Turn1Image?.bounds)!
                // 3
                cell.Turn1Image?.addSubview(blurView)
                */
                
                
                cell.TableImageCTs?.isHidden = true
                
                //  cell.greenCheck?.hidden = true
                
                
                cell.TableImageCTs?.isHidden = false
                cell.heartView?.isHidden = true
                
                // println("Edit Shown")
                
                // cell.TableImageCTs?.imageView?.image = UIImage(named: "EditButton_white.png")
                cell.TableImageCTs?.setTitle("Edit", for: UIControlState())
                cell.TableImageCTs?.addTarget(self, action: #selector(MyGamesDemoViewController.GameMailClicked(_:)), for: .touchUpInside)
                
                cell.TableImageCTs?.tag = (indexPath as NSIndexPath).row
            } else {
                cell.TableImageCTs?.isHidden = true
                cell.greenCheck?.isHidden = false
                
            }
            
        } else {
            cell.TableImageCTs?.isHidden = true
            cell.heartView?.isHidden = false
            cell.heartLBL?.text = gametype.GameGameLikeArray as String
            
        }
        
        
        
        
        cell.titleLabel?.text = gametype.GameName as String
        cell.createdByLBL_who?.text = gametype.GamePlayer1 as String
        
        
        if gametype.GameTimeLimit == "00:00:00" {
            cell.visibilityLBL?.text = "None"
        } else {
            cell.visibilityLBL?.text = gametype.GameTimeLimit as String
            
        }
        //  cell.TurnLabel!.text = self.UsersTurnInfo[indexPath.row] as String
        
        if (gametype.GameIsComplete == "yes") {
            cell.timeLimitLBL?.text = "Completed:"
            cell.visibilityLBL?.text = LastTurnTimeNew//?.description
            
            cell.pokeBTN?.isHidden = true
            cell.pokeLBL?.isHidden = true
            cell.heartView?.isHidden = false
            
            // cell.heartLBL?.text = TotalLikesInfo[indexPath.row] as String
            cell.heartLBL?.text = gametype.GameGameLikeArray as String
            //  cell.TableImageCTs?.hidden = true
            cell.currentTurnLBL_who?.text = "Complete"
            cell.lastTurnLBL?.text = gametype.LastTurnUser
            cell.currentTurnLBL_who?.textColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
            
            cell.TakeTurnBTN?.tag = (indexPath as NSIndexPath).row
            
            // cell.TakeTurnBTN?.layer.cornerRadius = 10
            cell.TakeTurnBTN?.layer.borderWidth = 2
            cell.TakeTurnBTN?.layer.borderColor = UIColor.darkGray.cgColor
            
            cell.TakeTurnBTN?.layer.backgroundColor = UIColor(red: 0.572, green: 0.882, blue: 0.949, alpha: 1.0).cgColor
            
            cell.TakeTurnBTN?.setTitle("View Game", for: UIControlState())
            cell.TakeTurnBTN?.setTitleColor(UIColor.darkGray, for: UIControlState())
            
            cell.TakeTurnBTN?.addTarget(self, action: #selector(MyGamesDemoViewController.TakeTurnClicked(_:)), for: .touchUpInside)
            
            
            //  var image: UIImage = UIImage(named: "Circle_Check_Green.png")!
            
            
            cell.TurnLabel?.text = ("")
            
            cell.TurnLabel?.text = "Game Complete"
            
            cell.TurnLabel?.textColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
            
            cell.turnNumberIMG?.image = UIImage(named: "GreenCheck.png")!
            cell.turnNumberLBL?.text = ""
            //cell.turnNumberIMG?.image = UIImage(named: "Circle_Check_Green.png")!
        } else if (gametype.GameIsComplete == "no") {
            cell.timeLimitLBL?.text = "Turn Time Limit:"
            cell.heartView?.isHidden = true
            
            if (gametype.GameCanTakeTurn == "yes") {
                
                if gametype.GameUsersTurn == username.description {
                    cell.TakeTurnBTN?.setTitle("Take Your Turn!", for: UIControlState())
                    
                    //cell.TakeTurnBTN?.layer.cornerRadius = 10
                    cell.TakeTurnBTN?.layer.borderWidth = 2
                    cell.TakeTurnBTN?.layer.borderColor = UIColor.white.cgColor
                    cell.TakeTurnBTN?.layer.backgroundColor =  UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).cgColor
                    cell.TakeTurnBTN?.setTitleColor(UIColor.white, for: UIControlState())
                    cell.currentTurnLBL_who?.textColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
                    cell.pokeBTN?.isHidden = false
                    cell.pokeLBL?.isHidden = false
                    
                } else if gametype.GameUsersTurn == "OPEN" {
                    
                    cell.pokeBTN?.isHidden = true
                    cell.pokeLBL?.isHidden = true
                    
                    cell.TakeTurnBTN?.setTitle("Take Turn!", for: UIControlState())
                    
                    /*
                    var pulseAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale");
                    pulseAnimation.duration = 30.0;
                    pulseAnimation.toValue = NSNumber(float: 1.0);
                    pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
                    pulseAnimation.autoreverses = true;
                    pulseAnimation.repeatCount = FLT_MAX;
                    cell.TakeTurnBTN?.layer.addAnimation(pulseAnimation, forKey: nil)
                    */
                    
                    //  cell.TakeTurnBTN?.layer.cornerRadius = 10
                    cell.TakeTurnBTN?.layer.borderWidth = 2
                    cell.TakeTurnBTN?.layer.borderColor = UIColor.white.cgColor
                    cell.TakeTurnBTN?.layer.backgroundColor =  UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).cgColor
                    cell.TakeTurnBTN?.setTitleColor(UIColor.white, for: UIControlState())
                    cell.currentTurnLBL_who?.textColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
                    //  cell.lastTurnLBL?.text = gametype.LastTurnUser
                    
                } else {
                    cell.TakeTurnBTN?.setTitle("Steal Turn?", for: UIControlState())
                    
                    //cell.TakeTurnBTN?.layer.cornerRadius = 10
                    cell.TakeTurnBTN?.layer.borderWidth = 2
                    cell.TakeTurnBTN?.layer.borderColor = UIColor.white.cgColor
                    // cell.TakeTurnBTN?.layer.backgroundColor =  UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).CGColor
                    cell.TakeTurnBTN?.layer.backgroundColor =  UIColor.orange.cgColor
                    
                    cell.TakeTurnBTN?.setTitleColor(UIColor.white, for: UIControlState())
                    
                    cell.currentTurnLBL_who?.textColor = UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0)
                    // cell.lastTurnLBL?.text = gametype.LastTurnUser
                    //      UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
                    
                    cell.pokeBTN?.isHidden = false
                    cell.pokeLBL?.isHidden = false
                }
                
                
                // cell.currentTurnLBL_who?.text = "Any Player"
                cell.currentTurnLBL_who?.text = gametype.GameUsersTurn as String
                //cell.lastTurnLBL?.text = gametype.LastTurnUser
                
                cell.pokeBTN?.addTarget(self, action: #selector(MyGamesDemoViewController.pokeAnyClicked(_:)), for: .touchUpInside)
                cell.pokeBTN?.tag = (indexPath as NSIndexPath).row
                
                
                //cell.TableImageCTs?.hidden = false
                //  cell.greenCheck?.hidden = true
                
                cell.TakeTurnBTN?.tag = (indexPath as NSIndexPath).row
                
                
                
                cell.TakeTurnBTN?.addTarget(self, action: #selector(MyGamesDemoViewController.TakeTurnClicked(_:)), for: .touchUpInside)
                
                
                cell.TurnLabel?.text = "Current Turn = \(gametype.GameTurnNumber as String)"
                
                switch (gametype.GameTurnNumber as String) {
                    
                case "1":
                    cell.turnNumberIMG?.image = UIImage(named: "num1.png")!
                case "2":
                    cell.turnNumberIMG?.image = UIImage(named: "num2.png")!
                case "3":
                    cell.turnNumberIMG?.image = UIImage(named: "num3.png")!
                case "4":
                    cell.turnNumberIMG?.image = UIImage(named: "num4.png")!
                case "5":
                    cell.turnNumberIMG?.image = UIImage(named: "num5.png")!
                case "6":
                    cell.turnNumberIMG?.image = UIImage(named: "num6.png")!
                case "7":
                    cell.turnNumberIMG?.image = UIImage(named: "num7.png")!
                case "8":
                    cell.turnNumberIMG?.image = UIImage(named: "num8.png")!
                case "9":
                    cell.turnNumberIMG?.image = UIImage(named: "num9.png")!
                case "10":
                    cell.turnNumberIMG?.image = UIImage(named: "num10.png")!
                default:
                    cell.turnNumberIMG?.image = UIImage(named: "GreenCheck.png")!
                    
                    
                }
                
                cell.turnNumberLBL?.text = "Turn"
                
                cell.TurnLabel?.textColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
                
            } else {
                
                
                if gametype.GameUsersTurn == username.description {
                    
                    
                    cell.currentTurnLBL_who?.textColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
                    // cell.lastTurnLBL?.text = gametype.LastTurnUser
                    //cell.TableImageCTs?.hidden = false
                    //  cell.greenCheck?.hidden = true
                    
                    cell.TakeTurnBTN?.tag = (indexPath as NSIndexPath).row
                    
                    // cell.TakeTurnBTN?.layer.cornerRadius = 10
                    cell.TakeTurnBTN?.layer.borderWidth = 2
                    cell.TakeTurnBTN?.layer.borderColor = UIColor.white.cgColor
                    cell.TakeTurnBTN?.layer.backgroundColor =  UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).cgColor
                    
                    cell.TakeTurnBTN?.setTitle("Take Turn!", for: UIControlState())
                    
                    /*
                    var pulseAnimation:CABasicAnimation = CABasicAnimation(keyPath: "opacity");
                    pulseAnimation.duration = 30.0;
                    pulseAnimation.toValue = NSNumber(float: 1.0);
                    pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
                    pulseAnimation.autoreverses = true;
                    pulseAnimation.repeatCount = FLT_MAX;
                    cell.TakeTurnBTN?.layer.addAnimation(pulseAnimation, forKey: nil)
                    */
                    
                    cell.TakeTurnBTN?.setTitleColor(UIColor.white, for: UIControlState())
                    
                    cell.TakeTurnBTN?.addTarget(self, action: #selector(MyGamesDemoViewController.TakeTurnClicked(_:)), for: .touchUpInside)
                    
                    
                    //cell.TurnLabel?.text = "Current Turn = \(TurnNumberInfo[indexPath.row] as String)"
                    cell.TurnLabel?.text = "Current Turn = \(gametype.GameTurnNumber as String)"
                    
                    switch (gametype.GameTurnNumber as String) {
                        
                    case "1":
                        cell.turnNumberIMG?.image = UIImage(named: "num1.png")!
                    case "2":
                        cell.turnNumberIMG?.image = UIImage(named: "num2.png")!
                    case "3":
                        cell.turnNumberIMG?.image = UIImage(named: "num3.png")!
                    case "4":
                        cell.turnNumberIMG?.image = UIImage(named: "num4.png")!
                    case "5":
                        cell.turnNumberIMG?.image = UIImage(named: "num5.png")!
                    case "6":
                        cell.turnNumberIMG?.image = UIImage(named: "num6.png")!
                    case "7":
                        cell.turnNumberIMG?.image = UIImage(named: "num7.png")!
                    case "8":
                        cell.turnNumberIMG?.image = UIImage(named: "num8.png")!
                    case "9":
                        cell.turnNumberIMG?.image = UIImage(named: "num9.png")!
                    case "10":
                        cell.turnNumberIMG?.image = UIImage(named: "num10.png")!
                    default:
                        cell.turnNumberIMG?.image = UIImage(named: "GreenCheck.png")!
                        
                    }
                    
                    cell.turnNumberLBL?.text = "Turn"
                    
                    cell.TurnLabel?.textColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
                    cell.currentTurnLBL_who?.text = "Your Turn!"
                    cell.pokeBTN?.isHidden = true
                    cell.pokeLBL?.isHidden = true
                    
                    
                    
                    
                } else {
                    
                    
                    cell.currentTurnLBL_who?.text = gametype.GameUsersTurn as String
                    
                    cell.currentTurnLBL_who?.textColor = UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0)
                    
                    cell.TakeTurnBTN?.tag = (indexPath as NSIndexPath).row
                    
                    // cell.TakeTurnBTN?.layer.cornerRadius = 10
                    cell.TakeTurnBTN?.layer.borderWidth = 2
                    cell.TakeTurnBTN?.layer.borderColor = UIColor.white.cgColor
                    cell.TakeTurnBTN?.layer.backgroundColor = UIColor(red: 0.929, green: 0.113, blue: 0.145, alpha: 1.0).cgColor
                    
                    cell.TakeTurnBTN?.setTitle("Please Wait", for: UIControlState())
                    
                    cell.TakeTurnBTN?.setTitleColor(UIColor.white, for: UIControlState())
                    
                    cell.TakeTurnBTN?.addTarget(self, action: #selector(MyGamesDemoViewController.TakeTurnClicked(_:)), for: .touchUpInside)
                    
                    // cell.TurnLabel?.text = ("Waiting on \(gametype.turnUser as String)")
                    
                    cell.TurnLabel?.text = "Current Turn = \(gametype.GameTurnNumber as String)"
                    
                    switch (gametype.GameTurnNumber as String) {
                        
                    case "1":
                        cell.turnNumberIMG?.image = UIImage(named: "num1.png")!
                    case "2":
                        cell.turnNumberIMG?.image = UIImage(named: "num2.png")!
                    case "3":
                        cell.turnNumberIMG?.image = UIImage(named: "num3.png")!
                    case "4":
                        cell.turnNumberIMG?.image = UIImage(named: "num4.png")!
                    case "5":
                        cell.turnNumberIMG?.image = UIImage(named: "num5.png")!
                    case "6":
                        cell.turnNumberIMG?.image = UIImage(named: "num6.png")!
                    case "7":
                        cell.turnNumberIMG?.image = UIImage(named: "num7.png")!
                    case "8":
                        cell.turnNumberIMG?.image = UIImage(named: "num8.png")!
                    case "9":
                        cell.turnNumberIMG?.image = UIImage(named: "num9.png")!
                    case "10":
                        cell.turnNumberIMG?.image = UIImage(named: "num10.png")!
                    default:
                        cell.turnNumberIMG?.image = UIImage(named: "GreenCheck.png")!
                        
                    }
                    
                    cell.turnNumberLBL?.text = "Turn"
                    cell.TurnLabel?.textColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
                    cell.pokeBTN?.isHidden = false
                    cell.pokeLBL?.isHidden = false
                    cell.pokeBTN?.addTarget(self, action: #selector(MyGamesDemoViewController.pokeClicked(_:)), for: .touchUpInside)
                    cell.pokeBTN?.tag = (indexPath as NSIndexPath).row
                    
                    
                }
                
                
            }
            
        } else {
            
            
            
            
        }// }
        
        
        if gametype.LastTurnUser == username.description {
            cell.lastTurnLBL?.text = "It Was You!"
            cell.lastTurnLBL?.textColor = UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0)
        } else {
            cell.lastTurnLBL?.text = gametype.LastTurnUser
            cell.lastTurnLBL?.textColor = UIColor.black
            
        }
        /*
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
        
        cell.Turn1Image?.image = UIImage(named: "QuoteBoxImage.png")!
        var darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        // 2
        var blurView = UIVisualEffectView(effect: darkBlur)
        //blurView.modalPresentationStyle = .OverFullScreen
        self.modalPresentationStyle = .OverCurrentContext
        //cell.Turn1Image?.modal
        visualEffectView.frame = (cell.Turn1Image?.bounds)!
        //visualEffectView.mo
        blurView.frame = (cell.Turn1Image?.bounds)!
        //blurView.alpha = 0.5
        // 3
        // cell.Turn1Image?.addSubview(blurView)
        cell.Turn1Image?.contentMode = UIViewContentMode.ScaleAspectFit
        //cell.Turn1View?.addSubview(blurView)
        cell.Turn1Image?.addSubview(visualEffectView)
        */
        
        
        /*
        dispatch_async(dispatch_get_main_queue(), {
        //if let cellToUpdate = collectionView.cellForItemAtIndexPath(indexPath) {
        
        if let cellToUpdate = self.TableView.cellForRowAtIndexPath(indexPath) {
        
        
        self.addBlurView((cell.Turn1Image)!)
        //let GIFData = NSData
        
        // cell.TurnImage?.image = UIImage.animatedImageWithAnimatedGIFData(data!)
        //cellToUpdate.TurnImage?.image = image
        }
        })
        */
        // addBlurView((cell.Turn1Image)!)
        
        //cell.setupIsBlurred(true)
        
        
        return cell
        
        
        
    }
    
    
    
    
    func applyBlurEffect(_ image: UIImage) -> UIImage{
        let radius = CGFloat(35)
        /*
        var gpuBlurFilter = GPUImageGaussianBlurFilter()
        
        gpuBlurFilter.blurRadiusInPixels = CGFloat(radius)
        
        var blurredImage = gpuBlurFilter.imageByFilteringImage(image)
        */
        
        
        /*
        let blurFilter = GPUImageiOSBlurFilter()
        
        blurFilter.blurRadiusInPixels = radius
        
        var blurredImage = blurFilter.imageByFilteringImage(image)
        */
        
        let blurredImage = image.applyBlur(
            withRadius: CGFloat(radius),
            tintColor: nil,
            saturationDeltaFactor: 1.0,
            maskImage: nil
        )
        
        
        /*
        var imageToBlur = CIImage(image: image)
        var blurfilter = CIFilter(name: "CIGaussianBlur")
        blurfilter!.setValue(imageToBlur, forKey: "inputImage")
        //blurfilter!.
        //blurfilter!.
        var resultImage = blurfilter!.valueForKey("outputImage") as! CIImage
        var blurredImage = UIImage(CIImage: resultImage)
        */
        
        // self.blurImageView.image = blurredImage
        
        
        
        
        
        
        
        return blurredImage!
        
    }
    
    
    func addBlurView(_ imgView: UIImageView) {
        let blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        self.blurEffectView = UIVisualEffectView(effect: blurEffect)
        self.blurEffectView.frame = imgView.bounds
        //self.blurEffectView.autoresizingMask = UIViewAutoresizing.FlexibleWidth |
        self.blurEffectView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        imgView.addSubview(blurEffectView)
    }
    
    
    @IBAction func editTableView(_ sender: AnyObject) {
        
        
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.dark)
        // 2
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = self.view.bounds
        // 3
        // cell.Turn1Image?.addSubview(blurView)
        
        
        if TableView.isEditing{
            TableView.setEditing(false, animated: false)
            // self.view.addSubview(blurView)
            //editBTN.style = UIBarButtonItemStyle.Plain;
            //editBTN.title = "Delete Game";
            TableView.reloadData()
        } else {
            //   blurView.removeFromSuperview()
            TableView.setEditing(true, animated: true)
            //editBTN.title = "Done";
            //editBTN.style = UIBarButtonItemStyle.Done;
            TableView.reloadData()
        }
        
        
         SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Delete A Game", subTitle: "Delete games you created or hide games created by someone else", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Deleted", subTitle: "Well you can't delete games just yet, but nice job.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
        
        /*
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            
            print("Game Creator: \(Player1Info[indexPath.row])")
            
            
            
            var GameCreator = String()
            
            var gametype: GameType
            
            /*
            var gametype: GameType
            
            if (self.resultSearchController.active) {
            gametype = FilteredGames[GameRowSelected]
            } else {
            gametype = GameSearchArray[GameRowSelected]
            }
            
            GameSelected = gametype.GameID
            
            */
            
            if (self.resultSearchController.active) {
                GameCreator = GameSearchArray[indexPath.row].GamePlayer1
            } else {
                GameCreator = Player1Info[indexPath.row].description
            }
            
            var admin = NSString()
            
            if prefs.valueForKey("ISADMIN") != nil {
                admin = prefs.valueForKey("ISADMIN") as! NSString
            } else {
                admin = "no"
            }
            
            
            if admin.isEqualToString("yes") {
                
                let theAlert = SCLAlertView()
                
                theAlert.addButton("Delete it") {
                    
                    print("Deleting game \(self.GameIDInfo[indexPath.row].description)")
                    
                    DeleteGameData(self.GameIDInfo[indexPath.row].description)
                    
                    self.GameNameInfo.removeAtIndex(indexPath.row)
                    self.GameSearchInfo.removeAtIndex(indexPath.row)
                    self.GameIDInfo.removeAtIndex(indexPath.row)
                    self.Player1Info.removeAtIndex(indexPath.row)
                    self.Player2Info.removeAtIndex(indexPath.row)
                    self.Player3Info.removeAtIndex(indexPath.row)
                    self.Player4Info.removeAtIndex(indexPath.row)
                    self.Player5Info.removeAtIndex(indexPath.row)
                    self.Player6Info.removeAtIndex(indexPath.row)
                    self.Player7Info.removeAtIndex(indexPath.row)
                    self.Player8Info.removeAtIndex(indexPath.row)
                    self.Player9Info.removeAtIndex(indexPath.row)
                    self.Player10Info.removeAtIndex(indexPath.row)
                    self.GameStyleInfo.removeAtIndex(indexPath.row)
                    self.IsCompleteInfo.removeAtIndex(indexPath.row)
                    self.TurnNumberInfo.removeAtIndex(indexPath.row)
                    self.UsersTurnInfo.removeAtIndex(indexPath.row)
                    self.LastTurnTimeInfo.removeAtIndex(indexPath.row)
                    self.TimeLimitInfo.removeAtIndex(indexPath.row)
                    self.CanTakeTurnInfo.removeAtIndex(indexPath.row)
                    self.GameStyleInfo.removeAtIndex(indexPath.row)
                    self.commentInfo.removeAtIndex(indexPath.row)
                    self.GameFailArrayInfo.removeAtIndex(indexPath.row)
                    self.GameLikeArrayInfo.removeAtIndex(indexPath.row)
                    
                    self.Player1IDInfo.removeAtIndex(indexPath.row)
                    self.Player2IDInfo.removeAtIndex(indexPath.row)
                    self.Player3IDInfo.removeAtIndex(indexPath.row)
                    self.Player4IDInfo.removeAtIndex(indexPath.row)
                    self.Player5IDInfo.removeAtIndex(indexPath.row)
                    self.Player6IDInfo.removeAtIndex(indexPath.row)
                    self.Player7IDInfo.removeAtIndex(indexPath.row)
                    self.Player8IDInfo.removeAtIndex(indexPath.row)
                    self.Player9IDInfo.removeAtIndex(indexPath.row)
                    self.Player10IDInfo.removeAtIndex(indexPath.row)
                    self.UsersTurnIDInfo.removeAtIndex(indexPath.row)
                    
                    self.contentInfo.removeAtIndex(indexPath.row)
                    
                    self.GameSearchArray.removeAtIndex(indexPath.row)
                    
                    self.editTableView(self.editBTN)
                    
                    self.TableView.reloadData()
                    
                    
                }
                
                theAlert.addButton("Hide it") {
                    
                    var removeId = self.GameIDInfo[indexPath.row].description
                    print("removing game from view, starting function removegamefromview")
                    self.RemoveGameFromView(removeId)
                    
                    
                    self.GameNameInfo.removeAtIndex(indexPath.row)
                    self.GameSearchInfo.removeAtIndex(indexPath.row)
                    self.GameIDInfo.removeAtIndex(indexPath.row)
                    self.Player1Info.removeAtIndex(indexPath.row)
                    self.Player2Info.removeAtIndex(indexPath.row)
                    self.Player3Info.removeAtIndex(indexPath.row)
                    self.Player4Info.removeAtIndex(indexPath.row)
                    self.Player5Info.removeAtIndex(indexPath.row)
                    self.Player6Info.removeAtIndex(indexPath.row)
                    self.Player7Info.removeAtIndex(indexPath.row)
                    self.Player8Info.removeAtIndex(indexPath.row)
                    self.Player9Info.removeAtIndex(indexPath.row)
                    self.Player10Info.removeAtIndex(indexPath.row)
                    self.GameStyleInfo.removeAtIndex(indexPath.row)
                    self.IsCompleteInfo.removeAtIndex(indexPath.row)
                    self.TurnNumberInfo.removeAtIndex(indexPath.row)
                    self.UsersTurnInfo.removeAtIndex(indexPath.row)
                    self.LastTurnTimeInfo.removeAtIndex(indexPath.row)
                    self.TimeLimitInfo.removeAtIndex(indexPath.row)
                    self.CanTakeTurnInfo.removeAtIndex(indexPath.row)
                    self.GameStyleInfo.removeAtIndex(indexPath.row)
                    self.commentInfo.removeAtIndex(indexPath.row)
                    self.GameFailArrayInfo.removeAtIndex(indexPath.row)
                    self.GameLikeArrayInfo.removeAtIndex(indexPath.row)
                    self.Player1IDInfo.removeAtIndex(indexPath.row)
                    self.Player2IDInfo.removeAtIndex(indexPath.row)
                    self.Player3IDInfo.removeAtIndex(indexPath.row)
                    self.Player4IDInfo.removeAtIndex(indexPath.row)
                    self.Player5IDInfo.removeAtIndex(indexPath.row)
                    self.Player6IDInfo.removeAtIndex(indexPath.row)
                    self.Player7IDInfo.removeAtIndex(indexPath.row)
                    self.Player8IDInfo.removeAtIndex(indexPath.row)
                    self.Player9IDInfo.removeAtIndex(indexPath.row)
                    self.Player10IDInfo.removeAtIndex(indexPath.row)
                    self.UsersTurnIDInfo.removeAtIndex(indexPath.row)
                    self.contentInfo.removeAtIndex(indexPath.row)
                    self.GameSearchArray.removeAtIndex(indexPath.row)
                    
                    self.editTableView(self.editBTN)
                    
                    self.TableView.reloadData()
                    
                    
                }
                
                theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Delete or Hide?", subTitle: "Reminder - if Deleting, this cannot be undone.", duration: nil, completeText: "Cancel", style: .Custom, colorStyle: 1, colorTextButton: 1)
                
                
            } else {
                
                if GameCreator == username  {
                    
                    
                    let theAlert = SCLAlertView()
                    
                    
                    theAlert.addButton("Delete it") {
                        
                        print("Deleting game \(self.GameIDInfo[indexPath.row].description)")
                        
                        DeleteGameData(self.GameIDInfo[indexPath.row].description)
                        
                        self.GameNameInfo.removeAtIndex(indexPath.row)
                        self.GameSearchInfo.removeAtIndex(indexPath.row)
                        self.GameIDInfo.removeAtIndex(indexPath.row)
                        self.Player1Info.removeAtIndex(indexPath.row)
                        self.Player2Info.removeAtIndex(indexPath.row)
                        self.Player3Info.removeAtIndex(indexPath.row)
                        self.Player4Info.removeAtIndex(indexPath.row)
                        self.Player5Info.removeAtIndex(indexPath.row)
                        self.Player6Info.removeAtIndex(indexPath.row)
                        self.Player7Info.removeAtIndex(indexPath.row)
                        self.Player8Info.removeAtIndex(indexPath.row)
                        self.Player9Info.removeAtIndex(indexPath.row)
                        self.Player10Info.removeAtIndex(indexPath.row)
                        self.GameStyleInfo.removeAtIndex(indexPath.row)
                        self.IsCompleteInfo.removeAtIndex(indexPath.row)
                        self.TurnNumberInfo.removeAtIndex(indexPath.row)
                        self.UsersTurnInfo.removeAtIndex(indexPath.row)
                        self.LastTurnTimeInfo.removeAtIndex(indexPath.row)
                        self.TimeLimitInfo.removeAtIndex(indexPath.row)
                        self.CanTakeTurnInfo.removeAtIndex(indexPath.row)
                        self.GameStyleInfo.removeAtIndex(indexPath.row)
                        self.commentInfo.removeAtIndex(indexPath.row)
                        self.GameFailArrayInfo.removeAtIndex(indexPath.row)
                        self.GameLikeArrayInfo.removeAtIndex(indexPath.row)
                        
                        self.Player1IDInfo.removeAtIndex(indexPath.row)
                        self.Player2IDInfo.removeAtIndex(indexPath.row)
                        self.Player3IDInfo.removeAtIndex(indexPath.row)
                        self.Player4IDInfo.removeAtIndex(indexPath.row)
                        self.Player5IDInfo.removeAtIndex(indexPath.row)
                        self.Player6IDInfo.removeAtIndex(indexPath.row)
                        self.Player7IDInfo.removeAtIndex(indexPath.row)
                        self.Player8IDInfo.removeAtIndex(indexPath.row)
                        self.Player9IDInfo.removeAtIndex(indexPath.row)
                        self.Player10IDInfo.removeAtIndex(indexPath.row)
                        self.UsersTurnIDInfo.removeAtIndex(indexPath.row)
                        
                        self.contentInfo.removeAtIndex(indexPath.row)
                        
                        self.GameSearchArray.removeAtIndex(indexPath.row)
                        
                        self.editTableView(self.editBTN)
                        
                        self.TableView.reloadData()
                        
                        
                    }
                    
                    //  theAlert.addButton("Cancel") {
                    //  }
                    //  theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Delete Game?", subTitle: "Are you sure, this can't be undone?")
                    
                    theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Delete Game?", subTitle: "Are you sure, this can't be undone?", duration: nil, completeText: "Cancel", style: .Custom, colorStyle: 1, colorTextButton: 1)
                    
                    
                    
                    /*
                    let alertController = UIAlertController(title: "Delete Game?", message: "Are you sure you want to delete this game?  This will permanently delete this game and can not be undone", preferredStyle: .Alert)
                    let CancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action:UIAlertAction) in
                    print("Cancel button pressed")
                    
                    }
                    
                    
                    
                    
                    let OkAction = UIAlertAction(title: "Ok", style: .Default) { (action:UIAlertAction) in
                    print("OK button pressed")
                    
                    print("Deleting game \(self.GameIDInfo[indexPath.row].description)")
                    
                    DeleteGameData(self.GameIDInfo[indexPath.row].description)
                    
                    self.GameNameInfo.removeAtIndex(indexPath.row)
                    self.GameSearchInfo.removeAtIndex(indexPath.row)
                    self.GameIDInfo.removeAtIndex(indexPath.row)
                    self.Player1Info.removeAtIndex(indexPath.row)
                    self.Player2Info.removeAtIndex(indexPath.row)
                    self.Player3Info.removeAtIndex(indexPath.row)
                    self.Player4Info.removeAtIndex(indexPath.row)
                    self.Player5Info.removeAtIndex(indexPath.row)
                    self.Player6Info.removeAtIndex(indexPath.row)
                    self.Player7Info.removeAtIndex(indexPath.row)
                    self.Player8Info.removeAtIndex(indexPath.row)
                    self.Player9Info.removeAtIndex(indexPath.row)
                    self.Player10Info.removeAtIndex(indexPath.row)
                    self.GameStyleInfo.removeAtIndex(indexPath.row)
                    self.IsCompleteInfo.removeAtIndex(indexPath.row)
                    self.TurnNumberInfo.removeAtIndex(indexPath.row)
                    self.UsersTurnInfo.removeAtIndex(indexPath.row)
                    self.LastTurnTimeInfo.removeAtIndex(indexPath.row)
                    self.TimeLimitInfo.removeAtIndex(indexPath.row)
                    self.CanTakeTurnInfo.removeAtIndex(indexPath.row)
                    self.GameStyleInfo.removeAtIndex(indexPath.row)
                    self.commentInfo.removeAtIndex(indexPath.row)
                    self.GameFailArrayInfo.removeAtIndex(indexPath.row)
                    self.GameLikeArrayInfo.removeAtIndex(indexPath.row)
                    
                    self.Player1IDInfo.removeAtIndex(indexPath.row)
                    self.Player2IDInfo.removeAtIndex(indexPath.row)
                    self.Player3IDInfo.removeAtIndex(indexPath.row)
                    self.Player4IDInfo.removeAtIndex(indexPath.row)
                    self.Player5IDInfo.removeAtIndex(indexPath.row)
                    self.Player6IDInfo.removeAtIndex(indexPath.row)
                    self.Player7IDInfo.removeAtIndex(indexPath.row)
                    self.Player8IDInfo.removeAtIndex(indexPath.row)
                    self.Player9IDInfo.removeAtIndex(indexPath.row)
                    self.Player10IDInfo.removeAtIndex(indexPath.row)
                    self.UsersTurnIDInfo.removeAtIndex(indexPath.row)
                    
                    self.contentInfo.removeAtIndex(indexPath.row)
                    
                    self.GameSearchArray.removeAtIndex(indexPath.row)
                    
                    self.editTableView(self.editBTN)
                    
                    self.TableView.reloadData()
                    
                    
                    
                    }
                    
                    alertController.addAction(OkAction);
                    alertController.addAction(CancelAction);
                    
                    alertController.view.tintColor = UIColor.blackColor();
                    
                    
                    
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
                    
                } else {
                    
                    /*
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Unable to Delete"
                    alertView.message = "Only the user who created the game can delete the game"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                    */
                    
                    
                    
                    let theAlert = SCLAlertView()
                    
                    
                    theAlert.addButton("Hide it") {
                        
                        var removeId = self.GameIDInfo[indexPath.row].description
                        print("removing game from view, starting function removegamefromview")
                        self.RemoveGameFromView(removeId)
                        
                        
                        
                        self.GameNameInfo.removeAtIndex(indexPath.row)
                        self.GameSearchInfo.removeAtIndex(indexPath.row)
                        self.GameIDInfo.removeAtIndex(indexPath.row)
                        self.Player1Info.removeAtIndex(indexPath.row)
                        self.Player2Info.removeAtIndex(indexPath.row)
                        self.Player3Info.removeAtIndex(indexPath.row)
                        self.Player4Info.removeAtIndex(indexPath.row)
                        self.Player5Info.removeAtIndex(indexPath.row)
                        self.Player6Info.removeAtIndex(indexPath.row)
                        self.Player7Info.removeAtIndex(indexPath.row)
                        self.Player8Info.removeAtIndex(indexPath.row)
                        self.Player9Info.removeAtIndex(indexPath.row)
                        self.Player10Info.removeAtIndex(indexPath.row)
                        self.GameStyleInfo.removeAtIndex(indexPath.row)
                        self.IsCompleteInfo.removeAtIndex(indexPath.row)
                        self.TurnNumberInfo.removeAtIndex(indexPath.row)
                        self.UsersTurnInfo.removeAtIndex(indexPath.row)
                        self.LastTurnTimeInfo.removeAtIndex(indexPath.row)
                        self.TimeLimitInfo.removeAtIndex(indexPath.row)
                        self.CanTakeTurnInfo.removeAtIndex(indexPath.row)
                        self.GameStyleInfo.removeAtIndex(indexPath.row)
                        self.commentInfo.removeAtIndex(indexPath.row)
                        self.GameFailArrayInfo.removeAtIndex(indexPath.row)
                        self.GameLikeArrayInfo.removeAtIndex(indexPath.row)
                        self.Player1IDInfo.removeAtIndex(indexPath.row)
                        self.Player2IDInfo.removeAtIndex(indexPath.row)
                        self.Player3IDInfo.removeAtIndex(indexPath.row)
                        self.Player4IDInfo.removeAtIndex(indexPath.row)
                        self.Player5IDInfo.removeAtIndex(indexPath.row)
                        self.Player6IDInfo.removeAtIndex(indexPath.row)
                        self.Player7IDInfo.removeAtIndex(indexPath.row)
                        self.Player8IDInfo.removeAtIndex(indexPath.row)
                        self.Player9IDInfo.removeAtIndex(indexPath.row)
                        self.Player10IDInfo.removeAtIndex(indexPath.row)
                        self.UsersTurnIDInfo.removeAtIndex(indexPath.row)
                        self.contentInfo.removeAtIndex(indexPath.row)
                        
                        
                        self.GameSearchArray.removeAtIndex(indexPath.row)
                        
                        self.editTableView(self.editBTN)
                        
                        self.TableView.reloadData()
                        
                        
                    }
                    
                    
                    //  theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0), title: "Hide Game?", subTitle: "Only the game creator can permantly delete it.")
                    
                    theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0), title: "Hide Game?", subTitle: "Only the game creator can permantly delete it.", duration: nil, completeText: "Cancel", style: .Custom, colorStyle: 1, colorTextButton: 1)
                    
                    
                    
                    /*
                    
                    let alertController = UIAlertController(title: "Hide Game", message: "Only the user who created the game can permanently delete the game.  However you can remove this game from your 'My Games list.  Others will still show the game on their list.  Would you like to hide this game from your list of games?", preferredStyle: .Alert)
                    let CancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action:UIAlertAction) in
                    print("Cancel button pressed")
                    
                    }
                    
                    let OkAction = UIAlertAction(title: "Ok", style: .Default) { (action:UIAlertAction) in
                    print("OK button pressed")
                    
                    
                    /*
                    let AC = JSController("Unable To Delete", MyMessage: "Only the user who created the game can permanently delete the game.  However you can remove this game from your My Games list.  Others will still show the game on their list.",Color: "Red")
                    self.presentViewController(AC, animated: true, completion: nil)
                    */
                    
                    var removeId = self.GameIDInfo[indexPath.row].description
                    print("removing game from view, starting function removegamefromview")
                    self.RemoveGameFromView(removeId)
                    
                    
                    self.GameNameInfo.removeAtIndex(indexPath.row)
                    self.GameSearchInfo.removeAtIndex(indexPath.row)
                    self.GameIDInfo.removeAtIndex(indexPath.row)
                    self.Player1Info.removeAtIndex(indexPath.row)
                    self.Player2Info.removeAtIndex(indexPath.row)
                    self.Player3Info.removeAtIndex(indexPath.row)
                    self.Player4Info.removeAtIndex(indexPath.row)
                    self.Player5Info.removeAtIndex(indexPath.row)
                    self.Player6Info.removeAtIndex(indexPath.row)
                    self.Player7Info.removeAtIndex(indexPath.row)
                    self.Player8Info.removeAtIndex(indexPath.row)
                    self.Player9Info.removeAtIndex(indexPath.row)
                    self.Player10Info.removeAtIndex(indexPath.row)
                    self.GameStyleInfo.removeAtIndex(indexPath.row)
                    self.IsCompleteInfo.removeAtIndex(indexPath.row)
                    self.TurnNumberInfo.removeAtIndex(indexPath.row)
                    self.UsersTurnInfo.removeAtIndex(indexPath.row)
                    self.LastTurnTimeInfo.removeAtIndex(indexPath.row)
                    self.TimeLimitInfo.removeAtIndex(indexPath.row)
                    self.CanTakeTurnInfo.removeAtIndex(indexPath.row)
                    self.GameStyleInfo.removeAtIndex(indexPath.row)
                    self.commentInfo.removeAtIndex(indexPath.row)
                    self.GameFailArrayInfo.removeAtIndex(indexPath.row)
                    self.GameLikeArrayInfo.removeAtIndex(indexPath.row)
                    self.Player1IDInfo.removeAtIndex(indexPath.row)
                    self.Player2IDInfo.removeAtIndex(indexPath.row)
                    self.Player3IDInfo.removeAtIndex(indexPath.row)
                    self.Player4IDInfo.removeAtIndex(indexPath.row)
                    self.Player5IDInfo.removeAtIndex(indexPath.row)
                    self.Player6IDInfo.removeAtIndex(indexPath.row)
                    self.Player7IDInfo.removeAtIndex(indexPath.row)
                    self.Player8IDInfo.removeAtIndex(indexPath.row)
                    self.Player9IDInfo.removeAtIndex(indexPath.row)
                    self.Player10IDInfo.removeAtIndex(indexPath.row)
                    self.UsersTurnIDInfo.removeAtIndex(indexPath.row)
                    self.contentInfo.removeAtIndex(indexPath.row)
                    self.GameSearchArray.removeAtIndex(indexPath.row)
                    
                    self.editTableView(self.editBTN)
                    
                    self.TableView.reloadData()
                    }
                    alertController.addAction(OkAction);
                    
                    alertController.addAction(CancelAction);
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                    */
                    
                }
                
            }
            
        } else if editingStyle == UITableViewCellEditingStyle.Insert{
            
            GameNameInfo.append("New Item")
            // GameSearchArray.append()
            
        }
        
        */
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return true;
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item : String = GameNameInfo[(sourceIndexPath as NSIndexPath).row] as String;
        
        
        GameNameInfo.remove(at: (sourceIndexPath as NSIndexPath).row);
        
        
        GameNameInfo.insert(item as NSString, at: (destinationIndexPath as NSIndexPath).row)
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DemoDraw" {
            
            if let destination = segue.destination as? ImageViewController {
                
                destination.GameTurn = TurnNumberInfoBTN
                destination.GameID = GameIDInfoBTN
                //                    destination.Reply
                
            }
        }
        
        
        if segue.identifier == "DemoQuote" {
            
            if let destination = segue.destination as? QuoteViewController {
                
                destination.GameTurn = TurnNumberInfoBTN
                destination.GameID_Orig = GameIDInfoBTN
                //                    destination.Reply
                
            }
        }
        
        if segue.identifier == "DemoComplete" {
            
            if let destination = segue.destination as? PageIntroViewController {
                
               // destination.GameTurn = TurnNumberInfoBTN
                destination.GAME_ID = GameIDInfoBTN
                //                    destination.Reply
                
            }
        }
        
        
        if segue.identifier == GameSegue {
            if let destination = segue.destination as? GameViewController {
                
                
                
                destination.GameName = GameNameInfoBTN
                destination.GameID = GameIDInfoBTN
                destination.CurrentTurn = TurnNumberInfoBTN
                destination.IsComplete = IsCompleteInfoBTN
                destination.GameStyle = GameStyleInfoBTN
                destination.IsTurnAvailable = CanTakeTurnInfoBTN
                
                destination.CurrentUser = CurrentUserInfoBTN
                
                destination.NumComments = NumComments
                
                destination.ContentRating = theContent
                
                /*
                
                destination.GameName = GameNameInfoBTN
                destination.GameID = GameIDInfoBTN
                destination.CurrentTurn = TurnNumberInfoBTN
                destination.IsComplete = IsCompleteInfoBTN
                destination.GameStyle = GameStyleInfoBTN
                destination.IsTurnAvailable = CanTakeTurnInfoBTN
                
                destination.CurrentUser = CurrentUserInfoBTN
                
                destination.NumComments = commentInfo[GameRowSelected]
                
                destination.ContentRating = contentInfo[GameRowSelected]
                */
                
                /*
                if let GameIndex = TableView.indexPathForSelectedRow()?.row {
                destination.GameName = GameNameInfo[GameIndex]
                destination.GameID = GameIDInfo[GameIndex]
                println("Game Turn 1: \(TurnNumberInfo[GameIndex])")
                
                destination.CurrentTurn = TurnNumberInfo[GameIndex]
                destination.IsComplete = IsCompleteInfo[GameIndex]
                destination.GameStyle = GameStyleInfo[GameIndex]
                destination.IsTurnAvailable = CanTakeTurnInfo[GameIndex]
                
                
                
                
                }
                
                */
            }
        }
        
        if segue.identifier == "pokeplayer" {
            
            let FBFriendViewController = segue.destination
            FBFriendViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            
            FBFriendViewController.popoverPresentationController!.delegate = self
            
            if segue.destination is PokePlayerViewController {
                
                // destination.RowSelected = replaceRow
                
                
                
            }
            
        }
        if segue.identifier == "ShowComments" {
            
            if let destination = segue.destination as? CommentsViewController {
                
                destination.NumComments = NumComments
                destination.GameID = GameSelected
                destination.ReplyUser = username
                destination.ReplyUserID = userID
                //                    destination.Reply
                
            }
        }
        
        if segue.identifier == "HowTo" {
            
            if let destination = segue.destination as? HowToSecondViewController {
                // let AudioBrowseViewController = segue.destinationViewController
                destination.theTopic = "My Games"
                //PQ2ViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
                
                // PQ2ViewController.popoverPresentationController!.delegate = self
                //  PQ2ViewController.presentationController?.delegate = self
            }
            
        }
        
        if segue.identifier == "goto_gameMail" {
            
            if let destination = segue.destination as? PlayerListViewController {
                
                destination.GameSelected = GameSelected
                destination.Player1 = thePlayer1
                destination.Player2 = thePlayer2
                destination.Player3 = thePlayer3
                destination.Player4 = thePlayer4
                destination.Player5 = thePlayer5
                destination.Player6 = thePlayer6
                destination.Player7 = thePlayer7
                destination.Player8 = thePlayer8
                destination.Player9 = thePlayer9
                destination.Player10 = thePlayer10
                
                destination.GameID = GameSelected
                
                destination.Visibility = theVisibility
                destination.ContentRating = theContent
                destination.JustViewingPlayers = JustViewingPlayers
                
            }
        }
    }
    
    
    func GetDeletedGamesData() {
        
      //  SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Unhide Games", subTitle: "Any games that you 'Hide' would now be visible", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
        
        /*
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //let managedContext = appDelegate.managedObjectContext!
        
        if let managedContext = appDelegate.managedObjectContext {
            
            let fetchRequest = NSFetchRequest(entityName: "DeletedGames")
            let error: NSError?
            
            do {
                let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
                
                
                
                if let results = fetchedResults {
                    let DGames = results
                    print(DGames)
                    
                    
                    
                    for items in DGames as [NSManagedObject] {
                        
                        let Gid = items.valueForKey("id") as! String
                        
                        
                        
                        print(items)
                        print("game id = \(Gid)")
                        
                        DeletedGameIDs.append(Gid)
                    }
                    
                    
                } else {
                    //print("Could not fetch \(error), \(error!.userInfo)")
                }
                
            } catch {
                print(error)
            }
            
        }
        
        print("Removed Games = \(DeletedGameIDs)")
        //println("Friends Now: \(NameInfo)")
        
        
        */
    }
    
    
    
    @IBAction func ClearHiddenGames(_ sender: AnyObject) {
        
        
        let theAlert = SCLAlertView()
        
        
        theAlert.addButton("Yes") {
            
            self.ClearHiddenYes()
            
        }
        
        //   theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Unhide All Games?", subTitle: "Are you sure you want to unhide all hidden games?")
        
        theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0), title: "Unhide All Game?", subTitle: "Are you sure you want to unhide all hidden games?", duration: nil, completeText: "Cancel", style: .custom, colorStyle: 1, colorTextButton: 1)
        
        
        /*
        
        let alertController = UIAlertController(title: "Unhide All Games?", message: "Are you sure you want to unhide all hidden games?", preferredStyle: .Alert)
        let CancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action:UIAlertAction) in
        print("Cancel button pressed")
        
        
        
        }
        
        alertController.addAction(CancelAction);
        
        let OkAction = UIAlertAction(title: "Yes", style: .Default) { (action:UIAlertAction) in
        print("OK button pressed")
        
        self.ClearHiddenYes()
        
        }
        
        alertController.addAction(OkAction);
        
        alertController.view.tintColor = UIColor.blackColor();
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
    
    
    
    func ClearHiddenYes() {
        
        /*
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName: "DeletedGames")
        var error: NSError?
        
        do {
            let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
            
            
            if let results = fetchedResults {
                var Friends = results
                print(Friends)
                
                
                
                for items in Friends as [NSManagedObject] {
                    
                    var FName = items.valueForKey("id") as! String
                    
                    
                    
                    
                    print(items)
                    print(items.valueForKey("id")!)
                    
                    
                    
                    print("Deleting User: \(FName) in")
                    
                    managedContext.deleteObject(items)
                    
                    do {
                        try managedContext.save()
                    } catch _ {
                    }
                    
                    // NumMembers++
                    // PlayerCount.append(NumMembers.description)
                    
                    //   theFriends.append(MyFriends(name:FName,email:EmailAdd))
                    
                }
                
            }
            
            //  let AC = JSController("Success", MyMessage: "All available games are now visible",Color: "Green")
            //  self.presentViewController(AC, animated: true, completion: nil)
            
            
            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Success", subTitle: "All available games are now visible", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
            
            
            
        } catch {
            print(error)
        }
        
        */
        
        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Success", subTitle: "All available games are now visible", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
        
    }
    
    
    func RemoveGameFromView(_ GameIDNum: NSString) {
        
        /*
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("DeletedGames", inManagedObjectContext: managedContext)
        
        let game = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        game.setValue(GameIDNum, forKey: "id")
        
        print("Deleting Game with ID: \(GameIDNum)")
        
        var error: NSError?
        
        do {
            try managedContext.save()
        } catch let error1 as NSError {
            error = error1
            print("Could not save \(error), \(error!.userInfo)")
        }

*/
        /*
        Friends.append(person)
        CurNum = NumFriends.count
        CurNum++
        NumFriends.append(CurNum)
        */
    }
    
    
    func FilterGameData(_ urlData: Data) -> ([NSArray], [GameType]) {
        GameData.removeAll()
        GameSearchInfo.removeAll()
        
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
                
                if !DeletedGameIDs.contains(gameID as NSString) {
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
                    
                    
                    let totalLikes = result["totalLikes"].stringValue
                    let commentTemp = result["comments"].stringValue
                    
                    let Turn1MediaType = result["turn1mediatype"].stringValue
                    let GameSettingP = result["gameSetting"].stringValue
                    
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
                        //TurnUser2 = "User1"
                    case "2":
                        LastTurnUser = player1 as NSString
                        TurnUser = player2 as NSString
                        TurnUserID = player2ID as NSString
                    case "3":
                        LastTurnUser = player2 as NSString
                        TurnUser = player3 as NSString
                        TurnUserID = player3ID as NSString
                    case "4":
                        LastTurnUser = player3 as NSString
                        TurnUser = player4 as NSString
                        TurnUserID = player4ID as NSString
                    case "5":
                        LastTurnUser = player4 as NSString
                        TurnUser = player5 as NSString
                        TurnUserID = player5ID as NSString
                    case "6":
                        LastTurnUser = player5 as NSString
                        TurnUser = player6 as NSString
                        TurnUserID = player6ID as NSString
                    case "7":
                        LastTurnUser = player6 as NSString
                        TurnUser = player7 as NSString
                        TurnUserID = player7ID as NSString
                    case "8":
                        LastTurnUser = player7 as NSString
                        TurnUser = player8 as NSString
                        TurnUserID = player8ID as NSString
                    case "9":
                        LastTurnUser = player8 as NSString
                        TurnUser = player9 as NSString
                        TurnUserID = player9ID as NSString
                    case "10":
                        LastTurnUser = player9 as NSString
                        TurnUser = player10 as NSString
                        TurnUserID = player10ID as NSString
                    default:
                        LastTurnUser = player10 as NSString
                        print("Error")
                    }
                    
                    
                    let theSearchString = "\(player1) \(player2) \(player3) \(player4) \(player5) \(player6) \(player7) \(player8) \(player9) \(player10) \(gname)"
                    
                    let ContentRating = result["contentrating"].stringValue
                    
                    
                    
                    if isComplete == "yes" {
                        GameSearchInfo.append(GameType(GameCategory: "Complete", GameName: gname, GameID: gameID, GamePlayer1: player1, GamePlayer2: player2, GamePlayer3: player3, GamePlayer4: player4, GamePlayer5: player5, GamePlayer6: player6, GamePlayer7: player7, GamePlayer8: player8, GamePlayer9: player9, GamePlayer10: player10, GameTurnNumber: turnNumber, GameIsComplete: isComplete, GameUsersTurn: TurnUser as String, GameLastTurnTime: LastTurnTime, GameTimeLimit: TimeLimit, GameCanTakeTurn: CanTakeTurn, GameGameStyle: GameStyle, GameGameVisible: GameVisible as String, GameTotalLikes: totalLikes, GameCommentInfo: commentTemp, GameGameLikeArray: gameliketemp, GameGameFailArray: gamefailtemp, GamePlayer1ID: player1ID, GamePlayer2ID: player2ID, GamePlayer3ID: player3ID, GamePlayer4ID: player4ID, GamePlayer5ID: player5ID, GamePlayer6ID: player6ID, GamePlayer7ID: player7ID, GamePlayer8ID: player8ID, GamePlayer9ID: player9ID, GamePlayer10ID: player10ID, GameUsersTurnID: TurnUserID as String, GameContent: ContentRating, GameSearchString: theSearchString, Turn1MediaType: Turn1MediaType, Turn1URLString: Turn1URLString, LastTurnUser: LastTurnUser as String, GameSetting: GameSettingP, NewToView: false))
                        //         GameSearchArray.append(GameType(category: "Complete", name: gname, turnUser: TurnUser as String))
                    } else {
                        //    GameSearchArray.append(GameType(category: "In Process", name: gname, turnUser: TurnUser as String))
                        GameSearchInfo.append(GameType(GameCategory: "In Process", GameName: gname, GameID: gameID, GamePlayer1: player1, GamePlayer2: player2, GamePlayer3: player3, GamePlayer4: player4, GamePlayer5: player5, GamePlayer6: player6, GamePlayer7: player7, GamePlayer8: player8, GamePlayer9: player9, GamePlayer10: player10, GameTurnNumber: turnNumber, GameIsComplete: isComplete, GameUsersTurn: TurnUser as String, GameLastTurnTime: LastTurnTime, GameTimeLimit: TimeLimit, GameCanTakeTurn: CanTakeTurn, GameGameStyle: GameStyle, GameGameVisible: GameVisible as String, GameTotalLikes: totalLikes, GameCommentInfo: commentTemp, GameGameLikeArray: gameliketemp, GameGameFailArray: gamefailtemp, GamePlayer1ID: player1ID, GamePlayer2ID: player2ID, GamePlayer3ID: player3ID, GamePlayer4ID: player4ID, GamePlayer5ID: player5ID, GamePlayer6ID: player6ID, GamePlayer7ID: player7ID, GamePlayer8ID: player8ID, GamePlayer9ID: player9ID, GamePlayer10ID: player10ID, GameUsersTurnID: TurnUserID as String, GameContent: ContentRating, GameSearchString: theSearchString, Turn1MediaType: Turn1MediaType, Turn1URLString: Turn1URLString, LastTurnUser: LastTurnUser as String, GameSetting: GameSettingP, NewToView: false))
                        
                        
                    }
                    
                    
                    contentArray.append(ContentRating as NSString)
                    gnameArray.append(gname as NSString)
                    GameIdArray.append(gameID as NSString)
                    Player1Array.append(player1 as NSString)
                    Player2Array.append(player2 as NSString)
                    Player3Array.append(player3 as NSString)
                    Player4Array.append(player4 as NSString)
                    Player5Array.append(player5 as NSString)
                    Player6Array.append(player6 as NSString)
                    Player7Array.append(player7 as NSString)
                    Player8Array.append(player8 as NSString)
                    Player9Array.append(player9 as NSString)
                    
                    Player10Array.append(player10 as NSString)
                    
                    Player1IDArray.append(player1ID as NSString)
                    Player2IDArray.append(player2ID as NSString)
                    Player3IDArray.append(player3ID as NSString)
                    Player4IDArray.append(player4ID as NSString)
                    Player5IDArray.append(player5ID as NSString)
                    Player6IDArray.append(player6ID as NSString)
                    Player7IDArray.append(player7ID as NSString)
                    Player8IDArray.append(player8ID as NSString)
                    Player9IDArray.append(player9ID as NSString)
                    Player10IDArray.append(player10ID as NSString)
                    
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
                    TurnNumberArray.append(turnNumber as NSString)
                    IsCompleteArray.append(isComplete as NSString)
                    UsersTurnArray.append(TurnUser)
                    UsersTurnIDArray.append(TurnUserID)
                    
                    
                    LastTurnTimeArray.append(LastTurnTime as NSString)
                    TimeLimitArray.append(TimeLimit as NSString)
                    CanTakeTurnArray.append(CanTakeTurn as NSString)
                    GameStyleArray.append(GameStyle as NSString)
                    GameVisibleArray.append(GameVisible)
                    TotalLikesArray.append(totalLikes as NSString)
                    commentArray.append(commentTemp as NSString)
                    GameLikeArrayTemp.append(gameliketemp as NSString)
                    GameFailArrayTemp.append(gamefailtemp as NSString)
                }
            }
            
        }
        
        
        
        GameData.append(gnameArray as NSArray)
        GameData.append(GameIdArray as NSArray)
        GameData.append(Player1Array as NSArray)
        GameData.append(Player2Array as NSArray)
        GameData.append(Player3Array as NSArray)
        GameData.append(Player4Array as NSArray)
        GameData.append(Player5Array as NSArray)
        GameData.append(Player6Array as NSArray)
        GameData.append(Player7Array as NSArray)
        GameData.append(Player8Array as NSArray)
        GameData.append(Player9Array as NSArray)
        GameData.append(Player10Array as NSArray)
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
        GameData.append(TurnNumberArray as NSArray)
        GameData.append(IsCompleteArray as NSArray)
        GameData.append(UsersTurnArray as NSArray)
        GameData.append(LastTurnTimeArray as NSArray)
        GameData.append(TimeLimitArray as NSArray)
        GameData.append(CanTakeTurnArray as NSArray)
        GameData.append(GameStyleArray as NSArray)
        GameData.append(GameVisibleArray as NSArray)
        GameData.append(TotalLikesArray as NSArray)
        GameData.append(commentArray as NSArray)
        GameData.append(GameLikeArrayTemp as NSArray)
        GameData.append(GameFailArrayTemp as NSArray)
        
        GameData.append(Player1IDArray as NSArray)
        GameData.append(Player2IDArray as NSArray)
        GameData.append(Player3IDArray as NSArray)
        GameData.append(Player4IDArray as NSArray)
        GameData.append(Player5IDArray as NSArray)
        GameData.append(Player6IDArray as NSArray)
        GameData.append(Player7IDArray as NSArray)
        GameData.append(Player8IDArray as NSArray)
        GameData.append(Player9IDArray as NSArray)
        GameData.append(Player10IDArray as NSArray)
        GameData.append(UsersTurnIDArray as NSArray)
        GameData.append(contentArray as NSArray)
        //GameData.append(GameSearchArray)
        
        return (GameData, GameSearchInfo)
        
    }
    
    /*
    @IBAction func menuButton(sender: AnyObject) {
        
        
        if self.revealViewController() == nil {
            self.performSegueWithIdentifier("goto_menu", sender: self)
        }
    }
    */
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        super.viewDidLoad()
        print("popover dismissed")
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    
    /*
    @IBAction func unwindToMyGames(unwindSegue: UIStoryboardSegue) {
        if let blueViewController = unwindSegue.sourceViewController as? QuoteViewController {
            print("Coming from Quote")
        }
        else if let redViewController = unwindSegue.sourceViewController as? ImageViewController {
            print("Coming from Image")
        }
        else if let CompleteViewController = unwindSegue.sourceViewController as? PageIntroViewController {
            print("Coming from Completed")
        }
        else if let theGameViewController = unwindSegue.sourceViewController as? GameViewController {
            print("Coming GameViewController")
        }
        
    }
    
    */
    
    
    func LoadNextGames(_ CurrentTurnsLoaded: Int) {
        //var NewTurnsLoaded = CurrentTurnsLoaded
        let StartNumber = CurrentTurnsLoaded
        let EndNumber = CurrentTurnsLoaded + 50
        
        print("Getting Data for turns \(StartNumber) through \(EndNumber)")
        
        //  LFURLData = GetUserTurnData(self.playerID, StartNum: StartNumber, EndNum: EndNumber)
        _ = GetUserGameDataPublic(self.username, userID: self.userID, gameSetting: "public", StartNum: StartNumber, EndNum: EndNumber, type: self.SegmentValueString)
        
        
        print("RECEIVED THE NEXT FIVE TURNS")
        
        DispatchQueue.main.async(execute: {
            
            print("FILTERING THE NEXT FIVE TURNS NOW")
            
            // self.TurnStruc = self.FilterTurnData(self.LFURLData)
            
            
            DispatchQueue.main.async(execute: {
                
                
                
                self.TableView?.reloadData()
                print("done animating")
                //self.actInd.stopAnimating()
                
                self.NumTurnsLoaded = EndNumber
                print("New Number set for NumTurnsLoaded: \(self.NumTurnsLoaded)!!!!!!!!!!!!!!!")
                
            })
            
        })
        
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        //  print("ContentOffset = \(contentOffset)")
        //  print("maximumOffset = \(maximumOffset)")
        //   print("Threshold = \(threshold)")
        _ = maximumOffset - contentOffset
        //   print("max - content = \(cmm)")
        
        if !isLoadingMore && (maximumOffset - contentOffset <= threshold) {
            
            
            if NumTurnsLoaded >= MyTotalTurns {
                print("No MORE TURNS TO LOAD")
                NumTurnsLoaded = MyTotalTurns
            } else {
                
                // let SaveProgressHUD3 = ProgressHUD(text: "Loading More...")
                //  self.view.addSubview(SaveProgressHUD3)
                
                
                
                
                print("is at bottom")
                // Get more data - API call
                //self.NumTurnsLoaded = self.NumTurnsLoaded + 5
                
                if pickerItem {
                    print("LOADING THE NEXT PUBLIC GAMES")
                    
                    print("Number of Turns Currently loaded = \(self.NumTurnsLoaded)")
                    
                    self.isLoadingMore = true
                    
                   // self.LoadNextGames(self.NumTurnsLoaded)
                    
                    
                    // Update UI
                    
                    
                    DispatchQueue.main.async {
                        self.TableView!.reloadData()
                        self.isLoadingMore = false
                        
                        //   SaveProgressHUD3.removeFromSuperview()
                        
                    }
                } else {
                    print("All of my games are already loaded")
                }
                
            }
            
        }
        
        if !isLoadingMore && (maximumOffset - contentOffset >= (maximumOffset)) {
            
            
            print("is at top")
            
            
        }
        
        
        
        let yPos: CGFloat = -scrollView.contentOffset.y
        //   print("yPos = \(yPos)")
        
        _ = scrollView.contentSize.height
        //  print("theight = \(tHeight)")
        // let tTop = scrollView.layer.
        
        
        if !isRefreshing {
            if yPos < TableYPos {
                print("Scrolling Down")
                
                if yPos < -150 {
                    
                    
                }
                
                
            } else {
                print("Scrolling Up")
                
                
                
            }
            TableYPos = yPos
            
        } else {
            print("is refreshing, don't scroll")
            
            
            
            
            
        }
        
        if (yPos > 0) {
            
            
            
        } else {
            
            if (yPos < -0.5) {
                
                //   print("Scrolling down")
                
                
            }
            
        }
        
        
    }
    
    
    
    @IBAction func searchForGameBTN(_ sender: AnyObject) {
        
        if !SearchBarShowing {
            
            UIView.animate(withDuration: 1.0, animations: {
                // self.resultSearchController.alpha = 1.0
                self.resultSearchController.searchBar.alpha = 1.0
                /*
                TableView.view.frame.height = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
                }, completion: {
                (value: Bool) in
                //do nothing after animation
                
                */
                }
                
            )
            
            
            SearchBarShowing = true
        } else {
            
            UIView.animate(withDuration: 1.0, animations: {
                self.resultSearchController.searchBar.alpha = 0.0
                /*
                TableView.view.frame.height = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
                }, completion: {
                (value: Bool) in
                //do nothing after animation
                
                */
            })
            
            SearchBarShowing = false
            
            
        }
        
    }
    
  
    
    func gamesegmentValueChanged(_ sender: AnyObject?){
        
        if gameSegment.selectedIndex == 0 {
            /*
            self.actInd.hidden = false
            self.actInd.startAnimating()
            self.titleLBL.text = "My Games"
            
            self.RemoveGameArrayData()
            print("Mygames")
            //segmentControl.items = ["My Turns", "All", "Completed"]
            self.TableView.reloadData()
            
            if pickerIsAllGames {
                pickerIsAllGames = false
                UIView.animateWithDuration(1.0, animations: {
                    self.segmentControl.center.y = self.segmentControl.center.y + 40
                    self.TableView.center.y = self.TableView.center.y + 40
                    self.segmentControlTOP.constant = 0
                })
                
                pickerItem = false
               // refreshMyGames()
                self.CreateDemoGames()
                
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.actInd.hidden = true
                self.actInd.stopAnimating()
            })
            */
            
            if pickerIsAllGames {
                pickerIsAllGames = false
                UIView.animate(withDuration: 1.0, animations: {
                    self.segmentControl.center.y = self.segmentControl.center.y + 40
                    self.TableView.center.y = self.TableView.center.y + 40
                    self.segmentControlTOP.constant = 0
                })
                
                pickerItem = false
                // refreshMyGames()
                //self.CreateDemoGames()
                
            }

            
            if segmentControl.selectedIndex == 0 {
                
                self.actInd.isHidden = false
                self.actInd.startAnimating()
                self.SegmentValueString = "All"
                self.RemoveGameArrayData()
                print("Segment = \(self.SegmentValueString)")
                
                
                
                //  dispatch_async(dispatch_get_main_queue(), {
                if !self.pickerItem {
                    // self.refreshMyGames()
                    self.CreateDemoGamesAll()
                } else {
                    //  self.refreshPublicGames()
                    self.CreateDemoGamesAll()
                }
                // })
                //salesValue.text = "$23,399"
                
                DispatchQueue.main.async(execute: {
                    self.actInd.isHidden = true
                    self.actInd.stopAnimating()
                })
                
                //filterContentForSearchText("", scope: "All")
                
            } else if segmentControl.selectedIndex == 1{
                
                self.actInd.isHidden = false
                self.actInd.startAnimating()
                self.SegmentValueString = "My Turns"
                self.RemoveGameArrayData()
                print("Segment = \(self.SegmentValueString)")
                
                
                
                
                //   dispatch_async(dispatch_get_main_queue(), {
                if !self.pickerItem {
                    // self.refreshMyGames()
                    self.CreateDemoGamesMyTurns()
                } else {
                    //  self.refreshPublicGames()
                    self.CreateDemoGamesMyTurns()
                }
                //  })
                DispatchQueue.main.async(execute: {
                    self.actInd.isHidden = true
                    self.actInd.stopAnimating()
                })
                //filterContentForSearchText("", scope: "Complete")
                //salesValue.text = "$81,295"
            } else {
                
                self.actInd.isHidden = false
                self.actInd.startAnimating()
                
                self.SegmentValueString = "Completed"
                self.RemoveGameArrayData()
                print("Segment = \(self.SegmentValueString)")
                
                //actInd.hidden = false
                
                
                
                //   dispatch_async(dispatch_get_main_queue(), {
                if !self.pickerItem {
                    // self.refreshMyGames()
                    self.CreateDemoGamesCompleted2()
                } else {
                    //self.refreshPublicGames()
                    self.CreateDemoGamesCompleted2()
                }
                
                DispatchQueue.main.async(execute: {
                    self.actInd.isHidden = true
                    self.actInd.stopAnimating()
                })
                //   })
                // filterContentForSearchText("", scope: "In Process")
                //salesValue.text = "$199,392"
            }

            
            //filterContentForSearchText("", scope: "All")
            
        } else if gameSegment.selectedIndex == 1 {
            
            self.actInd.isHidden = false
            self.actInd.startAnimating()
            
            self.RemoveGameArrayData()
            self.SegmentValueString = "All"
            self.titleLBL.text = "Pubilc Games"
            self.TableView.reloadData()
            
            if !pickerIsAllGames {
                pickerIsAllGames = true
                UIView.animate(withDuration: 1.0, animations: {
                    self.segmentControl.center.y = self.segmentControl.center.y - 40
                    self.TableView.center.y = self.TableView.center.y - 40
                    self.segmentControlTOP.constant = -40
                })
                
            }
            
            print("all games")
            
            pickerItem = true
          //  refreshPublicGames()
            //self.CreateDemoGames()
            
            DispatchQueue.main.async(execute: {
                self.actInd.isHidden = true
                self.actInd.stopAnimating()
            })
            
        }
    }
    
    func segmentValueChanged(_ sender: AnyObject?){
        
        if segmentControl.selectedIndex == 0 {
            
            self.actInd.isHidden = false
            self.actInd.startAnimating()
            self.SegmentValueString = "All"
            self.RemoveGameArrayData()
            print("Segment = \(self.SegmentValueString)")
            
            
            
            //  dispatch_async(dispatch_get_main_queue(), {
            if !self.pickerItem {
               // self.refreshMyGames()
                self.CreateDemoGamesAll()
            } else {
              //  self.refreshPublicGames()
                self.CreateDemoGamesAll()
            }
            // })
            //salesValue.text = "$23,399"
            
            DispatchQueue.main.async(execute: {
                self.actInd.isHidden = true
                self.actInd.stopAnimating()
            })
            
            //filterContentForSearchText("", scope: "All")
            
        } else if segmentControl.selectedIndex == 1{
            
            self.actInd.isHidden = false
            self.actInd.startAnimating()
            self.SegmentValueString = "My Turns"
            self.RemoveGameArrayData()
            print("Segment = \(self.SegmentValueString)")
            
            
            
            
            //   dispatch_async(dispatch_get_main_queue(), {
            if !self.pickerItem {
               // self.refreshMyGames()
                self.CreateDemoGamesMyTurns()
            } else {
              //  self.refreshPublicGames()
                self.CreateDemoGamesMyTurns()
            }
            //  })
            DispatchQueue.main.async(execute: {
                self.actInd.isHidden = true
                self.actInd.stopAnimating()
            })
            //filterContentForSearchText("", scope: "Complete")
            //salesValue.text = "$81,295"
        } else {
            
            self.actInd.isHidden = false
            self.actInd.startAnimating()
            
            self.SegmentValueString = "Completed"
            self.RemoveGameArrayData()
            print("Segment = \(self.SegmentValueString)")
            
            //actInd.hidden = false
            
            
            
            //   dispatch_async(dispatch_get_main_queue(), {
            if !self.pickerItem {
               // self.refreshMyGames()
                self.CreateDemoGamesCompleted2()
            } else {
                //self.refreshPublicGames()
                self.CreateDemoGamesCompleted2()
            }
            
            DispatchQueue.main.async(execute: {
                self.actInd.isHidden = true
                self.actInd.stopAnimating()
            })
            //   })
            // filterContentForSearchText("", scope: "In Process")
            //salesValue.text = "$199,392"
        }
    }
    
    
    
    
    
    @IBAction func closeBTN(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
 
    
    
   
    
}




/*
extension MyGamesViewController {
    //}: FBFriendsViewControllerDelegate {
    func PokePlayerViewControllerFinished(pokeplayerviewController: PokePlayerViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        //self.FBFriendName = fbfriendsviewController.FBFriendName
        
        //  let item  = likesviewController.TotalLikes
        // print("replacing item in like array , adding \(item)")
        // let item2  = likesviewController.LikedPUshed
        // NumFails.removeAtIndex(ReplaceAtRowNum);
        
        //// NumFails.insert(item, atIndex: ReplaceAtRowNum)
        
        //  LikedPushedArray.removeAtIndex(ReplaceAtRowNum);
        
        //  LikedPushedArray.insert(item2, atIndex: ReplaceAtRowNum)
    }
}
*/
