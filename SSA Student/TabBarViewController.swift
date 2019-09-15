//
//  TabBarViewController.swift
//  SSA Student
//
//  Created by Nick on 8/3/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    fileprivate var pageViewController: SchedulePageViewController?
    
    func updatePageViewController() {
        guard self.pageViewController != nil else {return}
        self.pageViewController!.checkUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageViewController = SchedulePageViewController()
        
        // Do any additional setup after loading the view.
        let viewControllers = [
            pageViewController!,
            GroupsTableViewController(),
            BarcodeViewController(),
            MoreTableViewController.getInstance()
        ] 
        
        self.viewControllers = viewControllers.map({ (controller) -> UIViewController in
            let controller = UINavigationController(rootViewController: controller)
            controller.extendedLayoutIncludesOpaqueBars = true
            controller.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21, weight: .medium)
            ]
            return controller
        })
        
        self.view.backgroundColor = .white
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)], for: .selected)
        
        self.tabBar.isTranslucent = false
        
        SchoolDaysDownloader.checkSchedule {
            self.updatePageViewController()
        }

    }
}
