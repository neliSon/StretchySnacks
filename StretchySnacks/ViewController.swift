//
//  ViewController.swift
//  StretchySnacks
//
//  Created by Nelson Chow on 2016-04-14.
//  Copyright © 2016 Nelson Chow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    var animator:UIDynamicAnimator!
    var openBottomConstraint: NSLayoutConstraint!
    var closedBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var navBarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        makeStackView()
    }

    // MARK: Actions
    @IBAction func plusButton(sender: UIButton) {
        print("Plus icon pressed.")
        toggleStackView()
        animateNavBarHeight()
        rotatePlusButton()


    }
    
    // MARK: General Functions
    func animateNavBarHeight() {
        self.navBarHeightConstraint.constant = navBarHeightConstraint.constant == 66.0 ? 200 : 66
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func rotatePlusButton() {
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.plusButton.transform = CGAffineTransformRotate(self.plusButton.transform, CGFloat(M_PI_4))
            }, completion: nil)
    }
    
    func makeStackView() {
        let image1 = UIImage(named: "oreos")
        let image2 = UIImage(named: "pizza_pockets")
        let image3 = UIImage(named: "pop_tarts")
        let image4 = UIImage(named: "popsicle")
        let image5 = UIImage(named: "ramen")
        
        let imageView1 = UIImageView(image: image1)
        let imageView2 = UIImageView(image: image2)
        let imageView3 = UIImageView(image: image3)
        let imageView4 = UIImageView(image: image4)
        let imageView5 = UIImageView(image: image5)
        
        let imageViews = [imageView1, imageView2, imageView3, imageView4, imageView5]
        
        let stackView = UIStackView(arrangedSubviews: imageViews)
        stackView.axis = .Horizontal
        stackView.distribution = .FillEqually
        stackView.alignment = .Fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        stackView.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor).active = true
        stackView.rightAnchor.constraintEqualToAnchor(self.view.rightAnchor).active = true
        stackView.heightAnchor.constraintEqualToConstant(navBarView.frame.height).active = true
        
        
        openBottomConstraint = stackView.bottomAnchor.constraintEqualToAnchor(self.navBarView.bottomAnchor)
        
        closedBottomConstraint = stackView.topAnchor.constraintEqualToAnchor(self.navBarView.topAnchor, constant: -navBarView.frame.height)
        
        closedBottomConstraint.active = true
        openBottomConstraint.active = false
    }
    
    func toggleStackView() {
        if navBarHeightConstraint.constant == 66.0 {
            // going to open
            closedBottomConstraint.active = false
            openBottomConstraint.active = true
        }else {
            // otherwise will close
            openBottomConstraint.active = false
            closedBottomConstraint.active = true
        }
    }
}

