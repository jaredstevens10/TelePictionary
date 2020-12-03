//
//  HowToViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/9/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

//
//  HowToViewController.swift
//  PartyTraits
//
//  Created by Jared Stevens on 7/8/15.
//  Copyright (c) 2015 Jared Stevens. All rights reserved.
//

import UIKit

class HowToViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var isFun = NSString()
    var HTtopic = NSString()
    let prefs:UserDefaults = UserDefaults.standard
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
 //   let pageTitles = ["Object Of The Game", "Starting A New Game", "Creating Friends Group", "Managing Your Games", "Viewing A Completed Game", "What Are Game Tokens?"]
    
    var pageTitles = [NSString]()
    

    var images1 = [NSString]()
    var images2 = [NSString]()
    var imagesFull = [NSString]()

    var LBL1text = [NSString]()
    var LBL2text = [NSString]()
    var images1Hidden = [Bool]()
    var images2Hidden = [Bool]()
    var imagesFullHidden = [Bool]()
   // var images1Groups = ["Step1Groups.png","Step2Groups.png","Step3Groups.png","Step4Groups.png"]
   // var images2Groups = ["Step1Groups.png","Step2Groups.png","Step3Groups.png","Step4Groups.png"]
   

    
    
    var count = 0
    
    var HowToPage : UIPageViewController!
   
    
    @IBAction func swipeLeft(_ sender: AnyObject) {
        print("SWipe left")
    }
    @IBAction func swiped(_ sender: AnyObject) {
        
        self.HowToPage.view .removeFromSuperview()
        self.HowToPage.removeFromParent()
        reset()
  
 
    

    
    
   
    }
    
    /*
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var subViews: NSArray = view.subviews
        var scrollView: UIScrollView? = nil
        var pageControl: UIPageControl? = nil
        
        for view in subViews {
            if view.isKindOfClass(UIScrollView) {
                scrollView = view as? UIScrollView
            }
            else if view.isKindOfClass(UIPageControl) {
                pageControl = view as? UIPageControl
            }
        }
        
        if (scrollView != nil && pageControl != nil) {
            scrollView?.frame = view.bounds
            view.bringSubviewToFront(pageControl!)
        }
    }
    */
    
    func reset() {
    /* Getting the page View controller */
    HowToPage = self.storyboard?.instantiateViewController(withIdentifier: "HowToPage") as! UIPageViewController
    
    self.HowToPage.dataSource = self
    //self.HowToPage.delegate = self
    
    let pageContentViewController = self.viewControllerAtIndex(0)
    
        self.HowToPage.setViewControllers([pageContentViewController!], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
    
    /* We are substracting 30 because we have a start again button whose height is 30*/
    self.HowToPage.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 30)
        
    
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.backgroundColor = UIColor.clear
        
   // self.view.bringSubviewToFront(pageControl)
 //   self.HowToPage.view.addSubview(pageControl)
        
        self.addChild(HowToPage)
        
    self.view.addSubview(HowToPage.view)
  //  self.view.addSubview(pageControl)
        
        self.HowToPage.didMove(toParent: self)
      /*
        var pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.whiteColor()
        pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        pageControl.backgroundColor = UIColor.clearColor()
       // self.view.addSubview(pageControl.view)
      */
        
    }
    
    @IBAction func start(_ sender: AnyObject) {
    let pageContentViewController = self.viewControllerAtIndex(0)
        self.HowToPage.setViewControllers([pageContentViewController!], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        isFun = prefs.value(forKey: "ISFUN") as! NSString
        /*
        if let font = UIFont(name: "DK Cool Crayon", size: 20.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.whiteColor()]
        }
        */
        
        switch HTtopic {
            
            //NEW GAME ITEMS
            
        case "First Step":
            
            pageTitles = ["Starting A New Game", "Start With A Quote", "Start With An Image", "Starting A New Game", "Starting A New Game","Starting A New Game", "Starting A New Game", "Starting A New Game", "Starting A New Game", "Starting A New Game", "Starting A New Game", "Starting A New Game", "Starting A New Game", "Starting A New Game"]
            images1 = ["Step1NewGame.png","Step2NewGame.png","Step3NewGame.png","Step4NewGame.png","Step5NewGame.png","Step6NewGame.png","Step7NewGame.png","Step8NewGame.png","Step9NewGame.png","Step10NewGame.png","Step11NewGame.png","Step12NewGame.png","Step13NewGame.png","Step14NewGame.png"]
            images2 = ["Step1NewGame.png","Step2NewGame.png","Step3NewGame.png","Step4NewGame.png","Step5NewGame.png","Step6NewGame.png","Step7NewGame.png","Step8NewGame.png","Step9NewGame.png","Step10NewGame.png","Step11NewGame.png","Step12NewGame.png","Step13NewGame.png","Step14NewGame.png"]
            LBL1text = ["","","","","","","","","","","","","",""]
            LBL2text = ["Select a Quote or Image to start a game","In the quote view, type a quote or insert an Audio clip","In the image view, select an image from your photos or take a picture","Give your game a title","Select a 'Turn Time', the minimum time each player has to take their turn","Select the number of players, you can add more later","Select the game Content Rating, a guide for other players on approriate content for this game","Here you will select who you will be playing with","Tap the 'My Groups' button to add a preset group","Tap the group name to add the players from that group","or the 'Plus Icon' to add more players","It's ideal to select players from your previos players, but you can also choose from your contacts and the game center","Tap the player's name to select","Once all the player's are selected, tap 'Start Game' to create the game."]
            imagesFull = ["Step1NewGame.png","Step2NewGame.png","Step3NewGame.png","Step4NewGame.png","Step5NewGame.png","Step6NewGame.png","Step7NewGame.png","Step8NewGame.png","Step9NewGame.png","Step11NewGame.png","Step10NewGame.png","Step12NewGame.png","Step13NewGame.png","Step14NewGame.png"]
            images1Hidden = [true,true,true,true,true,true,true,true,true,true,true,true,true,true]
            images2Hidden = [true,true,true,true,true,true,true,true,true,true,true,true,true,true]
            imagesFullHidden = [false, false, false, false,false,false, false, false, false,false,false, false,false,false]
          
            
        case "Start with Audio Clip":
            pageTitles = ["Add Audio Clip","Add Audio Clip","Add Audio Clip","Add Audio Clip","Add Audio Clip","Add Audio Clip","Add Audio Clip","Add Audio Clip","Add Audio Clip"]
            images1 = ["","","","","","","","",""]
            images2 = ["","","","","","","","",""]
            LBL1text = ["","","","","","","","",""]
            LBL2text = ["Firsrt, tap the Quote icon","Next tap the Music icon", "Select an audio clip by tapping the Record or Music library icon","To select from your music library, tap 'Select Audio File'","To trim the audio file, tap 'Select Start Time'","Select the start time using the Star Time Picker...","..or tap and swipe the time sliders to adjust the Begin and End time","Once your time is selected, tap 'Trim Audio File'.  It will need to be 10 seconds or less","After the Audio file is trimmed, tap 'Save'"]
            images1Hidden = [true, true, true, true, true, true, true, true, true]
            images2Hidden = [true, true, true, true, true, true, true, true, true]
            imagesFullHidden = [false, false, false, false, false, false, false, false, false]
            imagesFull = ["Step1NewAudioNew.png","Step1NewAudio2.png","Step1NewAudioNew.png","Step2NewAudio.png","Step3NewAudio1.png","Step4NewAudio.png","Step5NewAudio.png","Step6NewAudio.png","Step7NewAudio.png"]
            
        case "Turn Times?":
            pageTitles = ["Game Turn Time"]
            images1 = [""]
            images2 = [""]
            LBL1text = [""]
            LBL2text = ["Designed to help speed up game play, after the time expires the turn can be taken by any player"]
            images1Hidden = [true]
            images2Hidden = [true]
            imagesFullHidden = [false]
            imagesFull = ["Step5NewGame.png"]
            
        case "Content Rating?":
            pageTitles = ["Content Rating", "Content Rating", "Content Rating", "Content Rating"]
            images1 = ["","","",""]
            images2 = ["Step9MyGamesFull.png","Step9MyGamesFull1.png","Step9MyGamesFull2.png","Step9MyGamesFull3.png"]
            LBL1text =  ["","","",""]
            LBL2text = ["Be mindful of who you are playing with...","Content for Everyone","Content for teenagers and above","Mature Content"]
            
            images1Hidden = [true, true, true, true]
            images2Hidden = [true, true, true, true]
            imagesFullHidden = [false, false, false, false]
            imagesFull = ["Step9MyGamesFull.png","Step9MyGamesFull1.png","Step9MyGamesFull2.png","Step9MyGamesFull3.png"]
            
        case "Adding Players":
            pageTitles = ["Adding Players","Adding Players","Adding Players","Adding Players","Adding Players"]
            images1 = ["Step8NewGame.png","Step9NewGame.png","Step10NewGame.png","Step12NewGame.png","Step13NewGame.png"]
            images2 = ["Step7NewGame.png","Step8NewGame.png","Step9NewGame.png","Step11NewGame.png","Step12NewGame.png"]
            LBL1text = ["","","","",""]
            LBL2text = ["Here you will select the players for your new game","You can add a custom group by tapping the Group Icon...","...Or tap the 'Add Player' icon to add one player","Once the player slot is added, choose from your previous players.","Select the previous player's name"]
            images1Hidden = [true, true, true, true, true, true]
            images2Hidden = [true, true, true, true, true, true]
            imagesFullHidden = [false, false, false, false, false]
            imagesFull = ["Step8NewGame.png","Step9NewGame.png","Step10NewGame.png","Step12NewGame.png","Step13NewGame.png"]
        
        case "Custom Groups":
            pageTitles = ["My Groups","My Groups"]
            images1 = ["",""]
            images2 = ["",""]
            LBL1text = ["",""]
            LBL2text = ["Save time and use one of your groups.  Tap the Groups button below","Select one of your custom groups"]
            images1Hidden = [true, true]
            images2Hidden = [true, true]
            imagesFullHidden = [false, false]
            imagesFull = ["Step9NewGame.png","Step11NewGame.png"]
            
        case "newgame":
            
            pageTitles = ["Starting A New Game", "Starting A New Game", "Starting A New Game", "Starting A New Game", "Starting A New Game"]
            images1 = ["Step1NewGame.png","Step2NewGame.png","Step3NewGame.png","Step4NewGame.png","Step5NewGame.png"]
            images2 = ["Step1New.png","Step2New.png","Step3New.png","Step4New.png","Step5New.png"]
            LBL1text = ["","","","",""]
            LBL2text = ["","","","",""]
            imagesFull = ["","","","",""]
        
            //PIXIE ITEMS
            
        case "My Pixie":
            pageTitles = ["My Pixie","My Pixie"]
            images1 = ["",""]
            images2 = ["",""]
            LBL1text = ["",""]
            LBL2text = ["Hi! I'm Pixie.  Please help upgrade me and my outfits...",""]
            images1Hidden = [true, true]
            images2Hidden = [true, true]
            imagesFullHidden = [false, false]
            imagesFull = ["CharacterNormal.png","CharacterNormal.png"]
  
            
             //FRIEND ITEMS
        
        case "Invite My Friends":
            pageTitles = ["Inviting Friends"]
            images1 = [""]
            images2 = [""]
            LBL1text = [""]
            LBL2text = ["Tap the Facebook, Email, or Message Invite to invite your friends to download Pics & Quotes"]
            images1Hidden = [true]
            images2Hidden = [true]
            imagesFullHidden = [false]
            imagesFull = ["Step1InviteFriends.png"]
        
        
        case "Add A Friend":
            pageTitles = ["Adding A Friend","Adding A Friend"]
            images1 = ["",""]
            images2 = ["",""]
            LBL1text = ["",""]
            LBL2text = ["Tap 'Manage Friends'","Tap the '+' button to add a friend from your previous players"]
            images1Hidden = [true, true]
            images2Hidden = [true, true]
            imagesFullHidden = [false, false]
            imagesFull = ["Step1AddFriends.png","Step2AddFriends.png"]
            
            
        case "My Best Friends":
            pageTitles = ["Best Friends","Best Friends"]
            images1 = ["",""]
            images2 = ["",""]
            LBL1text = ["",""]
            LBL2text = ["Tap 'Manage Friends'","Tap the '+' button to add a best friend from your previous players"]
            images1Hidden = [true, true]
            images2Hidden = [true, true]
            imagesFullHidden = [false, false]
            imagesFull = ["Step1AddFriends.png","Step2AddFriendsBest.png"]
            
            
         case "Creating A Group":
            
            pageTitles = ["Creating a Group", "Creating a Group", "Creating a Group", "Creating a Group", "Creating a Group"]
            
            images1 = ["Step1Groups.png","Steps2Groups.png","TapGroupName.png","Step3Groups.png","Step4Groups.png"]
            images1Hidden = [true, true, true, true, true]
            
            images2 = ["Step1Groups.png","Steps2Groups.png","TapGroupName.png","Step3Groups.png","Step4Groups.png"]
            images2Hidden = [true, true, true, true, true]
            
            LBL1text = ["Select the 'My Friends' view from the menu and tap the '+' next to 'Add a Group'","Enter a name for your new Group, then tap 'Done'","Tap on the name of your newly created group to add people to it","Tap the '+' icon at the bottom left to add players to your group","Tap the blue 'Previous Players' button to select the player"]
            LBL2text = ["Select the 'My Friends' view from the menu and tap the '+' next to 'Add a Group'","Enter a name for your new Group, then tap 'Done'","Tap on the name of your newly created group to add people to it","Tap the '+' icon at the bottom left to add players to your group","Tap the blue 'Previous Players' button to select the player"]
            
            imagesFull = ["Step1Groups.png","Step2Groups.png","TapGroupName.png","Step3Groups.png","Step4Groups.png"]
            imagesFullHidden = [false, false, false, false,false]
            
            
             //LEADERBOARD ITEMS
            
        case "Most Likes":
            pageTitles = ["Most Likes","Most Likes","Most Likes","Most Likes"]
            images1 = ["","","",""]
            images2 = ["","","",""]
            LBL1text = ["","","",""]
            LBL2text = ["View the players with the most 'Likes', tap on their name to see their 'Likes'","Tap on the 'Like' to see more","See the previous turn...","Tap the 'Report Content' button if you feel this turn should be removed"]
            images1Hidden = [true, true, true, true]
            images2Hidden = [true, true, true, true]
            imagesFullHidden = [false, false, false, false]
            imagesFull = ["Step1Likes.png","Step2Likes.png","Step3Likes.png","Step4Likes.png"]
            
        case "Most Fails":
            pageTitles = ["Most Fails","Most Fails","Most Fails","Most Fails"]
            images1 = ["","","",""]
            images2 = ["","","",""]
            LBL1text = ["","","",""]
            LBL2text = ["View the players with the most 'Fails', tap on their name to see their 'Fails'","Tap on the 'Fail' to see more","See the previous turn...","Tap the 'Report Content' button if you feel this turn should be removed"]
            images1Hidden = [true, true, true, true]
            images2Hidden = [true, true, true, true]
            imagesFullHidden = [false, false, false, false]
            imagesFull = ["Step1Fails.png","Step2Fails.png","Step3Fails.png","Step4Fails.png"]
            
        case "Most Games Played":
            pageTitles = ["Most Games","Most Games","Most Games","Most Games"]
            images1 = ["","","",""]
            images2 = ["","","",""]
            LBL1text = ["","","",""]
            LBL2text = ["View the leaders with the most games, tap on their username to learn more","Check out their user profile","View their Pics & Quotes Stats","Check out their current Pics & Quotes titles"]
            images1Hidden = [true, true, true, true]
            images2Hidden = [true, true, true, true]
            imagesFullHidden = [false, false, false, false]
            imagesFull = ["Step1Leaders.png","Step2Leaders.png","Step3Leaders.png","Step4Leaders.png"]
            
        case "leaders":
            
            pageTitles = ["Game Leaderboards", "Game Leaderboards", "Game Leaderboards", "Game Leaderboards"]
            images1 = ["Step1Leaders.png","Step2Leaders.png","Step3Leaders.png","Step4Leaders.png"]
            images2 = ["Step1Leaders.png","Step2Leaders.png","Step3Leaders.png","Step4Leaders.png"]
            LBL1text = ["","","",""]
            LBL2text = ["","","",""]
            images1Hidden = [true, true, true, true]
            images2Hidden = [true, true, true, true]
            imagesFullHidden = [false, false, false, false]
            imagesFull = [""]
            //TOOLBOX ITEMS

            
        case "Upgrading My Toolbox":
            
            pageTitles = ["Toolbox", "Toolbox", "Toolbox"]
            images1 = ["Step1Tool.png","Step2Tool.png","Step3Tool.png"]
            images2 = ["Step1Tool.png","Step2Tool.png","Step3Tool.png"]
            LBL1text = ["","",""]
            LBL2text = ["","",""]
            images1Hidden = [true, true, true]
            images2Hidden = [true, true, true]
            imagesFullHidden = [true, true, true]
            imagesFull = ["","",""]
            
            //MY GAMES ITEMS
        case "Edit My Game":
            pageTitles = ["Edit My Game","Edit My Game","Edit My Game","Edit My Game","Edit My Game","Edit My Game"]
            images1 = ["","","","","",""]
            images2 = ["","","","","",""]
            LBL1text = ["","","","","",""]
            LBL2text = ["If you created this game you will show an 'Edit' option, here you can edit game players and resend them notifications","In Green you will see who's turn it is","Tap the 'Edit Player' Button to select a new person for that turn","Choose from Several options, the best option is always Previous Players","hoose how you want to resend the player the game invite","if available...Push Notifications are the best option"]
            images1Hidden = [true, true, true, true, true, true]
            images2Hidden = [true, true, true, true, true, true]
            imagesFullHidden = [false, false, false, false, false, false]
            imagesFull = ["Step11MyGamesNew.png","Step12MyGamesFull.png","Step13MyGamesFull.png","Step14MyGames.png","Step15MyGamesFull.png","Step15MyGamesFull2.png"]
            
    
            
        case "Taking A Turn":
            pageTitles = ["Taking A Turn","Taking A Turn","Taking A Turn"]
            images1 = ["","",""]
            images2 = ["Step18MyGamesNew.png","Step16MyGamesNew.png","Step17MyGamesNew.png"]
            LBL1text = ["","",""]
            LBL2text = ["When it's your turn you'll have the option to 'Take Turn'","'Please Wait' shows that it's currently someone else's turn","'Steal Turn' shows that the Time Limit has exceeded and anyone can take the turn"]
            images1Hidden = [true, true, true]
            images2Hidden = [true, true, true]
            imagesFullHidden = [false, false, false]
            imagesFull = ["Step18MyGamesNew.png","Step16MyGamesNew.png","Step17MyGamesNew.png"]
            
        case "Delete A Game":
            pageTitles = ["Delete A Game","Delete A Game","Delete A Game"]
            images1 = ["","",""]
            images2 = ["","",""]
            LBL1text = ["","",""]
            LBL2text = ["Swipe left on any game or tap the 'Delete Game' button at the bottom left","You can only delete games you created, but you can hide the games you didn't create","Tap the 'Reset' button to unhide all of your hidden games (this will not unhide deleted games)"]
            images1Hidden = [true, true, true]
            images2Hidden = [true,true, true]
            imagesFullHidden = [false, false, false]
            imagesFull = ["Step1Delete.png","Step26MyGames.png","Step3Delete.png"]
            
        case "Public Games":
            pageTitles = ["Public Games"]
            images1 = [""]
            images2 = [""]
            LBL1text = [""]
            LBL2text = ["View Open Public games by swiping left on the top bar, then select 'Take Turn' on any game."]
            images1Hidden = [true]
            images2Hidden = [true]
            imagesFullHidden = [false]
           // imagesFull = ["Step1Delete.png"]
            imagesFull = ["Step1PublicGames.png"]
            
        case "View Game Players":
            pageTitles = ["View Game Players"]
            images1 = [""]
            images2 = [""]
            LBL1text = [""]
            LBL2text = ["Tap the 'Players' button to see who is playing in this game"]
            images1Hidden = [true]
            images2Hidden = [true]
            imagesFullHidden = [false]
            imagesFull = ["Step1ViewGamePlayers.png"]
            
        case "Adding A Comment":
            pageTitles = ["Game Comments"]
            images1 = [""]
            images2 = [""]
            LBL1text = [""]
            LBL2text = ["To add a comment on a game tap the 'Comments' button"]
            images1Hidden = [true]
            images2Hidden = [true]
            imagesFullHidden = [false]
             imagesFull = ["Step1AddComment.png"]
            
        case "Poke Another Player":
            pageTitles = ["Poke Another Player","Poke Another Player"]
            images1 = ["",""]
            images2 = ["",""]
            LBL1text = ["","Choose how hard you want to 'Poke' the player.."]
            LBL2text = ["To let a player know it's their turn tap the 'Poke' button to poke a player","..each option shows the poked player a unique message"]
            images1Hidden = [true, true]
            images2Hidden = [true, true]
            imagesFullHidden = [false, false]
            imagesFull = ["Step1PokePlayer.png","Step7MyGamesFull.png"]
            
        case "My Game Menu":
            
            pageTitles = ["My Games", "My Games", "My Games", "My Games", "My Games","My Games", "My Games", "My Games", "My Games", "My Games","My Games", "My Games", "My Games", "My Games", "My Games","My Games", "My Games", "My Games", "My Games", "My Games","My Games", "My Games", "My Games", "My Games", "My Games", "My Games", "My Games", "My Games"]
            images1 = ["Step1MyGamesNEW.png","Step2MyGamesNew.png","Step3MyGamesNew.png","Step4MyGamesNew.png","Step5MyGamesNew.png","Step6MyGamesNew.png","Step7MyGamesNew.png","Step7MyGamesFull.png","Step8MyGamesNew.png","Step9MyGamesNew.png","Step9MyGamesFull.png","Step9MyGamesFull1.png","Step9MyGamesFull2.png","Step9MyGamesFull3.png","Step10MyGamesNew.png","Step11MyGamesNew.png","Step12MyGamesFull.png","Step13MyGamesFull.png","Step14MyGames.png","Step15MyGamesFull.png","Step15MyGamesFull2.png","Step16MyGamesNew.png","Step17MyGamesNew.png","Step18MyGamesNew.png","Step23MyGamesNew.png","Step24MyGamesNew.png","Step26MyGamesNew.png","Step25MyGamesNew.png"]
            
            images1Hidden = [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true]
            
            images2 = ["Step1MyGamesNEW.png","Step2MyGamesNew.png","Step3MyGamesNew.png","Step4MyGamesNew.png","Step5MyGamesNew.png","Step6MyGamesNew.png","Step7MyGamesNew.png","Step7MyGamesFull.png","Step8MyGamesNew.png","Step9MyGamesNew.png","Step9MyGamesFull.png","Step9MyGamesFull1.png","Step9MyGamesFull2.png","Step9MyGamesFull3.png","Step10MyGamesNew.png","Step11MyGamesNew.png","Step12MyGamesFull.png","Step13MyGamesFull.png","Step14MyGames.png","Step15MyGamesFull.png","Step15MyGamesFull2.png","Step16MyGamesNew.png","Step17MyGamesNew.png","Step18MyGamesNew.png","Step23MyGamesNew.png","Step24MyGamesNew.png","Step26MyGamesNew.png","Step25MyGamesNew.png"]
            
            images2Hidden = [false, false, false, false, false, false, false, true, false, false, true, true, true, true, false, false, true, true, false, true, true, false, false, false, false, false, true, false]
            
            imagesFull = ["Step1MyGamesNEW.png","Step2MyGamesNew.png","Step3MyGamesNew.png","Step4MyGamesNew.png","Step5MyGamesNew.png","Step6MyGamesNew.png","Step7MyGamesNew.png","Step7MyGamesFull.png","Step8MyGamesNew.png","Step9MyGamesNew.png","Step9MyGamesFull.png","Step9MyGamesFull1.png","Step9MyGamesFull2.png","Step9MyGamesFull3.png","Step10MyGamesNew.png","Step11MyGamesNew.png","Step12MyGamesFull.png","Step13MyGamesFull.png","Step14MyGames.png","Step15MyGamesFull.png","Step15MyGamesFull2.png","Step16MyGamesNew.png","Step17MyGamesNew.png","Step18MyGamesNew.png","Step23MyGamesNew.png","Step24MyGamesNew.png","Step26MyGamesNew.png","Step25MyGamesNew.png"]
            
            imagesFullHidden = [true, true, true, true, true, true, true, false, true, true, false, false, false, false, true, true, false, false, true, false, false, true, true, true, true, true, false, true]
            
            LBL1text = ["Go To the 'My Games' Menu to view your games.  Each game has several key items","The Game Title","The Current Turn Number","The Player who created the game","The name of the player with the current turn","The Turn Time Limit","Poke A Player...to have them take their turn","","The Comment Button...add and view comments on this game","This Game's Content Rating","","","","","Tap this button to view who is playing in this game with you","If you created this game you will show an 'Edit' option, here you can edit game players and resend them notifications","","","Choose from Several options, the best option is always Previous Players","","","'Please Wait' shows that it's currently someone else's turn","'Steal Turn' shows that the Time Limit has exceeded and anyone can take the turn","When it's your turn you'll have the option to 'Take Turn'","Use the search bar to search for games by Game Name","Delete a game by swiping left on the game or by tapping the 'Delete Game' button at the bottom","","To unhide all your hidden games just tap 'Reset' at the bottomw left"]
            
            if isFun.isEqual(to: "no") {
            LBL2text = ["","","","","","","","Choose how hard you want to 'Poke' the player, each option shows the poked player a unique message","","","The Content Rating Information Page","Easy","Medium","Hard","","","In Green you will see who's turn it is","Tap the 'Edit Player' Button to select a new person for that turn","","Choose how you want to resend the player the game invite", "if available...Push Notifications are the best option","","","","","","You can only delete games you started, but you can hide all the games you didn't start",""]
                
            } else {
            
            LBL2text = ["","","","","","","","Choose how hard you want to 'Poke' the player, each option shows the poked player a unique message","","","The Content Rating Information Page","Content for Everyone","Content for teenagers and above","Mature Content","","","In Green you will see who's turn it is","Tap the 'Edit Player' Button to select a new person for that turn","","Choose how you want to resend the player the game invite", "if available...Push Notifications are the best option","","","","","","You can only delete games you started, but you can hide all the games you didn't start",""]
                
            }
            
            
            //TAKING A TURN ITEMS
        case "Draw A Picture":
            pageTitles = ["Draw A Picture","Draw A Picture","Draw A Picture","Draw A Picture","Draw A Picture","Draw A Picture","Draw A Picture","Draw A Picture"]
            images1 = ["","","","","","","",""]
            images2 = ["","","","","","","",""]
            LBL1text = ["","","","","","","",""]
            LBL2text = ["Your drawing canvas...","Tap the photo icon to insert an image","Select an image from your photo album, google images, or take a picture with your camera","Select your painting tools","Choose a color or tap the resize icon to change your brush size...or even  create a new color","Move the sliders to adjust your brush and color settings","Undo Last Item","...and Erase All"]
            images1Hidden = [true, true,true,true,true, true, true,true]
            images2Hidden = [true, true,true,true,true, true, true,true]
            imagesFullHidden = [false, false, false, false, false, false, false, false]
            imagesFull = ["Step1Picture.png","Step2Picture.png","Step3Picture.png","Step6Picture.png","Step7Picture.png","Step8Picture.png","Step9Picture.png","Step10Picture.png"]
            
        case "Insert Quote":
            pageTitles = ["Insert Quote"]
            images1 = [""]
            images2 = [""]
            LBL1text = [""]
            LBL2text = ["Insert your text above or tap the music icon to insert an Audio clip"]
            images1Hidden = [true]
            images2Hidden = [true]
            imagesFullHidden = [false]
            imagesFull = ["Step1Quote.png"]
            
        case "Add Image":
            pageTitles = ["Add Image", "Add Image" ,"Add Image", "Add Image", "Add Image", "Add Image", "Add Image", "Add Image", "Add Image"]
            images1 = ["","","","","","","","",""]
            images2 = ["","","","","","","","",""]
            LBL1text = ["","","","","","","","",""]
            LBL2text = ["Tap the photo icon to insert an image","Select an image from your photo album, google images, or take a picture with your camera","From Google images, tap the Screen Grab Icon...then move and resize the box over the desired image","Tap the camera icon to capture the image","Tap the Green Check icon to import the captured image","To trim the image, tap the Trim Icon","Resize the image by pinching the screen, change the resize direction using the three resize buttons","Tap Paste to insert",""]
            images1Hidden = [true, true, true, true, true, true, true, true, true]
            images2Hidden = [true, true, true, true, true, true, true, true, true]
            imagesFullHidden = [false, false, false, false,false, false, false, false, false]
            imagesFull = ["Step2Picture.png","Step3Picture.png","Step4Picture.png","Step4Picture1.png","Step4Picture2.png","Step4Picture3.png","Step4Picture4.png","Step4Picture5.png","Step5Picture.png"]
            
        case "Add Audio":
            pageTitles = ["Add Audio","Add Audio","Add Audio","Add Audio","Add Audio","Add Audio","Add Audio"]
            images1 = ["","","","","","",""]
            images2 = ["","","","","","",""]
            LBL1text = ["","","","","","",""]
            LBL2text = ["Create an audio clip by tapping the Record or Music library icon","To select from your music library, tap 'Select Audio File'","To trim the audio file, tap 'Select Start Time'","Select the start time using the Star Time Picker...","..or tap and swipe the time sliders to adjust the Begin and End time","Once your time is selected, tap 'Trim Audio File'","After the Audio file is trimmed, tap 'Save'"]
            images1Hidden = [true, true,true,true,true, true, true]
            images2Hidden = [true, true,true,true,true, true, true]
            imagesFullHidden = [false, false, false, false, false, false, false]
            imagesFull = ["Step1NewAudioNew.png","Step2NewAudio.png","Step3NewAudio1.png","Step4NewAudio.png","Step5NewAudio.png","Step6NewAudio.png","Step7NewAudio.png"]

            
         //COMPLETED GAMES ITEMS
        case "Liking A Turn":
            pageTitles = ["Liking A Turn","Liking A Turn","Liking A Turn"]
            images1 = ["","",""]
            images2 = ["","",""]
            LBL1text = ["While viewing a completed game, tap the 'Like' button","Tap the Heart icon to see who else has liked this turn",""]
            LBL2text = ["","",""]
            images1Hidden = [true, true, true]
            images2Hidden = [true, true, true]
            imagesFullHidden = [false, false, false]
            imagesFull = ["Step2Completed.png","Step3Completed.png","Step4Completed.png"]
        
        case "Failing A Turn":
            pageTitles = ["Failing A Turn","Failing A Turn","Failing A Turn"]
            images1 = ["","",""]
            images2 = ["","",""]
            LBL1text = ["While viewing a completed game, tap the 'Fail' button","Tap the Thumbs Down icon to see who else has failed this turn",""]
            LBL2text = ["","",""]
            images1Hidden = [true, true, true]
            images2Hidden = [true, true, true]
            imagesFullHidden = [false, false, false]
            imagesFull = ["Step2Completed.png","Step5Completed.png","Step6Completed.png"]
            
        case "Sharing":
            pageTitles = ["Sharing A Game","Sharing A Game","Sharing A Game","Sharing A Game","Sharing A Game","Sharing A Game","Sharing A Game","Sharing A Game","Sharing A Game"]
            images1 = ["","","","","","","","",""]
            images2 = ["","","","","","","","",""]
            LBL1text = ["Tap the Upload icon to share this turn!","","","","","","","Wait will your Video is created...",""]
            LBL2text = ["","Sharing on Facebook will earn you tokens!","Sharing on Twitter will also earn you tokens!","Send as a text message","Share on Instagram","Save to your photo album","Or Convert all of this games turns into a VIDEO!","","...once created, you can select how to share the video"]
            images1Hidden = [true, true, true, true, true, true, true, true, true]
            images2Hidden = [true, true, true, true, true, true, true, true, true]
            imagesFullHidden = [false, false, false, false, false, false, false, false, false]
            imagesFull = ["Step8Completed.png","FullStep9Completed.png","FullStep10Completed.png","FullStep11Completed.png","FullStep12Completed.png","FullStep13Completed.png","FullStep14Completed.png","Step15Completed.png","FullStep16Completed.png"]
            
        case "Content Settings":
            pageTitles = ["Content Settings","Content Settings"]
            images1 = ["",""]
            images2 = ["",""]
            LBL1text = ["Concerned about who will see this?",""]
            LBL2text = ["Tap the World Icon to change who can see this turn on the Leaderboards","Select your Content Privacy Setting"]
            images1Hidden = [true, true]
            images2Hidden = [true, true]
            imagesFullHidden = [false, false]
            imagesFull = ["Step17Completed.png","Step18Completed.png"]
            
        case "My Toolbox":
            pageTitles = ["My Toolbox","My Toolbox"]
            images1 = ["",""]
            images2 = ["",""]
            LBL1text = ["",""]
            LBL2text = ["Insert Images and Audio clips without having Tokens",""]
            images1Hidden = [true, true]
            images2Hidden = [true, true]
            imagesFullHidden = [false, false]
            imagesFull = ["",""]
            
        case "Viewing A Game":
            
            pageTitles = ["Completed Games"]
            images1 = ["Step1Completed.png"]
            
            images1Hidden = [true]
            
            
            
            images2 = ["Step1Completed.png"]
            images2Hidden = [true]
            
            
            // imagesFullHidden = [true, true, true, true, true, true, true, true, false, false, false, false, false, false, true, false, true, true, true]
            
            
            LBL2text = ["Tap 'View Game' from the 'My Games' menu"]
            
            LBL1text = [""]
            
            imagesFull = ["Step1Completed.png"]
            
            imagesFullHidden = [false]
            
        case "Completed Games":
            
            pageTitles = ["Completed Games", "Completed Games", "Completed Games", "Completed Games", "Completed Games", "Completed Games", "Completed Games", "Completed Games", "Completed Games", "Completed Games", "Completed Games", "Completed Games", "Completed Games", "Completed Games", "Completed Games", "Completed Games", "Completed Games", "Completed Games", "Completed Games"]
            images1 = ["Step1Completed.png","Step2Completed.png","Step3Completed.png","Step4Completed.png","Step5Completed.png","Step6Completed.png","Step7Completed.png","Step8Completed.png","FullStep9Completed.png","FullStep10Completed.png","FullStep11Completed.png","FullStep12Completed.png","FullStep13Completed.png","FullStep14Completed.png","Step15Completed.png","FullStep16Completed.png","Step17Completed.png","Step18Completed.png","Step19Completed.png"]
            
            images1Hidden = [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true]
            
            
            
            images2 = ["Step1Completed.png","Step2Completed.png","Step3Completed.png","Step4Completed.png","Step5Completed.png","Step6Completed.png","Step7Completed.png","Step8Completed.png","FullStep9Completed.png","FullStep10Completed.png","FullStep11Completed.png","FullStep12Completed.png","FullStep13Completed.png","FullStep14Completed.png","Step15Completed.png","FullStep16Completed.png","Step17Completed.png","Step18Completed.png","Step19Completed.png"]
            images2Hidden = [false, false, false, true, false, true, false, false, true, true, true, true, true, true, false, true, false, true, false]
            
            
            // imagesFullHidden = [true, true, true, true, true, true, true, true, false, false, false, false, false, false, true, false, true, true, true]
            
            
            LBL1text = ["Tap 'View Game' from the 'My Games' menu","Once loaded, swipe the screen to view each turn.  Don't forget to 'Like' or 'Fail' the turns as you view them.","Tap the Heart icon to view who else has 'Liked' this turn","","Or tap the 'Thumbs Down' Icon to see who has 'Failed' it","","Add a Comment to the game by tapping the 'Comment' Icon","Share the Laughs with your friends, by tapping the Share icon","","","","","","","Wait while your game is converted, the is the only way to share games with Clips of Audio","","Tap the World Icon to change who can see this turn on the Leaderboards","","And You can always tap the player's name to view their user profile"]
            
            LBL2text = ["","","","","","","","","Share on Facebook and you earn tokens!","Share on Twitter and you earn tokens!","Send as a text message","Share on Instagram","Save to your photo album","Or Convert all of this games turns into a VIDEO!","","Once Created, select how you want to share the video","","Select your Content Privacy Setting",""]
            
            imagesFull = ["Step1Completed.png","Step2Completed.png","Step3Completed.png","Step4Completed.png","Step5Completed.png","Step6Completed.png","Step7Completed.png","Step8Completed.png","FullStep9Completed.png","FullStep10Completed.png","FullStep11Completed.png","FullStep12Completed.png","FullStep13Completed.png","FullStep14Completed.png","Step15Completed.png","FullStep16Completed.png","Step17Completed.png","Step18Completed.png","Step19Completed.png"]
            
            imagesFullHidden = [true, true, true, false, true, false, true, true, false, false, false, false, false, false, true, false, true, false, true]

            
        default:
            print("error loading Page content")
        }
        
        
      
      // navigationController!.navigationBar.barTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
        
        
        /*
        self.title = "How To Play"
        
        if let font = UIFont(name: "DK Cool Crayon", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.whiteColor()]
        }
       */
        /*
        if self.revealViewController() != nil {
        menuButton.target = self.revealViewController()
        menuButton.action = "revealToggle:"
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
*/
        
        
    reset()
    }
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
       // return pageTitles.count
        return images1.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    
    var index = (viewController as! HowToContentViewController).pageIndex
    index += 1
    if(index == self.images1.count){
    return nil
    }
    return self.viewControllerAtIndex(index)
    
    }
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
    var index = (viewController as! HowToContentViewController).pageIndex
    if(index == 0){
    return nil
    }
    index -= 1
    return self.viewControllerAtIndex(index)
    
    }
    
    
    
    func viewControllerAtIndex(_ index : Int) -> UIViewController? {
    if((self.pageTitles.count == 0) || (index >= self.pageTitles.count)) {
    return nil
    }
    let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "HowToContentViewController") as! HowToContentViewController
    //pageContentViewController.imageName = self.images[index]
    pageContentViewController.titleText = self.pageTitles[index] as String
    pageContentViewController.pageIndex = index
    pageContentViewController.LBL1text = self.LBL1text[index] as String
    pageContentViewController.LBL2text = self.LBL2text[index] as String
    pageContentViewController.imageTOPname = self.images1[index]
    pageContentViewController.imageBOTTOMname = self.images2[index]
    pageContentViewController.IMG1hidden  = self.images1Hidden[index]
    pageContentViewController.IMG2hidden  = self.images2Hidden[index]
    pageContentViewController.IMGfullname  = self.imagesFull[index]
    pageContentViewController.IMGfullHidden  = self.imagesFullHidden[index]
        return pageContentViewController
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
