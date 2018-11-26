//
//  UIView.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/23/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit

class ProgressHUD: UIVisualEffectView {
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
   
    let label: UILabel = UILabel()
    let blurEffect = UIBlurEffect(style: .light)
    let vibrancyView: UIVisualEffectView
    let LoadView = UIView()
    
    init(text: String) {
        self.text = text
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.text = ""
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
       // self.LoadView =
        super.init(coder: aDecoder)
        self.setup()
        
    }
    
    func setup() {
        
  
       // contentView.addSubview(vibrancyView)
        contentView.addSubview(LoadView)
        contentView.backgroundColor = UIColor.black
        contentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
   /*
        vibrancyView.contentView.addSubview(activityIndictor)
        vibrancyView.contentView.addSubview(label)
    */
        LoadView.addSubview(label)
        LoadView.addSubview(activityIndictor)
        label.textColor = UIColor.white
        
        
        activityIndictor.color = UIColor.white
        activityIndictor.startAnimating()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superview = self.superview {
            
            let width = superview.frame.size.width / 1.25  //2.3
            let height: CGFloat = 100.0 //50.0
          
            self.frame = CGRect(x: superview.frame.size.width / 2 - width / 2,
                y: superview.frame.height / 2 - height / 2, width: width, height: height)
            self.layer.cornerRadius = 50
            
            
           // vibrancyView.frame = self.bounds
            LoadView.layer.cornerRadius = 50
            LoadView.frame = self.bounds
            
          //layer.backgroundColor = UIColor.blackColor().CGColor
            
            let activityIndicatorSize: CGFloat = 40
            activityIndictor.frame = CGRect(x: self.frame.width / 7, y: height / 2 - activityIndicatorSize / 2,
                width: activityIndicatorSize,
                height: activityIndicatorSize)
            activityIndictor.color = UIColor.white
//            activityIndictor.color = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
            //8.0
            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            label.text = text
           // label.textColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
            
            label.textColor = UIColor.white
            
            label.textAlignment = NSTextAlignment.center
            //label.frame = CGRectMake(activityIndicatorSize + 5, 0, width - activityIndicatorSize - 15, height)
            
            label.frame = CGRect(x: (self.frame.width / 7) + (activityIndicatorSize) - 10, y: 0, width: width - activityIndicatorSize - 15, height: height)
            //label.textColor = UIColor.grayColor()
            label.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
}

class ProgressHUD2: UIVisualEffectView {
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    let label: UILabel = UILabel()
    let blurEffect = UIBlurEffect(style: .light)
    let vibrancyView: UIVisualEffectView
    let LoadView = UIView()
    
    init(text: String) {
        self.text = text
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.text = ""
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        // self.LoadView =
        super.init(coder: aDecoder)
        self.setup()
        
    }
    
    func setup() {
        
        
        // contentView.addSubview(vibrancyView)
        contentView.addSubview(LoadView)
        contentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
      //  contentView.
        /*
        vibrancyView.contentView.addSubview(activityIndictor)
        vibrancyView.contentView.addSubview(label)
        */
      //  LoadView.s
        LoadView.addSubview(label)
        LoadView.addSubview(activityIndictor)
        label.textColor = UIColor.white
        
        
        activityIndictor.color = UIColor.white
        activityIndictor.startAnimating()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superview = self.superview {
            
            let width = superview.frame.size.width / 1.25  //2.3
            let height: CGFloat = 100.0 //50.0
            
            self.frame = CGRect(x: superview.frame.size.width,
                y: superview.frame.height, width: width, height: height)
            self.layer.cornerRadius = 50
            
            
            // vibrancyView.frame = self.bounds
            LoadView.layer.cornerRadius = 50
            LoadView.frame = self.bounds
            
            //layer.backgroundColor = UIColor.blackColor().CGColor
            
            let activityIndicatorSize: CGFloat = 40
            activityIndictor.frame = CGRect(x: self.frame.width / 7, y: height / 2 - activityIndicatorSize / 2,
                width: activityIndicatorSize,
                height: activityIndicatorSize)
            activityIndictor.color = UIColor.white
            //            activityIndictor.color = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
            //8.0
            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            label.text = text
            // label.textColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
            
            label.textColor = UIColor.white
            
            label.textAlignment = NSTextAlignment.center
            //label.frame = CGRectMake(activityIndicatorSize + 5, 0, width - activityIndicatorSize - 15, height)
            
            label.frame = CGRect(x: (self.frame.width / 7) + (activityIndicatorSize) - 10, y: 0, width: width - activityIndicatorSize - 15, height: height)
            //label.textColor = UIColor.grayColor()
            label.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
}



class ProgressHUDHow: UIVisualEffectView {
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    let label: UILabel = UILabel()
    let blurEffect = UIBlurEffect(style: .light)
    let vibrancyView: UIVisualEffectView
    let LoadView = UIView()
    
    init(text: String) {
        self.text = text
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.text = ""
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        // self.LoadView =
        super.init(coder: aDecoder)
        self.setup()
        
    }
    
    func setup() {
        
        
        // contentView.addSubview(vibrancyView)
        contentView.addSubview(LoadView)
        contentView.backgroundColor = UIColor.black
        contentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        /*
        vibrancyView.contentView.addSubview(activityIndictor)
        vibrancyView.contentView.addSubview(label)
        */
        LoadView.addSubview(label)
        LoadView.addSubview(activityIndictor)
        label.textColor = UIColor.white
        
        
        activityIndictor.color = UIColor.white
        activityIndictor.isHidden = true
       // activityIndictor.startAnimating()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superview = self.superview {
            
            let width = superview.frame.size.width / 1.25  //2.3
            let height: CGFloat = 100.0 //50.0
            
            self.frame = CGRect(x: superview.frame.size.width / 2 - width / 2,
                y: superview.frame.height / 2 - height / 2, width: width, height: height)
            self.layer.cornerRadius = 50
            
            
            // vibrancyView.frame = self.bounds
            LoadView.layer.cornerRadius = 50
            LoadView.frame = self.bounds
            
            //layer.backgroundColor = UIColor.blackColor().CGColor
            
            let activityIndicatorSize: CGFloat = 40
            activityIndictor.frame = CGRect(x: self.frame.width / 7, y: height / 2 - activityIndicatorSize / 2,
                width: activityIndicatorSize,
                height: activityIndicatorSize)
            activityIndictor.color = UIColor.white
            //            activityIndictor.color = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
            //8.0
            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            label.text = text
            // label.textColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
            
            label.textColor = UIColor.white
            
            label.textAlignment = NSTextAlignment.center
            //label.frame = CGRectMake(activityIndicatorSize + 5, 0, width - activityIndicatorSize - 15, height)
            
            label.frame = CGRect(x: 10, y: 0, width: width - 15, height: height)
            
          //  label.frame = CGRectMake((self.frame.width / 7) + (activityIndicatorSize) - 10, 0, width - activityIndicatorSize - 15, height)
            //label.textColor = UIColor.grayColor()
            label.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
}


class PixieHowTo: UIVisualEffectView {
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    var image: UIImage? {
        didSet {
            theImageView.image = image
        }
    }
    
    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    let label: UILabel = UILabel()
    let theImageView: UIImageView = UIImageView()
    let blurEffect = UIBlurEffect(style: .light)
    let vibrancyView: UIVisualEffectView
    let LoadView = UIView()
    
    init(text: String, image: UIImage) {
        self.text = text
        self.image = image
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        self.setup()
    }
    /*
    init(image: UIImage) {
        self.image = image
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blurEffect))
        super.init(effect: blurEffect)
        self.setup()

    }
    */
    required init?(coder aDecoder: NSCoder) {
        self.text = ""
        self.image = nil
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        // self.LoadView =
        super.init(coder: aDecoder)
        self.setup()
        
    }
    
    func setup() {
        
        
        let button   = UIButton(type: UIButtonType.system) as UIButton
        button.frame = CGRect(x: 50, y: 80, width: 15, height: 15)
        button.backgroundColor = UIColor.black
        button.setTitle("Ok", for: UIControlState())
        button.addTarget(self, action: #selector(PixieHowTo.buttonAction(_:)), for: UIControlEvents.touchUpInside)

        
        // contentView.addSubview(vibrancyView)
        contentView.addSubview(LoadView)
        contentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        //  contentView.
        /*
        vibrancyView.contentView.addSubview(activityIndictor)
        vibrancyView.contentView.addSubview(label)
        */
        //  LoadView.s
        LoadView.addSubview(label)
        LoadView.addSubview(theImageView)
        LoadView.addSubview(button)
      //  LoadView.addSubview(activityIndictor)
        label.textColor = UIColor.white
        
        
        activityIndictor.color = UIColor.white
        activityIndictor.startAnimating()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superview = self.superview {
            
            let width = superview.frame.size.width / 1.25  //2.3
            let height: CGFloat = 100.0 //50.0
            
            self.frame = CGRect(x: superview.frame.size.width,
                y: superview.frame.height, width: width, height: height)
            self.layer.cornerRadius = 50
            
            
            // vibrancyView.frame = self.bounds
            LoadView.layer.cornerRadius = 50
            LoadView.frame = self.bounds
            
            //layer.backgroundColor = UIColor.blackColor().CGColor
            
            let activityIndicatorSize: CGFloat = 40
            activityIndictor.frame = CGRect(x: self.frame.width / 7, y: height / 2 - activityIndicatorSize / 2,
                width: activityIndicatorSize,
                height: activityIndicatorSize)
            activityIndictor.color = UIColor.white
            //            activityIndictor.color = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
            //8.0
            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            label.text = text
            
            // label.textColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
            
            label.textColor = UIColor.white
            label.textAlignment = NSTextAlignment.center
            //label.frame = CGRectMake(activityIndicatorSize + 5, 0, width - activityIndicatorSize - 15, height)
            
            label.frame = CGRect(x: (self.frame.width / 7) + (activityIndicatorSize) - 10, y: 0, width: width - activityIndicatorSize - 15, height: height)
            //label.textColor = UIColor.grayColor()
            label.font = UIFont.boldSystemFont(ofSize: 16)
            
            theImageView.image = image
            theImageView.image?.draw(in: CGRect(x: 5,y: 5,width: 50,height: 50))
            
        }
    }
    
    func buttonAction(_ sender:UIButton!)
    {
        self.isHidden = true
    }
    
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
}


class MyWidgetView: UIView {
    
    @IBOutlet var view: UIView!;
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        
        Bundle.main.loadNibNamed("MyWidgetView", owner: self, options: nil);
        self.addSubview(self.view);
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superview = self.superview {
            //let width = superview.frame.size.width / 1.25  //2.3
            let width: CGFloat = 200.0
            let height: CGFloat = 200.0 //50.0
            
            self.frame = CGRect(x: superview.frame.size.width,
                y: superview.frame.height, width: width, height: height)
            self.layer.cornerRadius = 50
 
        }
        
    }
    
}


import UIKit
import ImageIO
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


extension UIImage {
    
    public class func gifWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("SwiftGif: Source for the image does not exist")
            return nil
        }
        return UIImage.animatedImageWithSource(source)
    }
    
    public class func gifWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main.url(forResource: name, withExtension: "gif") else {
            print("SwiftGif: This image named \"\(name)\" does not exist")
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        return gifWithData(imageData)
    }
    
    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        // Get dictionaries
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(
            CFDictionaryGetValue(cfProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
            to: CFDictionary.self)
        
        // Get delay time
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.1 {
            delay = 0.1 // Make sure they're not too fast
        }
        
        return delay
    }
    
    class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a, b = b
        // Check if one of them is nil
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        // Swap for modulo
        if a < b {
            let c = a
            a = b
            b = c
        }
        
        // Get greatest common divisor
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b! // Found it
            } else {
                a = b
                b = rest
            }
        }
    }
    
