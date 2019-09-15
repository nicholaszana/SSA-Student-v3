//
//  SignOutTableViewCell.swift
//  SSA Student
//
//  Created by Nick on 9/8/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class SignOutTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cellIcon.image = ImageAssets.google.imageWithInsets(insets: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        self.cellLabel.text = "Sign Out"
        self.layoutSubviews()
    }
    
    fileprivate var cellIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.tintColor = .white
        return imageView
    }()
    
    fileprivate var cellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(cellIcon)
        contentView.addSubview(cellLabel)
        
        //Activates Cell Icon Constraints
        NSLayoutConstraint.activate([
            cellIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cellIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            cellIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cellIcon.widthAnchor.constraint(equalTo: cellIcon.heightAnchor)
            ])
        
        //Activates Cell Label Constraints
        NSLayoutConstraint.activate([
            cellLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cellLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            cellLabel.leadingAnchor.constraint(equalTo: cellIcon.trailingAnchor, constant: 16),
            cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
    }

}
