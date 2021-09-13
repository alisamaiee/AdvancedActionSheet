//
//  RoundCheckbox.swift
//  AdvancedActionSheet
//

import Foundation
import UIKit

internal typealias CheckboxValueChangedBlock = (_ isOn: Bool) -> Void

@objc internal enum VKCheckboxLine: Int {
    case normal
    case thin
}

internal class RoundCheckBox: UIView {
    // MARK: - Properties
    
    /**
     Private property which indicates current state of checkbox
     Default value is false
     - See: isOn()
     */
    fileprivate var on: Bool = false {
        didSet {
            self.checkboxValueChangedBlock?(on)
        }
    }
    
    /**
     Closure which called when property 'on' is changed
     */
    var checkboxValueChangedBlock: CheckboxValueChangedBlock?
    
    // MARK: Customization
    
    
    var isAnimateEnabled : Bool = true
    
    /**
     Set background color of checkbox
     */
    var bgColor: UIColor = UIColor.clear {
        didSet {
            if !self.isOn()
            {
                self.setBackground(bgColor)
            }
        }
    }
    
    /**
     Set background color of checkbox in selected state
     */
    var bgColorSelected = UIColor.clear {
        didSet {
            if self.isOn() {
                self.setBackground(bgColorSelected)
            }
        }
    }
    
    /**
     Set checkmark color
     */
    var color: UIColor = UIColor.blue {
        didSet {
            self.checkmark.color = color
        }
    }
    
    /**
     Set checkbox corner radius
     */
    var cornerRadius: CGFloat {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.checkmark.layer.cornerRadius = cornerRadius
            self.backgroundView.layer.cornerRadius = cornerRadius
        }
    }
    
    /**
     Set line type
     Default value is Normal
     - See: VKCheckboxLine enum
     */
    var line = VKCheckboxLine.normal
    
    // MARK: Private properties
    
    fileprivate var button      = UIButton()
    fileprivate var checkmark   = RoundCheckboxView()
    internal var backgroundView = UIImageView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        self.cornerRadius = 8
        super.init(frame: frame)
        self.setupView()

    }
    
    required init?(coder aDecoder: NSCoder) {
        self.cornerRadius = 8
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    fileprivate func setupView() {
        // Init base properties
        self.layer.borderWidth            = 3
        self.layer.borderColor            = UIColor.darkGray.cgColor
        self.color                        = UIColor(red: 46/255, green: 119/255, blue: 217/255, alpha: 1)
        
        self.setBackground(UIColor.clear)
        self.backgroundView.frame = self.bounds
        self.backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        self.backgroundView.layer.masksToBounds = true
        self.addSubview(self.backgroundView)
        
        // Setup checkmark
        self.checkmark.frame = self.bounds
        self.checkmark.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        self.addSubview(self.checkmark)
        
        // Setup button
        self.button.frame = self.bounds
        self.button.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        self.button.addTarget(self, action: #selector(RoundCheckBox.buttonDidSelected), for: .touchUpInside)
        self.addSubview(self.button)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.button.bounds    = self.bounds
        self.checkmark.bounds = self.bounds
    }
}

// MARK: - Public
internal extension RoundCheckBox {
    /**
     Function allows you to set checkbox state
     - Parameter on Checkbox state
     */
    func setOn(_ on: Bool) {
        self.setOn(on, animated: false)
    }
    
    /**
     Function allows you to set checkbox state with animation
     - Parameter on Checkbox state
     - Parameter animated Enable anomation
     */
    func setOn(_ on: Bool, animated: Bool) {
        self.on = on
        self.showCheckmark(on, animated: animated)
        
        if animated {
            UIView.animate(withDuration: 0.275, animations:
                {
                    self.setBackground(on ? self.bgColorSelected : self.bgColor)
            })
        } else {
            self.setBackground(on ? self.bgColorSelected : self.bgColor)
        }
    }
    
    /**
     Function allows to check current checkbox state
     - Returns: State as Bool value
     */
    func isOn() -> Bool {
        return self.on
    }
    
    /// Set checkbox background color
    ///
    /// - Parameter backgroundColor: New color
    func setBackground(_ backgroundColor: UIColor) {
        self.backgroundView.image = UIImage.from(color: backgroundColor)
    }
}

// MARK: - Private
internal extension RoundCheckBox {
    @objc fileprivate func buttonDidSelected() {
        self.setOn(!self.on, animated: isAnimateEnabled)
    }
    
    fileprivate func showCheckmark(_ show: Bool, animated: Bool) {
        if show == true {
            let width = (self.bounds.width > 0) ? self.bounds.width : (self.cornerRadius > 0) ? (cornerRadius * 2) : 24
            self.checkmark.strokeWidth = width / (self.line == .normal ? 10 : 20)
            self.checkmark.show(animated)
        } else {
            self.checkmark.hide(animated)
        }
    }
}


private class RoundCheckboxView: UIView {
    var color: UIColor = UIColor.blue
    
    fileprivate var animationDuration: TimeInterval = 0.275
    fileprivate var strokeWidth: CGFloat = 0
    fileprivate var checkmarkLayer: CAShapeLayer!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupCheckmark()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCheckmark()
    }
    
    fileprivate func setupCheckmark() {
        self.checkmarkLayer             = CAShapeLayer()
        self.checkmarkLayer.fillColor   = nil
    }
}

private extension RoundCheckboxView {
    func show(_ animated: Bool) {
        self.alpha = 1
        
        self.checkmarkLayer.removeAllAnimations()
        let height = (self.bounds.height > 0) ? self.bounds.height : (self.layer.cornerRadius > 0) ? (self.layer.cornerRadius * 2) : 24
        let width = (self.bounds.width > 0) ? self.bounds.width : (self.layer.cornerRadius > 0) ? (self.layer.cornerRadius * 2) : 24
        let checkmarkPath = UIBezierPath()
        checkmarkPath.move(to: CGPoint(x: width * 0.28, y: height * 0.5))
        checkmarkPath.addLine(to: CGPoint(x: width * 0.42, y: height * 0.66))
        checkmarkPath.addLine(to: CGPoint(x: width * 0.72, y: height * 0.36))
        checkmarkPath.lineCapStyle  = .square
        self.checkmarkLayer.path    = checkmarkPath.cgPath
        
        self.checkmarkLayer.strokeColor = self.color.cgColor
        self.checkmarkLayer.lineWidth   = self.strokeWidth
        self.layer.addSublayer(self.checkmarkLayer)
        
        if animated == false {
            checkmarkLayer.strokeEnd = 1
        } else {
            let checkmarkAnimation: CABasicAnimation = CABasicAnimation(keyPath:"strokeEnd")
            checkmarkAnimation.duration = animationDuration
            checkmarkAnimation.isRemovedOnCompletion = false
            checkmarkAnimation.fillMode = CAMediaTimingFillMode.both
            checkmarkAnimation.fromValue = 0
            checkmarkAnimation.toValue = 1
            checkmarkAnimation.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
            self.checkmarkLayer.add(checkmarkAnimation, forKey:"strokeEnd")
        }
        self.setNeedsDisplay()
    }
    
    func hide(_ animated: Bool) {
        var duration = self.animationDuration
        
        if animated == false {
            duration = 0
        }
        
        UIView.animate(withDuration: duration, animations: {
                self.alpha = 0
        }, completion: {
            (completed) in
            self.checkmarkLayer.removeFromSuperlayer()
        })
    }
}

