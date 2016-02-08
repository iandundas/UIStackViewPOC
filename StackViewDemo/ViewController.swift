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
        
        for _ in 0...15{
            addItem()
        }
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
            
            let lastItem = stackView.arrangedSubviews.last
            let lastY = (lastItem?.frame.origin.y ?? 0) + (lastItem?.frame.size.height ?? 0)
            
            item.frame.origin = CGPoint(x: 0, y: lastY)
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
        UIView.animateWithDuration(0.25, animations: {
            self.stackView.arrangedSubviews.filter{$0.hidden==false}.last?.hidden = true
        })
        
        /*
        To remove a subview that the stack view manages, you
        need to call both removeArrangedSubview: and removeFromSuperview. Removing an arranged
        subview ensures the stack view will no longer manage that view's constraints. It doesn't
        take it out of the view hierarchy. This is very important to remember. */
    }
}

extension UIColor{
    static func randomColor()->UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}



