//
//  UploadViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/17/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//
import UIKit


class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    
    @IBOutlet weak var NewImageView: UIImageView!
   // @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func uploadButtonTapped(_ sender: AnyObject) {
        
        myImageUploadRequest()
        
    }
    
    @IBAction func selectPhotoButtonTapped(_ sender: AnyObject) {
        print("selecting photo")
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
        
    {
        myImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func myImageUploadRequest()
    {
        
        let myUrl = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/UploadImage.php");
        
        var firstName = "jared"
        var lastName = "Stevens"
        var userId = "1"
        
       // var post:NSString = "firstName=\(firstName)&lastName=\(lastName)&userId=\(userId)"
        
        let request = NSMutableURLRequest(url:myUrl!);
        request.httpMethod = "POST";
        
        let imageData = UIImageJPEGRepresentation(myImageView.image!, 1)
        
        let encodedImage = imageData!.base64EncodedString(options: [])
        
        let param = ["firstName":"Jared","lastName":"Stevens","userId":"1","encodedImage":"\(encodedImage)"]
        
        print("Got Params")
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        if(imageData==nil) { return; }
        
        request.httpBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        
    //    myActivityIndicator.startAnimating();
       
       // let task = URLSession.shared.dataTask(with: request, completionHandler: (
           let task = URLSession.shared.dataTask(with: request as URLRequest) {data,response,error in
        
       // let task = URLSession.shared.dataTask(with: request as URLRequest) {
            
//        }, completionHandler: {
                
           //     data, response, error in

            
            if error != nil {
                print("error=\(error)")
                return
            
                }
            
            // You can print out response object
          //  println("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("****** response data = \(responseString!)")
            
           // println("Response Data")
            
            //   let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(responseString!, options:NSJSONReadingOptions.MutableContainers , error: nil) as! NSDictionary
            
            
                //  let imageData:NSString = responseString!.valueForKey("userId") as! NSString
                   print("Image Data: \(imageData)")
            
                   let decodedData = Data(base64Encoded: encodedImage, options: NSData.Base64DecodingOptions(rawValue: 0))
            
             print("adding new Image")
            
                 self.NewImageView.image = UIImage(data: decodedData!)
            
            DispatchQueue.main.async(execute: {
                
                
                
                //self.myActivityIndicator.stopAnimating()
                
              //  println("Clearing old Image")
                self.myImageView.image = nil;
                

            });
            
        }
        //)
        
        task.resume()
        
    }
    
    func createBodyWithParameters(_ parameters: [String: String]?, filePathKey: String?, imageDataKey: Data, boundary: String) -> Data {
        
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        
       // println("Parameters: \(parameters!)")
        
        let filename = "user-profile2.jpg"
        
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey)
        body.appendString("\r\n")
        
        body.appendString("--\(boundary)--\r\n")
        
      //  println("body: \(body)")
       // println("ImageData \(imageDataKey)")
        return body as Data
        
       
    }
    
    func generateBoundaryString() -> String {
        return "Boundary--\(UUID().uuidString)"
    }
    
    
    
}

/*

extension NSMutableData {
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}
*/
