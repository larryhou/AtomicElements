//
//  AtomicElementView.swift
//  AtomicElements
//
//  Created by larryhou on 10/29/14.
//  Copyright (c) 2014 larryhou. All rights reserved.
//

import Foundation
import UIKit

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
    
    override func drawRect(rect: CGRect)
    {
        var bounds = CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height)
        backgroundImage.drawInRect(bounds)
        
        UIColor.whiteColor().set()
        
        var fontAttr = NSDictionary(objectsAndKeys: UIFont.boldSystemFontOfSize(36), NSFontAttributeName)
        var point = CGPointMake(10, 0)
        NSString(string: "\(atomicNumber)").drawAtPoint(point, withAttributes: fontAttr)
        
        fontAttr = NSDictionary(objectsAndKeys:UIFont.boldSystemFontOfSize(48), NSFontAttributeName)
        var size = NSString(string: name).sizeWithAttributes(fontAttr)
        point = CGPointMake((bounds.width - size.width) / 2, bounds.height / 2 - size.height)
        NSString(string: name).drawAtPoint(point, withAttributes: fontAttr)
        
        fontAttr = NSDictionary(objectsAndKeys: UIFont.boldSystemFontOfSize(96), NSFontAttributeName)
        size = NSString(string: symbol).sizeWithAttributes(fontAttr)
        point = CGPointMake((bounds.width - size.width) / 2, bounds.height - size.height - 10)
        NSString(string: symbol).drawAtPoint(point, withAttributes: fontAttr)
    }
    
    //MARK: 创建渐变遮罩
    private func createGradientMask(pixelsWidth:UInt, _ pixelsHeight:UInt)->CGImage?
    {
        var colorSpace = CGColorSpaceCreateDeviceGray()
        
        var gradientContext = CGBitmapContextCreate(nil, pixelsWidth, pixelsHeight, 8, 0, colorSpace, CGBitmapInfo(CGImageAlphaInfo.None.rawValue))
        
        if gradientContext != nil
        {
            var colors:[CGFloat] = [0.0, 1.0,
                                    1.0, 1.0]
            var grayGradient = CGGradientCreateWithColorComponents(colorSpace, colors, nil, 2)
            
            var startPoint = CGPointZero
            var endPoint = CGPointMake(0, CGFloat(pixelsHeight))
            
            CGContextDrawLinearGradient(gradientContext, grayGradient, startPoint, endPoint, CGGradientDrawingOptions(kCGGradientDrawsAfterEndLocation))
            
            return CGBitmapContextCreateImage(gradientContext)
        }
        
        return nil
    }
    
    //MARK: 创建指定高度的倒影
    func getReflectionWithHeight(height:UInt)->UIImage?
    {
        var colorSpace = CGColorSpaceCreateDeviceGray()
        var reflectionContext = CGBitmapContextCreate(nil, UInt(bounds.width), height, 8, 0, colorSpace, CGBitmapInfo(CGImageAlphaInfo.None.rawValue))
        
        if reflectionContext != nil
        {
            var translateY = bounds.height - CGFloat(height)
            CGContextTranslateCTM(reflectionContext, 0, -translateY)
            
            layer.drawInContext(reflectionContext)
            
            CGContextTranslateCTM(reflectionContext, 0, translateY)
            
            var reflactionImage = CGBitmapContextCreateImage(reflectionContext)
            
            var gradientMask = createGradientMask(1, 1)
            CGImageCreateWithMask(reflactionImage, gradientMask)
            
            return UIImage(CGImage: reflactionImage)
        }
        
        return nil
    }
}

@IBDesignable
class ImageReflectionView:UIView
{
    @IBInspectable
    var image:UIImage!
    
    override func drawRect(rect: CGRect)
    {
        
    }
}