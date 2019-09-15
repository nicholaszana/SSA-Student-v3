//
//  GroupsDetailsCalendarView.swift
//  SSA Student
//
//  Created by Nick on 8/22/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit
import Koyomi

class GroupsDetailCalenderViewController: UIViewController, KoyomiDelegate {
    
    struct GroupsCalendarEvent {
        let date: Date
        let subject: String
        let content: String
    }
    
    public var model: GroupCellModel? {
        didSet {
            guard let model = model else {return}
            let seededColor = UIColor.randomSeededColor(seed: model.classId)
            self.koyomi.selectedStyleColor = seededColor
            self.previousButton.setTitleColor(seededColor, for: .normal)
            self.nextButton.setTitleColor(seededColor, for: .normal)
        }
    }
    
    fileprivate var events: [GroupsCalendarEvent]? {
        didSet {
            guard self.events != nil else {return}
            var events = self.events!
            events.sort { (event1, event2) -> Bool in
                return event1.date < event2.date
            }
            for event in events {
                //TODO: UPDATE FOR THEMES
                self.koyomi.setDayColor(.red, of: event.date)
            }
            
            self.tableView.reloadData()
        }
    }
    
    fileprivate var previousButton: UIButton! = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didPressLastButton), for: .touchUpInside)
        button.setImage(ImageAssets.previous, for: .normal)
        return button
    }()
    
    fileprivate var monthLabel: UILabel! = {
        let label = UILabel()
        let labelFontSize = label.font.pointSize
        label.font = UIFont.systemFont(ofSize: labelFontSize, weight: .heavy)
        return label
    }()
    
    fileprivate var nextButton: UIButton! = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didPressNextButton), for: .touchUpInside)
        button.setImage(ImageAssets.next, for: .normal)
        return button
    }()
    
    fileprivate var controlStack: UIStackView! = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate var koyomi: Koyomi!
    
    fileprivate var tableView: UITableView! = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = true
        return tableView
    }()
    
    fileprivate func setupKoyomi() {
        let frame = CGRect(x: 8, y: 48, width: self.view.frame.width - 16, height: self.view.frame.height / 3)
        let cal = Koyomi(frame: frame, sectionSpace: 3.0, cellSpace: 1, inset: .zero, weekCellHeight: 25)
        cal.translatesAutoresizingMaskIntoConstraints = false
        cal.calendarDelegate = self
        cal.isHiddenOtherMonth = true
        cal.selectionMode = .single(style: .circle)
        cal.inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                
        cal.style = KoyomiStyle.custom(customColor: (dayBackgrond: UIColor.white,
        weekBackgrond: UIColor.white,
        week: .black,
        weekday: .black,
        holiday: (saturday: UIColor.lightGray, sunday: UIColor.lightGray),
        otherMonth: UIColor.clear,
        separator: UIColor.lightGray))
        cal.style = .monotone
        cal.display(in: .current)
        self.koyomi = cal
    }
    
    @objc func didPressLastButton() {
        koyomi.display(in: .previous)
    }
    
    @objc func didPressNextButton() {
        koyomi.display(in: .next)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Replace this
        self.view.backgroundColor = .white
        self.tableView.register(GroupsDetailsCalendarTableViewCell.self, forCellReuseIdentifier: "GroupsDetailsCalendarTableViewCell")
        self.setupKoyomi()
        
        self.layoutSubviews()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let date = Date()
        self.koyomi.select(date: date)
        self.updateTableViewHighlighting(date)
    }
    
    fileprivate func updateTableViewHighlighting(_ date: Date?) {
        guard let date = date else {return}
        for int in 0...tableView.numberOfRows(inSection: 0) {
            guard let cell = tableView.cellForRow(at: IndexPath(row: int, section: 0)) as? GroupsDetailsCalendarTableViewCell else {return}
            
            if cell.model?.date != date {
                cell.backgroundColor = .clear
            } else {
                guard let model = self.model else {return}
                let seededColor = UIColor.randomSeededColor(seed: model.classId)
                cell.backgroundColor = seededColor
            }
        }
    }
    
    //MARK: Kyomi Delegate
    func koyomi(_ koyomi: Koyomi, didSelect date: Date?, forItemAt indexPath: IndexPath) {
        updateTableViewHighlighting(date)
    }
    
    func koyomi(_ koyomi: Koyomi, currentDateString dateString: String) {
        let firstTwo = dateString.split(separator: "/")[0]
        guard let int = Int(firstTwo) else {return}
        self.monthLabel.text = DateFormatter().monthSymbols[int - 1]
    }
    
 
    fileprivate func layoutSubviews() {
        self.view.addSubview(koyomi)
        self.view.addSubview(self.controlStack)
        controlStack.addArrangedSubview(self.previousButton)
        controlStack.addArrangedSubview(self.monthLabel)
        controlStack.addArrangedSubview(self.nextButton)
        
        NSLayoutConstraint.activate([
            self.controlStack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8.0),
            self.controlStack.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            self.controlStack.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            self.controlStack.heightAnchor.constraint(equalToConstant: 32.0)
        ])
        
        tableView.frame = CGRect(x: 0, y: self.koyomi.frame.maxY, width: self.view.frame.width, height: self.view.frame.height - self.koyomi.frame.height - 48)
        self.view.addSubview(self.tableView)
        
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        
        self.events = [
            GroupsCalendarEvent(date: df.date(from: "8/11/2019") ?? Date(), subject: "Some event #1", content: "Here is some content for the event"),
            GroupsCalendarEvent(date: df.date(from: "8/14/2019") ?? Date(), subject: "Some event #2", content: "Here is some content for the event"),
            GroupsCalendarEvent(date: df.date(from: "9/4/2019") ?? Date(), subject: "Some event #3", content: "Here is some content for the event"),
            GroupsCalendarEvent(date: df.date(from: "8/24/2019") ?? Date(), subject: "Some event #3", content: "Here is some content for the event"),
            GroupsCalendarEvent(date: df.date(from: "8/24/2019") ?? Date(), subject: "Some event #3", content: "Here is some content for the event"),
        ]
    }
}
extension GroupsDetailCalenderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let events = self.events else {return 0}
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsDetailsCalendarTableViewCell.identifier) as! GroupsDetailsCalendarTableViewCell
        guard let events = events else {return cell}
        cell.model = events[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = (self.tableView.cellForRow(at: indexPath) as? GroupsDetailsCalendarTableViewCell)?.model else {return}
        let alertController = UIAlertController(title: model.subject, message: model.content, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Done", style: .default) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(doneAction)
        present(alertController, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
