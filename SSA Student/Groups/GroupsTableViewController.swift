//
//  GroupViewController.swift
//  SSA Student
//
//  Created by Nick on 8/3/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    public var model: [[GroupCellModel]]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    fileprivate var addGroupButton: UIBarButtonItem!
    
    convenience init() {
        
        self.init(nibName:nil, bundle:nil)
        
        self.title = "Groups"
        
        self.tabBarItem = UITabBarItem(title: "Groups", image: ImageAssets.group, tag: 0)
        
    }

    
    @objc func didPressEditButton() {
        present(UINavigationController(rootViewController: GroupsEditViewController()), animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addGroupButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didPressEditButton))
        
        //self.navigationItem.rightBarButtonItem = addGroupButton
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(GroupsTableViewCell.self, forCellReuseIdentifier: GroupsTableViewCell.identifier)
        
        var classModels = [GroupCellModel]()
        guard let classes = ScheduleModelController.getClasses() else {return}
        for group in classes.classes {
            let model = GroupCellModel(name: group.value.name, classId: group.value.classId)
            if group.value.type != .free {
                classModels.append(model)
            }
        }
        
        classModels.sort { (model1, model2) -> Bool in
            model1.name < model2.name
        }
        
        self.model = [classModels]
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        //return model?.count ?? 0
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?[section].count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            //return "Classes"
            return nil
        case 1:
            return "Clubs"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = self.model else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.identifier) as! GroupsTableViewCell
        cell.model = model[indexPath.section][indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let model = self.model?[indexPath.section][indexPath.row] else {return}
        let detailsViewController = GroupsDetailsViewController()
        detailsViewController.model = model
        
        present(UINavigationController(rootViewController: detailsViewController), animated: true, completion: nil)
    }
}
