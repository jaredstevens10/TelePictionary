//
//  FriendsViewController.swift
//  
//
//  Created by Jared Stevens on 7/9/15.
//
//

import UIKit

class FriendsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    let addressBook = APAddressBook()
    var contactPhoneNames: [String] = []
    var contactPhoneNumbers: [String] = []
    var lastUpdated: Dictionary<String,String> = [:]
    var moods: Dictionary<String,String> = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
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
