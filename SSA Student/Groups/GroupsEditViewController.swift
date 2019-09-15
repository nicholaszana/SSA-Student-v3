//
//  GroupsEditViewController.swift
//  SSA Student
//
//  Created by Nick on 8/24/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class GroupsEditViewController: UIViewController {

    fileprivate var createGroupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create a Club", for: .normal)
        button.layer.cornerRadius = 16.0
        button.clipsToBounds = true
        button.backgroundColor = .green
        return button
    }()
    
    fileprivate var joinGroupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Join a Club", for: .normal)
        button.layer.cornerRadius = 16.0
        button.clipsToBounds = true
        button.backgroundColor = .blue
        return button
    }()
    
    fileprivate var cancelButton: UIBarButtonItem!
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
        
    @objc fileprivate func didPressCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didPressCancelButton))
        
        self.navigationItem.leftBarButtonItem = cancelButton
        
        self.title = "Choose an Action"
        
        //TODO: Change when themes is a thing
        self.view.backgroundColor = .white
        
        self.layoutSubviews()
    }
    
    fileprivate func layoutSubviews() {
        self.view.addSubview(stackView)
        
        self.stackView.addArrangedSubview(createGroupButton)
        self.stackView.addArrangedSubview(joinGroupButton)
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8.0),
            self.stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8.0),
            self.stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8.0),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8.0),
        ])
        
        self.stackView.layoutIfNeeded()
        
    }

}
