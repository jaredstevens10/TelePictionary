//
//  CreateVideo.swift
//  TelePictionary
//
//  Created by Jared Stevens on 10/6/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import Foundation


import UIKit
import AVFoundation
import MobileCoreServices
import AssetsLibrary
import MediaPlayer
import CoreMedia


/*
class MergeVideoViewController: UIViewController {
    var firstAsset: AVAsset?
    var secondAsset: AVAsset?
    var audioAsset: AVAsset?
    var loadingAssetOne = false
    
    @IBOutlet var activityMonitor: UIActivityIndicatorView!
    
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    */
    func savedPhotosAvailable() -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum) == false {
            let alert = UIAlertController(title: "Not Available", message: "No Saved Album found", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    func startMediaBrowserFromViewController(viewController: UIViewController!, usingDelegate delegate : protocol<UINavigationControllerDelegate, UIImagePickerControllerDelegate>!) -> Bool {
        
        if UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum) == false {
            return false
        }
        
        let mediaUI = UIImagePickerController()
        mediaUI.sourceType = .SavedPhotosAlbum
        mediaUI.mediaTypes = [kUTTypeMovie as String]
        mediaUI.allowsEditing = true
        mediaUI.delegate = delegate
        presentViewController(mediaUI, animated: true, completion: nil)
        return true
    }
    
    
    
    /*
    @IBAction func loadAssetOne(sender: AnyObject) {
        if savedPhotosAvailable() {
            loadingAssetOne = true
            startMediaBrowserFromViewController(self, usingDelegate: self)
        }
    }
    
    
    @IBAction func loadAssetTwo(sender: AnyObject) {
        if savedPhotosAvailable() {
            loadingAssetOne = false
            startMediaBrowserFromViewController(self, usingDelegate: self)
        }
    }
    */
    
    
    /*
    @IBAction func loadAudio(sender: AnyObject) {
        let mediaPickerController = MPMediaPickerController(mediaTypes: .Any)
        mediaPickerController.delegate = self
        mediaPickerController.prompt = "Select Audio"
        presentViewController(mediaPickerController, animated: true, completion: nil)
    }

*/
    
    func orientationFromTransform(transform: CGAffineTransform) -> (orientation: UIImageOrientation, isPortrait: Bool) {
        var assetOrientation = UIImageOrientation.Up
        var isPortrait = false
        if transform.a == 0 && transform.b == 1.0 && transform.c == -1.0 && transform.d == 0 {
            assetOrientation = .Right
            isPortrait = true
        } else if transform.a == 0 && transform.b == -1.0 && transform.c == 1.0 && transform.d == 0 {
            assetOrientation = .Left
            isPortrait = true
        } else if transform.a == 1.0 && transform.b == 0 && transform.c == 0 && transform.d == 1.0 {
            assetOrientation = .Up
        } else if transform.a == -1.0 && transform.b == 0 && transform.c == 0 && transform.d == -1.0 {
            assetOrientation = .Down
        }
        return (assetOrientation, isPortrait)
    }
    
    func videoCompositionInstructionForTrack(track: AVCompositionTrack, asset: AVAsset) -> AVMutableVideoCompositionLayerInstruction {
        let instruction = AVMutableVideoCompositionLayerInstruction(assetTrack: track)
        let assetTrack = asset.tracksWithMediaType(AVMediaTypeVideo)[0] 
        
        let transform = assetTrack.preferredTransform
        let assetInfo = orientationFromTransform(transform)
        
        var scaleToFitRatio = UIScreen.mainScreen().bounds.width / assetTrack.naturalSize.width
        if assetInfo.isPortrait {
            scaleToFitRatio = UIScreen.mainScreen().bounds.width / assetTrack.naturalSize.height
            let scaleFactor = CGAffineTransformMakeScale(scaleToFitRatio, scaleToFitRatio)
            instruction.setTransform(CGAffineTransformConcat(assetTrack.preferredTransform, scaleFactor),
                atTime: kCMTimeZero)
        } else {
            let scaleFactor = CGAffineTransformMakeScale(scaleToFitRatio, scaleToFitRatio)
            var concat = CGAffineTransformConcat(CGAffineTransformConcat(assetTrack.preferredTransform, scaleFactor), CGAffineTransformMakeTranslation(0, UIScreen.mainScreen().bounds.width / 2))
            if assetInfo.orientation == .Down {
                let fixUpsideDown = CGAffineTransformMakeRotation(CGFloat(M_PI))
                let windowBounds = UIScreen.mainScreen().bounds
                let yFix = assetTrack.naturalSize.height + windowBounds.height
                let centerFix = CGAffineTransformMakeTranslation(assetTrack.naturalSize.width, yFix)
                concat = CGAffineTransformConcat(CGAffineTransformConcat(fixUpsideDown, centerFix), scaleFactor)
            }
            instruction.setTransform(concat, atTime: kCMTimeZero)
        }
        
        return instruction
    }
    */
    
    func CreateGameVideo(_ Image1: UIImage, Image2: UIImage) {
     //   if let Image1 = Image1, Image2 = Image2 {
           // activityMonitor.startAnimating()
            let audioAsset: AVAsset?
        // 1 - Create AVMutableComposition object. This object will hold your AVMutableCompositionTrack instances.
            let mixComposition = AVMutableComposition()
            
            // 2 - Create two video tracks
            
            let parentLayer:CALayer = CALayer()
           //parentLayer.fame = CGRectMake(0, 0, )
            parentLayer.frame = CGRect(x: 0, y: 0, width: Image1.size.width, height: Image1.size.height)
            let Image1Layer:CALayer = CALayer()
            Image1Layer.frame = CGRect(x: 0, y: 0, width: Image1.size.width, height: Image1.size.height)
            Image1Layer.contents = Image1.cgImage
            
            parentLayer.addSublayer(Image1Layer)
            
            let mainInstruction: AVMutableVideoCompositionInstruction = AVMutableVideoCompositionInstruction()
            mainInstruction.timeRange = CMTimeRange(start: kCMTimeZero, end: CMTimeMakeWithSeconds(100, 10))
            
            let gameVideoComposition = AVMutableVideoComposition()
            
            gameVideoComposition.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: Image1Layer, in: parentLayer)
            
           gameVideoComposition.frameDuration = CMTimeMake(1, 30)
           gameVideoComposition.renderScale = 1.0
           gameVideoComposition.renderSize = CGSize(width: 848, height: 480)
           gameVideoComposition.instructions = NSArray(array: [mainInstruction]) as! [AVVideoCompositionInstructionProtocol]
        
            /*
           
            let firstTrack = mixComposition.addMutableTrackWithMediaType(AVMediaTypeVideo,
                preferredTrackID: Int32(kCMPersistentTrackID_Invalid))

           // let firstTrack = mixComposition.addMutableTrackWithMediaType(AVMediaT,
              //  preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
            
            do {
            try firstTrack.insertTimeRange(CMTimeRangeMake(kCMTimeZero, firstAsset.duration),
                ofTrack: firstAsset.tracksWithMediaType(AVMediaTypeVideo)[0] ,
                atTime: kCMTimeZero)
            } catch {
                
            }
            
            /*firstTrack.insertTimeRange(CMTimeRangeMake(kCMTimeZero, firstAsset.duration),
                ofTrack: firstAsset.tracksWithMediaType(AVMediaTypeVideo)[0] as! AVAssetTrack,
                atTime: kCMTimeZero,
                error: nil)
            */

            let secondTrack = mixComposition.addMutableTrackWithMediaType(AVMediaTypeVideo,
                preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
            do {
                
            try secondTrack.insertTimeRange(CMTimeRangeMake(kCMTimeZero, secondAsset.duration),
                ofTrack: secondAsset.tracksWithMediaType(AVMediaTypeVideo)[0] ,
                atTime: firstAsset.duration)
            } catch {
                
            }
            
           // let mainInstruction = AVMutableVideoCompositionInstruction()
          //  mainInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, CMTimeAdd(firstAsset.duration, secondAsset.duration))
            
            let firstInstruction = videoCompositionInstructionForTrack(firstTrack, asset: firstAsset)
            firstInstruction.setOpacity(0.0, atTime: firstAsset.duration)
            let secondInstruction = videoCompositionInstructionForTrack(secondTrack, asset: secondAsset)
            
          //  mainInstruction.layerInstructions = [firstInstruction, secondInstruction]
            let mainComposition = AVMutableVideoComposition()
            mainComposition.instructions = [mainInstruction]
            mainComposition.frameDuration = CMTimeMake(1, 30)
            mainComposition.renderSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
            
            
            
            */
            
            // 3 - Audio track
        //SWIFT 3 ERROR UNUSED
        /*
        
        if let loadedAudioAsset = audioAsset {
                let audioTrack = mixComposition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: 0)
                do {
                    
                    /*
                try audioTrack.insertTimeRange(CMTimeRangeMake(kCMTimeZero, CMTimeAdd(firstAsset.duration, secondAsset!.duration)),
                    ofTrack: loadedAudioAsset.tracksWithMediaType(AVMediaTypeAudio)[0] ,
                    atTime: kCMTimeZero)
                    */
                    
                } catch {
                }
            } //else { return }
        
        */
        
            // 4 - Get path
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] 
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .short
            let date = dateFormatter.string(from: Date())
           let savePath = (documentDirectory as NSString).appendingPathComponent("mergeVideo-\(date).mov")
           // let savePath = (documentDirectory as NSString).stringByAppendingString("mergeVideo-\(date).mov")
            let url = URL(fileURLWithPath: savePath)
            
            // 5 - Create Exporter
            let exporter = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality)
            exporter!.outputURL = url
            exporter!.outputFileType = AVFileTypeQuickTimeMovie
            exporter!.shouldOptimizeForNetworkUse = true
            //exporter!.videoComposition = mainComposition
            exporter!.videoComposition = gameVideoComposition
            
            // 6 - Perform the Export
            exporter!.exportAsynchronously() {
                DispatchQueue.main.async(execute: { () -> Void in
                   exportDidFinish(exporter!)
                })
            }
      //  }
    }
    
    
    func exportDidFinish(_ session: AVAssetExportSession) {
        if session.status == AVAssetExportSessionStatus.completed {
            let outputURL = session.outputURL
            let library = ALAssetsLibrary()
            
            
            
            //SWIFT 3 Error FIXED
            print("Swift 3 error")
            
            if library.videoAtPathIs(compatibleWithSavedPhotosAlbum: outputURL) {
                library.writeVideoAtPath(toSavedPhotosAlbum: outputURL, completionBlock: { (asetURL, error) in
                    var title = ""
                    var message = ""
                    if error != nil {
                        title = "Error"
                        message = "Failed to save video"
                    } else {
                        title = "Success"
                        message = "Video saved"
                    }
                    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                })
                /*
                library.writeVideoAtPath(toSavedPhotosAlbum: outputURL,
                    completionBlock: { (assetURL:URL!, error: Error!) -> Void in
                        var title = ""
                        var message = ""
                        if error != nil {
                            title = "Error"
                            message = "Failed to save video"
                        } else {
                            title = "Success"
                            message = "Video saved"
                        }
                        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                      //  self.presentViewController(alert, animated: true, completion: nil)
                })
                */
            }
            
            
        }
        
      //  activityMonitor.stopAnimating()
       // firstAsset = nil
       // secondAsset = nil
       // audioAsset = nil
    }
    
    
    
    
