//
//  AtomicElementView.swift
//  AtomicElements
//
//  Created by larryhou on 10/29/14.
//  Copyright (c) 2014 larryhou. All rights reserved.
//

import Foundation
import UIKit

@objc protocol AtomicElementViewDelegate
{
    func didTap(target:AtomicElementView, sender:UITapGestureRecognizer)
}

@IBDesignable
class AtomicElementView:UIView
{
    @IBInspectable
    var backgroundImage:UIImage!
    
    @IBInspectable
    var atomicNumber:Int = 47
    
    @IBInspectable
    var symbol:String = "Ag"
    
    @IBInspectable
    var name:String = "Silver"
    
    weak var delegate:AtomicElementViewDelegate?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setup()
    }

    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup()
    {
        backgroundColor = UIColor.clearColor()
        setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "didTap:")
        addGestureRecognizer(tapGesture)
    }
    
    func didTap(sender:UITapGestureRecognizer)
    {
        delegate?.didTap(self, sender: sender)
    }
    
    override func canBecomeFirstResponder() -> Bool
    {
        return true
    }
    
    override func drawRect(rect: CGRect)
    {
        var bounds = CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height)
        backgroundImage.drawInRect(bounds)
        
        UIColor.whiteColor().set()
        
        var fontAttr = NSDictionary(objectsAndKeys: UIFont.boldSystemFontOfSize(48), NSFontAttributeName)
        var point = CGPointMake(10, 0)
        NSString(string: "\(atomicNumber)").drawAtPoint(point, withAttributes: fontAttr)
        
        fontAttr = NSDictionary(objectsAndKeys:UIFont.boldSystemFontOfSize(36), NSFontAttributeName)
        var size = NSString(string: name).sizeWithAttributes(fontAttr)
        point = CGPointMake((bounds.width - size.width) / 2, bounds.height / 2 - size.height - 10)
        NSString(string: name).drawAtPoint(point, withAttributes: fontAttr)
        
        fontAttr = NSDictionary(objectsAndKeys: UIFont.boldSystemFontOfSize(96), NSFontAttributeName)
        size = NSString(string: symbol).sizeWithAttributes(fontAttr)
        point = CGPointMake((bounds.width - size.width) / 2, bounds.height - size.height - 10)
        NSString(string: symbol).drawAtPoint(point, withAttributes: fontAttr)
    }
    
    //MARK: 获取截图
    func getContextImage()->UIImage
    {
        UIGraphicsBeginImageContext(bounds.size)
        var context = UIGraphicsGetCurrentContext()
        
        layer.renderInContext(context)
        
        var result = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return result
    }
}

@IBDesignable
class FlippedAtomicElementView:AtomicElementView
{    
    @IBInspectable
    var atomicWeight:Double = 108
    
    @IBInspectable
    var state:String = "Gas"
    
    @IBInspectable
    var period:Int = 6
    
    @IBInspectable
    var group:Int = 5
    
    @IBInspectable
    var discoverYear:String = "1922"
    
    @IBAction func jumpToWikipedia(sender: UIButton)
    {
        var url = NSURL(string: "http://en.wikipedia.org/wiki/\(name)")!
        if !UIApplication.sharedApplication().openURL(url)
        {
            UIAlertView(title: "ERROR", message: "Error occurs on opening \(url.description)", delegate: nil, cancelButtonTitle: "").show()
        }
    }
    
    override func drawRect(rect: CGRect)
    {
        var bounds = CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height)
        backgroundImage.drawInRect(bounds)
        
        UIColor.whiteColor().set()
        
        var point:CGPoint, size:CGSize
        var fontAttr:NSDictionary, text:NSString
        
        fontAttr = NSDictionary(objectsAndKeys: UIFont.boldSystemFontOfSize(32), NSFontAttributeName)
        point = CGPointMake(10, 5)
        NSString(string: "\(atomicNumber)").drawAtPoint(point, withAttributes: fontAttr)
        
