//
//  GroupsDetailsCalendarTableViewCell.swift
//  SSA Student
//
//  Created by Nick on 8/23/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class GroupsDetailsCalendarTableViewCell: UITableViewCell {
    
    static let identifier = "GroupsDetailsCalendarTableViewCell"
    
    public var model: GroupsDetailCalenderViewController.GroupsCalendarEvent? {
        didSet {
            guard let model = model else {return}
            
            let df = DateFormatter()
            df.dateStyle = .short
            
            self.subjectLabel.text = model.subject
            let elements = df.string(from: model.date).split(separator: "/")
            self.dateLabel.text = "\(elements[0])/\(elements[1])"
        }
    }
    
    fileprivate var subjectLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    fileprivate var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    fileprivate var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.subjectLabel)
        self.stackView.addArrangedSubview(self.dateLabel)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8.0),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8.0),
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8.0)
        ])
    }
    
}
