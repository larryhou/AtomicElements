//
//  AtomicTableViewCell.swift
//  AtomicElements
//
//  Created by larryhou on 10/27/14.
//  Copyright (c) 2014 larryhou. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class AtomicTableViewCell:UITableViewCell
{
    @IBOutlet
    var tileView:AtomicIconView!
    
    var element:AtomicElement!
    {
        didSet
        {
            tileView.backgroundImage = element.stateImageForAtomicElementTileView
            tileView.atomicNumber = element.atomicNumber
            tileView.symbol = element.symbol
        }
    }
}

