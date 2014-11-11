//
//  NumberAtomicDataSource.swift
//  AtomicElements
//
//  Created by larryhou on 10/28/14.
//  Copyright (c) 2014 larryhou. All rights reserved.
//

import Foundation
import UIKit

class NumberAtomicDataSource:NSObject, AtomicDataSource
{
    var elements:[AtomicElement]
    
    override init()
    {
        elements = PeriodicElements.sharedPeriodicElements.sortedByNumberElements
        super.init()
    }
    
    //MARK: AtomicDataSource protocol
    var title:String { return "Number-sorted Elements" }
    
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
    var titles:[String]!
    
    override init()
    {
        map = PeriodicElements.sharedPeriodicElements.nameIndexGroupedMap
        
        titles = []
        for key in map.keys
        {
            titles.append(key)
        }
        
        titles.sort({$0 < $1})
    }
    
    func atomicElementForIndexPath(indexPath: NSIndexPath) -> AtomicElement
    {
        var key = titles[indexPath.section]
        return map[key]![indexPath.row]
    }
    
    //MARK: AtomicDataSource protocol
    var title:String { return "Name-sorted Elements" }
    
    //MARK: UITableViewDataSource protocol
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return map.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var key = titles[section]
        return map[key]!.count
    }
    
    //MARK: 列表右边字母顺序快捷索引
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]!
    {
        return titles
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int
    {
        return index
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return titles[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier(ATOMIC_REUSABLE_CELL) as AtomicTableViewCell!
        cell.element = atomicElementForIndexPath(indexPath)
        return cell
    }
}