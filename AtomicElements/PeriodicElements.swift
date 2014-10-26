//
//  AtomicElementModel.swift
//  AtomicElements
//
//  Created by doudou on 10/26/14.
//  Copyright (c) 2014 larryhou. All rights reserved.
//

import Foundation

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