        size = NSString(string: symbol).sizeWithAttributes(fontAttr)
        point = CGPointMake(bounds.width - size.width - 10, 5)
        NSString(string: symbol).drawAtPoint(point, withAttributes: fontAttr)
        
        fontAttr = NSDictionary(objectsAndKeys: UIFont.boldSystemFontOfSize(36), NSFontAttributeName)
        size = NSString(string: name).sizeWithAttributes(fontAttr)
        point = CGPointMake((bounds.width - size.width) / 2, 50)
        NSString(string: name).drawAtPoint(point, withAttributes: fontAttr)
        
        text = NSString(string: String(format:"Atomic Weight: %3.0f", atomicWeight))
        fontAttr = NSDictionary(objectsAndKeys: UIFont.boldSystemFontOfSize(14), NSFontAttributeName)
        size = text.sizeWithAttributes(fontAttr)
        point = CGPointMake((bounds.width - size.width) / 2, 95)
        text.drawAtPoint(point, withAttributes: fontAttr)
        
        text = NSString(string: String(format:"State: %@", state))
        size = text.sizeWithAttributes(fontAttr)
        point = CGPointMake((bounds.width - size.width) / 2, point.y + 20)
        text.drawAtPoint(point, withAttributes: fontAttr)
        
        text = NSString(string: String(format:"Period: %2d", period))
        size = text.sizeWithAttributes(fontAttr)
        point = CGPointMake((bounds.width - size.width) / 2, point.y + 20)
        text.drawAtPoint(point, withAttributes: fontAttr)
        
        text = NSString(string: String(format:"Group: %2d", group))
        size = text.sizeWithAttributes(fontAttr)
        point = CGPointMake((bounds.width - size.width) / 2, point.y + 20)
        text.drawAtPoint(point, withAttributes: fontAttr)
        
        text = NSString(string: String(format:"Discovered: %@", discoverYear))
        size = text.sizeWithAttributes(fontAttr)
        point = CGPointMake((bounds.width - size.width) / 2, point.y + 20)
        text.drawAtPoint(point, withAttributes: fontAttr)
    }
    
}

@IBDesignable
class ImageReflectionView:UIView
{
    @IBInspectable
    var image:UIImage!
    {
        didSet
        {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setup()
    }

    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup()
    {
        backgroundColor = UIColor.clearColor()
    }
    
    override func drawRect(rect: CGRect)
    {
        var offsetY = image.size.height - bounds.height
        var bitmapData = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, offsetY, image.size.width, bounds.height))
        bitmapData = CGImageCreateWithMask(bitmapData, createGradientMask(1, UInt(bounds.height)))
        
        var result = UIImage(CGImage: bitmapData, scale: image.scale, orientation: UIImageOrientation.DownMirrored)!
        
        result.drawInRect(CGRectMake(0, 0, bounds.width, bounds.height))
    }
    
    //MARK: 创建渐变遮罩
    private func createGradientMask(pixelsWidth:UInt, _ pixelsHeight:UInt)->CGImage?
    {
        var colorSpace = CGColorSpaceCreateDeviceGray()
        
        var gradientContext = CGBitmapContextCreate(nil, pixelsWidth, pixelsHeight, 8, 0, colorSpace, CGBitmapInfo(CGImageAlphaInfo.None.rawValue))
        
        if gradientContext != nil
        {
            var colors:[CGFloat] = [1.0, 1.0,
                                    0.0, 1.0]
            var grayGradient = CGGradientCreateWithColorComponents(colorSpace, colors, nil, 2)
            
            var startPoint = CGPointZero
            var endPoint = CGPointMake(0, CGFloat(pixelsHeight))
            
            CGContextDrawLinearGradient(gradientContext, grayGradient, startPoint, endPoint, CGGradientDrawingOptions(kCGGradientDrawsAfterEndLocation))
            
            return CGBitmapContextCreateImage(gradientContext)
        }
        
        return nil
    }
}