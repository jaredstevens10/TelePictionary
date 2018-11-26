//
//  TableViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/9/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    // MARK: - Table view data source

   
    
    //@IBOutlet weak var TableView: UITableView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    let addressBook = APAddressBook()

    var contactPhoneNames: [String] = []
    var contactPhoneNumbers: [String] = []
    var lastUpdated: Dictionary<String,String> = [:]
    var moods: Dictionary<String,String> = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       // var cell:UITableViewCell = self.dequeueReusableCellWithIdentifier("BasicCell") as! UITableViewCell
        return UITableViewCell()
      //  cell.textLabel?.text = self.GameNameInfo[indexPath.row] as String
        
      //  return cell
    }
    
    
    
    
    func addNamesAndNumbersFromAddressBook(contact: AnyObject) {
        let name = getPersonsName(contact)
        let number = getPersonsNumber(contact)
        let nameIndex = getAlphabeticalIndex(name)
        contactPhoneNames.insert(name,atIndex: nameIndex)
        contactPhoneNumbers.insert(number, atIndex: nameIndex)
    }
    
    func getAlphabeticalIndex(name: String) -> Int {
        if(contactPhoneNames.count == 0) {
            return 0
        }
        for var index = 0; index < contactPhoneNames.count; ++index {
            if(name < contactPhoneNames[index]) {
                return index
            }
        }
        return contactPhoneNames.count

    }
    
    func getPersonsName(contact: AnyObject) -> String {
        var name = ""
        if(contact.firstName! != nil) {
            name += "\(contact.firstName) "
        }
        if(contact.lastName! != nil) {
            name += "\(contact.lastName)"
        }
        return name
    }
    
    func getPersonsNumber(contact: AnyObject) -> String {
        if let numberRaw = contact.phones![0] as? String {
            return handleRawNumberSting(numberRaw)
        }
        return " "
    }
    
    func handleRawNumberSting(numberRaw: String) -> String {
        let numberComponents = numberRaw.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
        var numberClean = ""
        for(var i = 0; i < numberComponents.count; i++) {
            numberClean += numberComponents[i]
        }
        return numberClean
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

    
    


