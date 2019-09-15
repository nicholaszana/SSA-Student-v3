//
//  GroupsDetailsBulletinsViewController.swift
//  SSA Student
//
//  Created by Nick on 8/22/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class GroupsDetailsBulletinsViewController: UITableViewController {

    struct GroupsDetailsBulletinModel {
        let title: String
        let content: String
        let timestamp: Date
    }
    
    public var model: GroupCellModel? {
        didSet {
            guard let model = model else {return}
            let df = DateFormatter()
            df.dateFormat = "MM/dd/yyyy"
            self.bulletins = [
                GroupsDetailsBulletinModel(title: "Bulletin #1", content: "Some bulletin content", timestamp: df.date(from: "8/14/19") ?? Date()),
                GroupsDetailsBulletinModel(title: "Bulletin #2", content: "Some bulletin content2", timestamp: df.date(from: "8/19/19") ?? Date())
                ].sorted(by: { (model1, model2) -> Bool in
                    model1.timestamp < model2.timestamp
                })
        }
    }
    
    fileprivate var bulletins: [GroupsDetailsBulletinModel]? {
        didSet {
            guard self.bulletins != nil else {return}
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(GroupDetailsBulletinsTableViewCell.self, forCellReuseIdentifier: GroupDetailsBulletinsTableViewCell.identifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bulletins?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let bulletins = self.bulletins, bulletins.count > indexPath.row else {return UITableViewCell()}
        let cell = self.tableView.dequeueReusableCell(withIdentifier: GroupDetailsBulletinsTableViewCell.identifier) as! GroupDetailsBulletinsTableViewCell
        cell.model = bulletins[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = (self.tableView.cellForRow(at: indexPath) as? GroupDetailsBulletinsTableViewCell)?.model else {return}
        let alertController = UIAlertController(title: model.title, message: model.content, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Done", style: .default) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(doneAction)
        present(alertController, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
