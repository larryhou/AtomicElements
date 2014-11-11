//
//  TabBarController.swift
//  AtomicElements
//
//  Created by doudou on 10/26/14.
//  Copyright (c) 2014 larryhou. All rights reserved.
//

import Foundation
import UIKit

class TabBarController:UITabBarController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        PeriodicElements.sharedPeriodicElements
        
        var tableViewController:ElementsTableViewController
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        for rootController in self.viewControllers! as [UINavigationController]
        {
            rootController.tabBarItem.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0)
            rootController.tabBarItem.setTitlePositionAdjustment(UIOffsetMake(0, -4))
            
            if rootController.topViewController == nil
            {
                tableViewController = storyboard.instantiateViewControllerWithIdentifier("AtomicTableView") as ElementsTableViewController
                rootController.viewControllers = [tableViewController]
            }
            
            tableViewController = rootController.viewControllers.last as ElementsTableViewController
            switch rootController.tabBarItem.title!
            {
                case "Number":
                    tableViewController.dataSource = NumberAtomicDataSource()
                    
                case "Name":
                    tableViewController.dataSource = NameAtomicDataSource()
                    
                default:
                    break
            }
        }
    }
}