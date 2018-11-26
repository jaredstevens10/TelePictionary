//
//  FacebookFunctions.swift
//  TelePictionary
//
//  Created by Jared Stevens on 8/11/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
import FBAudienceNetwork


func FaceBookUserData()
{
    let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
    graphRequest.start(completionHandler: {(connection, result, error) -> Void in
        if (error != nil)
        {
            print("Error: \(error)")
        } else {
            print("fetched user: \(result)")
            //let userName : NSString = result.valueForKey("facebookname") as! NSString
            //println("User name is: \(userName)")
           // let userEmail : NSString = result.valueForKey("email") as! NSString
          //  println("User Email is: \(userEmail)")
        }
    })
}


func GetFBFriends (){
    let fbRequest = FBSDKGraphRequest(graphPath:"/me/invitable_friends", parameters: nil, httpMethod: "Get")
    fbRequest?.start{(connection, result , error) -> Void in
        if error == nil {
            print("friends are : \(result)")
            
        } else {
            print("error getting friends - error: \(error)")
        }
        
    }
    
}

func FBFriends() {
    
    if (FBSDKAccessToken.current() != nil)
    {
        print("FB Already logged in")
        
        
        let friendsRequest = FBSDKGraphRequest(graphPath:"/me/invitable_friends", parameters: nil, httpMethod: "Get");
        
        //var FriendsRequest2 = FBSDKGraphRequest(
        
        friendsRequest?.start {
            (connection, result, error) -> Void in
            print("Friend Results: \(result)")
            
            let resultdict = result as! NSDictionary
            print("Result Dict: \(resultdict)")
            let data : NSArray = resultdict.object(forKey: "data") as! NSArray
            
            for i in 0 ..< data.count
            {
                let valueDict : NSDictionary = data[i] as! NSDictionary
                let id = valueDict.object(forKey: "id") as! String
                print("the id value is \(id)")
            }
            let friends = resultdict.object(forKey: "data") as! NSArray
            print("Found \(friends.count) friends")
            
            FaceBookUserData()
            
            
        }
 }
    //let loginView : FBSDKLoginButton = FBSDKLoginButton()
    //self.view.addSubview(loginView)
    
    //loginView.center = self.view.center
    //loginView.readPermissions = ["public_profile", "email", "user_friends"]
 
    //ELSE NOT LOGGED IN TO FACEBOOK
    
}

func sendGameInvitenew() {
    
    print("trying to send invite")
    let inviteDialog:FBSDKAppInviteDialog = FBSDKAppInviteDialog()
    if(inviteDialog.canShow()){
        let appLinkUrl:URL = URL(string: "TelePictionary://article/FacebookInvite?")!
        //let previewImageUrl:NSURL = NSURL(string: "http://\(ServerInfo.sharedInstance)imagescsletterfinal3d.png")!
        
        
        
        let inviteContent: FBSDKAppInviteContent = FBSDKAppInviteContent()
        //appLinkURL: appLinkUrl)
        // (appLinkURL: appLinkUrl)
        inviteContent.appLinkURL = appLinkUrl
        // inviteContent.
        // inviteContent.appInvitePreviewImageURL = previewImageUrl
        
        inviteDialog.content = inviteContent
        //inviteDialog
        //        inviteDialog.delegate = self
        inviteDialog.show()
    }
}

func shareImageToFaceBook(_ image: UIImage) -> Bool {
    print("attempting to share image to FB")
    
    print("FBSDKAccess Token = \(FBSDKAccessToken.current())")
    
    if (FBSDKAccessToken.current() != nil)
    {
    let photo : FBSDKSharePhoto = FBSDKSharePhoto()
    photo.image = image as UIImage
    photo.isUserGenerated = true
        
    let content : FBSDKSharePhotoContent = FBSDKSharePhotoContent()
    content.photos = [photo]
        
        print("Photo shared to facebook")
        return true
    } else {
        return false
    }
}

//func shareImageToFaceBook2(image: UIImage) -> Bool {

