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
            static var instance:PeriodicElements = PeriodicElements()
        }
        
        return Singleton.instance
    }
    
    var elements:[AtomicElement]
    var nameIndexGroupedMap:[String:[AtomicElement]]
    var stateGroupedMap:[String:[AtomicElement]]
    var symbolIndexGroupedMap:[String:[AtomicElement]]
    
    init()
    {
        self.elements = []
        self.nameIndexGroupedMap = [:]
        self.stateGroupedMap = [:]
        self.symbolIndexGroupedMap = [:]
        
        var path = NSBundle.mainBundle().pathForResource("Elements", ofType: "plist")
        var list:NSArray = NSArray(contentsOfFile: path!)!
        
        var item:AtomicElement
        for dict:AnyObject in list
        {
            item = AtomicElement(dict: dict as NSDictionary)
            elements.append(item)
            
            var letter = item.name.substringToIndex(advance(item.name.startIndex,1))
            if nameIndexGroupedMap[letter] == nil
            {
                nameIndexGroupedMap.updateValue([AtomicElement](), forKey: letter)
            }
            nameIndexGroupedMap[letter]?.append(item)
            
            letter = item.symbol.substringToIndex(advance(item.name.startIndex, 1))
            if symbolIndexGroupedMap[letter] == nil
            {
                symbolIndexGroupedMap.updateValue([AtomicElement](), forKey: letter)
            }
            symbolIndexGroupedMap[letter]?.append(item)
            
            if stateGroupedMap[item.state] == nil
            {
                stateGroupedMap[item.state] = [AtomicElement]()
            }
            
            stateGroupedMap[item.state]?.append(item)
        }
        
        for (key, _) in nameIndexGroupedMap
        {
            nameIndexGroupedMap[key]?.sort({$0.name < $1.name})
        }
        
        for (key, _) in stateGroupedMap
        {
            stateGroupedMap[key]?.sort({$0.name < $1.name})
        }
        
        for (key, _) in symbolIndexGroupedMap
        {
            symbolIndexGroupedMap[key]?.sort({$0.symbol < $1.symbol})
        }
        
        elements.sort({$0.name < $1.name})
    }
    
    var sortedByNumberElements:[AtomicElement]
    {
        return elements.sorted({$0.atomicNumber < $1.atomicNumber})
    }
    
    var soredBySymbolElements:[AtomicElement]
    {
        return elements.sorted({$0.symbol < $1.symbol})
    }
}