//}


/*
extension MergeVideoViewController {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        dismissViewControllerAnimated(true, completion: nil)
        
        if mediaType == kUTTypeMovie {
            let avAsset = AVAsset(URL: info[UIImagePickerControllerMediaURL] as! NSURL)
            var message = ""
            if loadingAssetOne {
                message = "Video one loaded"
                firstAsset = avAsset
            } else {
                message = "Video two loaded"
                secondAsset = avAsset
            }
            let alert = UIAlertController(title: "Asset Loaded", message: message, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
}

extension MergeVideoViewController: UINavigationControllerDelegate {
    
}

extension MergeVideoViewController: MPMediaPickerControllerDelegate {
    func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        let selectedSongs = mediaItemCollection.items
        if selectedSongs.count > 0 {
            let song = selectedSongs[0] 
            if let url = song.valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL {
                audioAsset = (AVAsset(URL: url) )
                dismissViewControllerAnimated(true, completion: nil)
                let alert = UIAlertController(title: "Asset Loaded", message: "Audio Loaded", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler:nil))
                presentViewController(alert, animated: true, completion: nil)
            } else {
                dismissViewControllerAnimated(true, completion: nil)
                let alert = UIAlertController(title: "Asset Not Available", message: "Audio Not Loaded", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler:nil))
                presentViewController(alert, animated: true, completion: nil)
            }
        } else {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

*/


