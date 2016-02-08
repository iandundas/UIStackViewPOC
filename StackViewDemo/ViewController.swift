//
//  ViewController.swift
//  StackViewDemo
//
//  Created by Ian Dundas on 08/02/2016.
//  Copyright © 2016 IanDundas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0...15 { addItem ()}
    }

    @IBAction func tappedAddButton(sender: AnyObject) {
        
        addItem()
    }
    
    @IBAction func tappedSubtractButton(sender: AnyObject) {
        
        subtractItem()
    }
    
    
    private func addItem(){
        /* If you wish to add a subview for the stack view to manage, you do so
        by calling addArrangedSubview: or insertArrangedSubview:atIndex:. The
        arrangedSubViews array is a subset of its subViews property.*/
        
        if let item = NSBundle.mainBundle().loadNibNamed("StackableItem", owner: self, options: nil).first as? UIView{
            item.backgroundColor = UIColor.randomColor()
            stackView.addSubview(item)
            
            // Animate from the position of the bottom of the last item in the stack:
            if let lastItem = stackView.arrangedSubviews.last{
                let lastY = lastItem.frame.origin.y + lastItem.frame.size.height
                item.frame.origin = CGPoint(x: 0, y: lastY)
            }
            
            item.frame.size = CGSize(width: stackView.frame.size.width,height: 0)
            item.alpha = 0
            
            UIView.animateWithDuration(0.25, animations: {
                item.alpha = 1
                self.stackView.addArrangedSubview(item)
                self.stackView.layoutIfNeeded()
            })
        }
    }
    private func subtractItem(){
        /*
        To remove a subview that the stack view manages, you
        need to call both removeArrangedSubview: and removeFromSuperview. Removing an arranged
        subview ensures the stack view will no longer manage that view's constraints. It doesn't
        take it out of the view hierarchy. This is very important to remember. */

        if let item = self.stackView.arrangedSubviews.filter({$0.hidden==false}).last {
            UIView.animateWithDuration(0.25, animations: {
                item.alpha = 0
                item.hidden = true
            },
            completion: { completed in
                self.stackView.removeArrangedSubview(item)
                item.removeFromSuperview()
            })
        }
        
    }
}

extension UIColor{
    static func randomColor()->UIColor{
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 0.5)
    }
}



