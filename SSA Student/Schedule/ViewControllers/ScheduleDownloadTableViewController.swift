//
//  ScheduleDownloadTableViewController.swift
//  SSA Student
//
//  Created by Nick on 9/2/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

protocol ScheduleDownloadTableViewControllerDelegate {
    func didDownload()
}

class ScheduleDownloadTableViewController: UITableViewController, ScheduleDownloadTableViewCellDelegate {
    
    var model: [String]? {
        didSet {
            guard model != nil else {return}
            self.tableView.reloadData()
        }
    }
    
    public var delegate: ScheduleDownloadTableViewControllerDelegate?
    
    fileprivate var scheduleClasses: [(ScheduleBlock, ScheduleClass)] = []
    
    @objc func didPressSave() {
        ScheduleDownloadModelController.saveClasses(self.scheduleClasses)
        if delegate != nil {
            delegate!.didDownload()
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(ScheduleDownloadTableViewCell.self, forCellReuseIdentifier: ScheduleDownloadTableViewCell.identifier)
        
        self.title = "Download Schedule"
        
        ScheduleDownloadModelController.downloadSchedule { (strings) in
            self.model = strings
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didPressSave))
        
    }
    
    func didGetClass(_ scheduleClass: ScheduleClass, block: ScheduleBlock) {
        self.scheduleClasses.append((block, scheduleClass))
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleDownloadTableViewCell.identifier) as! ScheduleDownloadTableViewCell
        cell.delegate = self
        guard let model = self.model else {return cell}
        cell.model = model[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

}