func createVideoFromImage(_ img: CGImage) -> Void {
    
    
    let maxImageSize = UIImage(cgImage: img)
    
    let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .short
    let date = dateFormatter.string(from: Date())
    let savePath = (documentDirectory as NSString).appendingPathComponent("mergeVideo-\(date).mov")
    // let savePath = (documentDirectory as NSString).stringByAppendingString("mergeVideo-\(date).mov")
    let url = URL(fileURLWithPath: savePath)
    var error: NSError?
    
    
    var frameSize = CGSize(width: CGFloat(img.width), height: CGFloat(img.height))
    /*
    if frameSize.width > maxImageSize.width || frameSize.heigh > maxImageSize.height {
        let scale = min((maxImageSize.width/frameSize.width), (maxImageSize.height/frameSize.height))
        frameSize = CGSizemake((scale * frameSize.width), (scale * frameSize.height))
    }
    */
    if frameSize.width > 200 || frameSize.height > 200 {
        let scale = min((200/frameSize.width), (200/frameSize.height))
        frameSize = CGSize(width: (scale * frameSize.width), height: (scale * frameSize.height))
    }

    
    //let fileName = "\(uniqueString()).m4v"
    //let fileName = "TestVideo.m4v"
   // let assetWriter: AVAssetWriter?
    
    do {
        
    let assetWriter = try AVAssetWriter(outputURL: url, fileType: AVFileTypeAppleM4V)
        
        //let assetWriter = AVAssetWriter(URL: url, fileType: AVFileTypeAppleM4V, error: &error)
    
    let outputSettings = [
        AVVideoCodecKey: AVVideoCodecH264,
        AVVideoWidthKey: frameSize.width,
        AVVideoHeightKey: frameSize.height
    ] as [String : Any]
    
    let assetWriterInput = AVAssetWriterInput(mediaType: AVMediaTypeVideo, outputSettings: outputSettings as [String : AnyObject])
    
    let pixelBufferAdaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: assetWriterInput, sourcePixelBufferAttributes: nil)
    
    if assetWriter.canAdd(assetWriterInput) {
        assetWriter.add(assetWriterInput)
    }
    
    assetWriter.startWriting()
    assetWriter.startSession(atSourceTime: kCMTimeZero)
    
        do {
        
    let buffer:CVPixelBuffer = try pixelBufferFromCGImage(img, frameSize: frameSize)
        
           
    if pixelBufferAdaptor.assetWriterInput.isReadyForMoreMediaData {
        let frameTime = CMTimeMakeWithSeconds(0, 30)
        let pixelBufferAppend = pixelBufferAdaptor.append(buffer, withPresentationTime: frameTime)
        
        if pixelBufferAppend {
            assetWriterInput.markAsFinished()
            
            assetWriter.finishWriting { () -> Void in
                switch assetWriter.status {
                case AVAssetWriterStatus.failed:
                    print("Error: \(assetWriter.error)")
                default:
                   // let path = self.fileUrl(fileName).path!
                    let path = url.path
                    let content = FileManager.default.contents(atPath: path)
                    print("Video: \(path) \(content?.count)")
                }
            }
        } else {
            print("failed to append pixel buffer")
        }
    }
            
    } catch {
            print("Buffer Error = \(error)")
    }

            
    
    } catch {
        print(error)
    }
    
    
}

