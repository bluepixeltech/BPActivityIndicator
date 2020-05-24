//
//  ViewController.swift
//  BPActivityIndicator
//
//  Created by Pouya Khansaryan on 4/29/20.
//  Copyright © 2020 Pouya Khansaryan. All rights reserved.
//

import UIKit
import BPActivityIndicator

class ViewController: UIViewController {
    
    
    @IBOutlet weak var ai01: BPActivityIndicator!
    @IBOutlet weak var ai02: BPActivityIndicator!
    @IBOutlet weak var ai03: BPActivityIndicator!
    @IBOutlet weak var ai04: BPActivityIndicator!
    @IBOutlet weak var ai05: BPActivityIndicator!
    @IBOutlet weak var ai06: BPActivityIndicator!
    @IBOutlet weak var ai07: BPActivityIndicator!
    @IBOutlet weak var ai08: BPActivityIndicator!
    @IBOutlet weak var ai09: BPActivityIndicator!
    @IBOutlet weak var ai10: BPActivityIndicator!
    @IBOutlet weak var ai11: BPActivityIndicator!
    @IBOutlet weak var ai12: BPActivityIndicator!
    @IBOutlet weak var ai13: BPActivityIndicator!
    @IBOutlet weak var ai14: BPActivityIndicator!
    @IBOutlet weak var ai15: BPActivityIndicator!
    @IBOutlet weak var ai16: BPActivityIndicator!
    
    @IBOutlet weak var l01: UILabel!
    @IBOutlet weak var l02: UILabel!
    @IBOutlet weak var l03: UILabel!
    @IBOutlet weak var l04: UILabel!
    @IBOutlet weak var l05: UILabel!
    @IBOutlet weak var l06: UILabel!
    @IBOutlet weak var l07: UILabel!
    @IBOutlet weak var l08: UILabel!
    @IBOutlet weak var l09: UILabel!
    @IBOutlet weak var l10: UILabel!
    @IBOutlet weak var l11: UILabel!
    @IBOutlet weak var l12: UILabel!
    @IBOutlet weak var l13: UILabel!
    @IBOutlet weak var l14: UILabel!
    @IBOutlet weak var l15: UILabel!
    @IBOutlet weak var l16: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ai01.activityIndicatorStyle = .standardSpinning
        ai01.backgroundMode = .none
        ai01.color = .black
        ai01.lineWidth = 3.0
        ai01.startAnimating()
        l01.text = "standardSpinning"
        
        ai02.activityIndicatorStyle = .standardPulsating
        ai02.backgroundMode = .none
        ai02.color = .red
        ai02.lineWidth = 3.0
        ai02.startAnimating()
        l02.text = "standardPulsating"
        
        ai03.activityIndicatorStyle = .standardSpinningDashed
        ai03.backgroundMode = .none
        ai03.color = .green
        ai03.lineWidth = 3.0
        ai03.startAnimating()
        l03.text = "standardSpinningDashed"
        
        ai04.activityIndicatorStyle = .standardTrailingContinuous
        ai04.backgroundMode = .none
        ai04.color = .blue
        ai04.lineWidth = 3.0
        ai04.startAnimating()
        l04.text = "standardTrailingContinuous"
        
        ai05.activityIndicatorStyle = .standardTrailingDashed
        ai05.backgroundMode = .none
        ai05.color = .systemRed
        ai05.lineWidth = 3.0
        ai05.startAnimating()
        l05.text = "standardTrailingDashed"
        
        ai06.activityIndicatorStyle = .standardEchoOutside
        ai06.backgroundMode = .none
        ai06.color = .systemBlue
        ai06.lineWidth = 3.0
        ai06.startAnimating()
        l06.text = "standardEchoOutside"
        
        ai07.activityIndicatorStyle = .standardEchoInside
        ai07.backgroundMode = .none
        ai07.color = .systemGray
        ai07.lineWidth = 3.0
        ai07.startAnimating()
        l07.text = "standardEchoInside"
        
        ai08.activityIndicatorStyle = .standardRainbowFill
        ai08.backgroundMode = .none
        ai08.color = .systemPink
        ai08.lineWidth = 3.0
        ai08.startAnimating()
        l08.text = "standardRainbowFill"
        
        ai09.activityIndicatorStyle = .tripleDotDance
        ai09.backgroundMode = .none
        ai09.color = .systemTeal
        ai09.lineWidth = 3.0
        ai09.startAnimating()
        l09.text = "tripleDotDance"
        
        ai10.activityIndicatorStyle = .iOSCircles
        ai10.backgroundMode = .none
        ai10.color = .systemRed
        ai10.lineWidth = 3.0
        ai10.startAnimating()
        l10.text = "iOSCircles"
        
        ai11.activityIndicatorStyle = .iOS
        ai11.backgroundMode = .none
        ai11.color = .systemGreen
        ai11.lineWidth = 3.0
        ai11.startAnimating()
        l11.text = "iOS"
        
        ai12.activityIndicatorStyle = .ringFlare
        ai12.backgroundMode = .none
        if #available(iOS 13.0, *) {
            ai12.color = .systemIndigo
        } else {
            ai12.color = .blue
        }
        ai12.lineWidth = 3.0
        ai12.startAnimating()
        l12.text = "ringFlare"
        
        ai13.activityIndicatorStyle = .linearBars
        ai13.backgroundMode = .none
        ai13.color = .systemOrange
        ai13.startAnimating()
        l13.text = "linearBars"
        
        ai14.activityIndicatorStyle = .linearBarWave
        ai14.backgroundMode = .none
        ai14.color = .systemPink
        ai14.startAnimating()
        l14.text = "linearBarWave"
        
        ai15.activityIndicatorStyle = .linearBarWaggle
        ai15.backgroundMode = .none
        ai15.color = .systemTeal
        ai15.startAnimating()
        l15.text = "linearBarWaggle"
        
        ai16.activityIndicatorStyle = .linearBarHop
        ai16.backgroundMode = .none
        ai16.color = .black
        ai16.startAnimating()
        l16.text = "linearBarHop"
        
    }


}

