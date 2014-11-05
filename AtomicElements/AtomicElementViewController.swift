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
                                     toItem: self.view, attribute: NSLayoutAttribute.CenterX,
                                 multiplier: 1, constant: 0)
        view.addConstraint(constrain)
        
        // 相对父级容器垂直居中
        constrain = NSLayoutConstraint(item: flippedView,
                                  attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal,
                                     toItem: self.view, attribute: NSLayoutAttribute.CenterY,
                                 multiplier: 1, constant: 0)
        view.addConstraint(constrain)
        
    }
    
    func didClickRightButton()
    {
        if atomicView.superview != nil
        {
            flipAtomicView(atomicView)
        }
        else
        if flippedView.superview != nil
        {
            flipAtomicView(flippedView)
        }
    }
    
    func didTap(target: AtomicElementView, sender: UITapGestureRecognizer)
    {
        flipAtomicView(target)
    }
    
    func flipAtomicView(target:AtomicElementView)
    {
        flipIndicatorButton.userInteractionEnabled = false
        view.userInteractionEnabled = false
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(FLIP_DURATION)
        UIView.setAnimationDelegate(self)
        
        if target == atomicView
        {
            UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromRight, forView: self.view, cache: true)
            atomicView.hidden = true
            view.addSubview(flippedView)
            
            reflactionView.image = flippedView.getContextImage()
        }
        else
        if target == flippedView
        {
            UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromLeft, forView: self.view, cache: true)
            flippedView.removeFromSuperview()
            atomicView.hidden = false
            
            reflactionView.image = atomicView.getContextImage()
        }
        
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
