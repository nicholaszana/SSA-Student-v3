//
//  SchedulePeriodTableViewCell.swift
//  SSA Student
//
//  Created by Nick on 8/18/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class SchedulePeriodTableViewCell: UITableViewCell {

    static let identifier: String = "SchedulePeriodTableViewCell"
        
    public var model: SchedulePeriodViewModel? {
        didSet {
            guard let model = model else {return}
            self.periodNameLabel.text = model.periodName
            self.periodTimeLabel.text = model.periodTime
            self.classNameLabel.text = model.className
            self.moreInfoLabel.text = model.moreInfo ?? ""
            
            if model.classType == .free || model.classType == .lunch || model.classType == .other {
                self.ribbonView.tintColor = .clear
            } else {
                self.ribbonView.tintColor = .randomSeededColor(seed: model.classId)
            }
        }
    }
    
    fileprivate var backgroundRectangle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.layer.cornerRadius = 8.0
        view.clipsToBounds = true
        view.backgroundColor = .lightGray
        return view
    }()
    
    fileprivate var whiteCoverView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.layer.cornerRadius = 8.0
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    fileprivate var periodNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.isUserInteractionEnabled = false
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    fileprivate var periodTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.isUserInteractionEnabled = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
        return label
    }()
    
    fileprivate var classNameLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .natural
        return label
    }()
    
    fileprivate var moreInfoLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
        label.textAlignment = .natural
        return label
    }()
    
    fileprivate var periodInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isUserInteractionEnabled = false
        return stackView
    }()
    
    fileprivate var classInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isUserInteractionEnabled = false
        return stackView
    }()
    
    fileprivate var ribbonView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = ImageAssets.ribbon.imageWithInsets(insets: UIEdgeInsets.zero)?.withRenderingMode(.alwaysTemplate)
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.addSubview(self.backgroundRectangle)
        NSLayoutConstraint.activate([
            self.backgroundRectangle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8.0),
            self.backgroundRectangle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8.0),
            self.backgroundRectangle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4.0),
            self.backgroundRectangle.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -4.0),
        ])
        
        self.contentView.addSubview(whiteCoverView)
        NSLayoutConstraint.activate([
            self.whiteCoverView.leadingAnchor.constraint(equalTo: self.backgroundRectangle.leadingAnchor, constant: 2.0),
            self.whiteCoverView.topAnchor.constraint(equalTo: self.backgroundRectangle.topAnchor, constant: 2.0),
            self.whiteCoverView.bottomAnchor.constraint(equalTo: self.backgroundRectangle.bottomAnchor, constant: -2.0),
            self.whiteCoverView.trailingAnchor.constraint(equalTo: self.backgroundRectangle.trailingAnchor, constant: -2.0),
        ])
        
        self.contentView.addSubview(self.periodInfoStackView)
        self.periodInfoStackView.addArrangedSubview(periodNameLabel)
        self.periodInfoStackView.addArrangedSubview(periodTimeLabel)
        
        NSLayoutConstraint.activate([
            self.periodInfoStackView.leadingAnchor.constraint(equalTo: self.whiteCoverView.leadingAnchor, constant: 4.0),
            self.periodInfoStackView.topAnchor.constraint(equalTo: self.whiteCoverView.topAnchor, constant: 4.0),
            self.periodInfoStackView.bottomAnchor.constraint(equalTo: self.whiteCoverView.bottomAnchor, constant: -4.0),
            self.periodInfoStackView.widthAnchor.constraint(equalTo: self.whiteCoverView.widthAnchor, multiplier: self.contentView.frame.width < 700 ? 0.33 : 0.25),
        ])
        
        self.periodInfoStackView.layoutIfNeeded()
        
        self.contentView.addSubview(self.ribbonView)
        NSLayoutConstraint.activate([
            self.ribbonView.trailingAnchor.constraint(equalTo: self.whiteCoverView.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            self.ribbonView.topAnchor.constraint(equalTo: self.whiteCoverView.safeAreaLayoutGuide.topAnchor),
            self.ribbonView.widthAnchor.constraint(equalToConstant: 16),
            self.ribbonView.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        self.contentView.addSubview(self.classInfoStackView)
        self.classInfoStackView.addArrangedSubview(self.classNameLabel)
        self.classInfoStackView.addArrangedSubview(self.moreInfoLabel)
        
        NSLayoutConstraint.activate([
            classInfoStackView.leadingAnchor.constraint(equalTo: self.periodInfoStackView.trailingAnchor, constant: 8.0),
            classInfoStackView.topAnchor.constraint(equalTo: self.whiteCoverView.topAnchor, constant: 4.0),
            classInfoStackView.trailingAnchor.constraint(equalTo: self.ribbonView.leadingAnchor, constant: -4.0),
            classInfoStackView.bottomAnchor.constraint(equalTo: self.whiteCoverView.bottomAnchor, constant: -4.0),
        ])
        
        self.classInfoStackView.layoutIfNeeded()
    }

}
