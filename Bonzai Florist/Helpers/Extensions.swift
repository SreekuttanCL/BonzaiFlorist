//
//  Extensions.swift
//  Bonzai Florist
//
//  Created by Sreekuttan C L on 2019-11-30.
//  Copyright © 2019 Sreekuttan C L. All rights reserved.
//

import UIKit

extension UITextField {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
}

extension UIButton{
    func roundedButton(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft , .topRight, .allCorners],
            cornerRadii: CGSize(width: 30, height: 30))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}
