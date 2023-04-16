//
//  LoginScreen.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/15.
//

import UIKit

protocol LoginScreenDelegate {
    func loginButtonTapped()
}

class LoginScreen: UIView {
    
    // MARK: - Delegate
    var delegate: LoginScreenDelegate?
    
    func setViewDelegate(delegate: LoginScreenDelegate?) {
        self.delegate = delegate
    }
    
    //MARK: - Elements

    private lazy var loginButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.borderWidth = 2
        element.layer.borderColor = Colors.darkMagenta
        element.clipsToBounds = true
        element.layer.cornerRadius = 30
        element.backgroundColor = .black
        element.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        element.addTarget(self, action: #selector(self.loginButtonTapped), for: .touchUpInside)
        element.setTitle("FaceID", for: .normal)
        return element
    }()
    
    lazy var gradientBackground: CAGradientLayer = {
        let element = CAGradientLayer()
        element.type = .axial
        element.colors = [
            Colors.darkMagenta,
            Colors.darkGray,
            Colors.darkMagenta
        ]
        element.locations = [0, 0.5, 1]
        return element
    }()
    
    //MARK: - Elements targets
    
    @objc private func loginButtonTapped(){
        delegate?.loginButtonTapped()
    }
    
    func setBackground(){
        self.gradientBackground.frame = bounds
        layer.insertSublayer(gradientBackground, at: 0)
        gradientBackground.setColors(newColors: [Colors.darkGray,
                                                 Colors.darkMagenta,
                                                 Colors.darkGray],
                                     animated: true,
                                     duration: 4,
                                     name: .easeInEaseOut)
    }
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Elements settings

    private func setButton() {
        addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 60),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        ])
    }
    
}
