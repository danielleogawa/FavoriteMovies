//
//  HomeScreen.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/16.
//

import UIKit

final class HomeScreen: UIView {
    
    lazy var gradientBackground: CAGradientLayer = {
        let element = CAGradientLayer()
        element.type = .axial
        element.colors = [
            Colors.darkGray.cgColor,
            Colors.darkMagenta.cgColor
        ]
        element.locations = [0, 1]
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.darkGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBackground(){
        self.gradientBackground.frame = bounds
        layer.insertSublayer(gradientBackground, at: 0)
        gradientBackground.setColors(newColors: [Colors.darkGray.cgColor,
                                                 Colors.darkMagenta.cgColor,
                                                 Colors.darkGray.cgColor],
                                     animated: true,
                                     duration: 4,
                                     name: .easeInEaseOut)
    }
    
}

