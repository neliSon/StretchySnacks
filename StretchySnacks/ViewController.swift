//
//  ViewController.swift
//  StretchySnacks
//
//  Created by Nelson Chow on 2016-04-14.
//  Copyright © 2016 Nelson Chow. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Properties
    var animator:UIDynamicAnimator!
    var openBottomConstraint: NSLayoutConstraint!
    var closedBottomConstraint: NSLayoutConstraint!
    
    var tableView: UITableView = UITableView()
    var foodStrings = [String]()
    
    @IBOutlet weak var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var navBarView: UIView!
    
//    let tapRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        makeStackView()
        makeTableView()
    }

    // MARK: Actions
    @IBAction func plusButton(sender: UIButton) {
        print("Plus icon pressed.")
        toggleStackView()
        animateNavBarHeight()
        rotatePlusButton()
    }
    
    // MARK: TableViewDelegate
    
    // MARK: TableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        return cell
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
        let imageView1 = NamedImageView(name: "Oreos", imageName: "oreos", target: self)
        let imageView2 = NamedImageView(name: "Pizza Pockets", imageName: "pizza_pockets", target: self)
        let imageView3 = NamedImageView(name: "Pop Tarts", imageName: "pop_tarts", target: self)
        let imageView4 = NamedImageView(name: "Popsicle", imageName: "popsicle", target: self)
        let imageView5 = NamedImageView(name: "Ramen", imageName: "ramen", target: self)
        
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
        
        closedBottomConstraint = stackView.topAnchor.constraintEqualToAnchor(self.navBarView.topAnchor, constant: -(navBarView.frame.height + 15))  // +15 to hide stackview furthur up.
        
        closedBottomConstraint.active = true
        openBottomConstraint.active = false
    }
    
    func toggleStackView() {
        if navBarHeightConstraint.constant == 66.0 {
            // going to open.
            closedBottomConstraint.active = false
            openBottomConstraint.active = true
        }else {
            // otherwise will close.
            openBottomConstraint.active = false
            closedBottomConstraint.active = true
        }
    }
    
    func makeTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor).active = true
        tableView.rightAnchor.constraintEqualToAnchor(self.view.rightAnchor).active = true
        tableView.topAnchor.constraintEqualToAnchor(navBarView.bottomAnchor).active = true
        tableView.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor).active = true
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func tappedFood(gesture: UITapGestureRecognizer) {
        
        if let namedImageView = gesture.view as? NamedImageView {
            print("tapped \(namedImageView.name)")
            
        }
    }
}



class NamedImageView: UIImageView {
    var name: String
    
    init(name: String, imageName: String, target: AnyObject, action: Selector = #selector(ViewController.tappedFood(_:))) {
        self.name = name
        super.init(image: UIImage(named: imageName))
        
        self.userInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tapRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

