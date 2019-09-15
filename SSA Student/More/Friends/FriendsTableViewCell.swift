//
//  FriendsTableViewCell.swift
//  SSA Student
//
//  Created by Nick on 8/23/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    static let identifier = "FriendsTableViewCell"
    
    public var model: FriendsViewController.FriendCell? {
        didSet {
            guard let model = self.model else {return}
            self.profilePicImageView.image = model.profilePic
            self.friendNameLabel.text = model.name
        }
    }
    
    fileprivate var profilePicImageView: ProfilePicture = {
        let imageView = ProfilePicture()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate var friendNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.addSubview(friendNameLabel)
        self.contentView.addSubview(profilePicImageView)
        
        NSLayoutConstraint.activate([
            profilePicImageView.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8.0),
            profilePicImageView.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 8.0),
            profilePicImageView.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8.0),
            profilePicImageView.widthAnchor.constraint(equalTo: profilePicImageView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            friendNameLabel.leadingAnchor.constraint(equalTo: self.profilePicImageView.trailingAnchor, constant: 8.0),
            friendNameLabel.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 8.0),
            friendNameLabel.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8.0),
            friendNameLabel.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8.0)
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.friendNameLabel.text = nil
        self.profilePicImageView.image = nil
    }
    
}
