//
//  ElementsParsingTests.swift
//  AtomicElements
//
//  Created by doudou on 10/26/14.
//  Copyright (c) 2014 larryhou. All rights reserved.
//

import UIKit
import Foundation
import XCTest

class ElementsParsingTests: XCTestCase
{
    func testReadPerformance()
    {
        self.measureBlock()
        {
            var path = NSBundle.mainBundle().pathForResource("Elements", ofType: "plist")
            var list = NSArray(contentsOfFile: path!)!
        }
    }
    
    func testParsingPerformance()
    {
        var path = NSBundle.mainBundle().pathForResource("Elements", ofType: "plist")
        var list = NSArray(contentsOfFile: path!)!
        
        self.measureBlock()
        {
            var elements:[AtomicElement] = []
            
            for item:AnyObject in list
            {
                elements.append(AtomicElement(dict: item as NSDictionary))
            }
        }
    }

}
