//
//  ScheduleLargeTitleTableViewCell.swift
//  SSA Student
//
//  Created by Nick on 8/28/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class ScheduleLargeTitleTableViewCell: UITableViewCell {

    let toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    let label: UILabel = {
        let label = UILabel()
        label.text = "Schedule Uses Large Title"
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(self.label)
        stackView.addArrangedSubview(self.toggleSwitch)
        stackView.layoutIfNeeded()
        
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 24.0),
            self.stackView.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 8.0),
            self.stackView.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8.0),
            self.stackView.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8.0),
        ])
        
        if let isSet = Defaults.get(key: .scheduleLargeTitleToggleSwitch) as? Bool {
            self.toggleSwitch.setOn(isSet, animated: false)
        } else {
            Defaults.set(value: true, key: .scheduleLargeTitleToggleSwitch)
            self.toggleSwitch.setOn(true, animated: false)
        }
        
        self.toggleSwitch.addTarget(self, action: #selector(didToggleSwitch), for: .valueChanged)
    }
    
    @objc func didToggleSwitch() {
        Defaults.set(value: self.toggleSwitch.isOn, key: .scheduleLargeTitleToggleSwitch)
    }

}