/*
func shareImageToFaceBook2() -> Bool {    print("attempting to share image to FB")
    
    print("FBSDKAccess Token = \(FBSDKAccessToken.currentAccessToken())")
    
 //   if (FBSDKAccessToken.currentAccessToken() != nil)
//    {
    let photo : FBSDKShareLinkContent = FBSDKShareLinkContent()
    
      //  let photo : FBSDKSharePhoto = FBSDKSharePhoto()
    photo.contentURL = NSURL(string: "http://\(ServerInfo.sharedInstance)")
    photo.contentTitle = "Pics & Quotes"
    photo.contentDescription = "Description"
       // photo.userGenerated = true
    
   
    
        let content : FBSDKSharePhotoContent = FBSDKSharePhotoContent()
        content.photos = [photo]
    
     FBSDKShareDialog.showFromViewController(self, withContent: content, delegate: nil)
    
        print("Photo shared to facebook")
        return true
//    }

}

*/
func shareVideoToFaceBook(_ videoURL: URL, myView: UIViewController) -> Bool {
    print("attempting to share video to FB")
    
    if (FBSDKAccessToken.current() != nil)
    {
        print("FB: setting up video to share")
        let video : FBSDKShareVideo = FBSDKShareVideo()
        
        video.videoURL = videoURL as URL
       // photo.userGenerated = true
        
        let content : FBSDKShareVideoContent = FBSDKShareVideoContent()
        
        content.video = video
        
        print("Video shared to facebook")
        return true
    } else {
        getFBPermission(myView: myView)
        return false
    }
}

func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
    print("Userlogged in")
    if ((error) != nil)
    {
        //process error
    } else if result.isCancelled {
        //handle Cancel
    } else {
        if result.grantedPermissions.contains("email")
        {
            //get the email info
        }
    }
}
func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    print("user logged out")
}

func returnUserData()
{
    let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
    graphRequest.start(completionHandler: {(connection, result, error) -> Void in
        if (error != nil)
        {
            print("Error: \(error)")
        } else {
            print("fetched user: \(result)")
            let userName : NSString = graphRequest.value(forKey: "name") as! NSString
           // let userName : NSString = result.value(forKey: "name") as! NSString
            print("User name is: \(userName)")
            let userEmail : NSString = graphRequest.value(forKey: "email") as! NSString
          //  let userEmail : NSString = result.value(forKey: "email") as! NSString
            print("User Email is: \(userEmail)")
        }
    })
}

func getFBPermission(myView: UIViewController) {
    let login: FBSDKLoginManager = FBSDKLoginManager()

    
    //    login.logInWithReadPermissions("public_profile", "user_friends", "email"]
    //SWIFT 3 ERROR FIXED??
    
    print("swift 3 error")
  
    
    login.logIn(withPublishPermissions: ["publish_actions"], from: myView) { (result, error) in
        if (error != nil) {
            
        } else if (result?.isCancelled)! {
            
        } else {
            if (result?.grantedPermissions.contains("user_friends"))! {
                print("have friends permission")
            }
            if (result?.grantedPermissions.contains("email"))! {
                print("have email permission")
            }
    }
        
    }
   
        /*
    login.logIn(withPublishPermissions: ["publish_actions"], from: self, handler: (result, error) -> Void in
        
        if (error != nil) {
        
        } else if (result?.isCancelled)! {
        
        } else {
        if (result?.grantedPermissions.contains("user_friends"))! {
        print("have friends permission")
        }
        if (result?.grantedPermissions.contains("email"))! {
        print("have email permission")
        }
        
        
    })
        
        */
    
//}//))

/*
      login.logIn(withPublishPermissions: ["publish_actions"]) { (result, error) -> Void in
        
        if (error != nil) {
            
        } else if (result?.isCancelled)! {
            
        } else {
            if (result?.grantedPermissions.contains("user_friends"))! {
                print("have friends permission")
            }
            if (result?.grantedPermissions.contains("email"))! {
                print("have email permission")
            }
  
            
        }
    }//)
 */
}

func getFBPermissionPhotos() {
    let login: FBSDKLoginManager = FBSDKLoginManager()
    
    
    //    login.logInWithReadPermissions("public_profile", "user_friends", "email"]
    
    login.logIn(withReadPermissions: ["email", "public_profile", "user_friends", "user_photos"], handler: { (result , error) -> Void in
        
        if (error != nil) {
            
        } else if (result?.isCancelled)! {
            
        } else {
            if (result?.grantedPermissions.contains("user_friends"))! {
                print("have friends permission")
            }
            if (result?.grantedPermissions.contains("email"))! {
                print("have email permission")
            }
            if (result?.grantedPermissions.contains("user_photos"))! {
                print("have photo permission")
            }

            
        }
    })
}



