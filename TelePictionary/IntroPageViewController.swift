//
//  IntroPageViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 8/30/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit

class IntroPageViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    
    @IBOutlet weak var testImageView: UIImageView!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    var strLabel = UILabel()
    var messageFrame = UIView()
    
    var ActivityInd = UIActivityIndicatorView()
    
    var QBoxImage = UIImage(named: "QuoteBoxImage.png")

    
    var testLabel = [NSString]()
    
    //[ UIImage(named: "QuoteBoxImage.png"), UIImage(named: "QuoteBoxImage.png"), UIImage(named: "QuoteBoxImage.png"), UIImage(named: "QuoteBoxImage.png"), UIImage(named: "QuoteBoxImage.png"), UIImage(named: "QuoteBoxImage.png"), UIImage(named: "QuoteBoxImage.png"), UIImage(named: "QuoteBoxImage.png"), UIImage(named: "QuoteBoxImage.png"), UIImage(named: "QuoteBoxImage.png") ]
    //  @IBOutlet weak var loadingRing: UIActivityIndicatorView!
    
    var GAME_ID = NSString()
    
    
    var Turn1Quote = NSString()
    var Turn2Image = UIImage()
    var Turn3Quote = NSString()
    var Turn4Image = UIImage()
    var Turn5Quote = NSString()
    var Turn6Image = UIImage()
    var Turn7Quote = NSString()
    var Turn8Image = UIImage()
    var Turn9Quote = NSString()
    var Turn10Image = UIImage()
    
    
    var count = 0
    
    var TurnUser = NSString()
    var GameData = [NSArray]()
    var Game_Data_Array = [NSString]()
    
    var username = NSString()
    
    var GameIDInfo = NSString()
    

    
    var images = [UIImage]()
    
    var Quotes = [NSString]()
    var pageTitles = [NSString]()
    var users = [NSString]()
    
    //  var images = ["pencilpic.png","pencilpic.png","pencilpic.png","pencilpic.png"]
    
    //   let pageTitles = ["Title 1", "Title 2", "Title 3", "Title 4"]
    
    var GameNameInfo = NSString()
    
    var pageViewController2 : UIPageViewController!
    
    func progressBarDisplayer(_ msg:String, _ indicator:Bool){
        print(msg)
        strLabel = UILabel(frame: CGRect(x:50, y: 0, width: 200, height: 50))
        strLabel.text = msg
        strLabel.textColor = UIColor.darkGray
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
        self.pageViewController2.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 50)
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
        
        testLabel.append("1")
        testLabel.append("2")
        testLabel.append("3")
        
        
        if Reachability.isConnectedToNetwork() {
            
            //    println("is connected")
            //    progressBarDisplayer("Getting Game Data", true)
            //images = ["",Turn2Image,"",Turn4Image,"",Turn6Image,"",Turn8Image,"",Turn10Image]
            
            
            //  self.TableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
            
            // var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
            // view.addGestureRecognizer(tap)
            
            let prefs:UserDefaults = UserDefaults.standard
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            
          //  var URLData = CompleteGameData(GAME_ID)
            //println(test)
           // var GameInfo = FilterGameData(URLData)
            
           // println("Game Info: \(GameInfo)")
            
            //QuoteBox.append(QBoxImage!)
            
                       /*
            TurnNumberInfo = GameInfo[12] as! [(NSString)]
            IsCompleteInfo = GameInfo[13] as! [(NSString)]
            UsersTurnInfo = GameInfo[14] as! [(NSString)]
            */
            
            
            
            
        
                
                print("Picture style game")
                
            
                
               // images

            
            /*
            dispatch_async(dispatch_get_main_queue()) {
            self.messageFrame.removeFromSuperview()
            }       // loadingRing.stopAnimating()
            */
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
        if((self.users.count == 0) || (index >= self.users.count)) {
            return nil
            
        }
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
        
        pageContentViewController.imageName = self.images[index]
        
    //    pageContentViewController.QuoteImageName = self.QuoteBox[index]
        
     //   pageContentViewController.titleText = self.users[index] as String
    //    pageContentViewController.QuoteText = self.Quotes[index] as String
        pageContentViewController.pageIndex = index
     //   pageContentViewController.ImageFrame = self.FrameImages[index]
        
        return pageContentViewController
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return users.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
    
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if error == nil {
            let ac = UIAlertController(title: "Saved!", message: "Done", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }
    

    
    @IBAction func BackBTN(_ sender: AnyObject) {
        print("back button pressed")
        
        // self.dismissViewControllerAnimated(true, completion: nil)
        self.performSegue(withIdentifier: "restart", sender: self)
        
        
    }
    
    
    func getImageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0,y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
        
    }
    
}
