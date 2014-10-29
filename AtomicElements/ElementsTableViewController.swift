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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = dataSource
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 44
    }
}