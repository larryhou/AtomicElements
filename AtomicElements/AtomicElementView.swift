//
//  AtomicElementView.swift
//  AtomicElements
//
//  Created by larryhou on 10/29/14.
//  Copyright (c) 2014 larryhou. All rights reserved.
//

import Foundation
import UIKit

protocol AtomicElementViewDelegate
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
    
    var delegate:AtomicElementViewDelegate?
    
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
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        var context = CGBitmapContextCreate(nil, UInt(bounds.width), UInt(bounds.height), 8, 0, colorSpace, CGBitmapInfo(CGImageAlphaInfo.PremultipliedLast.rawValue))
        
        var flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, bounds.height)
        CGContextConcatCTM(context, flipVertical)
        
        layer.drawInContext(context)
        var bitmapData = CGBitmapContextCreateImage(context)
        return UIImage(CGImage: bitmapData, scale: 1, orientation: UIImageOrientation.DownMirrored)!
    }
}

@IBDesignable
class ImageReflectionView:UIView
{
    @IBInspectable
    var image:UIImage!
    
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