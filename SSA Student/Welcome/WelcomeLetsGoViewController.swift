//
//  WelcomeLetsGoViewController.swift
//  SSA Student
//
//  Created by Nick on 8/30/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class WelcomeLetsGoViewController: UIViewController {

    fileprivate var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 48, weight: .semibold)
        label.text = "Congratulations!"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    fileprivate var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "You're ready to start\nusing SSA Student."
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var letsGoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Let's Go!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIView().tintColor
        return button
    }()
    
    @objc func presentMainView() {
        self.navigationController?.pushViewController(TabBarViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.layoutSubviews()
        
        self.view.backgroundColor = .white
        
        self.letsGoButton.addTarget(self, action: #selector(presentMainView), for: .touchUpInside)
    }
    

    fileprivate func layoutSubviews() {
        
        self.view.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: self.view.safeAreaLayoutGuide.layoutFrame.height/6),
            self.titleLabel.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: -128)
        ])
        
        self.view.addSubview(self.subtitleLabel)
        NSLayoutConstraint.activate([
            self.subtitleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16.0),
            self.subtitleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
        
        self.view.addSubview(self.letsGoButton)
        NSLayoutConstraint.activate([
            self.letsGoButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.letsGoButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -128),
            self.letsGoButton.heightAnchor.constraint(equalToConstant: 48),
            self.letsGoButton.widthAnchor.constraint(equalToConstant: 256)
        ])
    }

}
