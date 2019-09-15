//
//  PlannerViewController.swift
//  SSA Student
//
//  Created by Nick on 8/12/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class PlannerViewController: UITableViewController {

    struct PlannerItem {
        let name: String
        let dueDate: Date
        let classId: String
    }
    
    public var plannerItems: [PlannerItem]? {
        didSet {
            guard let items = self.plannerItems else {return}
            
            self.sortedPlannerItems = []
            var dictionary = [Date: [PlannerItem]]()
            for item in items {
                let date = item.dueDate
                if dictionary[date] == nil {
                    dictionary[date] = [item]
                } else {
                    dictionary[date]!.append(item)
                }
            }
            
            for item in dictionary {
                self.sortedPlannerItems.append((item.key, item.value))
            }
            
            self.tableView.reloadData()
        }
    }
    
    fileprivate var sortedPlannerItems: [(Date, [PlannerItem])] = []
    
    convenience init() {
        
        self.init(nibName:nil, bundle:nil)
        
        self.title = "Planner"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(PlannerTableViewCell.self, forCellReuseIdentifier: PlannerTableViewCell.identifier)
        
        self.plannerItems = [
            PlannerItem(name: "something something something", dueDate: Date(), classId: "nil"),
            PlannerItem(name: "something else something else", dueDate: Date().addingTimeInterval(18400), classId: "nil")
        ]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sortedPlannerItems.count
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortedPlannerItems[section].1.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: PlannerTableViewCell.identifier) as! PlannerTableViewCell
        cell.model = self.sortedPlannerItems[indexPath.section].1[indexPath.row]
        return cell
    }

}
