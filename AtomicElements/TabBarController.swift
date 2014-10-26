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
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        println(self.viewControllers)
        for rootController in self.viewControllers! as [UINavigationController]
        {
            rootController.tabBarItem.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0)
            rootController.tabBarItem.setTitlePositionAdjustment(UIOffsetMake(0, -4))
            if rootController.topViewController == nil
            {
                rootController.viewControllers = [storyboard.instantiateViewControllerWithIdentifier("AtomicTableView")]
            }
        }
    }
}