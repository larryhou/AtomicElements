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
        
        flippedView = NSBundle.mainBundle().loadNibNamed("FlippedAtomicElementView", owner: self, options: nil).first as FlippedAtomicElementView
        flippedView.frame = atomicView.frame
        flippedView.delegate = self
        
        flipIndicatorButton = UIButton(frame: CGRectMake(0, 0, 30, 30))
        flipIndicatorButton.setBackgroundImage(UIImage(named: BUTTON_ITEM_IMAGE), forState: UIControlState.Normal)
        
        let flipButtonBarItem = UIBarButtonItem(customView: flipIndicatorButton)
        flipIndicatorButton.addTarget(self, action: "didClickRightButton", forControlEvents: UIControlEvents.TouchDown)
        navigationItem.setRightBarButtonItem(flipButtonBarItem, animated: true)
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
            UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromRight, forView: atomicView, cache: true)
            atomicView.removeFromSuperview()
            view.addSubview(flippedView)
            
            reflactionView.image = flippedView.getContextImage()
        }
        else
        if target == flippedView
        {
            UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromLeft, forView: flippedView, cache: true)
            flippedView.removeFromSuperview()
            view.addSubview(atomicView)
            
            reflactionView.image = UIImage(named: BUTTON_ITEM_IMAGE)
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
