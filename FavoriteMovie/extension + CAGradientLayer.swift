//
//  extension + CAGradientLayer.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/16.
//

import UIKit

extension CAGradientLayer {
    
    func setColors(newColors: [CGColor],
                   animated: Bool,
                   duration: TimeInterval = 0,
                   name: CAMediaTimingFunctionName? = nil) {
        if !animated {
            self.colors = newColors
            return
        }
        
        let colorAnimation = CABasicAnimation(keyPath: "colors")
        colorAnimation.fromValue = colors
        colorAnimation.toValue = newColors
        colorAnimation.duration = duration
        colorAnimation.isRemovedOnCompletion = false
        colorAnimation.fillMode = CAMediaTimingFillMode.both
        colorAnimation.timingFunction = CAMediaTimingFunction(name: name ?? .linear)
        colorAnimation.repeatCount = .infinity
        
        add(colorAnimation, forKey: "colorsChangeAnimation")
    }
}
