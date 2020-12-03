//
//  FirstLoadViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 8/30/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit

class FirstLoadViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate  {
    
    var label3 = [NSString]()
    var label2 = [NSString]()
    var testLabel = [NSString]()
    var username = NSString()
    var HowToLBLs = [NSString]()
    var HowToPics = [UIImage]()
    var pages = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    var ShowHowToPicArray = [true, false, false, false, false, false, false, true, true]
    var ShowLogoImage = [false, true, true, true, true, true, true, true, true]
    var ShowSwipe = [true, true, true, true, true, true, true, false, false]
    var PlayHidden = [true, true, true, true, true, true, true, true, true]
    
    var testLabel2 = [NSString]()
    
    var TitleLBLs = [NSString]()
    
    var users = [NSString]()
    
    var images = [UIImage]()
    var CP = UIImage(named: "chalkboard bg.png")
    var HowTo1 = UIImage(named: "HowTo1VV.png")
    var HowTo2 = UIImage(named: "HowTo2VV.png")
    var HowTo3 = UIImage(named: "HowTo3VV.png")
    var HowTo2_2 = UIImage(named: "HowTo2-2VV.png")
    var HowTo3_2 = UIImage(named: "HowTo3-2V.png")
    var BlankImage = UIImage()
    
    var LogoImages = [UIImage]()
    var LogoImage = UIImage(named: "PQPhoto2.png")
    
    var pageViewController2 : UIPageViewController!
    
    @IBOutlet weak var TitleLBL: UILabel!
    let Title: NSString = "Pics & Quotes"
  //  @IBOutlet weak var ContainerView: UIView!
    
    @IBOutlet weak var bgImage: UIImageView!
    var firstViewController: UIViewController?
    
    @IBOutlet weak var closeBTN: UIButton!
    
    /*
    private var activeViewController: UIViewController? {
        didSet{
            removeInactiveViewController(oldValue)
            updateActiveViewController()
        }
    }
    */
    
    @IBAction func swipeLeft(_ sender: AnyObject) {
        print("Swipe left")
    }
    @IBAction func swiped(_ sender: AnyObject) {
        
        
        self.pageViewController2.view .removeFromSuperview()
        self.pageViewController2.removeFromParent()
        reset()
        print("Index is \(index)")
    }
    