    class func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        // Fill arrays
        for i in 0..<count {
            // Add image
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            // At it's delay in cs
            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        // Calculate full duration
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        // Get frames
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        // Heyhey
        let animation = UIImage.animatedImage(with: frames,
            duration: Double(duration) / 1000.0)
        
        return animation
    }
    
}


class DashedBorderView: UIView {
    
    var _border:CAShapeLayer!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        _border = CAShapeLayer();
        _border.lineWidth = 4
        _border.strokeColor = UIColor.red.cgColor;
        _border.fillColor = nil;
        _border.lineDashPattern = [4, 4];
        self.layer.addSublayer(_border);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _border.path = UIBezierPath(roundedRect: self.bounds, cornerRadius:8).cgPath;
        _border.frame = self.bounds;
    }
}


class PartialTransparentMaskView: UIView{
    var transparentRects: Array<CGRect>?
    var transparentCircles: Array<CGRect>?
    weak var targetView: UIView?
    
    init(frame: CGRect, backgroundColor: UIColor?, transparentRects: Array<CGRect>?, transparentCircles: Array<CGRect>?, targetView: UIView?) {
        super.init(frame: frame)
        
        if((backgroundColor) != nil){
            self.backgroundColor = backgroundColor
        }
        
        self.transparentRects = transparentRects
        self.transparentCircles = transparentCircles
        self.targetView = targetView
        self.isOpaque = false
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        backgroundColor?.setFill()
        UIRectFill(rect)
        
        // clear the background in the given rectangles
        if let rects = transparentRects {
            for aRect in rects {
                
                let holeRectIntersection = aRect.intersection(rect )
                
                UIColor.clear.setFill();
                UIRectFill(holeRectIntersection);
            }
        }
        
        if let circles = transparentCircles {
            for aRect in circles {
                
                let holeRectIntersection = aRect
                
                let context = UIGraphicsGetCurrentContext();
                
                if( holeRectIntersection.intersects(rect ) )
                {
                    context?.addEllipse(in: holeRectIntersection);
                    context?.clip();
                    context?.clear(holeRectIntersection);
                    context?.setFillColor(UIColor.clear.cgColor)
                    context?.fill(holeRectIntersection);
                }
            }
        }
    }
}


