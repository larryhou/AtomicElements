//
//  AtomicDataSource.swift
//  AtomicElements
//
//  Created by doudou on 10/26/14.
//  Copyright (c) 2014 larryhou. All rights reserved.
//

import Foundation
import UIKit

let ATOMIC_REUSABLE_CELL = "AtomicReusableCell"

protocol AtomicDataSource:UITableViewDataSource
{
    var title:String { get }
    func atomicElementForIndexPath(indexPath:NSIndexPath)->AtomicElement
}

class NumberAtomicDataSource:NSObject, AtomicDataSource
{
    var elements:[AtomicElement]
    
    override init()
    {
        elements = PeriodicElements.sharedPeriodicElements.sortedByNumberElements
        super.init()
    }
    
    //MARK: AtomicDataSource protocol
    var title:String { return "Number-Sorted Elements" }
    
    func atomicElementForIndexPath(indexPath: NSIndexPath) -> AtomicElement
    {
        return elements[indexPath.row]
    }
    
    //MARK: UITableViewDataSource protocol
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return elements.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier(ATOMIC_REUSABLE_CELL) as AtomicTableViewCell!
        cell.element = atomicElementForIndexPath(indexPath)
        return cell
    }
    
}

class NameAtomicDataSource:NSObject, AtomicDataSource
{
    var map:[String:[AtomicElement]]
    var sectionTitles:[String]
    
    override init()
    {
        map = PeriodicElements.sharedPeriodicElements.nameIndexGroupedMap
        
        sectionTitles = []
        for key in map.keys
        {
            sectionTitles.append(key)
        }
        
        sectionTitles.sort({$0 < $1})
    }
    
    func atomicElementForIndexPath(indexPath: NSIndexPath) -> AtomicElement
    {
        var key = sectionTitles[indexPath.section]
        return map[key]![indexPath.row]
    }
    
    //MARK: AtomicDataSource protocol
    var title:String { return "Name-Indexed Elements" }
    
    //MARK: UITableViewDataSource protocol
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return map.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var key = sectionTitles[section]
        return map[key]!.count
    }
    
    //MARK: 列表右边字母顺序快捷索引
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]!
    {
        return sectionTitles
    }
    
    //MARK: 设置对应title以及title索引返回section索引，为快捷索引添加跳转连接
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int
    {
        return index
    }
    
    //MARK: 添加分组title
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return sectionTitles[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier(ATOMIC_REUSABLE_CELL) as AtomicTableViewCell!
        cell.element = atomicElementForIndexPath(indexPath)
        return cell
    }
}

class StateAtomicDataSource:NSObject, AtomicDataSource
{
    var map:[String:[AtomicElement]]
    var sectionTitles:[String]
    var subtitles:[String]
    
    override init()
    {
        map = PeriodicElements.sharedPeriodicElements.stateGroupedMap
        
        sectionTitles = []
        subtitles = []
        
        for key in map.keys
        {
            sectionTitles.append(key)
        }
        
        sectionTitles.sort({$0 < $1})
        subtitles = sectionTitles.map
        {
            $0.substringToIndex(advance($0.startIndex, 1))
        }
    }
    
    var title:String { return "State-Indexed Elements" }
    
    func atomicElementForIndexPath(indexPath: NSIndexPath) -> AtomicElement
    {
        var key = sectionTitles[indexPath.section]
        return map[key]![indexPath.row]
    }
    
    //MARK:
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return map.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var key = sectionTitles[section]
        return map[key]!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier(ATOMIC_REUSABLE_CELL) as AtomicTableViewCell!
        cell.element = atomicElementForIndexPath(indexPath)
        return cell
    }
    
    //MARK:
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]!
    {
        return subtitles
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int
    {
        return index
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return sectionTitles[section]
    }
}

class SymbolAtomicDataSource:NSObject, AtomicDataSource
{
    var map:[String:[AtomicElement]]
    var sectionTitles:[String]
    
    override init()
    {
        map = PeriodicElements.sharedPeriodicElements.symbolIndexGroupedMap
        
        sectionTitles = []
        for key in map.keys
        {
            sectionTitles.append(key)
        }
        
        sectionTitles.sort({$0 < $1})
    }
    
    var title:String { return "Symbol-Indexed Elements" }
    
    func atomicElementForIndexPath(indexPath: NSIndexPath) -> AtomicElement
    {
        var key = sectionTitles[indexPath.section]
        return map[key]![indexPath.row]
    }
    
    //MARK:
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return map.count
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        var key = sectionTitles[section]
        return map[key]!.count
    }
    
    func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier(ATOMIC_REUSABLE_CELL) as AtomicTableViewCell
        cell.element = atomicElementForIndexPath(indexPath)
        return cell
    }
    
    //MARK:
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]!
    {
        return sectionTitles
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int
    {
        return index
    }
    
    //MARK:
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return sectionTitles[section]
    }
    
}