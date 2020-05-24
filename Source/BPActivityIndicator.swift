//
//  BPActivityIndicator.swift
//  CustomButton
//
//  Created by Pouya Khansaryan on 4/25/20.
//  Copyright © 2020 Pouya Khansaryan. All rights reserved.
//

import UIKit
import Foundation


public enum ActivityIndicatorStyle: CaseIterable {
    case standardSpinning
    case standardPulsating
    case standardSpinningDashed
    case standardTrailingContinuous
    case standardTrailingDashed
    case standardEchoOutside
    case standardEchoInside
    case standardRainbowFill
    case tripleDotDance
    case iOSCircles
    case iOS
    case ringFlare
    case linearBars
    case linearBarWave
    case linearBarWaggle
    case linearBarHop
}

@IBDesignable
public final class BPActivityIndicator: UIView {
    
    // MARK: - Inspecables
    @IBInspectable public var color: UIColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1) {
        didSet {
            configure()
        }
    }
    
    @IBInspectable public var lineWidth: CGFloat = 10.0 {
        didSet {
            configure()
        }
    }
    
    @IBInspectable public var title: String? = nil

    @IBInspectable public var titleColor: UIColor = UIColor.darkGray


    // MARK: - Properties & types
    
    public var activityIndicatorStyle: ActivityIndicatorStyle? = nil {
        didSet {
            configure()
        }
    }
    
    public enum BackgroundMode {
        case none
        case compact
        case fullScreen
    }
    
    public enum BackgroundColorStyle {
        case light
        case dark
        case lightBlur
        case darkBlur
    }
    
    public var backgroundMode: BackgroundMode = .none
    
    public var backgroundAlpha: Float = 0.6
    
    public var backgroundColorStyle: BackgroundColorStyle = .dark
    
    private lazy var titleLabel = UILabel()
    
    private lazy var blurEffectView = UIVisualEffectView()
        
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 13.0)
        
    private var titleHeight: CGFloat?
        
    // MARK: - Shape layers
    private lazy var backgroundLayer = CALayer()
    private lazy var masterLayer = CAShapeLayer()
    
    private let animationDuration: CFTimeInterval = 0.7
    
    /// Public: indicate the status of the Activity Indicator
    public var isAnimating: Bool { return animating }

    /// For private use only!
    private(set) public var animating: Bool = false {
        didSet {
            self.isHidden = !isAnimating
            if animating {
                setupAnimations()
            } else {
                removeAnimations()
            }
        }
    }
   
    public override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        if animating {
            configure()
            setupAnimations()
        }
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        /// Handles backgroundLayer frame when device orientation changes
        configure()
    }
    public override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    override public func draw(_ rect: CGRect) {
        configure()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
            configure()

    }
    
    public override var backgroundColor: UIColor? {
        set {
            super.backgroundColor = UIColor.clear
        }
        get {
            return super.backgroundColor
        }
    }
    
    private func configure() {
        
        guard activityIndicatorStyle != nil else { return }
        
        self.isHidden = !isAnimating
        
        setupStyle()

        blurEffectView.removeFromSuperview()
              
        isUserInteractionEnabled = false
        
        if backgroundMode == .fullScreen {
            backgroundLayer.frame = CGRect(origin: CGPoint(x: -self.frame.minX, y: -self.frame.minY),
                                           size: UIScreen.main.bounds.size)
            
        } else {
            backgroundLayer.frame = self.layer.bounds
        }

        if backgroundMode != .none {
            switch backgroundColorStyle {
            case .light:
                backgroundLayer.opacity = backgroundAlpha
                backgroundLayer.backgroundColor = UIColor.white.cgColor
            case .lightBlur:
                let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
                blurEffectView.effect = blurEffect
                blurEffectView.frame = backgroundLayer.frame
                blurEffectView.layer.masksToBounds = true
                self.addSubview(blurEffectView)
            case .darkBlur:
                let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                blurEffectView.effect = blurEffect
                blurEffectView.frame = backgroundLayer.frame
                blurEffectView.layer.masksToBounds = true
                self.addSubview(blurEffectView)
            default:
                backgroundLayer.opacity = backgroundAlpha
                backgroundLayer.backgroundColor = UIColor.black.cgColor
            }
            
        } else {
            backgroundLayer.backgroundColor = UIColor.clear.cgColor
        }
        
        if backgroundMode != .fullScreen {
            backgroundLayer.cornerRadius = UIScreen.main.bounds.width / 20.0
            blurEffectView.layer.cornerRadius = UIScreen.main.bounds.width / 20.0
        } else {
            backgroundLayer.cornerRadius = 0.0
            blurEffectView.layer.cornerRadius = 0.0
        }
        
        if #available(iOS 13.0, *) {
            backgroundLayer.cornerCurve = CALayerCornerCurve.continuous
        } 
        
        backgroundLayer.masksToBounds = true
        
        self.layer.addSublayer(backgroundLayer)
        
        if title != nil && backgroundMode != .none {
            titleHeight = self.bounds.height / 3.0
            titleLabel.frame = CGRect(x: 0.0,
                                      y: self.bounds.height - titleHeight!,
                                      width: self.bounds.width, height: titleHeight!)
            titleLabel.text = title
            titleLabel.font = titleFont
            titleLabel.textColor = titleColor
            titleLabel.contentMode = UIView.ContentMode.center
            titleLabel.textAlignment = NSTextAlignment.center
            titleLabel.numberOfLines = 0
            titleLabel.adjustsFontSizeToFitWidth = true
            titleLabel.backgroundColor = UIColor.clear
            self.addSubview(titleLabel)

        }
        masterLayer.lineWidth = lineWidth
        masterLayer.fillColor = nil
        masterLayer.strokeColor = color.cgColor
        masterLayer.lineCap = CAShapeLayerLineCap.round
        self.layer.addSublayer(masterLayer)
    }
    
    private func masterLayerFrame() -> CGRect {
        if title != nil && backgroundMode != .none {
            return CGRect(x: 0.0, y: 0.0, width: layer.bounds.width, height: layer.bounds.height * 2.0 / 3.0)
        } else {
            return layer.bounds
        }
    }
    
    private func setupStyle() {
        switch activityIndicatorStyle {
        case .standardSpinning:
            drawMainCircle(from: 190.0, to: 90.0, filled: false, strokeColor: color)
        case .standardPulsating:
            drawMainCircle(from: 190.0, to: 90.0, filled: false, strokeColor: color)
        case .standardSpinningDashed:
            drawMainCircle(from: 0.0, to: 360.0, filled: false, strokeColor: color)
        case .standardTrailingContinuous:
            drawMainCircle(from: 0.0, to: 360.0, filled: false, strokeColor: color)
        case .standardTrailingDashed:
           drawMainCircle(from: 0.0, to: 360.0, filled: false, strokeColor: color)
        case .standardEchoOutside:
            drawMainCircle(from: 0.0, to: 360.0, filled: false, strokeColor: color)
        case .standardEchoInside:
            drawMainCircle(from: 0.0, to: 360.0, filled: false, strokeColor: color)
        case .standardRainbowFill:
            drawMainCircle(from: 0.0, to: 360.0, filled: true, strokeColor: color)
        case .tripleDotDance:
            drawTripleDot()
        case .iOSCircles:
            drawiOS()
        case .iOS:
            drawiOS()
        case .ringFlare:
            drawMainCircle(from: 0.0, to: 360, filled: false, strokeColor: UIColor.clear, sizeCoeff: 0.85)
        case .linearBars:
            drawLinear()
        case .linearBarWave:
            drawLinear()
        case .linearBarWaggle:
            drawLinear()
        case .linearBarHop:
            drawLinear()
            
        default:
            return
        }
    }
    
    public func startAnimating() {
        self.animating = true
    }
    
    public func stopAnimating() {
        self.animating = false
    }
    
    private func removeAnimations() {
        self.masterLayer.removeAllAnimations()
        self.masterLayer.sublayers?.removeAll()
    }
    
    private func setupAnimations() {
        removeAnimations()
        
        switch activityIndicatorStyle {
        case .standardSpinning:
            addAnimationsSpinClassic()
        case .standardPulsating:
            addAnimationsSpinThickness()
        case .standardSpinningDashed:
            addAnimationsSpinningDashed()
        case .standardTrailingContinuous:
            addAnimationTailingContinuous()
        case .standardTrailingDashed:
            addAnimationTailingDashed()
        case .standardEchoOutside:
            addAnimationEchoOutside()
        case .standardEchoInside:
            addAnimationEchoInside()
        case .standardRainbowFill:
            addAnimationRainbowFill()
        case .tripleDotDance:
            addAnimationTripleDotDance()
        case .iOSCircles:
            addAnimationiOSCircles()
        case .iOS:
            addAnimationiOS()
        case .ringFlare:
            addAnimationRingFlare()
        case .linearBars:
            addAnimationLinearBars()
        case .linearBarWave:
            addAnimationLinearBarWave()
        case .linearBarWaggle:
            addAnimationLinearBarWaggle()
        case .linearBarHop:
            addAnimationLinearBarHop()
        default:
            return
        }
    }
    
    private func toRadians(_ degree: CGFloat) -> CGFloat {
        return degree * CGFloat.pi / 180.0
    }
      
    private func drawiOS() {
        masterLayer.frame = masterLayerFrame()
    }
    
    private func drawLinear() {
        masterLayer.frame = masterLayerFrame()
    }
    
    private func drawTripleDot() {
        masterLayer.frame = masterLayerFrame()
        let R: CGFloat = round(0.8 * min(masterLayer.bounds.width / 2, masterLayer.bounds.height / 2))
        let r: CGFloat = round(0.25 * R)
        let arcWidth: CGFloat = round(0.2 * R)
        let centerPoint: CGPoint = CGPoint(x: masterLayer.frame.midX, y: masterLayer.frame.midY)
        let radius: CGFloat = R - arcWidth
        let centerDot1: CGPoint = CGPoint(x: radius, y: 0.0)
        let rotate120: CGAffineTransform = CGAffineTransform(rotationAngle: toRadians(120.0))
        let centerDot2: CGPoint = centerDot1.applying(rotate120)
        let centerDot3: CGPoint = centerDot2.applying(rotate120)
        let dot1 = UIBezierPath(arcCenter: centerDot1, radius: r, startAngle: toRadians(0.0), endAngle: toRadians(360.0), clockwise: true)
        dot1.apply(CGAffineTransform(translationX: centerPoint.x, y: centerPoint.y))
        let dot2 = UIBezierPath(arcCenter: centerDot2, radius: r, startAngle: toRadians(0.0), endAngle: toRadians(360.0), clockwise: true)
        dot2.apply(CGAffineTransform(translationX: centerPoint.x, y: centerPoint.y))
        let dot3 = UIBezierPath(arcCenter: centerDot3, radius: r, startAngle: toRadians(0.0), endAngle: toRadians(360.0), clockwise: true)
        dot3.apply(CGAffineTransform(translationX: centerPoint.x, y: centerPoint.y))

        let combined = CGMutablePath()
        combined.addPath(dot1.cgPath)
        combined.addPath(dot2.cgPath)
        combined.addPath(dot3.cgPath)
        masterLayer.path = combined
        masterLayer.fillColor = nil
        masterLayer.strokeColor = color.cgColor
        masterLayer.lineWidth = min(3.0, self.masterLayer.lineWidth)
        let minLength = min(self.masterLayer.bounds.width, self.masterLayer.bounds.height)
        self.masterLayer.lineDashPattern = minLength > 50.0 ? [10] : [5]
        self.masterLayer.lineDashPhase = 5.0
    }
    
    private func drawMainCircle(from startAngleDeg: CGFloat, to endAngleDeg: CGFloat, filled: Bool = false, strokeColor: UIColor, sizeCoeff: CGFloat = 1.0) {
        masterLayer.frame = masterLayerFrame()
        let R: CGFloat = round(sizeCoeff * min(masterLayer.bounds.width / 2, masterLayer.bounds.height / 2))
        let arcWidth: CGFloat = round(0.2 * R)
        let centerPoint: CGPoint = CGPoint(x: masterLayer.frame.midX, y: masterLayer.frame.midY)
        let radius: CGFloat = R - arcWidth
        let startAngle: CGFloat = toRadians(startAngleDeg)
        let endAngle: CGFloat = toRadians(endAngleDeg)
        let circlePath = UIBezierPath(arcCenter: centerPoint,
                                      radius: radius,
                                      startAngle: startAngle,
                                      endAngle: endAngle,
                                      clockwise: true)
        
        masterLayer.path = circlePath.cgPath
        if filled {
            masterLayer.fillColor = color.cgColor
            masterLayer.strokeColor = nil
        }
        else {
            masterLayer.fillColor = nil
            masterLayer.strokeColor = strokeColor.cgColor
        }
        
    }
    
    // MARK: - Animation methods
    private func addAnimationLinearBarHop() {
        let barCount = 7
        let width = round(0.7 * min(layer.bounds.width, layer.bounds.height) / CGFloat(barCount))
        let height: CGFloat = round(2.5 * width)
        let shift = width * 1.2

        let marker = CALayer()
        marker.bounds = CGRect(origin: .zero, size: CGSize(width: width, height: height))
        marker.cornerRadius = width / 2.0
        marker.backgroundColor = color.cgColor
        marker.position = CGPoint(x: masterLayer.frame.midX - (CGFloat(barCount - 1) * shift) / 2.0, y: masterLayer.frame.midY + height / 2.0)

        let spinnerReplicator = CAReplicatorLayer()
        spinnerReplicator.bounds = masterLayer.bounds
        spinnerReplicator.position = CGPoint(x: masterLayer.frame.midX, y: masterLayer.frame.midY)

        let instanceRotation = CATransform3DMakeTranslation(shift, 0.0, 0.0)
        spinnerReplicator.instanceCount = barCount
        spinnerReplicator.instanceTransform = instanceRotation
        
        spinnerReplicator.addSublayer(marker)
        masterLayer.addSublayer(spinnerReplicator)
        
        marker.opacity = 0.0
        let fade = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        fade.fromValue = 1.0
        fade.toValue = 0.2
        fade.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    
        let hop = CABasicAnimation(keyPath: "position.y")
        hop.toValue = marker.position.y - height / 2.0
        hop.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        hop.autoreverses = true
        hop.duration = animationDuration / Double(barCount)
        
        let group = CAAnimationGroup()
        group.duration = animationDuration
        group.repeatCount = .infinity
        group.animations = [fade, hop]
        
        let markerAnimationDuration = animationDuration / Double(barCount)
        spinnerReplicator.instanceDelay = markerAnimationDuration
        marker.add(group, forKey: String(describing: activityIndicatorStyle))

    }
    
    private func addAnimationLinearBarWaggle() {
        let barCount = 7
        let width = round(0.7 * min(layer.bounds.width, layer.bounds.height) / CGFloat(barCount))
        let height: CGFloat = round(2.5 * width)
        let shift = width * 1.2

        let marker = CALayer()
        marker.bounds = CGRect(origin: .zero, size: CGSize(width: width, height: height))
        marker.cornerRadius = width / 2.0
        marker.backgroundColor = color.cgColor
        marker.position = CGPoint(x: masterLayer.frame.midX - (CGFloat(barCount - 1) * shift) / 2.0, y: masterLayer.frame.midY + height / 2.0)

        let spinnerReplicator = CAReplicatorLayer()
        spinnerReplicator.bounds = masterLayer.bounds
        spinnerReplicator.position = CGPoint(x: masterLayer.frame.midX, y: masterLayer.frame.midY)

        let instanceRotation = CATransform3DMakeTranslation(shift, 0.0, 0.0)
        spinnerReplicator.instanceCount = barCount
        spinnerReplicator.instanceTransform = instanceRotation
        
        spinnerReplicator.addSublayer(marker)
        masterLayer.addSublayer(spinnerReplicator)
        
        marker.opacity = 0.0
        let fade = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        fade.fromValue = 1.0
        fade.toValue = 0.2
        fade.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    
        let rot = CABasicAnimation(keyPath: "transform.rotation.z")
        rot.fromValue = 0.0
        rot.toValue = CGFloat.pi
        rot.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        rot.autoreverses = true
        rot.duration = animationDuration / Double(barCount)
        
        let group = CAAnimationGroup()
        group.duration = animationDuration
        group.repeatCount = .infinity
        group.animations = [fade, rot]
        
        let markerAnimationDuration = animationDuration / Double(barCount)
        spinnerReplicator.instanceDelay = markerAnimationDuration
        marker.add(group, forKey: String(describing: activityIndicatorStyle))

    }
    
    private func addAnimationLinearBarWave() {
        let barCount = 7
        let width = round(0.7 * min(layer.bounds.width, layer.bounds.height) / CGFloat(barCount))
        let height: CGFloat = round(2.5 * width)
        let shift = width * 1.2

        let marker = CALayer()
        marker.bounds = CGRect(origin: .zero, size: CGSize(width: width, height: height))
        marker.cornerRadius = width / 2.0
        marker.backgroundColor = color.cgColor
        marker.position = CGPoint(x: masterLayer.frame.midX - (CGFloat(barCount - 1) * shift) / 2.0, y: masterLayer.frame.midY + height / 2.0)

        let spinnerReplicator = CAReplicatorLayer()
        spinnerReplicator.bounds = masterLayer.bounds
        spinnerReplicator.position = CGPoint(x: masterLayer.frame.midX, y: masterLayer.frame.midY)

        let instanceRotation = CATransform3DMakeTranslation(shift, 0.0, 0.0)
        spinnerReplicator.instanceCount = barCount
        spinnerReplicator.instanceTransform = instanceRotation
        
        spinnerReplicator.addSublayer(marker)
        masterLayer.addSublayer(spinnerReplicator)
        
        marker.opacity = 0.0
        let fade = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        fade.fromValue = 1.0
        fade.toValue = 0.2
        fade.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        let scale = CABasicAnimation(keyPath: "transform.scale.y")
        scale.fromValue = 1.0
        scale.toValue = 1.7
        scale.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        scale.autoreverses = true
        scale.duration = animationDuration / Double(barCount)
        
        let group = CAAnimationGroup()
        group.duration = animationDuration
        group.repeatCount = .infinity
        group.animations = [fade, scale]
        
        let markerAnimationDuration = animationDuration / Double(barCount)
        spinnerReplicator.instanceDelay = markerAnimationDuration
        marker.add(group, forKey: String(describing: activityIndicatorStyle))

    }
    
    private func addAnimationLinearBars() {
        let barCount = 7
        let width = round(0.7 * min(layer.bounds.width, layer.bounds.height) / CGFloat(barCount))
        let height: CGFloat = round(2.5 * width)
        let shift = width * 1.2

        let marker = CALayer()
        marker.bounds = CGRect(origin: .zero, size: CGSize(width: width, height: height))
        marker.cornerRadius = width / 2.0
        marker.backgroundColor = color.cgColor
        marker.position = CGPoint(x: masterLayer.frame.midX - (CGFloat(barCount - 1) * shift) / 2.0, y: masterLayer.frame.midY + height / 2.0)

        let spinnerReplicator = CAReplicatorLayer()
        spinnerReplicator.bounds = masterLayer.bounds
        spinnerReplicator.position = CGPoint(x: masterLayer.frame.midX, y: masterLayer.frame.midY)

        let instanceRotation = CATransform3DMakeTranslation(shift, 0.0, 0.0)
        spinnerReplicator.instanceCount = barCount
        spinnerReplicator.instanceTransform = instanceRotation
        
        spinnerReplicator.addSublayer(marker)
        masterLayer.addSublayer(spinnerReplicator)
        
        marker.opacity = 0.0
        let fade = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        fade.fromValue = 1.0
        fade.toValue = 0.2
        fade.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        fade.repeatCount = .infinity
        fade.duration = animationDuration
        let markerAnimationDuration = animationDuration / Double(barCount)
        spinnerReplicator.instanceDelay = markerAnimationDuration
        marker.add(fade, forKey: String(describing: activityIndicatorStyle))

    }
    
    private func addAnimationRingFlare() {
        masterLayer.strokeColor = nil
        /// Add flare
        func createFlare(sizeCoeff: CGFloat, flareColor: UIColor) -> CALayer {
            let gradientLeft = CAGradientLayer()
            gradientLeft.type = CAGradientLayerType.radial
            gradientLeft.colors = [flareColor.cgColor, flareColor.withAlphaComponent(0.0).cgColor]
            gradientLeft.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLeft.endPoint = CGPoint(x: 0.5, y: 0.0)
            let flareWidth: CGFloat = round(sizeCoeff * min(masterLayer.bounds.width, masterLayer.bounds.height))
            gradientLeft.frame = CGRect(x: 0.0, y: 0.0, width: flareWidth, height: flareWidth)
            let gradientRight = CAGradientLayer()
            gradientRight.type = CAGradientLayerType.radial
            gradientRight.colors = [color.cgColor, color.withAlphaComponent(0.0).cgColor]
            gradientRight.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientRight.endPoint = CGPoint(x: 0.5, y: 0.0)
            gradientRight.frame = CGRect(x: flareWidth, y: 0.0, width: flareWidth, height: flareWidth)
            gradientRight.transform = CATransform3DMakeRotation(toRadians(180.0), 0.0, 0.0, 1.0)
            let gradientContainer = CAShapeLayer()
            gradientContainer.frame = CGRect(x: 100.0, y: 50.0, width: flareWidth * 2, height: flareWidth)
            gradientContainer.addSublayer(gradientLeft)
            gradientContainer.addSublayer(gradientRight)
            let centerPoint: CGPoint = CGPoint(x: masterLayer.frame.midX, y: masterLayer.frame.midY)
            let R: CGFloat = round(min(masterLayer.bounds.width / 2, masterLayer.bounds.height / 2))
            let arcWidth: CGFloat = round(0.2 * R)
            let radius: CGFloat = R - arcWidth
            gradientContainer.position = CGPoint(x: centerPoint.x + radius, y: centerPoint.y)
            return gradientContainer
        }
        
        let flare1 = createFlare(sizeCoeff: 0.3, flareColor: color)
        let flare2 = createFlare(sizeCoeff: 0.2, flareColor: color)
        let flare3 = createFlare(sizeCoeff: 0.1, flareColor: color)
        masterLayer.addSublayer(flare1)
        masterLayer.addSublayer(flare2)
        masterLayer.addSublayer(flare3)

        /// Add animation
        func animateFlare(with tFunction: CAMediaTimingFunction) -> CAKeyframeAnimation {
            let anim = CAKeyframeAnimation(keyPath: #keyPath(CAShapeLayer.position))
            anim.path = masterLayer.path
            anim.duration = animationDuration * 1.5
            anim.repeatCount = .infinity
            anim.timingFunction = tFunction
            anim.isRemovedOnCompletion = false
            return anim
        }
        
        let rotAnim1 = animateFlare(with: .init(controlPoints: 0.0, 0.2, 0.3, 1.0))
        let rotAnim2 = animateFlare(with: .init(controlPoints: 0.1, 0.5, 0.7, 0.8))
        let rotAnim3 = animateFlare(with: .init(controlPoints: 0.4, 0.6, 0.9, 0.8))

        flare1.add(rotAnim1, forKey: String(describing: activityIndicatorStyle))
        flare2.add(rotAnim2, forKey: String(describing: activityIndicatorStyle))
        flare3.add(rotAnim3, forKey: String(describing: activityIndicatorStyle))
        
        
    }
    
    private func addAnimationiOS() {
        let barCount = 12
        let width = round(0.7 * min(layer.bounds.width, layer.bounds.height) / CGFloat(barCount))
        let height: CGFloat = round(3.0 * width)
        let spread: CGFloat = round(0.7 * min(masterLayer.bounds.width / 2, masterLayer.bounds.height / 2))
        
        let marker = CALayer()
        marker.bounds = CGRect(origin: .zero, size: CGSize(width: width, height: height))
        marker.cornerRadius = width / 2.0
        marker.backgroundColor = color.cgColor
        marker.position = CGPoint(x: masterLayer.frame.midX, y: masterLayer.frame.midY + spread)

        let spinnerReplicator = CAReplicatorLayer()
        spinnerReplicator.bounds = masterLayer.bounds
        spinnerReplicator.position = CGPoint(x: masterLayer.frame.midX, y: masterLayer.frame.midY)

        let angle = toRadians(360.0) / CGFloat(barCount)
        let instanceRotation = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
        spinnerReplicator.instanceCount = barCount
        spinnerReplicator.instanceTransform = instanceRotation
        
        spinnerReplicator.addSublayer(marker)
        masterLayer.addSublayer(spinnerReplicator)
        
        marker.opacity = 0.0
        let fade = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        fade.fromValue = 1.0
        fade.toValue = 0.2
        fade.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        fade.repeatCount = .infinity
        fade.duration = animationDuration
        let markerAnimationDuration = animationDuration / Double(barCount)
        spinnerReplicator.instanceDelay = markerAnimationDuration
        marker.add(fade, forKey: String(describing: activityIndicatorStyle))

    }
    
    private func addAnimationiOSCircles() {
        let barCount = 12
        let diameter = round(min(layer.bounds.width, layer.bounds.height) / CGFloat(barCount))
        let spread: CGFloat = round(0.6 * min(masterLayer.bounds.width / 2, masterLayer.bounds.height / 2))
        
        let marker = CAShapeLayer()
        marker.bounds = CGRect(origin: .zero, size: CGSize(width: diameter, height: diameter))
        marker.path = UIBezierPath(ovalIn: marker.bounds).cgPath
        marker.fillColor = color.cgColor
        marker.position = CGPoint(x: masterLayer.frame.midX, y: masterLayer.frame.midY + spread)
        
        let spinnerReplicator = CAReplicatorLayer()
        spinnerReplicator.bounds = masterLayer.bounds
        spinnerReplicator.position = CGPoint(x: masterLayer.frame.midX, y: masterLayer.frame.midY)

        let angle = toRadians(360.0) / CGFloat(barCount)
        let instanceRotation = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
        spinnerReplicator.instanceCount = barCount
        spinnerReplicator.instanceTransform = instanceRotation
        
        spinnerReplicator.addSublayer(marker)
        masterLayer.addSublayer(spinnerReplicator)
        
        marker.opacity = 0.0
        let fade = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        fade.fromValue = 1.0
        fade.toValue = 0.2
        fade.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        fade.repeatCount = .infinity
        fade.duration = animationDuration
        let markerAnimationDuration = animationDuration / Double(barCount)
        spinnerReplicator.instanceDelay = markerAnimationDuration
        marker.add(fade, forKey: String(describing: activityIndicatorStyle))

    }
    
    private func addAnimationTripleDotDance() {
        let rotAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotAnim.fromValue = 0.0
        rotAnim.toValue = toRadians(180)
        rotAnim.duration = animationDuration
        rotAnim.repeatCount = .infinity
        rotAnim.isCumulative = true
        
        self.masterLayer.add(rotAnim, forKey: String(describing: activityIndicatorStyle) + "1")
        
        let R: CGFloat = round(0.8 * min(masterLayer.bounds.width / 2, masterLayer.bounds.height / 2))
        let arcWidth: CGFloat = round(0.2 * R)
        let centerPoint: CGPoint = CGPoint(x: masterLayer.frame.midX, y: masterLayer.frame.midY)
        let radius: CGFloat = R - arcWidth
        let startAngle: CGFloat = toRadians(0.0)
        let endAngle: CGFloat = toRadians(360.0)
        let unifiedCirclePath = UIBezierPath(arcCenter: centerPoint,
                                      radius: radius,
                                      startAngle: startAngle,
                                      endAngle: endAngle,
                                      clockwise: true)
        
        let mergeAnim = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.path))
        mergeAnim.toValue = unifiedCirclePath.cgPath
        mergeAnim.duration = animationDuration
        mergeAnim.autoreverses = true
        mergeAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        mergeAnim.repeatCount = .infinity
        
        self.masterLayer.add(mergeAnim, forKey: String(describing: activityIndicatorStyle) + "2")
        
    }
    
    private func addAnimationRainbowFill() {
        masterLayer.strokeColor = nil
        let gradient = CAGradientLayer()
        gradient.type = CAGradientLayerType.conic
        let col1 = #colorLiteral(red: 0.5803921569, green: 0, blue: 0.8274509804, alpha: 1)
        let col2 = #colorLiteral(red: 0.2941176471, green: 0, blue: 0.5098039216, alpha: 1)
        let col3 = #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)
        let col4 = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
        let col5 = #colorLiteral(red: 1, green: 1, blue: 0, alpha: 1)
        let col6 = #colorLiteral(red: 1, green: 0.4980392157, blue: 0, alpha: 1)
        let col7 = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        let col8 = #colorLiteral(red: 0.5803921569, green: 0, blue: 0.8274509804, alpha: 1)
        gradient.colors = [col1.cgColor, col2.cgColor, col3.cgColor, col4.cgColor,
                           col5.cgColor, col6.cgColor, col7.cgColor, col8.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.frame = self.masterLayer.bounds
        let shapeMask = CAShapeLayer()
        shapeMask.path = self.masterLayer.path
        gradient.mask = shapeMask
        masterLayer.addSublayer(gradient)
        
        let animGroup = CAAnimationGroup()
        animGroup.duration = animationDuration * 1.7
        animGroup.repeatCount = .infinity

        let growAnim = CABasicAnimation(keyPath: "transform.scale")
        growAnim.fromValue = 0.2
        growAnim.toValue = 1.0
        growAnim.byValue = 0.5
        growAnim.repeatCount = .infinity
        growAnim.isCumulative = true
        growAnim.isRemovedOnCompletion = false
        growAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)

        
        let opacityAnim = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.opacity))
        /// starting from opacity greater than 1 creates a delay
        opacityAnim.fromValue = 2.0
        opacityAnim.toValue = 0.0
        opacityAnim.byValue = 0.1
        opacityAnim.repeatCount = .infinity
        opacityAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        opacityAnim.isRemovedOnCompletion = false
        opacityAnim.fillMode = CAMediaTimingFillMode.forwards
        opacityAnim.isCumulative = true
        
        let rotAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotAnim.fromValue = 0.0
        rotAnim.toValue = toRadians(360.0)
        rotAnim.repeatCount = .infinity
        rotAnim.isCumulative = true
        
        animGroup.animations = [growAnim, opacityAnim, rotAnim]
        self.masterLayer.add(animGroup, forKey: String(describing: activityIndicatorStyle))
    }
    
    private func addAnimationEchoInside() {
        let animGroup = CAAnimationGroup()
        animGroup.duration = animationDuration * 1.7
        animGroup.repeatCount = .infinity

        let shrinkAnim = CABasicAnimation(keyPath: "transform.scale")
        shrinkAnim.fromValue = 1.0
        shrinkAnim.toValue = 0.2
        shrinkAnim.byValue = 0.5
        shrinkAnim.repeatCount = .infinity
        shrinkAnim.isCumulative = true
        shrinkAnim.isRemovedOnCompletion = false
        shrinkAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)

        
        let opacityAnim = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.opacity))
        /// starting from opacity greater than 1 creates a delay
        opacityAnim.fromValue = 1.5
        opacityAnim.toValue = 0.0
        opacityAnim.byValue = 0.1
        opacityAnim.repeatCount = .infinity
        opacityAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        opacityAnim.isRemovedOnCompletion = false
        opacityAnim.fillMode = CAMediaTimingFillMode.forwards
        opacityAnim.isCumulative = true
        
        animGroup.animations = [shrinkAnim, opacityAnim]
        self.masterLayer.add(animGroup, forKey: String(describing: activityIndicatorStyle))
    }
    
    private func addAnimationEchoOutside() {
        let animGroup = CAAnimationGroup()
        animGroup.duration = animationDuration * 1.7
        animGroup.repeatCount = .infinity

        let growAnim = CABasicAnimation(keyPath: "transform.scale")
        growAnim.fromValue = 0.2
        growAnim.toValue = 1.0
        growAnim.byValue = 0.5
        growAnim.repeatCount = .infinity
        growAnim.isCumulative = true
        growAnim.isRemovedOnCompletion = false
        growAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)

        
        let opacityAnim = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.opacity))
        /// starting from opacity greater than 1 creates a delay
        opacityAnim.fromValue = 2.0
        opacityAnim.toValue = 0.0
        opacityAnim.byValue = 0.1
        opacityAnim.repeatCount = .infinity
        opacityAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        opacityAnim.isRemovedOnCompletion = false
        opacityAnim.fillMode = CAMediaTimingFillMode.forwards
        opacityAnim.isCumulative = true
        
        animGroup.animations = [growAnim, opacityAnim]
        self.masterLayer.add(animGroup, forKey: String(describing: activityIndicatorStyle))
    }
    
    private func addAnimationTailingContinuous() {
        self.masterLayer.lineDashPattern = nil
        let strokeEndAnimation: CAAnimation = {
            let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
            animation.fromValue = 0.0
            animation.toValue = 1.0
            animation.duration = animationDuration * 1.8
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

            let group = CAAnimationGroup()
            group.duration = animationDuration * 2.0
            group.repeatCount = .infinity
            group.animations = [animation]
            return group
        }()

        let strokeStartAnimation: CAAnimation = {
            let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeStart))
            animation.beginTime = animationDuration / 2.0
            animation.fromValue = 0.0
            animation.toValue = 1.0
            animation.duration = animationDuration * 1.8
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

            let group = CAAnimationGroup()
            group.duration = animationDuration * 2.0
            group.repeatCount = .infinity
            group.animations = [animation]
            return group
            }()
        
        let rotationAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
            animation.fromValue = 0.0
            animation.toValue = toRadians(360.0)
            animation.duration = animationDuration * 2.0
            animation.repeatCount = .infinity
        return animation
        }()
        
        self.masterLayer.add(strokeEndAnimation, forKey: String(describing: activityIndicatorStyle) + "1")
        self.masterLayer.add(strokeStartAnimation, forKey: String(describing: activityIndicatorStyle) + "2")
        self.masterLayer.add(rotationAnimation, forKey: String(describing: activityIndicatorStyle) + "3")

    }
    
    private func addAnimationTailingDashed() {
        self.masterLayer.lineWidth = min(5.0, self.masterLayer.lineWidth)
        let minLength = min(self.masterLayer.bounds.width, self.masterLayer.bounds.height)
        self.masterLayer.lineDashPattern = minLength > 50.0 ? [25] : [10]
        self.masterLayer.lineDashPhase = 20.0
        
        let strokeEndAnimation: CAAnimation = {
            let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
            animation.fromValue = 0.0
            animation.toValue = 1.0
            animation.duration = animationDuration * 1.8
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

            let group = CAAnimationGroup()
            group.duration = animationDuration * 2.0
            group.repeatCount = .infinity
            group.animations = [animation]
            return group
        }()

        let strokeStartAnimation: CAAnimation = {
            let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeStart))
            animation.beginTime = animationDuration / 2.0
            animation.fromValue = 0.0
            animation.toValue = 1.0
            animation.duration = animationDuration * 1.8
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

            let group = CAAnimationGroup()
            group.duration = animationDuration * 2.0
            group.repeatCount = .infinity
            group.animations = [animation]
            return group
            }()
        
        let rotationAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
            animation.fromValue = 0.0
            animation.toValue = toRadians(360.0)
            animation.duration = animationDuration * 2.0
            animation.repeatCount = .infinity
        return animation
        }()
        
        self.masterLayer.add(strokeEndAnimation, forKey: String(describing: activityIndicatorStyle) + "1")
        self.masterLayer.add(strokeStartAnimation, forKey: String(describing: activityIndicatorStyle) + "2")
        self.masterLayer.add(rotationAnimation, forKey: String(describing: activityIndicatorStyle) + "3")

    }
    
    private func addAnimationsSpinningDashed() {
        self.masterLayer.lineWidth = min(5.0, self.masterLayer.lineWidth)
        let minLength = min(self.masterLayer.bounds.width, self.masterLayer.bounds.height)
        self.masterLayer.lineDashPattern = minLength > 50.0 ? [20] : [10]
        self.masterLayer.lineDashPhase = 30.0
        let spinAnim = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
        spinAnim.toValue = CATransform3DMakeRotation(toRadians(-180), 0.0, 0.0, 1.0)
        spinAnim.duration = animationDuration
        spinAnim.repeatCount = .infinity
        spinAnim.isCumulative = true
        spinAnim.isRemovedOnCompletion = false
        
        self.masterLayer.add(spinAnim, forKey: String(describing: activityIndicatorStyle))
    }
    
    private func addAnimationsSpinThickness() {
        let animGroup = CAAnimationGroup()
        animGroup.duration = animationDuration
        animGroup.repeatCount = .infinity

        let spinAnim = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
        spinAnim.toValue = CATransform3DMakeRotation(toRadians(-180), 0.0, 0.0, 1.0)
        spinAnim.duration = animationDuration * 0.6
        spinAnim.repeatCount = .infinity
        spinAnim.isCumulative = true
        spinAnim.isRemovedOnCompletion = false
        
        let thicknessAnim = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.lineWidth))
        thicknessAnim.fromValue = lineWidth * 1.0
        thicknessAnim.toValue = lineWidth * 0.1
        thicknessAnim.duration = animationDuration * 0.5
        thicknessAnim.repeatCount = .infinity
        thicknessAnim.autoreverses = true
        thicknessAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        thicknessAnim.isRemovedOnCompletion = false
        thicknessAnim.fillMode = CAMediaTimingFillMode.forwards
        thicknessAnim.isCumulative = true
        
        animGroup.animations = [spinAnim, thicknessAnim]
        self.masterLayer.add(animGroup, forKey: String(describing: activityIndicatorStyle))
    }
    
    private func addAnimationsSpinClassic() {
        let spinAnim = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
        spinAnim.toValue = CATransform3DMakeRotation(toRadians(-180), 0.0, 0.0, 1.0)
        spinAnim.duration = animationDuration
        spinAnim.repeatCount = .infinity
        spinAnim.isCumulative = true
        spinAnim.isRemovedOnCompletion = false
        self.masterLayer.add(spinAnim, forKey: String(describing: activityIndicatorStyle))
    }
    
    private func lightenColor(_ color: UIColor, by percentageCoeff: CGFloat) -> UIColor {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        if color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: hue, saturation: saturation, brightness: brightness * (1 + percentageCoeff), alpha: alpha)
        }
        return color
    }
    
    private func darkenColor(_ color: UIColor, by percentageCoeff: CGFloat) -> UIColor {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        if color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: hue, saturation: saturation, brightness: brightness * (1 - percentageCoeff), alpha: alpha)
        }
        return color
    }
    
}

