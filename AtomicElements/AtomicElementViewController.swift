//
//  AtomicElementViewController.swift
//  AtomicElements
//
//  Created by larryhou on 10/29/14.
//  Copyright (c) 2014 larryhou. All rights reserved.
//

import Foundation
import UIKit

class AtomicElementViewController:UIViewController, AtomicElementViewDelegate
{
    let REFLACTION_HEIGHT_RATIO:CGFloat = 0.3
    let BUTTON_ITEM_IMAGE:String = "flipper_list_blue.png"
    let FLIP_DURATION:NSTimeInterval = 0.75
    
    @IBOutlet var atomicView:AtomicElementView!
    @IBOutlet var reflactionView:ImageReflectionView!
    
    var flippedView:FlippedAtomicElementView!
    
    var element:AtomicElement!
    var flipIndicatorButton:UIButton!
    
    var needFlip2Front = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        atomicView.delegate = self
        atomicView.backgroundImage = element.stateImageForAtomicElementView
        atomicView.atomicNumber = element.atomicNumber
        atomicView.symbol = element.symbol
        atomicView.name = element.name
        atomicView.setNeedsDisplay()
        
        reflactionView.image = atomicView.getContextImage()
        
        setupFlippedView()
        
        flipIndicatorButton = UIButton(frame: CGRectMake(0, 0, 30, 30))
        flipIndicatorButton.setBackgroundImage(UIImage(named: BUTTON_ITEM_IMAGE), forState: UIControlState.Normal)
        
        let flipButtonBarItem = UIBarButtonItem(customView: flipIndicatorButton)
        flipIndicatorButton.addTarget(self, action: "didClickRightButton", forControlEvents: UIControlEvents.TouchDown)
        navigationItem.setRightBarButtonItem(flipButtonBarItem, animated: true)
    }
    
    func setupFlippedView()
    {
        flippedView = NSBundle.mainBundle().loadNibNamed("FlippedAtomicElementView", owner: self, options: nil).first as FlippedAtomicElementView
        view.addSubview(flippedView)
        flippedView.delegate = self
        flippedView.hidden = true
        
        flippedView.backgroundImage = element.stateImageForAtomicElementView
        flippedView.atomicNumber = element.atomicNumber
        flippedView.symbol = element.symbol
        flippedView.name = element.name
        flippedView.group = element.group
        flippedView.period = element.period
        flippedView.state = element.state
        flippedView.atomicWeight = element.atomicWeight
        flippedView.discoverYear = element.discoverYear
        flippedView.setNeedsDisplay()
        
        var constrain:NSLayoutConstraint
        
        // 限制宽度为256
        constrain = NSLayoutConstraint(item: flippedView,
                                  attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal,
                                     toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute,
                                 multiplier: 1, constant: 256)
        flippedView.addConstraint(constrain)
        
        // 限制高度为256
        constrain = NSLayoutConstraint(item: flippedView,
                                  attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal,
                                     toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute,
                                 multiplier: 1, constant: 256)
        flippedView.addConstraint(constrain)
        
        
        // 相对父级容器水平居中
        constrain = NSLayoutConstraint(item: flippedView,
                                  attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal,
                                     toItem: view, attribute: NSLayoutAttribute.CenterX,
                                 multiplier: 1, constant: 0)
        view.addConstraint(constrain)
        
        // 相对父级容器垂直居中
        constrain = NSLayoutConstraint(item: view,
                                  attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal,
                                     toItem: flippedView, attribute: NSLayoutAttribute.CenterY,
                                 multiplier: 1, constant: 0)
        view.addConstraint(constrain)
        
    }
    
    func didClickRightButton()
    {
        needFlip2Front = atomicView.hidden
        flipCurrentView()
    }
    
    func didTap(target: AtomicElementView, sender: UITapGestureRecognizer)
    {
        needFlip2Front = target == flippedView ? true : false
        flipCurrentView()
    }
    
    func flipCurrentView()
    {
        flipIndicatorButton.userInteractionEnabled = false
        view.userInteractionEnabled = false
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(FLIP_DURATION)
        UIView.setAnimationDelegate(self)
        
        if !needFlip2Front
        {
            UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromRight, forView: self.view, cache: true)
            atomicView.hidden = true
            flippedView.hidden = !atomicView.hidden
            
            reflactionView.image = flippedView.getContextImage()
        }
        else
        {
            UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromLeft, forView: self.view, cache: true)
            atomicView.hidden = false
            flippedView.hidden = !atomicView.hidden
            
            reflactionView.image = atomicView.getContextImage()
        }
        
        UIView.commitAnimations()
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(FLIP_DURATION)
        UIView.setAnimationDelegate(self)
        
        var stateImage:UIImage
        
        if !needFlip2Front
        {
            UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromRight, forView: flipIndicatorButton, cache: true)
            stateImage = element.flipperImageForAtomicElementNavigationItem
        }
        else
        {
            UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromLeft, forView: flipIndicatorButton, cache: true)
            stateImage = UIImage(named: BUTTON_ITEM_IMAGE)!
        }
        
        flipIndicatorButton.setBackgroundImage(stateImage, forState: UIControlState.Normal)
        flipIndicatorButton.setBackgroundImage(stateImage, forState: UIControlState.Highlighted)
        
        UIView.commitAnimations()
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool)
    {
        flipIndicatorButton.userInteractionEnabled = true
        view.userInteractionEnabled = true
    }
    
    override func animationDidStart(anim: CAAnimation!)
    {
        println("animation start")
    }
}
