//
//  StoreAppViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 8/14/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import StoreKit

class StoreAppViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    @IBOutlet weak var titleLBL: UILabel!
    
      let prefs = UserDefaults.standard
    
    @IBOutlet var TableView: UITableView!
    
   // var tableView = UITableView()
   // let productIdentifiers = Set(["com.ClavenSolutions.TelePictionary.pcamera", "com.ClavenSolutions.TelePictionary.paudio", "com.ClavenSolutions.TelePictionary.allpurchase"])
    
      let productIdentifiers = Set(["com.ClavenSolutions.TelePictionary.pcamera", "com.ClavenSolutions.TelePictionary.paudion"])
    
  //   let productIdentifiers = Set(["com.ClavenSolutions.TelePictionary.pcamera", "com.ClavenSolutions.TelePictionary.paudio","com.ClavenSolutions.TelePictionary.adfree"])
   // let productIdentifiersAudio = Set(["com.ClavenSolutions.TelePictionary.paudio"])
    
    var product: SKProduct?
    
    var productsArray = Array<SKProduct>()
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // TableView.scrollEnabled = false;
        TableView.alwaysBounceVertical = false
        self.title = "My Pencil Box"
        
        if let font = UIFont(name: "DK Cool Crayon", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.white]
            
           // NSNotificationCenter.defaultCenter().postNotificationName("updateLoader", object: nil, userInfo: nil);
        }
        
       

        
    navigationController!.navigationBar.barTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        
      //  tableView = UITableView(frame: self.view.frame)
        /*
        tableView = UITableView(frame: CGRect(x: 0, y: self.view.frame.origin.y + 120, width: self.view.frame.width, height: self.view.frame.height - 60))
        
        tableView.separatorColor = UIColor.clearColor()
        tableView.backgroundColor = UIColor.darkGrayColor()
        */
        
        TableView.dataSource = self
        TableView.delegate = self
        
       // self.view.addSubview(tableView)
        
        //titleLBL.bringSubviewToFront(self.view)
        
        SKPaymentQueue.default().add(self)
        
        requestProductData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        SKPaymentQueue.default().remove(self)
    }
    
    // In-App Purchase Methods
    
    func requestProductData()
    {
        if SKPaymentQueue.canMakePayments() {
            
            print("Can Make Payments")
            let request = SKProductsRequest(productIdentifiers:
                self.productIdentifiers as Set<String>)
            request.delegate = self
            request.start()
            
            print("Product Arrays = \(productsArray)")
            
            
        } else {
            let alert = UIAlertController(title: "In-App Purchases Not Enabled", message: "Please enable In App Purchase in Settings", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.default, handler: { alertAction in
                alert.dismiss(animated: true, completion: nil)
                
                let url: URL? = URL(string: UIApplicationOpenSettingsURLString)
                if url != nil
                {
                    UIApplication.shared.openURL(url!)
                }
                
            }))
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { alertAction in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        var products = response.products
        
        if (products.count != 0) {
            for i in 0 ..< products.count
            {
                self.product = products[i] as? SKProduct
                print("product found \(self.product?.localizedDescription)")
                print("product found \(self.product?.localizedTitle)")
                
                self.productsArray.append(product!)
            }
            self.TableView.reloadData()
        } else {
            print("No products found")
        }
        
      //  products = response.invalidProductIdentifiers
        
        for product in products
        {
            print("Product not found: \(product)")
        }
    }
    
    func buyProduct(_ sender: UIButton) {
        let payment = SKPayment(product: productsArray[sender.tag])
        print("buying product = payment = \(payment)")
        
        SKPaymentQueue.default().add(payment)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            switch transaction.transactionState {
                
            case SKPaymentTransactionState.purchased:
                print("Transaction Approved")
                print("Product Identifier: \(transaction.payment.productIdentifier)")
                self.deliverProduct(transaction)
                SKPaymentQueue.default().finishTransaction(transaction)
                
            case SKPaymentTransactionState.failed:
                print("Transaction Failed")
                SKPaymentQueue.default().finishTransaction(transaction)
            default:
                break
            }
        }
    }
    
    func deliverProduct(_ transaction:SKPaymentTransaction) {
        
       if transaction.payment.productIdentifier == "com.ClavenSolutions.TelePictionary.pcamera" || transaction.payment.productIdentifier == "com.ClavenSolutions.TelePictionary.paudion" || transaction.payment.productIdentifier == "com.ClavenSolutions.TelePictionary.allpurchase" || transaction.payment.productIdentifier == "com.ClavenSolutions.TelePictionary.addfree"
        {
            print("Non-Consumable Product Purchased")
            
            if transaction.payment.productIdentifier == "com.ClavenSolutions.TelePictionary.pcamera" {
            
            prefs.set(true, forKey: "CameraPurchased")
            
            }
            
            if transaction.payment.productIdentifier == "com.ClavenSolutions.TelePictionary.paudion" {
                
                prefs.set(true, forKey: "AudioPurchased")
                
            }
            // Unlock Feature
        }
            }
    
    func restorePurchases(_ sender: UIButton) {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    
   
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("Transactions Restored")
        
       // var purchasedItemIDS = []
        for transaction:SKPaymentTransaction in queue.transactions {
            
           if transaction.payment.productIdentifier == "com.ClavenSolutions.TelePictionary.pcamera" || transaction.payment.productIdentifier == "com.ClavenSolutions.TelePictionary.paudion"
            {
                print("Non-Consumable Product Purchased")
                // Unlock Feature
            }
            /*
            if transaction.payment.productIdentifier == "com.ClavenSolutions.TelePictionary.pcamera" || transaction.payment.productIdentifier == "com.ClavenSolutions.TelePictionary.paudio" || transaction.payment.productIdentifier == "com.ClavenSolutions.TelePictionary.allpurchase"
            {
                print("Non-Consumable Product Purchased")
                // Unlock Feature
            }

           */
        }
        
        let alert = UIAlertView(title: "Thank You", message: "Your purchase(s) were restored.", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
    // Screen Layout Methods
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       // return self.productsArray.count + 1
        return self.productsArray.count
    }
    
    
    /*
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellFrame = CGRectMake(0, 0, self.tableView.frame.width, 52.0)
        var retCell = UITableViewCell(frame: cellFrame)
        retCell.backgroundColor = UIColor.darkGrayColor()
        
        if self.productsArray.count != 0
        {
            if indexPath.row == 5
            {
                var restoreButton = UIButton(frame: CGRectMake(10.0, 10.0, UIScreen.mainScreen().bounds.width - 20.0, 44.0))
                restoreButton.titleLabel!.font = UIFont (name: "HelveticaNeue-Bold", size: 20)
                restoreButton.addTarget(self, action: "restorePurchases:", forControlEvents: UIControlEvents.TouchUpInside)
                restoreButton.backgroundColor = UIColor.whiteColor()
                restoreButton.setTitle("Restore Purchases", forState: UIControlState.Normal)
                restoreButton.titleLabel?.textColor = UIColor.darkGrayColor()
                
                //textcolor = UIColor.darkGrayColor()
                retCell.addSubview(restoreButton)
            }
            else
            {
                var singleProduct = productsArray[indexPath.row]
                
                var titleLabel = UILabel(frame: CGRectMake(10.0, 0.0, UIScreen.mainScreen().bounds.width - 20.0, 25.0))
                titleLabel.textColor = UIColor.whiteColor()
                titleLabel.text = singleProduct.localizedTitle
                titleLabel.font = UIFont (name: "HelveticaNeue", size: 20)
                retCell.addSubview(titleLabel)
                
                var descriptionLabel = UILabel(frame: CGRectMake(10.0, 10.0, UIScreen.mainScreen().bounds.width - 70.0, 40.0))
                descriptionLabel.textColor = UIColor.blackColor()
                descriptionLabel.text = singleProduct.localizedDescription
                descriptionLabel.font = UIFont (name: "HelveticaNeue", size: 10)
                retCell.addSubview(descriptionLabel)
                
                var buyButton = UIButton(frame: CGRectMake(UIScreen.mainScreen().bounds.width - 60.0, 5.0, 50.0, 20.0))
                buyButton.titleLabel!.font = UIFont (name: "HelveticaNeue", size: 12)
                buyButton.tag = indexPath.row
                buyButton.addTarget(self, action: "buyProduct:", forControlEvents: UIControlEvents.TouchUpInside)
                buyButton.backgroundColor = UIColor.blackColor()
                //buyButton.
                buyButton.titleLabel!.textColor = UIColor.darkGrayColor()
                var numberFormatter = NSNumberFormatter()
                numberFormatter.numberStyle = .CurrencyStyle
                numberFormatter.locale = NSLocale.currentLocale()
                buyButton.setTitle(numberFormatter.stringFromNumber(singleProduct.price), forState: UIControlState.Normal)
                retCell.addSubview(buyButton)
            }
        }
        
        return retCell
    }
    */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = TableView.dequeueReusableCellWithIdentifier("BasicCell", forIndexPath: indexPath) as! BasicCell
        
        
        
        var cell = BasicCell()
        
       
        
        cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.backgroundColor = UIColor.clear
        
        if self.productsArray.count != 0
        {
            if (indexPath as NSIndexPath).row == 5
            {
               // var restoreButton = UIButton(frame: CGRectMake(10.0, 10.0, UIScreen.mainScreen().bounds.width - 20.0, 44.0))
                
                //cell.restoreButton?.frame.width = UIScreen.mainScreen().bounds.width - 20.0
                
                cell.restoreButton?.titleLabel!.font = UIFont (name: "HelveticaNeue-Bold", size: 20)
                
                
                cell.restoreButton?.addTarget(self, action: #selector(StoreAppViewController.restorePurchases(_:)), for: UIControlEvents.touchUpInside)
                
                
                cell.restoreButton?.backgroundColor = UIColor.white
            cell.restoreButton?.setTitle("Restore Purchase", for: UIControlState())
            
            cell.restoreButton?.titleLabel?.textColor = UIColor.darkGray
                cell.restoreButton?.isHidden = false
                
                //textcolor = UIColor.darkGrayColor()
                //retCell.addSubview(restoreButton)
            }
            else
            {
                
              //  cell.restoreButton?.hidden = true
                cell.restoreButton?.isHidden = false
                cell.restoreButton?.setTitle("Restore Purchase", for: UIControlState())
                
                cell.restoreButton?.addTarget(self, action: #selector(StoreAppViewController.restorePurchases(_:)), for: UIControlEvents.touchUpInside)
                cell.restoreButton?.layer.cornerRadius = 5
                cell.restoreButton?.layer.borderWidth = 1
                cell.restoreButton?.layer.borderColor = UIColor.white.cgColor
                
                cell.addButton?.addTarget(self, action: #selector(StoreAppViewController.buyProduct(_:)), for: UIControlEvents.touchUpInside)
                cell.addButton?.layer.cornerRadius = 5
                cell.addButton?.layer.borderWidth = 1
                cell.addButton?.layer.borderColor = UIColor.white.cgColor
                
                let singleProduct = productsArray[(indexPath as NSIndexPath).row]
                
              //  var titleLabel = UILabel(frame: CGRectMake(10.0, 0.0, UIScreen.mainScreen().bounds.width - 20.0, 25.0))
                
//cell.titleLabel?.textColor = UIColor.whiteColor()
                
                cell.titleLabel?.text = singleProduct.localizedTitle
                
               // cell.titleLabel?.font = UIFont (name: "HelveticaNeue", size: 20)
                
                //retCell.addSubview(titleLabel)
                
               // var descriptionLabel = UILabel(frame: CGRectMake(10.0, 10.0, UIScreen.mainScreen().bounds.width - 70.0, 40.0))
                
                //subtitleLabel.textColor = UIColor.blackColor()
                
                cell.subtitleLabel?.text = singleProduct.localizedDescription
                
                //subtitleLabel.font = UIFont (name: "HelveticaNeue", size: 10)
               
                //retCell.addSubview(descriptionLabel)
                
              //  var buyButton = UIButton(frame: CGRectMake(UIScreen.mainScreen().bounds.width - 60.0, 5.0, 50.0, 20.0))
                
            //    buyButton.titleLabel!.font = UIFont (name: "HelveticaNeue", size: 12)
                
                cell.buyButton?.tag = (indexPath as NSIndexPath).row
                
                cell.buyButton?.addTarget(self, action: #selector(StoreAppViewController.buyProduct(_:)), for: UIControlEvents.touchUpInside)
                
                cell.buyButton?.layer.cornerRadius = 20
                
                if singleProduct.localizedTitle == "Record & Import Audio Clips" {
                    cell.TableImage?.image = UIImage(named: "BuyAudioIcon.png")
                    print("should show record")
                }
                
                if singleProduct.localizedTitle == "Use your Camera & Photos" {
                    print("should show camera")
                   cell.TableImage?.image = UIImage(named: "Camera Image blueNew.png")
                }
                
                /*
                if singleProduct.localizedTitle == "Ad Free" {
                    cell.TableImage?.image = UIImage(named: "adfreeIcon.png")
                }
*/

                /*
                if singleProduct.localizedTitle == "Complete Toolbox" {
                    
                        cell.TableImage?.image = UIImage(named: "starIcon.png")
                }
*/
                
                /*cell.heartIMG?.hidden = false
                } else {
                    cell.heartIMG?.hidden = true
                }
                */
                
//                buyButton.backgroundColor = UIColor.blackColor()
                //buyButton.
              //  buyButton.titleLabel!.textColor = UIColor.darkGrayColor()
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .currency
                numberFormatter.locale = Locale.current
                
                
                cell.buyButton?.setTitle(numberFormatter.string(from: singleProduct.price), for: UIControlState())
                
              //  retCell.addSubview(buyButton)
            }
        }
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
    //    return 52.0
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    /*
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 0
        {	return 64.0
        }
        
        return 32.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        
        let ret = UILabel(frame: CGRectMake(10, 0, self.TableView.frame.width - 20, 32.0))
        ret.backgroundColor = UIColor.clearColor()
        ret.text = "In-App Purchases"
        ret.textAlignment = NSTextAlignment.Center
        return ret

    }
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


class Product: NSObject
{
    var title: String = ""
    var details: String = ""
    var id: String = ""
}


