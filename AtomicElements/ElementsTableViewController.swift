//
//  ElementsTableViewController.swift
//  AtomicElements
//
//  Created by doudou on 10/29/14.
//  Copyright (c) 2014 larryhou. All rights reserved.
//

import Foundation
import UIKit

class ElementsTableViewController:UITableViewController
{
    var dataSource:AtomicDataSource!
    {
        didSet
        {
            navigationItem.title = dataSource.title
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.sectionHeaderHeight = 30
    }
    
    
    //MARK: assign a fixed height for custom cell
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 44
    }
    
    //MARK: pass AtomicElement object to destination controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ElementDetailSegue"
        {
            var indexPath:NSIndexPath = tableView.indexPathForSelectedRow()!
            
            var viewController = segue.destinationViewController as AtomicElementViewController
            viewController.element = dataSource.atomicElementForIndexPath(indexPath)
            viewController.hidesBottomBarWhenPushed = true
        }
    }
}