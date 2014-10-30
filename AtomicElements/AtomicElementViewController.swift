//
//  AtomicElementViewController.swift
//  AtomicElements
//
//  Created by larryhou on 10/29/14.
//  Copyright (c) 2014 larryhou. All rights reserved.
//

import Foundation
import UIKit

class AtomicElementViewController:UIViewController
{
    let REFLACTION_HEIGHT_RATIO:CGFloat = 0.3
    
    @IBOutlet weak var atomicView: AtomicElementView!
    @IBOutlet weak var reflactionView:UIImageView!
    
    var element:AtomicElement!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        atomicView.backgroundImage = element.stateImageForAtomicElementView
        atomicView.atomicNumber = element.atomicNumber
        atomicView.symbol = element.symbol
        atomicView.name = element.name
        atomicView.setNeedsDisplay()
        
        reflactionView = UIImageView(frame: CGRectMake(atomicView.frame.origin.x, atomicView.frame.origin.y, atomicView.frame.width, atomicView.frame.height * REFLACTION_HEIGHT_RATIO))
        
        reflactionView.image = atomicView.getReflectionWithHeight(UInt(reflactionView.bounds.height))
        
        view.addSubview(reflactionView)
    }
}
