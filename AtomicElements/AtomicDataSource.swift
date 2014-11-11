//
//  AtomicDataSource.swift
//  AtomicElements
//
//  Created by doudou on 10/26/14.
//  Copyright (c) 2014 larryhou. All rights reserved.
//

import Foundation
import UIKit

protocol AtomicDataSource:UITableViewDataSource
{
    var title:String { get }
    func atomicElementForIndexPath(indexPath:NSIndexPath)->AtomicElement
}

let ATOMIC_REUSABLE_CELL = "AtomicReusableCell"