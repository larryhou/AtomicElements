//
//  AtomicTableViewCell.swift
//  AtomicElements
//
//  Created by larryhou on 10/27/14.
//  Copyright (c) 2014 larryhou. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class AtomicTableViewCell:UITableViewCell
{
    @IBOutlet
    var icon:AtomicIconView!
    
    @IBOutlet
    var label:UILabel!
    
    var element:AtomicElement!
    {
        didSet
        {
            icon.backgroundImage = element.stateImageForAtomicElementTileView
            icon.atomicNumber = element.atomicNumber
            icon.symbol = element.symbol
            
            label.text = element.name
        }
    }
}


@IBDesignable
class AtomicIconView:UIView
{
    @IBInspectable
    var backgroundImage:UIImage!
    
    @IBInspectable
    var atomicNumber:Int = 47
    
    @IBInspectable
    var symbol:String = "Ag"
    
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
        NSString(string: "\(atomicNumber)").drawAtPoint(point, withAttributes: fontAttr)
        
        fontAttr = [NSFontAttributeName:UIFont.boldSystemFontOfSize(18)]
        var size = NSString(string: symbol).sizeWithAttributes(fontAttr)
        point = CGPointMake((bounds.width - size.width) / 2, 14)
        NSString(string: symbol).drawAtPoint(point, withAttributes: fontAttr)
    }
    
    override func prepareForInterfaceBuilder()
    {
//        if !(backgroundImage != nil)
//        {
//            backgroundImage = UIImage(named: "Artificial_37.png", inBundle: nil, compatibleWithTraitCollection: nil)
//        }
    }
}

