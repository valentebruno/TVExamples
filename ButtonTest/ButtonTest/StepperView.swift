//
//  StepperView.swift
//  ButtonTest
//
//  Created by Bruno Bilescky on 29/09/15.
//  Copyright © 2015 bgondim. All rights reserved.
//

import UIKit

@IBDesignable
class StepperView: UIControl {
    
    @IBInspectable var selectedBackgroundColor :UIColor = UIColor.redColor()
    @IBInspectable var selectedTextColor :UIColor = UIColor.whiteColor()
    
    @IBInspectable var title :String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    @IBInspectable var minValue :Int = 0
    @IBInspectable var maxValue :Int = 10
    @IBInspectable var currentValue :Int = 5 {
        didSet {
            valueLabel.text = "\(currentValue)"
        }
    }
    
    private let selectTap = UITapGestureRecognizer()
    private let unselectTap = UITapGestureRecognizer()
    private let menuTap = UITapGestureRecognizer()
    private let incrementSwipe = UISwipeGestureRecognizer()
    private let decrementSwipe = UISwipeGestureRecognizer()
    
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    private let editLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        commonInit()
    }
    
    private func commonInit() {
        self.addSubview(titleLabel)
        self.addSubview(valueLabel)
        self.addSubview(editLabel)
        titleLabel.textAlignment = .Center
        valueLabel.textAlignment = .Center
        editLabel.textAlignment = .Right
        titleLabel.font = UIFont.boldSystemFontOfSize(30)
        editLabel.font = UIFont.systemFontOfSize(22)
        valueLabel.font = UIFont.boldSystemFontOfSize(80)
        titleLabel.textColor = UIColor.blackColor()
        valueLabel.textColor = UIColor.blackColor()
        editLabel.textColor = UIColor.blackColor()
        
        editLabel.text = "Pressione para editar"
        editLabel.alpha = 0
        
        menuTap.allowedPressTypes = [NSNumber(integer: UIPressType.Menu.rawValue)]
        menuTap.addTarget(self, action: "unselectComponent:")
        
        selectTap.addTarget(self, action: "selectComponent:")
        unselectTap.addTarget(self, action: "unselectComponent:")
        
        incrementSwipe.addTarget(self, action: "incrementCounter:")
        incrementSwipe.direction = .Right
        
        decrementSwipe.addTarget(self, action: "decrementCounter:")
        decrementSwipe.direction = .Left
        
        self.addGestureRecognizer(selectTap)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 60)
        let valueHeight = CGRectGetHeight(self.frame) - CGRectGetMaxY(titleLabel.frame) - 12
        valueLabel.frame = CGRectMake(CGRectGetMidX(titleLabel.frame) - (valueHeight/2), CGRectGetMaxY(titleLabel.frame) - 4, valueHeight, valueHeight)
        editLabel.frame = CGRectMake(10, CGRectGetHeight(self.frame) - 38, CGRectGetWidth(self.frame) - 20, 38)
    }
    
    override func canBecomeFocused() -> Bool {
        return true
    }
    
    override func shouldUpdateFocusInContext(context: UIFocusUpdateContext) -> Bool {
        return !selected
    }

    func selectComponent(gesture :UITapGestureRecognizer) {
        selected = true
        self.backgroundColor = selectedBackgroundColor
        self.editLabel.hidden = true
        titleLabel.textColor = selectedTextColor
        valueLabel.textColor = selectedTextColor
        self.removeGestureRecognizer(selectTap)
        self.addGestureRecognizer(unselectTap)
        self.addGestureRecognizer(menuTap)
        self.addGestureRecognizer(incrementSwipe)
        self.addGestureRecognizer(decrementSwipe)
    }
    
    func unselectComponent(gesture :UITapGestureRecognizer) {
        selected = false
        self.editLabel.hidden = false
        self.backgroundColor = UIColor.whiteColor()
        titleLabel.textColor = UIColor.blackColor()
        valueLabel.textColor = UIColor.blackColor()
        self.removeGestureRecognizer(unselectTap)
        self.removeGestureRecognizer(menuTap)
        self.removeGestureRecognizer(incrementSwipe)
        self.removeGestureRecognizer(decrementSwipe)
        self.addGestureRecognizer(selectTap)
    }
    
    func incrementCounter(gesture :UISwipeGestureRecognizer) {
        if currentValue < maxValue {
            currentValue = currentValue + 1
        }
    }
    
    func decrementCounter(gesture :UISwipeGestureRecognizer) {
        if currentValue > minValue {
            currentValue = currentValue - 1
        }
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocusInContext(context, withAnimationCoordinator: coordinator)
        
        if let nextView = context.nextFocusedView where nextView == self {
            coordinator.addCoordinatedAnimations({
                self.transform = CGAffineTransformMakeScale(1.05, 1.05)
                self.editLabel.alpha = 1
            }, completion: nil)
        }
        else if let previousView = context.previouslyFocusedView where previousView == self {
            coordinator.addCoordinatedAnimations({
                self.transform = CGAffineTransformIdentity
                self.editLabel.alpha = 0
            }, completion: nil)
        }
    }
    
}
