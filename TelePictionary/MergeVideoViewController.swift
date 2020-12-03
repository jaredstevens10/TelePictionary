//
//  MergeVideoViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 10/7/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

//


import UIKit
import AVFoundation
import MobileCoreServices
import AssetsLibrary
import MediaPlayer
import CoreMedia

class MergeVideoViewController: UIViewController, UIImagePickerControllerDelegate {
    var firstAsset: AVAsset?
    var secondAsset: AVAsset?
    var audioAsset: AVAsset?
    var loadingAssetOne = false
    
    @IBOutlet var activityMonitor: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func savedPhotosAvailable() -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) == false {
            let alert = UIAlertController(title: "Not Available", message: "No Saved Album found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    func startMediaBrowserFromViewController(_ viewController: UIViewController!) -> Bool {
        
//    }, usingDelegate delegate : protocol<UIImagePickerControllerDelegate>!) -> Bool {
      //  protocol<UINavigationControllerDelegate, UIImagePickerControllerDelegate>!) -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) == false {
            return false
        }
        
        let mediaUI = UIImagePickerController()
        mediaUI.sourceType = .savedPhotosAlbum
        mediaUI.mediaTypes = [kUTTypeMovie as String]
        mediaUI.allowsEditing = true
        mediaUI.delegate = self
        present(mediaUI, animated: true, completion: nil)
        return true
    }
    
    func exportDidFinish(_ session: AVAssetExportSession) {
        if session.status == AVAssetExportSession.Status.completed {
            let outputURL = session.outputURL
            let library = ALAssetsLibrary()
            
            //SWIFT 3 Error
            print("Swift 3 error")
            /*
            if library.videoAtPathIs(compatibleWithSavedPhotosAlbum: outputURL) {
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
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                })
            }
            */
        }
        
        activityMonitor.stopAnimating()
        firstAsset = nil
        secondAsset = nil
        audioAsset = nil
    }
    
    @IBAction func loadAssetOne(_ sender: AnyObject) {
        if savedPhotosAvailable() {
            loadingAssetOne = true
            startMediaBrowserFromViewController(self)
        }
    }
    

    
    @IBAction func loadAssetTwo(_ sender: AnyObject) {
        if savedPhotosAvailable() {
            loadingAssetOne = false
            //startMediaBrowserFromViewController(self, usingDelegate: self)
            startMediaBrowserFromViewController(self)
        }
    }
    
    
    @IBAction func loadAudio(_ sender: AnyObject) {
        let mediaPickerController = MPMediaPickerController(mediaTypes: .any)
        mediaPickerController.delegate = self
        mediaPickerController.prompt = "Select Audio"
        present(mediaPickerController, animated: true, completion: nil)
    }
    
    func orientationFromTransform(_ transform: CGAffineTransform) -> (orientation: UIImage.Orientation, isPortrait: Bool) {
        var assetOrientation = UIImage.Orientation.up
        var isPortrait = false
        if transform.a == 0 && transform.b == 1.0 && transform.c == -1.0 && transform.d == 0 {
            assetOrientation = .right
            isPortrait = true
        } else if transform.a == 0 && transform.b == -1.0 && transform.c == 1.0 && transform.d == 0 {
            assetOrientation = .left
            isPortrait = true
        } else if transform.a == 1.0 && transform.b == 0 && transform.c == 0 && transform.d == 1.0 {
            assetOrientation = .up
        } else if transform.a == -1.0 && transform.b == 0 && transform.c == 0 && transform.d == -1.0 {
            assetOrientation = .down
        }
        return (assetOrientation, isPortrait)
    }
    
    func videoCompositionInstructionForTrack(_ track: AVCompositionTrack, asset: AVAsset) -> AVMutableVideoCompositionLayerInstruction {
        let instruction = AVMutableVideoCompositionLayerInstruction(assetTrack: track)
        let assetTrack = asset.tracks(withMediaType: AVMediaType.video)[0]
        
        let transform = assetTrack.preferredTransform
        let assetInfo = orientationFromTransform(transform)
        
        var scaleToFitRatio = UIScreen.main.bounds.width / assetTrack.naturalSize.width
        if assetInfo.isPortrait {
            scaleToFitRatio = UIScreen.main.bounds.width / assetTrack.naturalSize.height
            let scaleFactor = CGAffineTransform(scaleX: scaleToFitRatio, y: scaleToFitRatio)
            instruction.setTransform(assetTrack.preferredTransform.concatenating(scaleFactor),
                at: CMTime.zero)
        } else {
            let scaleFactor = CGAffineTransform(scaleX: scaleToFitRatio, y: scaleToFitRatio)
            var concat = assetTrack.preferredTransform.concatenating(scaleFactor).concatenating(CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.width / 2))
            if assetInfo.orientation == .down {
                let fixUpsideDown = CGAffineTransform(rotationAngle: CGFloat(M_PI))
                let windowBounds = UIScreen.main.bounds
                let yFix = assetTrack.naturalSize.height + windowBounds.height
                let centerFix = CGAffineTransform(translationX: assetTrack.naturalSize.width, y: yFix)
                concat = fixUpsideDown.concatenating(centerFix).concatenating(scaleFactor)
            }
            instruction.setTransform(concat, at: CMTime.zero)
        }
        
        return instruction
    }
    
    
    @IBAction func merge(_ sender: AnyObject) {
        if let firstAsset = firstAsset, let secondAsset = secondAsset {
            activityMonitor.startAnimating()
            
            // 1 - Create AVMutableComposition object. This object will hold your AVMutableCompositionTrack instances.
            let mixComposition = AVMutableComposition()
            
            // 2 - Create two video tracks
            let firstTrack = mixComposition.addMutableTrack(withMediaType: AVMediaType.video,
                preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
            
            do {
                
                try firstTrack?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: firstAsset.duration),
                of: firstAsset.tracks(withMediaType: AVMediaType.video)[0] ,
                at: CMTime.zero)
            } catch {
                print(error)
            }
            
            let secondTrack = mixComposition.addMutableTrack(withMediaType: AVMediaType.video,
                preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
            
            do {
                try secondTrack?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: secondAsset.duration),
                of: secondAsset.tracks(withMediaType: AVMediaType.video)[0] ,
                at: firstAsset.duration)
            } catch {
                print(error)
            }
            
            
            let mainInstruction = AVMutableVideoCompositionInstruction()
            mainInstruction.timeRange = CMTimeRangeMake(start: CMTime.zero, duration: CMTimeAdd(firstAsset.duration, secondAsset.duration))
            
            let firstInstruction = videoCompositionInstructionForTrack(firstTrack!, asset: firstAsset)
            firstInstruction.setOpacity(0.0, at: firstAsset.duration)
            let secondInstruction = videoCompositionInstructionForTrack(secondTrack!, asset: secondAsset)
            
            mainInstruction.layerInstructions = [firstInstruction, secondInstruction]
            let mainComposition = AVMutableVideoComposition()
            mainComposition.instructions = [mainInstruction]
            mainComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
            mainComposition.renderSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            // 3 - Audio track
            if let loadedAudioAsset = audioAsset {
                let audioTrack = mixComposition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: 0)
                do {
                    try audioTrack?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: CMTimeAdd(firstAsset.duration, secondAsset.duration)),
                    of: loadedAudioAsset.tracks(withMediaType: AVMediaType.audio)[0] ,
                    at: CMTime.zero)
                } catch {
                    print(error)
                }
            }
            
            // 4 - Get path
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] 
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .short
            let date = dateFormatter.string(from: Date())
            let savePath = (documentDirectory as NSString).appendingPathComponent("mergeVideo-\(date).mov")
            let url = URL(fileURLWithPath: savePath)
            
            // 5 - Create Exporter
            let exporter = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality)
            exporter!.outputURL = url
            exporter!.outputFileType = AVFileType.mov
            exporter!.shouldOptimizeForNetworkUse = true
            exporter!.videoComposition = mainComposition
            
            // 6 - Perform the Export
            exporter!.exportAsynchronously() {
                DispatchQueue.main.async(execute: { () -> Void in
                    self.exportDidFinish(exporter!)
                })
            }
        }
    }
    
}
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
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.Cancel, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
}
*/
extension MergeVideoViewController: UINavigationControllerDelegate {
    
}

extension MergeVideoViewController: MPMediaPickerControllerDelegate {
    func mediaPicker(_ mediaPicker: MPMediaPickerController!, didPickMediaItems mediaItemCollection: MPMediaItemCollection!) {
        let selectedSongs = mediaItemCollection.items
        if selectedSongs.count > 0 {
            let song = selectedSongs[0] 
            if let url = song.value(forProperty: MPMediaItemPropertyAssetURL) as? URL {
                audioAsset = (AVAsset(url: url) )
                dismiss(animated: true, completion: nil)
                let alert = UIAlertController(title: "Asset Loaded", message: "Audio Loaded", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
                present(alert, animated: true, completion: nil)
            } else {
                dismiss(animated: true, completion: nil)
                let alert = UIAlertController(title: "Asset Not Available", message: "Audio Not Loaded", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
                present(alert, animated: true, completion: nil)
            }
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController!) {
        dismiss(animated: true, completion: nil)
    }
}
