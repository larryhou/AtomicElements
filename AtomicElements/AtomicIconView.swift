//
//  AtomicElementTileView.swift
//  AtomicElements
//
//  Created by larryhou on 10/27/14.
//  Copyright (c) 2014 larryhou. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class AtomicIconView:UIView
{
    @IBInspectable
    var backgroundImage:UIImage!
        {
        didSet
        {
            
        }
    }
    
    @IBInspectable
    var atomicNumber:Int = 95
    
    @IBInspectable
    var symbol:String = "Am"
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect)
    {
        var bounds = CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height)
        
        backgroundImage.drawInRect(bounds)
        
        UIColor.whiteColor().set()
        
        var point = CGPointMake(3, 2)
        var fontAttr = [NSFontAttributeName:UIFont.boldSystemFontOfSize(11)]
        NSString(string: atomicNumber.string).drawAtPoint(point, withAttributes: fontAttr)
        
        fontAttr = [NSFontAttributeName:UIFont.boldSystemFontOfSize(18)]
        var size = NSString(string: symbol).sizeWithAttributes(fontAttr)
        point = CGPointMake((bounds.width - size.width) / 2, 14)
        NSString(string: symbol).drawAtPoint(point, withAttributes: fontAttr)
    }
}