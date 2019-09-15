//
//  ViewController.swift
//  SSA Student
//
//  Created by Nick on 8/3/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit


class ScheduleTableViewController: UITableViewController {
    
    public var model: ScheduleViewModel? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let bool = Defaults.get(key: .scheduleLargeTitleToggleSwitch) as? Bool
        
        if bool == nil {
            return
        }
        
        self.navigationController?.navigationBar.prefersLargeTitles = bool!
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.separatorStyle = .none
        
        self.tableView.showsVerticalScrollIndicator = false
        
        self.edgesForExtendedLayout = UIRectEdge()
                
        self.tableView.register(SchedulePeriodTableViewCell.self, forCellReuseIdentifier: SchedulePeriodTableViewCell.identifier)
    }
    
    //UITableView Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        guard let model = model else {return 0}
        return model.periodModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = model else {return UITableViewCell()}
        if indexPath.section == 0 {
            let cell = UITableViewCell()
            let df = DateFormatter()

            if self.view.frame.width <= 320 {
                df.dateStyle = .short
                cell.textLabel?.text = "Day \(model.schoolDay.cycleDay.toString()) - \(df.weekdaySymbols[Calendar.current.component(.weekday, from: model.schoolDay.date)]), \(df.string(from: model.schoolDay.date))"
            } else {
                df.dateStyle = .full
                cell.textLabel?.text = "Day \(model.schoolDay.cycleDay.toString()) - \(df.string(from: model.schoolDay.date))"
            }
            
            
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .light)
            cell.textLabel?.textAlignment = .left
            return cell
        }
        let cell = self.tableView.dequeueReusableCell(withIdentifier: SchedulePeriodTableViewCell.identifier) as! SchedulePeriodTableViewCell
        cell.model = model.periodModels[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 44
        }
        
        if let bool = Defaults.get(key: .scheduleLargeTitleToggleSwitch) as? Bool, bool {
            return 75
        }
        
        guard let model = model else {return 65}
        let splitHeight = (self.view.frame.height  - 44)/CGFloat(model.periodModels.count)
        if splitHeight < 65 {
            self.tableView.isScrollEnabled = true
            return 65
        } else if splitHeight > 90 {
            return 90
        } else {
            self.tableView.isScrollEnabled = false
            return splitHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.tableView.deselectRow(at: indexPath, animated: false)
            return
        }
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? SchedulePeriodTableViewCell else {return}
        guard let model = cell.model else {return}
        
        let classification = ClassType.classify(model.classId)
        
        if classification == .free || classification == .other {
            
        } else {
            let detailsViewController = GroupsDetailsViewController()
            detailsViewController.model = GroupCellModel(name: model.className, classId: model.classId)
            present(UINavigationController(rootViewController: detailsViewController), animated: true, completion: nil)
        }
    }
}


