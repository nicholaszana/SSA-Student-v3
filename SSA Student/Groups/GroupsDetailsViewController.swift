//
//  GroupsDetailsViewController.swift
//  SSA Student
//
//  Created by Nick on 8/22/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

enum GroupView {
    case calendar
    case bulletins
}

class GroupsDetailsViewController: UIViewController {
    
    public var model: GroupCellModel? {
        didSet {
            guard let model = model else {return}
            self.title = model.name
            self.calendarViewController.model = model
            self.bulletinsViewController.model = model
        }
    }
    
    fileprivate var calendarViewController: GroupsDetailCalenderViewController = {
        let controller = GroupsDetailCalenderViewController()
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        return controller
    }()
    
    fileprivate var bulletinsViewController: GroupsDetailsBulletinsViewController = {
        let controller = GroupsDetailsBulletinsViewController()
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        return controller
    }()
    
    fileprivate var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Calendar", "Bulletins"])
        control.translatesAutoresizingMaskIntoConstraints = false
        control.addTarget(self, action: #selector(didChangeSegmentedControl), for: .valueChanged)
        return control
    }()
    
    @objc func didPressCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didChangeSegmentedControl() {
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            self.setViewTo(.calendar)
            return
        case 1:
            self.setViewTo(.bulletins)
            return
        default:
            self.setViewTo(.calendar)
            return
        }
    }
    
    fileprivate func setViewTo(_ view: GroupView) {
        
        switch view {
        case .calendar:
            self.calendarViewController.view.isHidden = false
            self.bulletinsViewController.view.isHidden = true
            return
        case .bulletins:
            self.calendarViewController.view.isHidden = true
            self.bulletinsViewController.view.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didPressCancel))
        
        self.segmentedControl.selectedSegmentIndex = 0
        self.layoutSubviews()
        
        self.setViewTo(.calendar)
    }
    
    fileprivate func layoutSubviews() {
        self.view.addSubview(self.segmentedControl)
        
        NSLayoutConstraint.activate([
            self.segmentedControl.topAnchor.constraint(equalToSystemSpacingBelow: self.view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0),
            self.segmentedControl.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.segmentedControl.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            self.segmentedControl.heightAnchor.constraint(equalToConstant: 48.0)
        ])
        
        self.view.addSubview(self.calendarViewController.view)
        NSLayoutConstraint.activate([
            self.calendarViewController.view.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 8.0),
            self.calendarViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.calendarViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.calendarViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        self.view.addSubview(self.bulletinsViewController.tableView)
        NSLayoutConstraint.activate([
            self.bulletinsViewController.view.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 8.0),
            self.bulletinsViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.bulletinsViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.bulletinsViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}
