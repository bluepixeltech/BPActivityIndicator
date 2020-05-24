//
//  VC2.swift
//  BPActivityIndicator
//
//  Created by Pouya Khansaryan on 5/6/20.
//  Copyright © 2020 Pouya Khansaryan. All rights reserved.
//

import UIKit
import BPActivityIndicator

class VC2: UIViewController {

    @IBOutlet weak var ai: BPActivityIndicator!
    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v3: UIView!
    @IBOutlet weak var v4: UIView!
    @IBOutlet weak var v5: UIView!
    @IBOutlet weak var style: UILabel!
    
    let queue = DispatchQueue.main
    let delay: Double = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        startSequence()
        
    }
    
    func startSequence() {
        style01()
        queue.asyncAfter(deadline: .now() + delay) {
            self.style02()
            self.queue.asyncAfter(deadline: .now() + self.delay) {
                self.style03()
                self.queue.asyncAfter(deadline: .now() + self.delay) {
                    self.style04()
                    self.queue.asyncAfter(deadline: .now() + self.delay) {
                        self.style05()
                        self.queue.asyncAfter(deadline: .now() + self.delay) {
                            self.style06()
                            self.queue.asyncAfter(deadline: .now() + self.delay) {
                                self.style07()
                                self.queue.asyncAfter(deadline: .now() + self.delay) {
                                    self.style08()
                                    self.queue.asyncAfter(deadline: .now() + self.delay) {
                                        self.style09()
                                        self.queue.asyncAfter(deadline: .now() + self.delay) {
                                            self.style10()
                                            self.queue.asyncAfter(deadline: .now() + self.delay) {
                                                self.style11()
                                                self.queue.asyncAfter(deadline: .now() + self.delay) {
                                                    self.style12()
                                                    self.queue.asyncAfter(deadline: .now() + self.delay) {
                                                        self.style13()
                                                        self.queue.asyncAfter(deadline: .now() + self.delay) {
                                                            self.style14()
                                                            self.queue.asyncAfter(deadline: .now() + self.delay) {
                                                                self.style15()
                                                                self.queue.asyncAfter(deadline: .now() + self.delay) {
                                                                    self.style16()
                                                                    self.queue.asyncAfter(deadline: .now() + self.delay) {
                                                                        self.style17()
                                                                        self.queue.asyncAfter(deadline: .now() + self.delay) {
                                                                            self.style18()
                                                                            
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func style01() {
        style.text = "iOS"
        ai.activityIndicatorStyle = .iOS
        ai.backgroundMode = .compact
        ai.backgroundColorStyle = .lightBlur
        ai.titleColor = .darkGray
        ai.titleFont = UIFont.systemFont(ofSize: 18.0, weight: .ultraLight)
        ai.title = "Please wait..."
        ai.color = .systemRed
        ai.lineWidth = 3.0
        ai.startAnimating()
    }
    
    func style02() {
        style.text = "iOSCircles"
        ai.activityIndicatorStyle = .iOSCircles
        ai.backgroundMode = .compact
        ai.backgroundColorStyle = .lightBlur
        ai.titleColor = .darkGray
        ai.titleFont = UIFont.systemFont(ofSize: 18.0, weight: .ultraLight)
        ai.title = "Please wait..."
        ai.color = .systemBlue
        ai.lineWidth = 3.0
        ai.startAnimating()
    }
    
    func style03() {
        style.text = "linearBarHop"
        ai.activityIndicatorStyle = .linearBarHop
        ai.backgroundMode = .compact
        ai.backgroundColorStyle = .lightBlur
        ai.titleColor = .darkGray
        ai.titleFont = UIFont.systemFont(ofSize: 18.0, weight: .ultraLight)
        ai.title = "Please wait..."
        ai.color = .black
        ai.lineWidth = 3.0
        ai.startAnimating()
    }
    
    func style04() {
        style.text = "linearBars"
        ai.activityIndicatorStyle = .linearBars
        ai.backgroundMode = .compact
        ai.backgroundColorStyle = .lightBlur
        ai.titleColor = .darkGray
        ai.titleFont = UIFont.systemFont(ofSize: 18.0, weight: .ultraLight)
        ai.title = "Please wait..."
        ai.color = .systemGreen
        ai.lineWidth = 3.0
        ai.startAnimating()
    }
    
    func style05() {
        style.text = "linearBarWaggle"
        ai.activityIndicatorStyle = .linearBarWaggle
        ai.backgroundMode = .compact
        ai.backgroundColorStyle = .lightBlur
        ai.titleColor = .darkGray
        ai.titleFont = UIFont.systemFont(ofSize: 18.0, weight: .ultraLight)
        ai.title = "Please wait..."
        ai.color = .magenta
        ai.lineWidth = 3.0
        ai.startAnimating()
    }
    
    func style06() {
        style.text = "linearBarWave"
        ai.activityIndicatorStyle = .linearBarWave
        ai.backgroundMode = .compact
        ai.backgroundColorStyle = .lightBlur
        ai.titleColor = .darkGray
        ai.titleFont = UIFont.systemFont(ofSize: 18.0, weight: .ultraLight)
        ai.title = "Please wait..."
        ai.color = .brown
        ai.lineWidth = 3.0
        ai.startAnimating()
    }
    
    func style07() {
        style.text = "ringFlare"
        ai.activityIndicatorStyle = .ringFlare
        ai.backgroundMode = .compact
        ai.backgroundColorStyle = .lightBlur
        ai.titleColor = .darkGray
        ai.titleFont = UIFont.systemFont(ofSize: 18.0, weight: .ultraLight)
        ai.title = "Please wait..."
        ai.color = .orange
        ai.lineWidth = 3.0
        ai.startAnimating()
    }
    
    func style08() {
        style.text = "standardEchoInside"
        ai.activityIndicatorStyle = .standardEchoInside
        ai.backgroundMode = .compact
        ai.backgroundColorStyle = .lightBlur
        ai.titleColor = .darkGray
        ai.titleFont = UIFont.systemFont(ofSize: 18.0, weight: .ultraLight)
        ai.title = "Please wait..."
        ai.color = .systemRed
        ai.lineWidth = 3.0
        ai.startAnimating()
    }
    
    func style09() {
        style.text = "standardEchoOutside"
        ai.activityIndicatorStyle = .standardEchoOutside
        ai.backgroundMode = .compact
        ai.backgroundColorStyle = .lightBlur
        ai.titleColor = .darkGray
        ai.titleFont = UIFont.systemFont(ofSize: 18.0, weight: .ultraLight)
        ai.title = "Please wait..."
        ai.color = .systemGreen
        ai.lineWidth = 3.0
        ai.startAnimating()
    }
    
    func style10() {
        style.text = "standardPulsating"
        ai.activityIndicatorStyle = .standardPulsating
        ai.backgroundMode = .compact
        ai.backgroundColorStyle = .lightBlur
        ai.titleColor = .darkGray
        ai.titleFont = UIFont.systemFont(ofSize: 18.0, weight: .ultraLight)
        ai.title = "Please wait..."
        ai.color = .blue
        ai.lineWidth = 3.0
        ai.startAnimating()
    }
    
    func style11() {
        style.text = "standardRainbowFill"
        ai.activityIndicatorStyle = .standardRainbowFill
        ai.backgroundMode = .compact
        ai.backgroundColorStyle = .lightBlur
        ai.titleColor = .darkGray
        ai.titleFont = UIFont.systemFont(ofSize: 18.0, weight: .ultraLight)
        ai.title = "Please wait..."
        ai.color = .systemRed
        ai.lineWidth = 3.0
        ai.startAnimating()
    }
    
    func style12() {
        style.text = "standardSpinning"
        ai.activityIndicatorStyle = .standardSpinning
        ai.backgroundMode = .compact
        ai.backgroundColorStyle = .lightBlur
        ai.titleColor = .darkGray
        ai.titleFont = UIFont.systemFont(ofSize: 18.0, weight: .ultraLight)
        ai.title = "Please wait..."
        ai.color = .cyan
        ai.lineWidth = 3.0
        ai.startAnimating()
    }
    
    func style13() {
        style.text = "standardSpinningDashed"
        ai.activityIndicatorStyle = .standardSpinningDashed
        ai.backgroundMode = .compact
        ai.backgroundColorStyle = .lightBlur
        ai.titleColor = .darkGray
        ai.titleFont = UIFont.systemFont(ofSize: 18.0, weight: .ultraLight)
        ai.title = "Please wait..."
        ai.color = .systemOrange
        ai.lineWidth = 3.0
        ai.startAnimating()
    }
    
    func style14() {
        style.text = "standardTrailingContinuous"
        ai.activityIndicatorStyle = .standardTrailingContinuous
        ai.backgroundMode = .compact
        ai.backgroundColorStyle = .lightBlur
        ai.titleColor = .darkGray
        ai.titleFont = UIFont.systemFont(ofSize: 18.0, weight: .ultraLight)
        ai.title = "Please wait..."
        ai.color = .systemPink
        ai.lineWidth = 3.0
        ai.startAnimating()
    }
    
    func style15() {
        style.text = "standardTrailingDashed"
        ai.activityIndicatorStyle = .standardTrailingDashed
        ai.backgroundMode = .compact
        ai.backgroundColorStyle = .lightBlur
        ai.titleColor = .darkGray
        ai.titleFont = UIFont.systemFont(ofSize: 18.0, weight: .ultraLight)
        ai.title = "Please wait..."
        ai.color = .systemGreen
        ai.lineWidth = 3.0
        ai.startAnimating()
    }
    
    func style16() {
        style.text = "tripleDotDance"
        ai.activityIndicatorStyle = .tripleDotDance
        ai.backgroundMode = .compact
        ai.backgroundColorStyle = .lightBlur
        ai.titleColor = .darkGray
        ai.titleFont = UIFont.systemFont(ofSize: 18.0, weight: .ultraLight)
        ai.title = "Please wait..."
        ai.color = .darkGray
        ai.lineWidth = 3.0
        ai.startAnimating()
    }
    
    func style17() {
        style.text = "standardRainbowFill"
        ai.activityIndicatorStyle = .standardRainbowFill
        ai.backgroundMode = .fullScreen
        ai.backgroundColorStyle = .lightBlur
        ai.titleColor = .darkGray
        ai.titleFont = UIFont.systemFont(ofSize: 20.0, weight: .ultraLight)
        ai.title = "Please wait..."
        ai.color = .darkGray
        ai.lineWidth = 3.0
        ai.startAnimating()
    }
    
    func style18() {
        style.text = "standardRainbowFill"
        ai.activityIndicatorStyle = .tripleDotDance
        ai.backgroundMode = .fullScreen
        ai.backgroundColorStyle = .darkBlur
        ai.titleColor = .white
        ai.titleFont = UIFont.systemFont(ofSize: 20.0, weight: .ultraLight)
        ai.title = "Please wait..."
        ai.color = .white
        ai.lineWidth = 3.0
        ai.startAnimating()
    }
    
    func setupViews() {
        v1.layer.cornerRadius = 20.0
        if #available(iOS 13.0, *) {
            v1.layer.cornerCurve = .continuous
        }
        v2.layer.cornerRadius = 20.0
        if #available(iOS 13.0, *) {
            v2.layer.cornerCurve = .continuous
        }
        v3.layer.cornerRadius = 20.0
        if #available(iOS 13.0, *) {
            v3.layer.cornerCurve = .continuous
        }
        v4.layer.cornerRadius = 20.0
        if #available(iOS 13.0, *) {
            v4.layer.cornerCurve = .continuous
        } 
        v5.layer.cornerRadius = 20.0
        if #available(iOS 13.0, *) {
            v5.layer.cornerCurve = .continuous
        }
        
    }
}
