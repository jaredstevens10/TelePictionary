//
//  SignUpPageViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 2/24/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class SignUpPageViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate  {

    var pageViewController2 : UIPageViewController!
    var pages = [Int]()
    
    
    @IBAction func swipeLeft(_ sender: AnyObject) {
        print("Swipe left")
    }
    @IBAction func swiped(_ sender: AnyObject) {
        
        
        self.pageViewController2.view .removeFromSuperview()
        self.pageViewController2.removeFromParent()
        
        reset()
        
        print("Index is \(index)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WelcomeViewController).pageIndex
        index += 1
        
        print("index: \(index)")
        
        /*
        let countind = self.images.count
        print("images count: \(countind)")
        
        
        if(index == self.images.count){
            return nil
        }
        
        */
        
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
        
        
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        
        
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
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
