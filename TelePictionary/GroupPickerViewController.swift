//
//  GroupPickerViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 8/16/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import CoreData

protocol GroupPickerViewControllerDelegate: class {
    func GroupPickerViewControllerFinished(_ grouppickerviewController: GroupPickerViewController)
}

class GroupPickerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var adelegate: GroupPickerViewControllerDelegate?
    
    var GroupData = [NSArray]()
    
    var theGroups = [MyFriends]()
    
    var Groups = [NSManagedObject]()
    var GroupsName = [NSString]()
    //var FriendsEmail = [NSString]()
    var NameTable = [NSString]()
    var GroupsInfo = [NSString]()
    //var EmailTable = [NSString]()
    var NameInfo = [NSString]()
    var numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    var NumSelected = [Int]()
    var GroupCount = [NSString]()
    var varNumGroups = Int()
    var TheGroup = NSString()
    var GroupSelected = Bool()
    
    var numGroups = Int()
    
    var GroupName = NSString()
    
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")        
        TableView.dataSource = self
        TableView.delegate = self
        self.TableView.separatorStyle = UITableViewCellSeparatorStyle.none        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.NameTable.count;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
         let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Group")
       // let fetchRequest = NSFetchRequest(entityName: "Group")
        let error: NSError?
        do {
        let fetchedResults = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
        
        
        
        if let results = fetchedResults {
            Groups = results
            print(Groups)
            
            
            
            for items in Groups as [NSManagedObject] {
                
                let FName = items.value(forKey: "groupname") as! String
                
               // var EmailAdd = items.valueForKey("email") as! String
                
                print(items)
                //println(items.valueForKey("groupname")!)
                
                NameTable.append(FName as NSString)
                //EmailTable.append(EmailAdd)
                GroupsName.append("NA")
                //FriendsEmail.append("NA")
                GroupCount.append("NA")
                //   theFriends.append(MyFriends(name:FName,email:EmailAdd))
                
            }
            
        }
        else {
           // print("Could not fetch \(error), \(error!.userInfo)")
        }
        } catch {
            print(error)
        }
        print("Friends Now: \(NameTable)")
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let row = (indexPath as NSIndexPath).row
        let selectedResult = (indexPath as NSIndexPath).item
        
        let FriendsRow = NameTable[row] as String
        
        print("Before deselect: \(GroupsName)")
        
        print("Row deselect: \(row)")
        // FriendsName.removeAtIndex(row)
        
        //if (row > 0) {
        
        //        if FriendsRow != "0" {
        
        
        
        let add = row + 1
        print("add one: \(add) Row = NA")
       GroupsName[add] = "NA"
        //FriendsEmail[add] = "NA"
        
        varNumGroups -= 1
        GroupCount[row] = "NA"
        //        }
        
        //  }
        
        //  FriendsName = FriendsName.filter{$0 != FriendsRow}
        
        //   FriendsEmail.removeAtIndex(row)
        
        //   FriendsEmail = FriendsEmail.filter{$0 != FriendsRow}
        
        print("After deselect: \(GroupsName)")
        /*
        if let index = find(self.FriendsInfo, note) {
        self.FriendsInfo.removeAtIndex(index)
        }
        */
        //  let cell2 = TableView.cellForRowAtIndexPath(indexPath)
        
        //  cell2?.backgroundColor = UIColor.whiteColor()
        
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
        
        //  cell.numbers.hidden = true
        // cell.background = UIColor.clearColor()
        
        //    self.TableView.reloadData()
        
        if numGroups == 1 {
            numGroups = 1
        } else {
            numGroups -= 1
        }
        
      //  GameLBL.text = "Game Players : \(numPlayers)"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = (indexPath as NSIndexPath).row
        let selectedResult = (indexPath as NSIndexPath).item
        
        
       // let row = indexPath.row
       // let selectedResult = indexPath.item
        let GroupsRow = Groups[row]
        print(GroupsRow)
        
        TheGroup = (GroupsRow.value(forKey: "groupname") as? String)! as NSString
        
        
        GroupSelected = true
        //self.performSegueWithIdentifier("goto_groupmembers", sender: self)
        
        
       // GroupData = GetGroupMembers(GroupsRow)
       // println("GroupData (from popover) = \(GroupData)")
        
       // self.dismissViewControllerAnimated(true, completion: nil)
        
        //self.performSegueWithIdentifier("group_selected", sender: self)
        
        
        
        self.dismiss(animated: true, completion: nil)
        
        self.adelegate?.GroupPickerViewControllerFinished(self)
        
        
      }
    
    func GetGroupMembers(_ GroupName: NSString) -> [NSArray] {
    
    var GroupArray = [NSArray]()
    var ContactName = [NSString]()
    var ContactEmail = [NSString]()
    var ContactID = [NSString]()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let managedContext = appDelegate.managedObjectContext!
     let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Person")
   // let fetchRequest = NSFetchRequest(entityName: "Person")
   // let error: NSError?
        do {
    let fetchedResults = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
    
    
    
    if let results = fetchedResults {
    Groups = results
    print(Groups)
    
    
    
    for items in Groups as [NSManagedObject] {
    
    let FName = items.value(forKey: "name") as! String
    
    let EmailAdd = items.value(forKey: "email") as! String
    
    let Gname = items.value(forKey: "group") as! String
        
    let FID = items.value(forKey: "id") as! String
        
    
    print(items)
    print(items.value(forKey: "name")!)
    
    if Gname == GroupName as String {
    
    ContactName.append(FName as NSString)
    ContactEmail.append(EmailAdd as NSString)
    ContactID.append(FID as NSString)
    
    //GroupsName.append("NA")
    //FriendsEmail.append("NA")
    //GroupCount.append("NA")
    //   theFriends.append(MyFriends(name:FName,email:EmailAdd))
    
    }
    GroupArray.append(ContactName as NSArray)
    GroupArray.append(ContactEmail as NSArray)
    GroupArray.append(ContactID as NSArray)
    //return GroupArray
    }
    } else {
    //print("Could not fetch \(error), \(error!.userInfo)")
    }
        } catch {
            print(error)
        }
    print("Friends Now: \(NameTable)")
    
    
    return GroupArray
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
        
        if tableView == TableView {
            
         
            
            cell.titleLabel?.text = self.NameTable[(indexPath as NSIndexPath).row] as String
          //  cell.subtitleLabel?.text = self.EmailTable[indexPath.row] as String
            
        }
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goto_groupmembers" {
        
        if let destination = segue.destination as? GroupMembersViewController {

        if let GroupIndex = (TableView.indexPathForSelectedRow as NSIndexPath?)?.row {
        let group = Groups[GroupIndex]
        destination.groupName = (group.value(forKey: "groupname") as? String)! as NSString
            
            
            
        }
        }
        } else if segue.identifier == "group_selected" {
            
            if let destination = segue.destination as? ConfirmPlayersViewController {
                
                if let GroupIndex = (TableView.indexPathForSelectedRow as NSIndexPath?)?.row {
                    let group = Groups[GroupIndex]
                    destination.groupName = (group.value(forKey: "groupname") as? String)! as NSString
                    destination.SelectedGroup = true
                    
                }
            }
        }
        
        else {

        if let destination = segue.destination as? GroupMembersViewController {
            
            if let GroupIndex = (TableView.indexPathForSelectedRow as NSIndexPath?)?.row {
                let group = Groups[GroupIndex]
                destination.groupName = (group.value(forKey: "groupname") as? String)! as NSString
            }
        }

        }

    }
    /*
    @IBAction func editTableView(sender: AnyObject) {
        
        if TableView.editing{
            TableView.setEditing(false, animated: false)
            editBTN.style = UIBarButtonItemStyle.Plain;
            editBTN.title = "Edit";
            TableView.reloadData()
        } else {
            TableView.setEditing(true, animated: true)
            editBTN.title = "Done";
            editBTN.style = UIBarButtonItemStyle.Done;
            TableView.reloadData()
        }
        
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            NameTable.removeAtIndex(indexPath.row)
            // EmailInfo.removeAtIndex(indexPath.row);
            //  NameInfo.removeAtIndex(indexPath.row)
            self.editTableView(editBTN)
            TableView.reloadData()
        } else if editingStyle == UITableViewCellEditingStyle.Insert{
            //Friends.append("New Item")
            NameTable.append("New Item")
            // EmailInfo.append("New Item");
            //  NameInfo.append("New Name");
        }
        
    }
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let item : String = NameTable[sourceIndexPath.row] as String;
        //  let item : String = EmailInfo[sourceIndexPath.row] as String;
        //  let item2 : String = NameInfo[sourceIndexPath.row] as String;
        NameTable.removeAtIndex(sourceIndexPath.row);
        //        EmailInfo.removeAtIndex(sourceIndexPath.row);
        //      NameInfo.removeAtIndex(sourceIndexPath.row);
        
        NameTable.insert(item, atIndex: destinationIndexPath.row)
        //        EmailInfo.insert(item, atIndex: destinationIndexPath.row)
        //      NameInfo.insert(item2, atIndex: destinationIndexPath.row)
    }
*/



}
