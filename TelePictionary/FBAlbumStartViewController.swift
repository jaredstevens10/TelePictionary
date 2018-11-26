//
//  FBAlbumStartViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 11/12/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import UIKit
import Foundation

class FBAlbumStartViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let fbHelper = FBHelper();
    var sources:[AlbumModel] = [AlbumModel]();
    var currentAlbumModel = AlbumModel(name: "", link: "", cover:"");
   // var destController:FBAlbumViewController?;
    
    var destController:FBCollectionViewController?;
    let baseUrl = "https://graph.facebook.com/v2.4/"
    
    var AlbumModelLink = [NSString]()
    
    var albumModel:AlbumModel = AlbumModel(name: "", link: "", cover:"");

    var accessToken2 = FBSDKAccessToken.current()
    
    var AlbumImages = [UIImage]()
    var ImagesInAlbum = [UIImage]()
    
    @IBOutlet weak var albumTable: UITableView!
   
    @IBOutlet weak var btnLoginLogout: UIButton!
    @IBOutlet var imgProfile : UIImageView?
    
    var email = String()
    //data.valueForKey("name") as! String;
    
    var firstName = String()
    //data.valueForKey("name") as! String;
    
    var userFBID = String()
    //data.valueForKey("id") as! String;
    
    var userImageURL = String()
    //"https://graph.facebook.com/\(userFBID)/picture?type=small";
    
    var url: URL!
    //(string: userImageURL);
    
    var imageData = Data()
    //(contentsOfURL: url!);
    
    var image = UIImage()
    //(data: imageData!);

    
    @IBAction func fetchDataAction(_ sender : AnyObject) {
        

        fbHelper.fetchAlbum();
    }
    
    //@IBOutlet var btnLoginLogout : UIButton
    
    @IBAction func facebookLogoutAction(_ sender : AnyObject) {
        self.fbHelper.logout();
        self.btnLoginLogout.titleLabel!.text = "Login to Facebook";
    }
    @IBAction func facebookLoginAction(_ sender : AnyObject) {
        
        
        if(self.btnLoginLogout.titleLabel!.text == "Login"){
            login();
        }
        else{
            fbHelper.logout();
        }

        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.currentAlbumModel = self.sources[(indexPath as NSIndexPath).row];
        
        if((self.destController) != nil){
            self.destController!.albumModel = self.currentAlbumModel;
            self.destController!.fbHelper = self.fbHelper;
            self.destController!.accessToken2 = self.accessToken2
            self.destController!.executePhoto();
        }
        
    }
    
    func selectRowAtIndexPath(_ indexPath: IndexPath!, animated: Bool, scrollPosition: UITableViewScrollPosition){
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    //var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("BasicCell")! as! BasicCell;
    
        
    let cell = albumTable.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
        
    //    cell.selectionStyle = UITableViewCellSelectionStyle.None
        
    cell.backgroundColor = UIColor.clear
        
        
    
    let data = self.sources[(indexPath as NSIndexPath).row];
        
   // cell.textLabel!.text = data.name;
   // cell.detailTextLabel!.text = data.link;
    if(data.cover != ""){
    let coverPhotoURL = URL(string: data.cover);
    let coverPhotoData = try? Data(contentsOf: coverPhotoURL!);

    cell.TableImage?.image = UIImage(data: coverPhotoData!);
        
   // cell.TableImage?.image = self.sources[indexPath.row];
    
    }
        
//    cell.TableImage?.image = self.ImagesInAlbum[indexPath.row]
    return cell;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
   // return self.sources.count;
        return self.ImagesInAlbum.count;
    }
    
    
    override func prepare(for segue: UIStoryboardSegue!, sender: Any!) {
        if(segue.identifier == "photoSegue"){
            let destinitionController = segue.destination as! FBCollectionViewController;
            destinitionController.albumModel = self.currentAlbumModel;
            self.destController = destinitionController;
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "PostData"), object: nil);
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "albumNotification"), object: nil);
    }
    
    override func viewDidLoad() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(FBAlbumStartViewController.executeHandle(_:)), name: NSNotification.Name(rawValue: "PostData"), object: nil);
       
        
        NotificationCenter.default.addObserver(self, selector: #selector(FBAlbumStartViewController.executeAlbum(_:)), name: NSNotification.Name(rawValue: "albumNotification"), object: nil);
        
        
        self.albumTable?.dataSource = self
        self.albumTable?.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
     /*
if (FBSDKAccessToken.currentAccessToken() != nil) {
 print("token is ok")
    
   // let theUser: User?
   // theUser!.id = FBSDKAccessToken.currentAccessToken().userID
*/
    //fbHelper.fetchAlbum();
  /*
} else {
print("token is nil")
        fbHelper.login();
        }

*/
    }
    
    
    @IBAction func LoadAlbumBTN(_ sender: AnyObject) {
        print("fetch album pressed")
        fetchAlbum()
    }
    
    func GetAllPictures() {
      // var linkTest = "146633149011678";
        let linkTest = "114191515589175"
        print("getting all pictures")
       // var albumsPhotosTemp = [UIImage]()
        
    //    for theAlbums in AlbumModelLink {
           
            var albumsPhotosTemp = [UIImage]()
            fetchPhoto(linkTest as String)
           // <#T##(album: AlbumImage) -> ()#>
     //   }
        
    }
    
    func fetchAlbum(){
        
        print("accessToken2 = \(accessToken2)")
        
        
        if (FBSDKAccessToken.current() != nil)
        {
print("token is not nil")
        
        let user = FBSDKAccessToken.current()
        
      //  let userImageURL = "\(self.baseUrl)\(user.userID)/albums?access_token=\(self.accessToken!.tokenString)";
        
        let graphPath = "/\(user?.userID)/albums";
        let request =  FBSDKGraphRequest(graphPath: graphPath, parameters: nil, httpMethod: "GET")
            
            //SWIFT 3 ERROR
            /*
        request?.start { (connection:FBSDKGraphRequestConnection!, result:AnyObject!, error:Error!) -> Void in
            if let gotError = error{
                print(gotError.description);
            }
            else{
                print(result)
                
                
                let resultdict = result as! NSDictionary
                print("Result Dict: \(resultdict)")
                // let data : NSArray = resultdict.objectForKey("data") as! NSArray
                
               // let graphData : NSArray = resultdict.objectForKey("data") as! NSArray;

                let graphData : NSArray = resultdict["data"] as! NSArray;
                
                var albums:[AlbumModel] =  [AlbumModel]();
                for obj:AnyObject in graphData{
                    let desc = obj.description;
                    //println(desc);
                    let name = obj.value(forKey: "name") as! String;
                    print("Album Name = \(name)")
                    //println(name);
                    let id = obj.value(forKey: "id") as! String;
                    var cover = "";
                    
                    cover = "\(id)/picture";
                    
                    
                    //println(coverLink);
                    let link = "\(id)/photos";
                    
                    let model = AlbumModel(name: name, link: link, cover:cover);
                    
                    self.AlbumModelLink.append(link)
                    //albums.append(model);
                    self.sources.append(model);
                    
                }
               // NSNotificationCenter.defaultCenter().postNotificationName("albumNotification", object: nil, userInfo: ["data":albums]);
               // exectueAlbum(
            }
        }
            
            */
           // fetchPhoto(<#T##link: String##String#>, addItemToTable: <#T##(album: AlbumImage) -> ()#>)
            
            GetAllPictures()
//            self.albumTable.reloadData()
         } else {
            
            print("token is nil, need to loging")
    getFBPermissionPhotos()
    //return false
     }
    }

    
    func login(){
        
        
        //SWIFT 3 ERROR
        /*
        print("accessToken2 = \(accessToken2)")
        
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["email", "public_profile", "user_friends", "user_photos"], handler: { (result:FBSDKLoginManagerLoginResult!, error:Error!) -> Void in
            
            if let gotError = error{
                //got error
            }
            else if(result.isCancelled){
                print("login canceled")
            }
            else{
                
                print(result.grantedPermissions)
                if(result.grantedPermissions.contains("email")){
                    
                    let request = FBSDKGraphRequest(graphPath: "me", parameters: nil, httpMethod: "GET")
                    request.start(completionHandler: { (connection:FBSDKGraphRequestConnection!, data:AnyObject!, error:NSError!) -> Void in
                        
                        if let gotError = error{
                            //got error
                        }
                        else {
                            
                            //println(data)
                            
                            
                            
                             self.email = data.value(forKey: "name") as! String;
                            
                            self.firstName = data.value(forKey: "name") as! String;
                            
                            self.userFBID = data.value(forKey: "id") as! String;
                            
                            print("user FB ID = \(self.userFBID)")
                            self.userImageURL = "https://graph.facebook.com/\(self.userFBID)/picture?type=small";
                            
                            self.url = URL(string: self.userImageURL)!;
                            
                            self.imageData = try! Data(contentsOf: self.url);
                            
                            self.image = UIImage(data: self.imageData)!;
                            
                            self.accessToken2 = FBSDKAccessToken.current();
                            
                            /*
                            print("userFBID: \(userFBID) Email \(email) \n firstName:\(firstName) \n image: \(image)");
                            
                            var userModel = User(email: email, name: firstName, image: image!, id: userFBID);
                            */
                            
                            //   NSNotificationCenter.defaultCenter().postNotificationName("PostData", object: userModel, userInfo: nil);
                        }
                    })
                    
                   
                }
                
            }
        })
        
        */
        
    }

    func executeAlbum(_ notification:Notification){
        
        let resultdict = (notification as NSNotification).userInfo as! NSDictionary
        print("Result Dict: \(resultdict)")
        // let data : NSArray = resultdict.objectForKey("data") as! NSArray
        
        let data  = resultdict.object(forKey: "data") as! [AlbumModel]
        
        
        
        //let data = notification.userInfo.
        
        //   ObjectForKey("data") as [AlbumModel];
        self.sources = data;
        self.albumTable.reloadData();
    }
    
    func executeHandle(_ notification:Notification){
        let userData = notification.object as! User;
        
        let name = userData.name as! String;
        let email = userData.email as! String;
        //lblName.text = name;
        //lblEmail.text = email;
        imgProfile!.image = userData.image;
        //  self.btnLoginLogout.titleLabel.text = "Logout";
        
    }

    func fetchCoverPhoto(_ coverLink: String, completion:@escaping (_ image:UIImage)->()){
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background).async(execute: { () -> Void in
            
            
            //http://graph.facebook.com/v2.4/10150192451235958/picture?type=thumbnail
            let userImageURL = "\(self.baseUrl)\(coverLink)?type=album&access_token=\(self.accessToken2!.tokenString)";
            
            let url = URL(string: userImageURL);
            
            let imageData = try? Data(contentsOf: url!);
            
            if let imageDataHas = imageData{
                let image = UIImage(data: imageData!);
                
                completion(image!)
                self.AlbumImages.append(image!)
            }
            
        })
    }
    
    //func fetchPhoto(link:String, addItemToTable: (album:AlbumImage)->()){
      func fetchPhoto(_ link:String){
        
        print("fetching photos")
       
        
       
        
        
        //SWIFT 3 ERROR
         /*
        fbRequest?.start { (connection:FBSDKGraphRequestConnection!, data:AnyObject!, error:Error!) -> Void in
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
 
 */
        self.albumTable.reloadData()
        
    }
    
    
    @IBAction func closeBTN(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
   
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