/*
func sendFBInvite() {
    
    println("trying to send invite")
    var inviteDialog:FBSDKAppInviteDialog = FBSDKAppInviteDialog()
    if(inviteDialog.canShow()){
        let appLinkUrl:NSURL = NSURL(string: "https://fb.me/675432082558667")!
        // let appLinkUrl:NSURL = NSURL(string: "TelePictionary://article/FacebookInvite?")!
        //let previewImageUrl:NSURL = NSURL(string: "http://\(ServerInfo.sharedInstance)imagescsletterfinal3d.png")!
        
        var inviteContent: FBSDKAppInviteContent = FBSDKAppInviteContent()
        //appLinkURL: appLinkUrl)
        // (appLinkURL: appLinkUrl)
        println("app invite should be shown here")
        inviteContent.appLinkURL = appLinkUrl
        // inviteContent.
        // inviteContent.appInvitePreviewImageURL = previewImageUrl
        
        inviteDialog.content = inviteContent
        //inviteDialog
        inviteDialog.delegate = self
        inviteDialog.show()
    }
}
*/



class FBHelper{
    var accessToken: FBSDKAccessToken?
    let baseUrl = "https://graph.facebook.com/v2.4/"
    init(){
        accessToken = FBSDKAccessToken.current()
    }
    
