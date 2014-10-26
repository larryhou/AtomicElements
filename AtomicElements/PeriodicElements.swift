//
//  AtomicElementModel.swift
//  AtomicElements
//
//  Created by doudou on 10/26/14.
//  Copyright (c) 2014 larryhou. All rights reserved.
//

import Foundation

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

class PeriodicElements
{
    class var sharedPeriodicElements:PeriodicElements
    {
        struct Singleton
        {
            static let instance:PeriodicElements = PeriodicElements()
        }
        
        return Singleton.instance
    }
    
    var elements:[AtomicElement]
    
    init()
    {
        self.elements = []
        
        var path = NSBundle.mainBundle().pathForResource("Elements", ofType: "plist")
        var list:NSArray = NSArray(contentsOfFile: path!)!
        
        for item:AnyObject in list
        {
            elements.append(AtomicElement(dict: item as NSDictionary))
        }
        
        println(elements)
    }
}