func pixelBufferFromCGImage (_ img: CGImage, frameSize: CGSize) -> CVPixelBuffer {
    
    let options = [
        "kCVPixelBufferCGImageCompatibilityKey": true,
        "kCVPixelBufferCGBitmapContextCompatibilityKey": true
    ]
    //let sampleBuffer: Unmanaged<CMSampleBuffer>?
    var pixelBufferPointer = UnsafeMutablePointer<Unmanaged<CVPixelBuffer>?>.allocate(capacity: 1)
    
    //var pixelBufferPointer : CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
    // var pixleBufferPoint = UnsafeMutablePointer<
    
   _ = CVPixelBufferCreate(kCFAllocatorDefault, Int(frameSize.width),  Int(frameSize.height), OSType(kCVPixelFormatType_32ARGB), options as CFDictionary?, UnsafeMutablePointer<CVPixelBuffer?>.allocate(capacity: 1))
    
   // let buffered = CVPixelBufferCreate(<#T##allocator: CFAllocator?##CFAllocator?#>, <#T##width: Int##Int#>, <#T##height: Int##Int#>, <#T##pixelFormatType: OSType##OSType#>, <#T##pixelBufferAttributes: CFDictionary?##CFDictionary?#>, <#T##pixelBufferOut: UnsafeMutablePointer<CVPixelBuffer?>##UnsafeMutablePointer<CVPixelBuffer?>#>)
    
  //  let buffered = CVPixelBufferCreate(nil, Int(frameSize.width), Int(frameSize.height), OSType(kCVPixelFormatType_32ARGB), options as CFDictionary?, nil)
    
   
    
   // let buffered:CVReturn = CVPixelBufferCreate(kCFAllocatorDefault, Int(frameSize.width), Int(frameSize.height), OSType(kCVPixelFormatType_32ARGB), options, UnsafeMutablePointer<CVPixelBuffer?>.alloc(1))
    do {
        

        try CVPixelBufferLockBaseAddress((pixelBufferPointer.pointee?.takeUnretainedValue())!, CVPixelBufferLockFlags(rawValue: CVOptionFlags(0)));
        
        //, 0)
  
    
       
    
    } catch {
        print(error)
    }
   // let rbgColorSpace = CGColorSpaceCreateDeviceRGB()
    
   // let lockBaseAddress = CVPixelBufferLockBaseAddress((pixelBufferPointer.memory?.takeUnretainedValue())!, 0)
    var pixelData:UnsafeMutableRawPointer = CVPixelBufferGetBaseAddress((pixelBufferPointer.pointee?.takeUnretainedValue())!)!
    
  //  let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.NoneSkipFirst.rawValue)
    let space:CGColorSpace = CGColorSpaceCreateDeviceRGB()
    
    //var context:CGContextRef = CGBitmapContextCreate(pixelData, Int(frameSize.width), Int(frameSize.height), 8, CVPixelBufferGetBytesPerRow((pixelBufferPointer.memory?.takeUnretainedValue())!), space, bitmapInfo)
    
    var context:CGContext = CGContext(data: pixelData, width: Int(frameSize.width), height: Int(frameSize.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow((pixelBufferPointer.pointee?.takeUnretainedValue())!), space: space, bitmapInfo: UInt32(CGImageAlphaInfo.noneSkipLast.rawValue))!
    
    context.draw(img, in: CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height))
    
    CVPixelBufferUnlockBaseAddress((pixelBufferPointer.pointee?.takeUnretainedValue())!, CVPixelBufferLockFlags(rawValue: CVOptionFlags(0)))
    
    return pixelBufferPointer.pointee!.takeUnretainedValue()
}