    func fetchFriendsPhoto(_ link:String, completionHandler: @escaping (_ img:UIImage)->()){
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background).async(execute: { () -> Void in
            
            //http://graph.facebook.com/v2.4/10150192451235958/picture?type=thumbnail
            let userImageURL = "\(self.baseUrl)\(link)/picture?type=album&access_token=\(self.accessToken!.tokenString)";
            
            let url = URL(string: userImageURL);
            
            let imageData = try? Data(contentsOf: url!);
            
            if let imageDataHas = imageData{
                let image = UIImage(data: imageData!);
                
                completionHandler(image!)
            }
            
        })
    }
    
    func fetchPhoto(_ link:String, addItemToTable: @escaping (_ album:AlbumImage)->()){
        
        let fbRequest = FBSDKGraphRequest(graphPath: link, parameters: nil, httpMethod: "GET")
        fbRequest?.start { (connection, data, error) -> Void in
            if let gotError = error{
                print("Error: %@", gotError)
            }
            else{
                
                DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background).async(execute: { () -> Void in
                    
                    //println(data)
                    var pictures:[AlbumImage] = [AlbumImage]();
                    
                    
                    
                    let resultdict = data as! NSDictionary
                    print("Result Dict: \(resultdict)")
                    // let data : NSArray = resultdict.objectForKey("data") as! NSArray
                    
                    let graphData : NSArray = resultdict.object(forKey: "data") as! NSArray;
                    
                    //let graphData = data.objectForKey("data") as Array;
                    var albums:[AlbumModel] =  [AlbumModel]();
                    
                    for obj:Any in graphData{
                        //println(obj.description);
                        //println(obj)
                        
                        let pictureId = (obj as AnyObject).value(forKey: "id") as! String;
                        
                        let smallImageUrl = "\(self.baseUrl)\(pictureId)/picture?type=thumbnail&access_token=\(self.accessToken!.tokenString)";
                        let url = URL(string: smallImageUrl);
                        let picData = try? Data(contentsOf: url!);
                        
                        var img:UIImage? = nil
                        if let picDataHas = picData{
                            img = UIImage(data: picData!);
                        }
                        
                        
                        let bigImageUrl = "\(self.baseUrl)\(pictureId)/picture?type=normal&access_token=\(self.accessToken!.tokenString)";
                        let sourceURL = URL(string: bigImageUrl)
                        let sourceData = try? Data(contentsOf: sourceURL!)
                        
                        var sourceImg:UIImage? = nil
                        if let hasSouceData = sourceData{
                            sourceImg = UIImage(data: hasSouceData)
                        }
                        
                        
                    //    let commentLink = "\(self.baseUrl)\(pictureId)/comments?access_token=\(self.accessToken!.tokenString)"
                    //    let likeLink = "\(self.baseUrl)\(pictureId)/likes?access_token=\(self.accessToken!.tokenString)"
                        
                        
                      //  var commentsByUser = self.executeComment(commentLink)
                      //  var likesByUser = self.executeLike(likeLink)
                        
                        
                        
                        //println("Comment: \(commentLink)")
                        //println("Like: \(likeLink)")
                        
                        
                        
                        //pictures.append(AlbumImage(smallImage: img!, bigImage: sourceImg!));
                        
                       // addItemToTable(album: AlbumImage(smallImage: img!, bigImage: sourceImg!, likes: likesByUser, comments: commentsByUser))
                        
                          addItemToTable(AlbumImage(smallImage: img!, bigImage: sourceImg!))
                        
                        //NSThread.sleepForTimeInterval(2)
                    }
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "photoNotification"), object: nil, userInfo: nil);
                })
                
                
            }
        }
        
        
    }
    
    func executeLike(_ likeLink:String) -> [Like]{
        let request = NSMutableURLRequest(url: URL(string: likeLink)!)
        request.httpMethod = "GET"
        var likes = [Like]()
        
        var responseObject:URLResponse?
        var err:NSErrorPointer? = nil
        do {
        let responseData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: &responseObject)
            
        let response = responseData
            
            if(err == nil){
                
                do {
                var likeResponse: Any? = try JSONSerialization.jsonObject(with: response, options: JSONSerialization.ReadingOptions.allowFragments)
                
                //println(likeResponse)
                if let likeDict:NSDictionary = likeResponse as? NSDictionary{
                    let data = likeDict.object(forKey: "data") as! NSArray
                    //println(data)
                    for likeObj in data{
                        likes.append(Like(likeBy: ((likeObj as AnyObject).value(forKey: "name") as? String)!, likeDate: "", likeByUrl: ((likeObj as AnyObject).value(forKey: "id") as? String)!, likeByImage: nil))
                    }
                    
                }
                } catch {
                    print(error)
                }
            }
        
        } catch {
            print(error)
        }
        return likes
    }
    
    
    func executeComment(_ commentLink:String) -> [Comment]{
        let request = NSMutableURLRequest(url: URL(string: commentLink)!)
        request.httpMethod = "GET"
        var comments = [Comment]()
        
        var responseObject:URLResponse?
        var err:NSErrorPointer? = nil
        
        do {
        let responseData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: &responseObject)
        
        let response = responseData
            if(err == nil){
                
                do {
                var likeResponse: Any? = try JSONSerialization.jsonObject(with: response, options: JSONSerialization.ReadingOptions.allowFragments)
                
                //println(likeResponse)
                if let likeDict:NSDictionary = likeResponse as? NSDictionary{
                    let data = likeDict.object(forKey: "data") as! NSArray
                    //println(data)
                    for commentObj in data{
                        comments.append(Comment(commentString: ((commentObj as AnyObject).value(forKey: "message") as? String)!, commentBy: (((commentObj as AnyObject).value(forKey: "from") as AnyObject).value(forKey: "name") as? String)!, commentLocation: "", commentDate: "", commentByUrl: (((commentObj as AnyObject).value(forKey: "from") as AnyObject).value(forKey: "id") as? String)!, commentByImage: nil))
                    }
                }
                } catch {
                    print(error)
                }
            }
        
        } catch {
            print(error)
        }
        return comments
    }
    
    
    
    func fetchCoverPhoto(_ coverLink: String, completion:@escaping (_ image:UIImage)->()){
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background).async(execute: { () -> Void in
            
            
            //http://graph.facebook.com/v2.4/10150192451235958/picture?type=thumbnail
            let userImageURL = "\(self.baseUrl)\(coverLink)?type=album&access_token=\(self.accessToken!.tokenString)";
            
            let url = URL(string: userImageURL);
            
            let imageData = try? Data(contentsOf: url!);
            
            if let imageDataHas = imageData{
                let image = UIImage(data: imageData!);
                
                completion(image!)
            }
            
        })
    }
    
    func fetchNewPhoto(_ link:String, completionHandler:()->()){
        
        let fbRequest = FBSDKGraphRequest(graphPath: link, parameters: nil, httpMethod: "GET")
        
        fbRequest?.start { (connection, data, error) -> Void in
            if let gotError = error{
                print("Error: %@", gotError)
            }
            else{
                print(data)
            }
        }
    }
    
    
    
    
    func fetchAlbum(){
        
        let user = FBSDKAccessToken.current()
        
        let userImageURL = "\(self.baseUrl)\(user?.userID)/albums?access_token=\(self.accessToken!.tokenString)";
        
        let graphPath = "/\(user?.userID)/albums";
        let request =  FBSDKGraphRequest(graphPath: graphPath, parameters: nil, httpMethod: "GET")
        request?.start { (connection, result, error) -> Void in
            if let gotError = error{
                //print(gotError.description);
            }
            else{
                print(result)
                
                
                let resultdict = result as! NSDictionary
                print("Result Dict: \(resultdict)")
               // let data : NSArray = resultdict.objectForKey("data") as! NSArray
                
                let graphData : NSArray = resultdict.object(forKey: "data") as! NSArray;
                var albums:[AlbumModel] =  [AlbumModel]();
                for obj:Any in graphData{
                    let desc = (obj as AnyObject).description;
                    //println(desc);
                    let name = (obj as AnyObject).value(forKey: "name") as! String;
                    //println(name);
                    let id = (obj as AnyObject).value(forKey: "id") as! String;
                    var cover = "";
                    
                    cover = "\(id)/picture";
                    
                    
                    //println(coverLink);
                    let link = "\(id)/photos";
                    
                    let model = AlbumModel(name: name, link: link, cover:cover);
                    albums.append(model);
                    
                }
                NotificationCenter.default.post(name: Notification.Name(rawValue: "albumNotification"), object: nil, userInfo: ["data":albums]);
            }
        }
    }
    
    func logout(){
        FBSDKLoginManager().logOut()
    }
    
    func readPermission() -> [String]{
        return ["email", "user_photos", "user_friends", "public_profile"]
    }
    
    func login(){
        
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["email", "public_profile", "user_friends", "user_photos"], handler: { (result, error) -> Void in
            
            if let gotError = error{
                //got error
            }
            else if(result?.isCancelled)!{
                print("login canceled")
            }
            else{
                
                print(result?.grantedPermissions)
                if(result?.grantedPermissions.contains("email"))!{
                    
                    let request = FBSDKGraphRequest(graphPath: "me", parameters: nil, httpMethod: "GET")
                    request?.start(completionHandler: { (connection, data, error) -> Void in
                        
                        if let gotError = error{
                            //got error
                        }
                        else {
                            
                            //println(data)
                            
                            
                            let email : String = request?.value(forKey: "email") as! String;
                         //   let email : String = data.value(forKey: "name") as! String;
                            
                            let firstName : String = request?.value(forKey: "name") as! String;
                           // let firstName:String = data.value(forKey: "name") as! String;
                            
                            let userFBID : String = request?.value(forKey: "id") as! String;
                            
                          //  let userFBID:String = data.value(forKey: "id") as! String;
                            
                          //  let userFBID : String = request?.value(forKey: "id") as! String;
                            let userImageURL = "https://graph.facebook.com/\(userFBID)/picture?type=small";
                            
                            let url = URL(string: userImageURL);
                            
                            let imageData = try? Data(contentsOf: url!);
                            
                            let image = UIImage(data: imageData!);
                            
                            /*
                            print("userFBID: \(userFBID) Email \(email) \n firstName:\(firstName) \n image: \(image)");
                            
                            var userModel = User(email: email, name: firstName, image: image!, id: userFBID);
                            */
                            
                         //   NSNotificationCenter.defaultCenter().postNotificationName("PostData", object: userModel, userInfo: nil);
                        }
                    })
                    
                    self.accessToken = FBSDKAccessToken.current();
                }
                
            }
        })
    }
    
}



