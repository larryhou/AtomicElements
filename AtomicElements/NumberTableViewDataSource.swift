//
//  NumberTableViewDataSource.swift
//  AtomicElements
//
//  Created by larryhou on 10/27/14.
//  Copyright (c) 2014 larryhou. All rights reserved.
//

import Foundation
import UIKit

class NumberTableViewDataSource:NSObject, AtomicDataSource
{
    var title:String { return "Number" }
    var tableViewStyle:UITableViewStyle { return UITableViewStyle.Plain }
    
    func atomicElementForIndexPath(indexPath: NSIndexPath) -> AtomicElement
    {
        return AtomicElement(dict: NSDictionary())
    }
    
    //MARK: UITableViewDataSource
    var elements:[AtomicElement]
    
    init()
    {
        self.elements = PeriodicElements.sharedPeriodicElements.sortedByNumberElements
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        return UITableViewCell()
    }
}
