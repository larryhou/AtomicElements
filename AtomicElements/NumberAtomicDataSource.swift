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
    var title:String { return "Number Sorted" }
    var tableViewStyle:UITableViewStyle { return UITableViewStyle.Plain; }
    
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