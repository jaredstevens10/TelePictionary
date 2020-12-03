//
//  NewPorQViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 9/16/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import CoreData

protocol NewPorQViewControllerDelegate: class {
    func NewPorQViewControllerFinished(_ newporqviewController: NewPorQViewController)
}

class NewPorQViewController: UIViewController {
    
    var cView: UIView = UIView()
    
    
    var QuoteSelected = NSString()
    
    var PQInt = Int()
    
    @IBOutlet weak var theView: UIView!
    var porqdelegate: NewPorQViewControllerDelegate?
    
    /*
    init() {
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = UIModalPresentationStyle.Custom
        //createUI()
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cView.translatesAutoresizingMaskIntoConstraints = false
        //cView.backgroundColor = UIColor(white: 0.0, alpha: 0.8)
        //view.addSubview(cView)
        
      //  theView.backgroundColor = UIColor(white: 0.0, alpha: 0.8)
        
       // theView.layer.borderWidth = 1
        
        
        self.view.backgroundColor = UIColor.clear
        /*
        let blurEffect = UIBlurEffect(style: .Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        self.view. = blurEffectView
        
*/

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func PicSelected(_ sender: AnyObject) {
        
        PQInt = 1
        
       self.dismiss(animated: true, completion: nil) 
    }
    
    
    @IBAction func QuoteSelected(_ sender: AnyObject) {
        
        PQInt = 0
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func selectQuote() {
        
        
        self.dismiss(animated: true, completion: nil)
        
        self.porqdelegate?.NewPorQViewControllerFinished(self)
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