//import Foundation
class User{
    var email:AnyObject = "" as AnyObject;
    var name:AnyObject = "" as AnyObject;
    var id:AnyObject = "" as AnyObject;
    var image:UIImage;
    init(email:AnyObject, name:AnyObject, image:UIImage, id:AnyObject){
        self.image = image
        self.name = name;
        self.email = email;
        self.id = id
    }
}


struct AlbumImage {
    
    var smallImage: UIImage
    var bigImage: UIImage
   // var likes: [String:AnyObject?]
    //var comments: String
    
}

struct Comment{
    
    var commentString: String
    var commentBy: String
    var commentLocation: String
    var commentDate: String
    var commentByUrl: String
    var commentByImage: UIImage?
    
}

struct Like{
    var likeBy: String
    var likeDate: String
    var likeByUrl: String
    var likeByImage: UIImage?
}


/*
class Comment{
    let email:AnyObject = "";
    let name:AnyObject = "";
    let image:UIImage;
    init(email:AnyObject, name:AnyObject, image:UIImage){
        self.image = image
        self.name = name;
        self.email=email;
    }
}

class Like{
    let email:AnyObject = "";
    let name:AnyObject = "";
    let image:UIImage;
    init(email:AnyObject, name:AnyObject, image:UIImage){
        self.image = image
        self.name = name;
        self.email=email;
    }
}

class AlbumModel{
    let name = "";
    let link = "";
    let cover = "";
    init(name:String, link:String, cover:String){
        self.name = name;
        self.link = link;
        self.cover = cover;
    }
}
*/

class AlbumModel{
    var name = "";
    var link = "";
    var cover = "";
    init(name:String, link:String, cover:String){
        self.name = name;
        self.link = link;
        self.cover = cover;
    }
}
