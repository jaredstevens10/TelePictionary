//
//  FBCollectionViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 11/13/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell1"

class FBCollectionViewController: UICollectionViewController {
    
    var AlbumPhotos = [UIImage]()
    var accessToken2 = FBSDKAccessToken.current()
    let baseUrl = "https://graph.facebook.com/v2.4/"
var ImagesInAlbum = [UIImage]()
    
    
    @IBOutlet weak var FBImage: UIImageView!
    
    var albumModel:AlbumModel = AlbumModel(name: "", link: "", cover:"");
    //var albumModel:AlbumModel = AlbumModel(link: "");
    var fbHelper:FBHelper?
    var sources:[UIImage] = [UIImage]();
    // var singlePhotoViewController:SinglePhotoViewController?;
    
    func photoExecuted(_ notification:Notification){
        /*
        let photos = notification.userInfo.valueForKey("photos") as [UIImage];
        self.sources = photos;
        self.tableView.reloadData();
        */
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        
        NotificationCenter.default.addObserver(self, selector: #selector(FBCollectionViewController.photoExecuted(_:)), name: NSNotification.Name(rawValue: "photoNotification"), object: nil);
        NotificationCenter.default.addObserver(self, selector: Selector("coverPhotoExecuted:"), name: NSNotification.Name(rawValue: "coverPhotoNotification"), object: nil);
        
        self.navigationItem.title = self.albumModel.name;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FBCell", for: indexPath) as! FBCollectionViewCell
    
        // Configure the cell
        
        cell.FBImage?.image = ImagesInAlbum[(indexPath as NSIndexPath).row]
        
        //cel
    
        return cell
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "coverPhotoNotification"), object: nil);
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "photoNotification"), object: nil);
    }
    
    func executePhoto(){
       // self.fbHelper!.fetchPhoto(self.albumModel.link);
        self.fetchPhoto(self.albumModel.link);

    }

  
    func fetchPhoto(_ link:String){
        
        print("fetching photos")
        let fbRequest = FBSDKGraphRequest(graphPath: link, parameters: nil, httpMethod: "GET")
        //SWIFT 3 ERROR
        fbRequest?.start { (connection, data, error) -> Void in
            if let gotError = error{
                print("Error: %@", gotError)
            }
            else{
                
                //      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
                
                //println(data)
                var pictures:[AlbumImage] = [AlbumImage]();
                
                
                
                let resultdict = data as! NSDictionary
                print("Result Dict: \(resultdict)")
                // let data : NSArray = resultdict.objectForKey("data") as! NSArray
                let pictureId = resultdict.value(forKey: "id") as! String;
                
                //  let graphData : NSArray = resultdict.objectForKey("data") as! NSArray;
                
                //let graphData = data.objectForKey("data") as Array;
                // var albums:[AlbumModel] =  [AlbumModel]();
                
                //                    for obj:AnyObject in graphData{
                //   for obj:AnyObject in resultdict{
                //println(obj.description);
                //println(obj)
                
                //    let pictureId = obj.valueForKey("id") as! String;
                
                let smallImageUrl = "\(self.baseUrl)\(pictureId)/picture?type=thumbnail&access_token=\(self.accessToken2!.tokenString)";
                let url = URL(string: smallImageUrl);
                let picData = try? Data(contentsOf: url!);
                
                var img:UIImage? = nil
                if let picDataHas = picData{
                    img = UIImage(data: picData!);
                }
                
                
                let bigImageUrl = "\(self.baseUrl)\(pictureId)/picture?type=album&access_token=\(self.accessToken2!.tokenString)";
                
                let sourceURL = URL(string: bigImageUrl)
                print("Source URL = \(sourceURL)")
                
                let sourceData = try? Data(contentsOf: sourceURL!)
                
                print("SourceData = \(sourceData)")
                
                
                var sourceImg:UIImage? = nil
                if let hasSouceData = sourceData{
                    sourceImg = UIImage(data: hasSouceData)
                    
                    self.ImagesInAlbum.append(sourceImg!)
                }
                
                
                //    let commentLink = "\(self.baseUrl)\(pictureId)/comments?access_token=\(self.accessToken!.tokenString)"
                //    let likeLink = "\(self.baseUrl)\(pictureId)/likes?access_token=\(self.accessToken!.tokenString)"
                
                
                //  var commentsByUser = self.executeComment(commentLink)
                //  var likesByUser = self.executeLike(likeLink)
                
                
                
                //println("Comment: \(commentLink)")
                //println("Like: \(likeLink)")
                
                
                
                //pictures.append(AlbumImage(smallImage: img!, bigImage: sourceImg!));
                
                // addItemToTable(album: AlbumImage(smallImage: img!, bigImage: sourceImg!, likes: likesByUser, comments: commentsByUser))
                
                
                
                
                // addItemToTable(album: AlbumImage(smallImage: img!, bigImage: sourceImg!))
                
                //NSThread.sleepForTimeInterval(2)
                //   }
                //   NSNotificationCenter.defaultCenter().postNotificationName("photoNotification", object: nil, userInfo: nil);
                //   })
                
                
            }
        }
       // self.albumTable.reloadData()
        self.collectionView?.reloadData()
        
    }
    



    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        //will return image
    }

}
