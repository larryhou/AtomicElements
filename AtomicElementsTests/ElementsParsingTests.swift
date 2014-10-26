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
    func testSingletonPerformance()
    {
        self.measureBlock()
        {
            PeriodicElements.sharedPeriodicElements
            return
        }
    }
    
    func testPlistReadPerformance()
    {
        self.measureBlock()
        {
            
        }
    }

}
