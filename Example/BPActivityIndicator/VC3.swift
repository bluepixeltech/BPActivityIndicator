//
//  VC3.swift
//  BPActivityIndicator
//
//  Created by Pouya Khansaryan on 5/18/20.
//  Copyright © 2020 Pouya Khansaryan. All rights reserved.
//

import UIKit
import BPActivityIndicator

class VC3: UIViewController {

    @IBOutlet weak var ai: BPActivityIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ai.activityIndicatorStyle = .tripleDotDance
        ai.backgroundMode = .compact
        ai.backgroundColorStyle = .dark
        ai.titleColor = .lightGray
        ai.titleFont = UIFont.systemFont(ofSize: 18.0, weight: .light)
        ai.title = "Please wait..."
        ai.color = .lightGray
        ai.lineWidth = 3.0
        ai.startAnimating()
        
    }
    
}
