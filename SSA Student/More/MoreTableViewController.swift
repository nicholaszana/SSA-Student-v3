//
//  MoreViewController.swift
//  SSA Student
//
//  Created by Nick on 8/3/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit
import SafariServices

class MoreTableViewController: UITableViewController, SFSafariViewControllerDelegate {
    
    /*
     2D Array representing more tab layout
     Each Array represents a section
     Each element represents a cell
    */
    static let models: [[MoreTableViewCellModel]] = [
        [
            //MoreTableViewCellModel(name: "Friends", icon: ImageAssets.group, type: .friends),
            //MoreTableViewCellModel(name: "Planner", icon: ImageAssets.planner, type: .planner)
        ],
        [
            MoreTableViewCellModel(name: "News", icon: ImageAssets.news, type: .news),
            MoreTableViewCellModel(name: "Calendar", icon: ImageAssets.calendar, type: .calendar),
            MoreTableViewCellModel(name: "Lunch Menus", icon: ImageAssets.lunch, type: .lunch),
            MoreTableViewCellModel(name: "Teacher Pages", icon: ImageAssets.teacherPages, type: .teacherPages)
        ],
        [
            MoreTableViewCellModel(name: "Settings", icon: ImageAssets.settings, type: .settings),
            MoreTableViewCellModel(name: "About", icon: ImageAssets.about, type: .about)
        ]
    ]
    
    static func getInstance() -> UITableViewController {
        let controller = MoreTableViewController(style: .grouped)
        controller.title = "More"
        controller.tabBarItem = UITabBarItem(title: "More", image: ImageAssets.more, tag: 0)
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        
        tableView.register(MoreTableViewCell.self, forCellReuseIdentifier: MoreTableViewCell.identifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return MoreTableViewController.models.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoreTableViewController.models[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoreTableViewCell.identifier) as! MoreTableViewCell
        cell.model = MoreTableViewController.models[indexPath.section][indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Websites"
        case 2:
            return "Settings"
        default:
            return nil
        }
    }
    
    func presentSafari(url: String) {
        if let url = URL(string: url) {
            let controller = SFSafariViewController(url: url)
            if #available(iOS 10.0, *) {
                controller.preferredBarTintColor = Theme.currentTheme.primaryColor
                controller.preferredControlTintColor = Theme.currentTheme.textOnPrimary
            } else {
                controller.view.tintColor = Theme.currentTheme.primaryColor
            }
            controller.delegate = self
            controller.modalPresentationCapturesStatusBarAppearance = true
            present(controller, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let type = MoreTableViewController.models[indexPath.section][indexPath.row].type
        let viewController: UIViewController!
        switch type {
            
        case .friends:
            viewController = FriendsViewController()
        case .about:
            viewController = AboutViewController()
        case .settings:
            viewController = SettingsTableViewController(style: .grouped)
        case .planner:
            viewController = PlannerViewController()
            
        //Presented in SFSafariViewController
        case .news:
            presentSafari(url: "https://www.shadysideacademy.org/about/news")
            return
        case .calendar:
            presentSafari(url: "https://www.shadysideacademy.org/about/calendar")
            return
        case .lunch:
            presentSafari(url: "https://www.shadysideacademy.org/lunch-menus")
            return
        case .teacherPages:
            presentSafari(url: "https://www.shadysideacademy.org/students/ms-ss-student-portal")
            return
        }
        if let viewController = viewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
