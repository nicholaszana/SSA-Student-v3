//
//  MoreTableViewCell.swift
//  SSA Student
//
//  Created by Nick on 8/7/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

enum MoreTableViewCellTypes {
    case friends
    case settings
    case about
    case news
    case calendar
    case lunch
    case teacherPages
    case planner
}

struct MoreTableViewCellModel {
    let name: String
    let icon: UIImage
    let type: MoreTableViewCellTypes
}

class MoreTableViewCell: UITableViewCell {
    
    static let identifier: String = "MoreTableViewCellIdentifier"

    public var model: MoreTableViewCellModel? {
        didSet {
            guard let model = self.model else {return}
            cellIcon.image = model.icon.withRenderingMode(.alwaysTemplate).imageWithInsets(insets: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
            cellLabel.text = model.name
        }
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