    /*
    func FBShare(theImage: UIImage) {
    let photo : FBSDKSharePhoto = FBSDKSharePhoto()
    photo.image = theImage as UIImage
    photo.userGenerated = true
    let content : FBSDKSharePhotoContent = FBSDKSharePhotoContent()
    content.photos = [photo]
    }
    */
    
    
    func reset() {
        /* Getting the page View controller */
        
        pageViewController2 = self.storyboard?.instantiateViewController(withIdentifier: "WelcomePageViewController") as! UIPageViewController
        
        self.pageViewController2.dataSource = self
        
        let pageContentViewController = self.viewControllerAtIndex(0)
        
        self.pageViewController2.setViewControllers([pageContentViewController!], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        
        /* We are substracting 30 because we have a start again button whose height is 30*/
        self.pageViewController2.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.addChild(pageViewController2)
        self.view.addSubview(pageViewController2.view)
        self.pageViewController2.didMove(toParent: self)
    }
    
    @IBAction func start(_ sender: AnyObject) {
        let pageContentViewController = self.viewControllerAtIndex(0)
        
        self.pageViewController2.setViewControllers([pageContentViewController!], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
    }
    /*
    override func viewDidLoad() {
    super.viewDidLoad()
    //  reset()
    }
    */
    override func viewDidAppear(_ animated: Bool) {
        reset()
    }
    
    override func viewDidLoad() {
        
        print("Page Intro loaded")
        
        label2.append("")
        label2.append("The game begins with any player (in this case, you) choosing a quote.  The 'Quote' can be anything...it can be from a song, a movie, or just something you made up.  Below is an example, let's see how the game goes...")
        label2.append("The next player will then draw a picture based on the quote they received from the first player.  See below, the initial quote and the picture drawn by player 2.")
        label2.append("ONLY seeing the immediate turn before (the picture), Player 3 will then write a quote based on the picture from the previous turn.  This continues, back and forth (quote, picture, quote, picture...) until each player has taken their turn.")
        label2.append("BUT WAIT...In Pics & Quotes you are not limited to simply drawing a picture or describing a picture with a quote...THIS IS WHERE IT GETS EXCITING. let's take a look, using the same quote as before...")
        label2.append("Instead of HAVING to draw a picture you now have the wonderful option of importing an image from your photos or even using your camera.  Also you don't have to start the game with a quote, you can start with an image instead")
        label2.append("As you can imagine...there are now so many more possibilities for hilarous outcomes...BUT WAIT there is even more")
        label2.append("instead of just describing an image with a quote...How about inserting a AUDIO CLIP from a song or just recording yourself.  ")
        label2.append("")

        
        label3.append("")
        label3.append("This will start the game. The next player will then either describe the Image player 1 selected or draw a picture based off their quote. BUT WAIT..")
        label3.append("instead of drawing a picture you may use your camera to take pictures or insert an image from your photo album.")
        
        label3.append("...or select and trim music from your music library.")
        label3.append("")
        label3.append("")
        label3.append("")
        label3.append("")
        label3.append("")
        
        
        testLabel.append("Pics & Quotes, a game inspired by the classic game 'TelePhone Pictionary'.  Let's learn how to play and why this version of the classic game is extra exciting")
        
        
        testLabel.append("")
        testLabel.append("")
        testLabel.append("")
        testLabel.append("")
        testLabel.append("")
        testLabel.append("")
        testLabel.append("And sometimes regular pictures are just boring, insert a Gif image instead!")
        testLabel.append("Once you complete a game, everyone will get to see the results.  When reviewing a completed game, don't forget to 'Like' or 'Fail' other people's turns.  Check out who has the most 'Likes' and 'Fails' on the game leaderboard!")
        
        
        testLabel2.append("")
      
        testLabel2.append("The Quote...Example 1")
        testLabel2.append("")
        testLabel2.append("")
        testLabel2.append("The Quote...Example 2")
        testLabel2.append("")
        testLabel2.append("")
        testLabel2.append("")
        testLabel2.append("")
        
        images.append(CP!)
        images.append(CP!)
        images.append(CP!)
        images.append(CP!)
        images.append(CP!)
        images.append(CP!)
        images.append(CP!)
        images.append(CP!)
        images.append(CP!)
        
        
        LogoImages.append(LogoImage!)
        LogoImages.append(LogoImage!)
        LogoImages.append(LogoImage!)
        LogoImages.append(LogoImage!)
        LogoImages.append(LogoImage!)
        LogoImages.append(LogoImage!)
        LogoImages.append(LogoImage!)
        LogoImages.append(LogoImage!)
        LogoImages.append(LogoImage!)
        
       // HowToLBLs.append(label2!)
       // HowToLBLs.append(label)
        HowToPics.append(HowTo1!)
        HowToPics.append(HowTo1!)
        HowToPics.append(HowTo2!)
        HowToPics.append(HowTo3!)
        HowToPics.append(HowTo1!)
        HowToPics.append(HowTo2_2!)
        HowToPics.append(HowTo3_2!)
        HowToPics.append(HowTo2_2!)
        HowToPics.append(HowTo3_2!)
        
        
        TitleLBLs.append("Pics & Quotes")
        TitleLBLs.append("")
        TitleLBLs.append("")
        TitleLBLs.append("")
        TitleLBLs.append("")
        TitleLBLs.append("")
        TitleLBLs.append("")
        TitleLBLs.append("")
        TitleLBLs.append("")

        
        
        if Reachability.isConnectedToNetwork() {
            
    
            
            let prefs:UserDefaults = UserDefaults.standard
            
            if prefs.value(forKey: "USERNAME") == nil {
               username = ""
                
            } else {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            }
  
        }
            
        else
            
        {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Network Error"
            alertView.message = "Please Confirm your network settings"
            alertView.delegate = self
            
            alertView.addButton(withTitle: "OK")
            alertView.show()
        }
        
        //createPhotoReel()
    }
  



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func CloseBTN(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WelcomeViewController).pageIndex
        index += 1
        
        print("index: \(index)")
        let countind = self.images.count
        print("images count: \(countind)")
        
        
        if(index == self.images.count){
            return nil
        }

        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WelcomeViewController).pageIndex
        if(index == 0){
            return nil
        }
        index -= 1
        return self.viewControllerAtIndex(index)
        
    }
    
    func viewControllerAtIndex(_ index : Int) -> UIViewController? {
        if((self.pages.count == 0) || (index >= self.pages.count)) {
            return nil
            
        }
        
        
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
        
        pageContentViewController.imageName = self.images[index]
        
        //    pageContentViewController.QuoteImageName = self.QuoteBox[index]
        
        var TitleLBLsTemp = self.TitleLBLs[index] as NSString
        var lable2Temp = label2[index] as NSString
        
        pageContentViewController.titleText = TitleLBLsTemp as NSString
        pageContentViewController.Label3Text = self.testLabel[index]
        pageContentViewController.ImageTitleText = self.testLabel2[index]
        pageContentViewController.pageIndex = index
        pageContentViewController.HowToPic = self.HowToPics[index]
        pageContentViewController.ShowHowToPic = self.ShowHowToPicArray[index]
        
        pageContentViewController.ShowLogo = self.ShowLogoImage[index]
        
        pageContentViewController.HowToText = lable2Temp as NSString
        pageContentViewController.PlayHidden = PlayHidden[index]
        
        pageContentViewController.theLogo = LogoImages[index]
        pageContentViewController.ShowSwipe = ShowSwipe[index]
        //   pageContentViewController.ImageFrame = self.FrameImages[index]
        
        return pageContentViewController
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
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
