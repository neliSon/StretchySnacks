//
//  NamedImageView.swift
//  StretchySnacks
//
//  Created by Nelson Chow on 2016-04-14.
//  Copyright © 2016 Nelson Chow. All rights reserved.
//

import UIKit

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
