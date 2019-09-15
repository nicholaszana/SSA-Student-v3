//
//  GroupsTableViewCell.swift
//  SSA Student
//
//  Created by Nick on 8/19/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {

    static let identifier = "GroupsTableViewCell"
    
    var model: GroupCellModel? {
        didSet {
            guard let model = self.model else { return }
            self.cellIcon.image = ImageAssets.getImageForClassId(model.classId).imageWithInsets(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
            self.cellIcon.backgroundColor = UIColor.randomSeededColor(seed: model.classId)
            self.cellLabel.text = model.name
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
        let fontSize = label.font.pointSize
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(cellIcon)
        contentView.addSubview(cellLabel)
        
        //Activates Cell Icon Constraints
        NSLayoutConstraint.activate([
            cellIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6), 
            cellIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            cellIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
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

    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellIcon.image = nil
        self.cellIcon.backgroundColor = nil
        self.cellLabel.text = nil
    }
}
