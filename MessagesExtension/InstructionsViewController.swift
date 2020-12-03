//
//  InstructionsViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 11/27/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var InstructionText = ["First, add a few friends to the text message", "Start a new game...either selecting the Picture or the Quote button", "If you select a picture first, the next player will enter a quote to describe your picture.  If you select a quote first, the next player will add a picture that best interperates your quote.", "Once you submit your turn, the first person to tap the text message will go next.", "Back and forth..Quote, Picture, Quote, Picture...", "The Game ends after 10 turns are taken, tap the 'Completed Game' and check out how each turn was interpreted","Also...Check out the full version of Pics&Quotes on the App Store for tons of other features"]
    var InstructionImages = [UIImage(named: "num1.png"), UIImage(named: "num2.png"),UIImage(named: "num3.png"),UIImage(named: "num4.png"),UIImage(named: "num5.png"),UIImage(named: "num6.png"),UIImage(named: "num7.png")]
    
    
    @IBOutlet weak var TableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.TableView.separatorStyle = UITableViewCellSeparatorStyle.none
        TableView.delegate = self
        TableView.dataSource = self
        self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return InstructionText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
        //cell.Turn1ImageBack.hidden = true
        // cell.Turn1Image?.hidden = true
      //  cell.Turn1Image?.contentMode = UIViewContentMode.scaleAspectFit
        cell.titleLabel.text = InstructionText[indexPath.row] as String
        cell.TableImage.image = InstructionImages[indexPath.row]! as UIImage
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.cellViewBG.layer.backgroundColor = UIColor.white.cgColor

        
        
       // cell.TurnByLBL.text = "Player: \(MyTurnData.playerName)"
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func closeBTN(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }

}
