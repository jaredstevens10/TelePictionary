//
//  MessageGameViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 10/26/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import Messages

class MessageGameViewController: MSMessagesAppViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backbtn(_ sender: AnyObject) {
        
        
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   // extension MessagesViewController: BuildIceCreamViewControllerDelegate {
    
    /*
        func buildIceCreamViewController(_ controller: BuildIceCreamViewController, didSelect iceCreamPart: IceCreamPart) {
 
 */
    
        
    //}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
