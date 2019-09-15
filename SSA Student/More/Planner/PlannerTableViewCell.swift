//
//  PlannerTableViewCell.swift
//  SSA Student
//
//  Created by Nick on 8/23/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class PlannerTableViewCell: UITableViewCell {
    
    static let identifier = "PlannerTableViewCell"
    
    public var model: PlannerViewController.PlannerItem? {
        didSet {
            guard let model = self.model else {return}
            self.contentLabel.text = model.name
            self.contentView.backgroundColor = UIColor.randomSeededColor(seed: model.classId)
        }
    }
    
    fileprivate var contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.addSubview(contentLabel)
        NSLayoutConstraint.activate([
            self.contentLabel.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8.0),
            self.contentLabel.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8.0),
            self.contentLabel.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 8.0),
            self.contentLabel.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8.0),
        ])
    }
    
}
