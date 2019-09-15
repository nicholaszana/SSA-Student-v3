//
//  WelcomeTypeSelectionViewController.swift
//  SSA Student
//
//  Created by Nick on 8/29/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class WelcomeTypeSelectionViewController: UIViewController {

    fileprivate var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 48, weight: .semibold)
        label.text = "First things first."
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
        label.text = "Who are you?"
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var studentButton: UIButton = {
        let button = UIButton()
        button.setTitle("I'm a Student", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIView().tintColor
        return button
    }()
    
    fileprivate var parentButton: UIButton = {
        let button = UIButton()
        button.setTitle("I'm a Parent", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIView().tintColor, for: .normal)
        return button
    }()

    fileprivate var facultyButton: UIButton = {
        let button = UIButton()
        button.setTitle("I'm a Faculty Member", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIView().tintColor, for: .normal)
        return button
    }()
    
    func presentNext() {
        self.navigationController?.pushViewController(WelcomeLetsGoViewController(), animated: true)
    }
    
    @objc func didPressStudent() {
        Defaults.set(value: UserType.student.rawValue, key: .userType)
        globalUser = User(userId: globalUser.userId, type: .student)
        presentNext()
    }
    
    @objc func didPressFaculty() {
        Defaults.set(value: UserType.faculty.rawValue, key: .userType)
        globalUser = User(userId: globalUser.userId, type: .faculty)
        presentNext()
    }
    
    @objc func didPressParent() {
        Defaults.set(value: UserType.parent.rawValue, key: .userType)
        globalUser = User(userId: globalUser.userId, type: .parent)
        presentNext()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.facultyButton.addTarget(self, action: #selector(didPressFaculty), for: .touchUpInside)
        self.parentButton.addTarget(self, action: #selector(didPressParent), for: .touchUpInside)
        self.studentButton.addTarget(self, action: #selector(didPressStudent), for: .touchUpInside)
        
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        self.layoutSubviews()
    }
    
    fileprivate func layoutSubviews() {
        
        self.view.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: self.view.safeAreaLayoutGuide.layoutFrame.height/6),
            self.titleLabel.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: -64)
        ])
        
        self.view.addSubview(self.subtitleLabel)
        NSLayoutConstraint.activate([
            self.subtitleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16.0),
            self.subtitleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
        
        self.view.addSubview(facultyButton)
        NSLayoutConstraint.activate([
            self.facultyButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.facultyButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
        ])
        
        self.view.addSubview(parentButton)
        NSLayoutConstraint.activate([
            self.parentButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.parentButton.bottomAnchor.constraint(equalTo: self.facultyButton.topAnchor, constant: -16),
        ])
        
        self.view.addSubview(studentButton)
        NSLayoutConstraint.activate([
            self.studentButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.studentButton.bottomAnchor.constraint(equalTo: self.parentButton.topAnchor, constant: -32),
            self.studentButton.heightAnchor.constraint(equalToConstant: 48),
            self.studentButton.widthAnchor.constraint(equalToConstant: 256)
        ])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
