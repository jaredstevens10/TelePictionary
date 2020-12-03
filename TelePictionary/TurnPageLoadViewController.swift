//
//  TurnPageLoadViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 3/8/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class TurnPageLoadViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var MediaTypeArray = [NSString]()
    var NewTurnNumberArray = [NSString]()
    
    
    var FollowTurnIDArray = [TurnSearchInfoFollow]()
    var PhotoIndex = Int()
    
    var pageViewController2 : UIPageViewController!
    var firstViewController: UIViewController?
    
    var pages = [String]()
    
    var TurnImages = [UIImage]()
    var PreviousTurnImage = [UIImage]()
    
    
    
    var pageIndex = Int()
    
    @IBOutlet weak var ReportView: UIView!
    var IsMyTurns = Bool()
    @IBOutlet weak var mainView: UIView!
    var MainImage = UIImage()
    var MainImageURL = String()
    var PreviousImage = UIImage()
    var NewTurnNumber = String()
    //var Player1: AVAudioPlayer!
    //var PlayerMain: AVAudioPlayer!
    var AudioData = Data()
    var AudioDataURL = String()
    var testData = Data()
    var TurnInfo = NSString()
    
    @IBOutlet weak var audioBTN: UIButton!
    @IBOutlet weak var audioBTNMAIN: UIButton!
    
    
    
    var HidePreviousAudio = Bool()
    var HideCurrentAudio = Bool()
    
    var MediaType = String()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("THE TOTAL TURNS TO VIEW ARRAY = \(FollowTurnIDArray)")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        pageViewController2 = self.storyboard?.instantiateViewController(withIdentifier: "TurnsPageViewController") as! UIPageViewController
        
        self.pageViewController2.dataSource = self
        
       // let pageContentViewController = self.viewControllerAtIndex(0)
        let pageContentViewController = self.viewControllerAtIndex(PhotoIndex)
        self.pageViewController2.setViewControllers([pageContentViewController!], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        
        /* We are substracting 30 because we have a start again button whose height is 30*/
        self.pageViewController2.view.frame = CGRect(x: 0, y: 60, width: self.view.frame.width, height: self.view.frame.height - 35)
        self.addChild(pageViewController2)
        self.view.addSubview(pageViewController2.view)
        self.pageViewController2.didMove(toParent: self)
    }
    
    @IBAction func start(_ sender: AnyObject) {
        let pageContentViewController = self.viewControllerAtIndex(PhotoIndex)
       // let pageContentViewController = self.viewControllerAtIndex(0)
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

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! CollectionImageViewController).pageIndex
        index += 1
        
        print("index: \(index)")
        let countind = self.FollowTurnIDArray.count
        print("images count: \(countind)")
        
        
        if(index == self.FollowTurnIDArray.count){
            return nil
        }
        
        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! CollectionImageViewController).pageIndex
        //PhotoIndex = index
        if(index == 0){
            return nil
        }
        index -= 1
        return self.viewControllerAtIndex(index)
        
    }
    
    func viewControllerAtIndex(_ index : Int) -> UIViewController? {
        print("View Controller total count should be = \(self.FollowTurnIDArray.count)")
        
        print("View controller at index: \(index.description)")
        
        if((self.FollowTurnIDArray.count == 0) || (index >= self.FollowTurnIDArray.count)) {
            return nil
            
        }
        
        
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "TurnsViewController") as! CollectionImageViewController
        pageContentViewController.FromFollowingTurns = true
        
        pageContentViewController.CurrentPhotInfo = FollowTurnIDArray[index]
        
        pageContentViewController.pageIndex = index
        
        PhotoIndex = index
        
       // pageContentViewController.pageIndex = PhotoIndex
        
        /*
        pageContentViewController.imageName = self.images[index]
        
        //    pageContentViewController.QuoteImageName = self.QuoteBox[index]
        
        pageContentViewController.titleText = self.TitleLBLs[index] as String
        pageContentViewController.Label3Text = self.testLabel[index]
        pageContentViewController.ImageTitleText = self.testLabel2[index]
        pageContentViewController.pageIndex = index
        pageContentViewController.HowToPic = self.HowToPics[index]
        pageContentViewController.ShowHowToPic = self.ShowHowToPicArray[index]
        
        pageContentViewController.ShowLogo = self.ShowLogoImage[index]
        
        pageContentViewController.HowToText = label2[index] as String
        pageContentViewController.PlayHidden = PlayHidden[index]
        
        pageContentViewController.theLogo = LogoImages[index]
        pageContentViewController.ShowSwipe = ShowSwipe[index]
        
        */
        //   pageContentViewController.ImageFrame = self.FrameImages[index]
        
        return pageContentViewController
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return FollowTurnIDArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        print("Returning PhotoIndex = \(PhotoIndex)")
        return PhotoIndex
       // return 0
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
