//
//  AtomicElementView.swift
//  AtomicElements
//
//  Created by larryhou on 10/29/14.
//  Copyright (c) 2014 larryhou. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class AtomicElementView:UIView
{
    @IBInspectable
    var backgroundImage:UIImage!
    
    @IBInspectable
    var atomicNumber:Int = 47
    
    @IBInspectable
    var symbol:String = "Ag"
    
    @IBInspectable
    var name:String = "Silver"
    
    override func drawRect(rect: CGRect)
    {
        
    }
}