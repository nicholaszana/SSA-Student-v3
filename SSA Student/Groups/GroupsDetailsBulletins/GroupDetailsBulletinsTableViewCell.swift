//
//  GroupDetailsBulletinsTableViewCell.swift
//  SSA Student
//
//  Created by Nick on 8/23/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class GroupDetailsBulletinsTableViewCell: UITableViewCell {

    static let identifier = "GroupDetailsBulletinsTableViewCell"
    
    public var model: GroupsDetailsBulletinsViewController.GroupsDetailsBulletinModel? {
        didSet {
            guard let model = model else {return}
            let df = DateFormatter()
            df.dateStyle = .short
            
            let elements = df.string(from: model.timestamp).split(separator: "/")
            self.dateLabel.text = "\(elements[0])/\(elements[1])"
            
            self.titleLabel.text = model.title
        }
    }
    
    fileprivate var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    fileprivate var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    fileprivate var stackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(titleLabel)
        self.stackView.addArrangedSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8.0),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8.0),
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8.0)
        ])
    }
}
