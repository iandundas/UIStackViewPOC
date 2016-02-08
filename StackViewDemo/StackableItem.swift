//
//  StackableItem.swift
//  StackViewDemo
//
//  Created by Ian Dundas on 08/02/2016.
//  Copyright © 2016 IanDundas. All rights reserved.
//

import UIKit

class StackableItem: UIView {
    var heightModifier:CGFloat = 0
    let increaseBy:CGFloat = 100
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func intrinsicContentSize() -> CGSize {
        let size = super.intrinsicContentSize()
        return CGSize(width: UIViewNoIntrinsicMetric, height: size.height + heightModifier)
    }
    
    @IBAction func embigify(sender: AnyObject) {
        /*  For all distributions except the UIStackViewDistributionFillEqually distribution,
        the stack view uses the arranged views’ intrinsicContentSize property when calculating
        the views’ size along the stack’s axis.*/
        
        heightModifier += increaseBy
        relayoutify()
    }
    
    @IBAction func shrinkify(sender: AnyObject) {
    
        heightModifier = max(heightModifier - increaseBy, 0)
        relayoutify()
    }
    
    @IBAction func hide(sender: AnyObject) {
        UIView.animateWithDuration(0.2) { () -> Void in
            self.hidden = true
        }
    }
    
    private func relayoutify(){
        UIView.animateWithDuration(0.2) { () -> Void in
            self.invalidateIntrinsicContentSize()
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
}