/*
func createVideoFromImage2(img: CGImageRef) -> Void {
    
    var error: NSError?
    let frameSize = CGSizeMake(CGFloat(CGImageGetWidth(img)), CGFloat(CGImageGetHeight(img)))
    var uniqueString = "TestSaveVideo"
    let fileName = "\(uniqueString).m4v"
    let assetWriter = AVAssetWriter(URL: fileUrl(fileName), fileType: AVFileTypeAppleM4V, error: &error)
    
    let outputSettings = [
        AVVideoCodecKey: AVVideoCodecH264,
        AVVideoWidthKey: frameSize.width,
        AVVideoHeightKey: frameSize.height
    ]
    
    let assetWriterInput = AVAssetWriterInput(mediaType: AVMediaTypeVideo, outputSettings: outputSettings)
    
    let pixelBufferAdaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: assetWriterInput, sourcePixelBufferAttributes: nil)
    
    if assetWriter.canAddInput(assetWriterInput) {
        assetWriter.addInput(assetWriterInput)
    }
    
    assetWriter.startWriting()
    assetWriter.startSessionAtSourceTime(kCMTimeZero)
    
    let buffer:CVPixelBufferRef = pixelBufferFromCGImage(img, frameSize: frameSize)
    
    if pixelBufferAdaptor.assetWriterInput.readyForMoreMediaData {
        let frameTime = CMTimeMakeWithSeconds(0, 30)
        let pixelBufferAppend = pixelBufferAdaptor.appendPixelBuffer(buffer, withPresentationTime: frameTime)
        
        if pixelBufferAppend {
            assetWriterInput.markAsFinished()
            
            assetWriter.finishWritingWithCompletionHandler { () -> Void in
                switch assetWriter.status {
                case AVAssetWriterStatus.Failed:
                    println("Error: \(assetWriter.error)")
                default:
                    let path = self.fileUrl(fileName).path!
                    let content = NSFileManager.defaultManager().contentsAtPath(path)
                    println("Video: \(path) \(content?.length)")
                }
            }
        } else {
            println("failed to append pixel buffer")
        }
    }
    
    
}

func pixelBufferFromCGImage (img: CGImageRef, frameSize: CGSize) -> CVPixelBufferRef {
    
    let options = [
        "kCVPixelBufferCGImageCompatibilityKey": true,
        "kCVPixelBufferCGBitmapContextCompatibilityKey": true
    ]
    
    var pixelBufferPointer = UnsafeMutablePointer<Unmanaged<CVPixelBuffer>?>.alloc(1)
    
    let buffered:CVReturn = CVPixelBufferCreate(kCFAllocatorDefault, UInt(frameSize.width), UInt(frameSize.height), OSType(kCVPixelFormatType_32ARGB), options, pixelBufferPointer)
    
    let lockBaseAddress = CVPixelBufferLockBaseAddress(pixelBufferPointer.memory?.takeUnretainedValue(), 0)
    var pixelData:UnsafeMutablePointer<(Void)> = CVPixelBufferGetBaseAddress(pixelBufferPointer.memory?.takeUnretainedValue())
    
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.NoneSkipFirst.rawValue)
    let space:CGColorSpace = CGColorSpaceCreateDeviceRGB()
    
    var context:CGContextRef = CGBitmapContextCreate(pixelData, UInt(frameSize.width), UInt(frameSize.height), 8, CVPixelBufferGetBytesPerRow(pixelBufferPointer.memory?.takeUnretainedValue()), space, bitmapInfo)
    
    CGContextDrawImage(context, CGRectMake(0, 0, frameSize.width, frameSize.height), img)
    
    CVPixelBufferUnlockBaseAddress(pixelBufferPointer.memory?.takeUnretainedValue(), 0)
    
    return pixelBufferPointer.memory!.takeUnretainedValue()
}


*/
