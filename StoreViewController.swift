//
//  StoreViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 8/14/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import StoreKit

class StoreViewController: UIViewController, SKProductsRequestDelegate, UITableViewDataSource, UITableViewDelegate, SKPaymentTransactionObserver {
    
    var username = NSString()
    
    @IBOutlet weak var tableView: UITableView!
    var productIdentifiers = Set(["com.ClavenSolutions.TelePictionary.pcamera"])
    var product: SKProduct?
    var productsArray = Array<SKProduct>()
    
    @IBOutlet weak var menuButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        let prefs:UserDefaults = UserDefaults.standard
        
        username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
        
        tableView.dataSource = self
        tableView.delegate = self
        
        SKPaymentQueue.default().add(self)
            requestProductData()

        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        SKPaymentQueue.default().remove(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.productsArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellFrame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 52.0)
        let retCell = UITableViewCell(frame: cellFrame)
        
        if self.productsArray.count != 0
        {
            if (indexPath as NSIndexPath).row == 5
            {
                let restoreButton = UIButton(frame: CGRect(x: 10.0, y: 10.0, width: UIScreen.main.bounds.width - 20.0, height: 44.0))
                restoreButton.titleLabel!.font = UIFont (name: "HelveticaNeue-Bold", size: 20)
                restoreButton.addTarget(self, action: #selector(StoreViewController.restorePurchases(_:)), for: UIControl.Event.touchUpInside)
                restoreButton.backgroundColor = UIColor.black
                restoreButton.setTitle("Restore Purchases", for: UIControl.State())
                retCell.addSubview(restoreButton)
            }
            else
            {
                let singleProduct = productsArray[(indexPath as NSIndexPath).row]
                
                let titleLabel = UILabel(frame: CGRect(x: 10.0, y: 0.0, width: UIScreen.main.bounds.width - 20.0, height: 25.0))
                titleLabel.textColor = UIColor.black
                titleLabel.text = singleProduct.localizedTitle
                titleLabel.font = UIFont (name: "HelveticaNeue", size: 20)
                retCell.addSubview(titleLabel)
                
                let descriptionLabel = UILabel(frame: CGRect(x: 10.0, y: 10.0, width: UIScreen.main.bounds.width - 70.0, height: 40.0))
                descriptionLabel.textColor = UIColor.black
                descriptionLabel.text = singleProduct.localizedDescription
                descriptionLabel.font = UIFont (name: "HelveticaNeue", size: 12)
                retCell.addSubview(descriptionLabel)
                
                let buyButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 60.0, y: 5.0, width: 50.0, height: 20.0))
                buyButton.titleLabel!.font = UIFont (name: "HelveticaNeue", size: 12)
                buyButton.tag = (indexPath as NSIndexPath).row
                buyButton.addTarget(self, action: #selector(StoreViewController.buyProduct(_:)), for: UIControl.Event.touchUpInside)
                buyButton.backgroundColor = UIColor.black
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .currency
                numberFormatter.locale = Locale.current
                buyButton.setTitle(numberFormatter.string(from: singleProduct.price), for: UIControl.State())
                retCell.addSubview(buyButton)
            }
        }
        
        return retCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 52.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 0
        {	return 64.0
        }
        
        return 32.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let ret = UILabel(frame: CGRect(x: 10, y: 0, width: self.tableView.frame.width - 20, height: 32.0))
        ret.backgroundColor = UIColor.clear
        ret.text = "In-App Purchases"
        ret.textAlignment = NSTextAlignment.center
        return ret
    }
    
    @IBAction func buyProduct(_ sender: AnyObject) {
        
        let payment = SKPayment(product: productsArray[sender.tag])
        SKPaymentQueue.default().add(payment)
    }
    
    func requestProductData()
    {
        if SKPaymentQueue.canMakePayments() {
            let request = SKProductsRequest(productIdentifiers:
                self.productIdentifiers as Set<String>)
            print("request: \(request)")
            request.delegate = self
            request.start()
        } else {
            let alert = UIAlertController(title: "In-App Purchases Not Enabled", message: "Please enable In App Purchase in Settings", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: { alertAction in
                alert.dismiss(animated: true, completion: nil)
                
                let url: URL? = URL(string: UIApplication.openSettingsURLString)
                if url != nil
                {
                    UIApplication.shared.openURL(url!)
                }
                
            }))
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { alertAction in
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
                self.productsArray.append(product!)
            }
            self.tableView.reloadData()
        } else {
            print("No products found")
        }
        
       //products = response.invalidProductIdentifiers
        
        for product in products
        {
            print("Product not found: \(product)")
        }
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
        
        if transaction.payment.productIdentifier == "com.ClavenSolution.TelePictionary.pcamera"
        {
            print("Non-Consumable Product Purchased")
            // Unlock Feature
        }
        else if transaction.payment.productIdentifier == "com.brianjcoleman.testiap2"
        {
            print("Non-Consumable Product Purchased")
            // Unlock Feature
        }
        else if transaction.payment.productIdentifier == "com.brianjcoleman.testiap3"
        {
            print("Auto-Renewable Subscription Product Purchased")
            // Unlock Feature
        }
        else if transaction.payment.productIdentifier == "com.brianjcoleman.testiap4"
        {
            print("Free Subscription Product Purchased")
            // Unlock Feature
        }
        else if transaction.payment.productIdentifier == "com.brianjcoleman.testiap5"
        {
            print("Non-Renewing Subscription Product Purchased")
            // Unlock Feature
        }
    }
    
    @objc func restorePurchases(_ sender: UIButton) {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("Transactions Restored")
        //SWIFT 3 ERROR BELOW
       // var purchasedItemIDS = [] as! NSArray
        //Fixed??
        for transaction:SKPaymentTransaction in queue.transactions {
            
            if transaction.payment.productIdentifier == "com.brianjcoleman.testiap1"
            {
                print("Consumable Product Purchased")
                // Unlock Feature
            }
            else if transaction.payment.productIdentifier == "com.brianjcoleman.testiap2"
            {
                print("Non-Consumable Product Purchased")
                // Unlock Feature
            }
            else if transaction.payment.productIdentifier == "com.brianjcoleman.testiap3"
            {
                print("Auto-Renewable Subscription Product Purchased")
                // Unlock Feature
            }
            else if transaction.payment.productIdentifier == "com.brianjcoleman.testiap4"
            {
                print("Free Subscription Product Purchased")
                // Unlock Feature
            }
            else if transaction.payment.productIdentifier == "com.brianjcoleman.testiap5"
            {
                print("Non-Renewing Subscription Product Purchased")
                // Unlock Feature
            }
        }
        
        let alert = UIAlertView(title: "Thank You", message: "Your purchase(s) were restored.", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
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
/*
class Product: NSObject
{
    var title: String = ""
    var details: String = ""
    var id: String = ""
}
*/
