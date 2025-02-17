//
//  PinTextField.swift
//  VergeiOS
//
//  Created by Swen van Zanten on 24-07-18.
//  Copyright © 2018 Verge Currency. All rights reserved.
//

import UIKit

class PinTextField: UIView {

    var pinCharacterCount: Int!
    let pinHeight: CGFloat = 24.0
    let pinMargin: CGFloat = 36.0
    let pinRadius: CGFloat = 12.0

    var pinsFilled: Int = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        self.becomeThemeable()
    }

    override func updateColors() {
        self.setNeedsDisplay()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setup()
    }

    func setup() {
        self.backgroundColor = .clear
        self.pinCharacterCount = Application.container.resolve(ApplicationRepository.self)!.pinCount
    }

    // Draw the pin character circles.
    override func draw(_ rect: CGRect) {
        let width = (pinMargin * CGFloat(self.pinCharacterCount - 1)) + pinHeight
        let rect = CGRect(x: (self.frame.width - width) / 2, y: 0, width: width, height: pinHeight)
        let circlesView = UIView(frame: rect)

        for index in 0...(self.pinCharacterCount - 1) {
            circlesView.layer.addSublayer(self.createCircleForIndex(index))
        }

        for view in self.subviews {
            view.removeFromSuperview()
        }

        self.addSubview(circlesView)
    }

    // Create the pin character circle.
    private func createCircleForIndex(_ index: Int) -> CAShapeLayer {
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: (CGFloat(index) * pinMargin) + pinRadius, y: pinRadius),
            radius: pinRadius,
            startAngle: 0,
            endAngle: CGFloat(Double.pi * 2),
            clockwise: true
        )

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath

        // Change the fill color
        shapeLayer.fillColor = ThemeManager.shared.primaryLight().withAlphaComponent(0.4).cgColor

        // Fill the pin when
        if (self.pinsFilled >= (index + 1)) {
            shapeLayer.fillColor = ThemeManager.shared.primaryLight().cgColor
        }

        return shapeLayer
    }

    // Add a character.
    public func addCharacter() {
        self.pinsFilled += (self.pinsFilled == self.pinCharacterCount) ? 0 : 1
        self.draw(self.frame)
    }

    // Remove a character.
    public func removeCharacter() {
        self.pinsFilled -= (self.pinsFilled == 0) ? 0 : 1
        self.draw(self.frame)
    }

    // Reset the pin text field.
    public func reset() {
        self.pinsFilled = 0
        self.draw(self.frame)
    }
}