class RemindPointsView: UIView {
    
    var isOpen = Bool()
    
    @IBOutlet weak var theView: UIView!
    @IBOutlet weak var pixieImage: UIImageView!
   
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var remindLBL: UILabel!
    @IBOutlet weak var BGView: UIView!
    
    var buttonClicked = Bool()
    
    
    var text: String? {
        didSet {
            remindLBL.text = text
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let subView: UIView = loadViewFromNib()
        let bounds = UIScreen.main.bounds
        
        
        let DeviceH = bounds.size.height
        //let halfH = DeviceH / 2;
        let DeviceW = bounds.size.width
        //let WLess10 = DeviceW - 10;
        let startX = (DeviceW / 2) - 125;
        let startY = (DeviceH / 2) - 125;
        print("Start x = \(startX)")
        //subView.layer.masksToBounds = true
       // subView.clipsToBounds = true
       // subView.layer.cornerRadius = 10
        
       // myRemindView.alpha = 0.0
       // myRemindView.frame = CGRectMake(startX, startY, 250, 250)
        //subView.frame = CGRectMake(startX, startY, 250, 250)
        subView.frame = self.bounds
        //label1.text = "123" //would cause error
        addSubview(subView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadViewFromNib() -> UIView {
        let view: UIView = UINib(nibName: "RemindPoints", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        return view
    }

    
   
    
   /*
    var text: String? {
        didSet {
            remindLBL.text = text
        }
    }
    
    
    init(text: String) {
        self.text = text
        //self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blurEffect))
       // super.init(effect: blurEffect)
        super.init()
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {

        self.text = ""
        fatalError("init(coder:) has not been implemented")
        self.setup()
    }
    
    func setup() {

    }
*/
    
    override func awakeFromNib() {
        
        hideBTN.layer.cornerRadius = 10
        hideBTN.layer.borderColor = UIColor.white.cgColor
        hideBTN.layer.borderWidth = 1
        
    }
    
    
    /*
    
    override func awakeFromNib() {
        theView.layer.cornerRadius = 10
        theView.clipsToBounds = true
        theView.layer.masksToBounds = true
        
        hideBTN.layer.cornerRadius = 10
        hideBTN.layer.borderColor = UIColor.whiteColor().CGColor
        hideBTN.layer.borderWidth = 1
        
        BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).CGColor
        
        var bounds = UIScreen.mainScreen().bounds
        let DeviceH = bounds.size.height
        //let halfH = DeviceH / 2;
        let DeviceW = bounds.size.width
        //let WLess10 = DeviceW - 10;
        let startX = (DeviceW / 2) - 125;
        let startY = (DeviceH / 2) - 125;
        
        self.frame = CGRectMake(startX, startY, 250, 250)
        
    }


    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
  
*/

    /*
    override init (frame : CGRect) {
    super.init(frame : frame)
    addBehavior()
    }
    
    convenience init () {
    self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
    }
    
    func addBehavior (){
    print("Add all the behavior here")
    }
    
    */
    /*
    required public init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    */
    
    @IBAction func hideBTN(_ sender: AnyObject) {
        
        UIView.animate(withDuration: 0.75, animations: {
            self.alpha = 0.0
        })
        
        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            //self.Off()
            buttonClicked = false
        } else {
            //self.On()
            buttonClicked = true
        }
        
    }
    
    
    class func instanceFromNib() -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = UIView()
        
        
       // let bounds = UIScreen.mainScreen().bounds
        let DeviceH = bounds.size.height
        //let halfH = DeviceH / 2;
        let DeviceW = bounds.size.width
        //let WLess10 = DeviceW - 10;
        let startX = (DeviceW / 2) - 125;
        let startY = (DeviceH / 2) - 125;
        
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        
        
        
        
        Nib = UINib(nibName: "RemindPoints", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
}

