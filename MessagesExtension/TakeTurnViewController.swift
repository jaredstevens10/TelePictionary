//
//  TakeTurnViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 10/27/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class TakeTurnViewController: UIViewController {
    
    
    static let storyboardIdentifier = "TakeTurnViewController"
    
    weak var delegate: TakeTurnViewControllerDelegate?
    
    
    var TurnStats: GameBoard? {
        
        didSet {
           // guard let turnInfo = GameBoard? else { return }
            
            //if GameBoard.
            
            // Determine the ice cream parts to show in the collection view.
            /*
            if iceCream.base == nil {
                iceCreamParts = Base.all.map { $0 }
                prompt = NSLocalizedString("Select a base", comment: "")
            }
            else if iceCream.scoops == nil {
                iceCreamParts = Scoops.all.map { $0 }
                prompt = NSLocalizedString("Add some scoops", comment: "")
            }
            else if iceCream.topping == nil {
                iceCreamParts = Topping.all.map { $0 }
                prompt = NSLocalizedString("Finish with a topping", comment: "")
            }
            
            */
        }
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol TakeTurnViewControllerDelegate: class {
    /// Called when the user taps to select an `IceCreamPart` in the `BuildIceCreamViewController`.
    func takeTurnViewController(_ controller: TakeTurnViewController, didSelect previousTurn: TurnInfo)
}

