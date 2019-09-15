//
//  ScheduleDownloadTableViewCell.swift
//  SSA Student
//
//  Created by Nick on 9/8/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

protocol ScheduleDownloadTableViewCellDelegate {
    func didGetClass(_ scheduleClass: ScheduleClass, block: ScheduleBlock)
}

class ScheduleDownloadTableViewCell: UITableViewCell {

    static let identifier = "ScheduleDownloadTableViewCell"
    
    fileprivate var whenLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    fileprivate var classIdLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    fileprivate var roomIdLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    fileprivate var teacherLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    fileprivate var leftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    fileprivate var rightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    public var delegate: ScheduleDownloadTableViewCellDelegate!
    
    public var model: String? {
        didSet {
            guard let model = model else {return}
            
            db.collection(FirestoreCollection.classes.rawValue).document(model).getDocument { (snapshot, err) in
                if let err = err {
                    print(err)
                    return
                }
                
                guard let data = snapshot?.data() else {return}
                guard
                    let block = data["block"] as? String,
                    let classId = data["classId"] as? String,
                    let roomId = data["roomId"] as? String,
                    let teacher = data["teacher"] as? String,
                    let lunch = data["lunch"] as? String,
                    let name = data["courseName"] as? String,
                    let terms = data["terms"] as? [String: Bool]
                else {return}
                
                
                let scheduleBlock = ScheduleBlock.classify(block)
                self.whenLabel.text = scheduleBlock.getDescriptorString()
                self.roomIdLabel.text = roomId
                self.teacherLabel.text = teacher
                self.classIdLabel.text = classId
                
                let scheduleLunch = ScheduleLunch.classify(lunch) ?? .AB
                print(name + "has lunch", scheduleLunch)
                let classType = ClassType.classify(classId)
                
                if terms["1"] ?? false {
                    self.delegate.didGetClass(ScheduleClass(classId: classId, lunch: scheduleLunch, name: name, type: classType), block: ScheduleBlock.classify(block))
                }
            }
            
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.leftStackView.addArrangedSubview(classIdLabel)
        self.leftStackView.addArrangedSubview(whenLabel)
        
        self.rightStackView.addArrangedSubview(teacherLabel)
        self.rightStackView.addArrangedSubview(roomIdLabel)
        
        self.contentView.addSubview(self.leftStackView)
        self.contentView.addSubview(self.rightStackView)
        
        NSLayoutConstraint.activate([
            self.leftStackView.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.leftStackView.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.centerXAnchor, constant: -8),
            self.leftStackView.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            self.leftStackView.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            self.rightStackView.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.centerXAnchor, constant: 8),
            self.rightStackView.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            self.rightStackView.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            self.rightStackView.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
        
        self.leftStackView.layoutIfNeeded()
        self.rightStackView.layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.whenLabel.text = nil
        self.roomIdLabel.text = nil
        self.teacherLabel.text = nil
        self.classIdLabel.text = nil
    }
    
}
