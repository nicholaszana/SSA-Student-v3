//
//  WelcomeViewController.swift
//  SSA Student
//
//  Created by Nick on 8/29/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class WelcomeViewController: UIViewController, GIDSignInDelegate {

    var signInButton: UIButton = {
        let button = GoogleButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(ImageAssets.google, for: .normal)
        return button
    }()
    
    @objc func googleSignIn() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    fileprivate var welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 48, weight: .semibold)
        label.text = "Welcome"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    fileprivate var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "To get started, please sign in\nwith your Shady Side Academy email."
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        self.signInButton.addTarget(self, action: #selector(googleSignIn), for: .touchUpInside)
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.presentingViewController = self
        self.layoutSubviews()
    }
    
    func moveToSelection() {
        navigationController?.pushViewController(WelcomeTypeSelectionViewController(), animated: true)
    }
    
    fileprivate func layoutSubviews() {
        
        self.view.addSubview(self.welcomeLabel)
        NSLayoutConstraint.activate([
            self.welcomeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.welcomeLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: self.view.safeAreaLayoutGuide.layoutFrame.height/6),
            self.welcomeLabel.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor)
        ])
        
        self.view.addSubview(self.subtitleLabel)
        NSLayoutConstraint.activate([
            self.subtitleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.subtitleLabel.topAnchor.constraint(equalTo: self.welcomeLabel.bottomAnchor, constant: 16.0),
            self.subtitleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
        
        self.view.addSubview(signInButton)
        NSLayoutConstraint.activate([
            self.signInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.signInButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 32),
            self.signInButton.widthAnchor.constraint(equalToConstant: 64),
            self.signInButton.heightAnchor.constraint(equalTo: self.signInButton.widthAnchor)
        ])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

        if let error = error {
            print(error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        guard let email = user.profile.email else {return}
        let splitString = email.split(separator: "@")
        guard splitString.count == 2 else {return}
        let userId = splitString[0]
        let emailUrl = splitString[1]
        if String(emailUrl) != "shadysideacademy.org" {
            let ac = UIAlertController(title: "Invalid Account", message: "Please try again, but sign in with your Shady Side Academy Google Account", preferredStyle: .alert)

            let doneAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)

            ac.addAction(doneAction)

            present(ac, animated: true, completion: nil)

            do {
                let fireabseAuth = Auth.auth()
                try fireabseAuth.signOut()
                return
            } catch let error as NSError {
                return
            }
        }
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                return
            }
         
            globalUser = User(userId: String(userId), type: .student)
            Defaults.set(value: userId, key: .userId)
            self.moveToSelection()
        }
    }
}




final class GoogleButton: UIButton {

    private var shadowLayer: CAShapeLayer!

    override func layoutSubviews() {
        super.layoutSubviews()

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 4).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor

            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 2

            layer.insertSublayer(shadowLayer, at: 0)
        }
    }

}
