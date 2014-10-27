//
//  AtomicElement.swift
//  AtomicElements
//
//  Created by doudou on 10/26/14.
//  Copyright (c) 2014 larryhou. All rights reserved.
//

import Foundation
import UIKit

extension Int
{
    var string:String
    {
        return "\(self)"
    }
}

extension String
{
    var double:Double
    {
        return NSString(string: self).doubleValue
    }
    
    var int:Int
    {
        if let value = self.toInt()
        {
            return value
        }
        
        return 0
    }
    
    var bool:Bool
    {
        return self.lowercaseString == "true" ? true : false
    }
}


class AtomicElement
{
    var atomicNumber    = 0
    var name            = ""
    var symbol          = ""
    var state           = ""
    var atomicWeight    = 0.0
    var group           = 0
    var period          = 0
    var discoverYear    = ""
    var radioactive     = false
    var vpos            = 0
    var hpos            = 0
    
    init(dict:NSDictionary)
    {
        self.atomicNumber   = get(dict, "atomicNumber").int
        self.name           = get(dict, "name")
        self.symbol         = get(dict, "symbol")
        self.state          = get(dict, "state")
        self.atomicWeight   = get(dict, "atomicWeight").double
        self.group          = get(dict, "group").int
        self.period         = get(dict, "period").int
        self.discoverYear   = get(dict, "discoveryYear")
        self.radioactive    = get(dict, "radioactive").bool
        self.vpos           = get(dict, "vertPos").int
        self.hpos           = get(dict, "horizPos").int
    }
    
    private func get(dict:NSDictionary, _ key:String)->String
    {
        if let value:AnyObject = dict.valueForKey(key)
        {
            return "\(value)"
        }
        
        return ""
    }
    
    var stateImageForAtomicElementTileView:UIImage
    {
        return UIImage(named: String(format: "%@_37.png", self.state))!
    }
    
    var stateImageForAtomicElementView:UIImage
    {
        return UIImage(named: String(format: "%@_256.png",self.state))!
    }
    
    var stateImageForPeriodicTableView:UIImage
    {
        return UIImage(named: String(format:"%@_24.png", self.state))!
    }
    
    var flipperImageForAtomicElementNavigationItem:UIImage
    {
        var size = CGSizeMake(30.0, 30.0)
        UIGraphicsBeginImageContext(size)
        
        var backgroundImage = UIImage(named: String(format:"%@_30.png", self.state))
        
        var bounds = CGRectMake(0, 0, size.width, size.height)
        backgroundImage!.drawInRect(bounds)
        
        UIColor.whiteColor().set()
        
        var fontAttr = [NSFontAttributeName:UIFont.boldSystemFontOfSize(8)]
        var point = CGPointMake(2, 1)
        NSString(string: atomicNumber.string).drawAtPoint(point, withAttributes: fontAttr)
        
        fontAttr = [NSFontAttributeName:UIFont.boldSystemFontOfSize(13)]
        size = NSString(string: symbol).sizeWithAttributes(fontAttr)
        point = CGPointMake((bounds.width - size.width)/2, 10)
        NSString(string: symbol).drawAtPoint(point, withAttributes: fontAttr)
        
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
}