//
//  SchedulePageViewController.swift
//  SSA Student
//
//  Created by Nick on 8/19/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit
import CoreData

class SchedulePageViewController: UIViewController, UIPageViewControllerDelegate, GoToDelegate, ScheduleDownloadTableViewControllerDelegate {

    /*
        Known Bug, probably related to Xcode 11 and macOS Catalina Betas, produces warning:
        SSA Student[24388:3936445] [WindowServer] display_timer_callback: unexpected state (now:************** < expected:**************)
     
        See the following thread for more info, but basically just ignore it
     
        https://forums.developer.apple.com/thread/119454
    */
    
    public var schoolDays: [SchoolDay]? = ScheduleModelController.getSchoolDays()
    
    public var cycleDays: [CycleDays: CycleDay]? = ScheduleModelController.getCycle()
    
    public var classes: ScheduleModel? = ScheduleModelController.getClasses()
    
    var pageViewController: UIPageViewController!
    
    fileprivate var todayButton: UIBarButtonItem!
    
    fileprivate var editButton: UIBarButtonItem!
    
    fileprivate var showCalendarButton: UIBarButtonItem!
    
    fileprivate func getIndexFor(_ inputDate: Date) -> Int? {
        
        guard let calendar = NSCalendar(calendarIdentifier: .gregorian) else {return nil}
        let components = calendar.components([.year, .month, .day], from: inputDate)
        guard let date = calendar.date(from: components) else {return nil}
        
        guard let days = schoolDays else {return nil}
        guard days.count > 0 else {return nil}
        if date > days[days.count - 1].date {
            return days.count - 1
        }
        
        let index = days.firstIndex(where: { (day) -> Bool in
            day.date >= date
        })
        
        return index
    }
    
    func didDownload() {
        self.update()
    }
    
    public func checkUpdate() {
        let ac = UIAlertController(title: "New Schedule Downloaded", message: "A new schedule has been downloaded, would you like to switch to it now?", preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "Yes", style: .default) { (action) in
            self.update()
        }
        
        let no = UIAlertAction(title: "No", style: .default, handler: nil)
        
        ac.addAction(yes)
        ac.addAction(no)
        
        self.present(ac, animated: true, completion: nil)
    }
    
    fileprivate func update() {
        self.schoolDays = ScheduleModelController.getSchoolDays()
        self.cycleDays = ScheduleModelController.getCycle()
        self.classes = ScheduleModelController.getClasses()
        
        var startingViewController: ScheduleTableViewController?
        if let index = getIndexFor(Date()) {
            startingViewController = self.viewControllerAtIndex(index: index)
        } else {
            startingViewController = ScheduleTableViewController()
        }
        if startingViewController != nil {
            let viewControllers = [startingViewController!]
            self.pageViewController.setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
        }
    }
    
    fileprivate func goTo(_ index: Int) {
        
        guard let currentIndex = getCurrentIndex() else {return}
        
        if currentIndex == index {
            return
        }
        
        var direction: UIPageViewController.NavigationDirection!
        
        if currentIndex < index {
            direction = .forward
        } else {
            direction = .reverse
        }
        
        guard let targetViewController = viewControllerAtIndex(index: index) else {return}
        
        self.pageViewController.setViewControllers([targetViewController], direction: direction, animated: true, completion: nil)
    }
    
    func didSelectCalendarDate(_ date: Date) {
        guard let targetIndex = self.getIndexFor(date) else {return}
        self.goTo(targetIndex)
    }
    
    
    @objc func todayButtonPressed() {
            
        guard let targetIndex = getIndexFor(Date()) else {return}
        goTo(targetIndex)

    }
    
    @objc func editButtonPressed() {
        
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        guard self.navigationItem.rightBarButtonItem != nil else {return}
        controller.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        
        let downloadAction = UIAlertAction(title: "Download", style: .default) { (action) in
            let dtv = ScheduleDownloadTableViewController()
            dtv.delegate = self
            self.present(UINavigationController(rootViewController: dtv), animated: true, completion: nil)
        }
        
        let inputAction = UIAlertAction(title: "Find Classes", style: .default) { (action) in
            print("Initiate Find Classes")
        }
        
        let manualEntryAction = UIAlertAction(title: "Manual Entry", style: .default) { (action) in
            print("Initate Manual Entry")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        controller.addAction(downloadAction)
//        controller.addAction(inputAction)
//        controller.addAction(manualEntryAction)
        controller.addAction(cancelAction)
        
        
        
        present(controller, animated: true, completion: nil)
        
    }
    
    @objc func showCalendarButtonPressed() {
        let controller = ScheduleGoToViewController()
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    convenience init() {
        
        self.init(nibName:nil, bundle:nil)
        
        self.title = "Schedule"
        
        self.tabBarItem = UITabBarItem(title: "Schedule", image: ImageAssets.calendar, tag: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.todayButton = UIBarButtonItem(image: ImageAssets.getCalendarForDay(
               NSCalendar.current.component(Calendar.Component.day, from: Date())
           ), style: .plain, target: self, action: #selector(todayButtonPressed))
        
        self.editButton = UIBarButtonItem(image: ImageAssets.settings, style: .plain, target: self, action: #selector(editButtonPressed))
        
        self.showCalendarButton = UIBarButtonItem(image: ImageAssets.showCalendar, style: .plain, target: self, action: #selector(showCalendarButtonPressed))
        
        self.todayButton.tintColor = .gray
        self.editButton.tintColor = .gray
        self.showCalendarButton.tintColor = .gray
        
        
        self.navigationItem.leftBarButtonItems = [todayButton, showCalendarButton]
        self.navigationItem.rightBarButtonItem = editButton

        if Defaults.get(key: .hasDownloadedSchedule) == nil {
            let dtv = ScheduleDownloadTableViewController()
            dtv.delegate = self
            self.present(UINavigationController(rootViewController: dtv), animated: true, completion: nil)
            Defaults.set(value: true, key: .hasDownloadedSchedule)
        }
        
        // Do any additional setup after loading the view.
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewController.OptionsKey.interPageSpacing: 20])
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        self.pageViewController.didMove(toParent: self)
        
        self.addChild(pageViewController)
        self.view.addSubview(pageViewController.view)
        pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        self.update()
        
        //TODO: Replace this when themes are implemented
        self.view.backgroundColor = .white
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .white
    }

    fileprivate func getCurrentIndex() -> Int? {
        guard let currentViewControllers = self.pageViewController.viewControllers else {return nil}
        guard currentViewControllers.count > 0, let currentViewController = currentViewControllers[0] as? ScheduleTableViewController else {return nil}
        guard let currentIndex = currentViewController.model?.schoolDay.index else {return nil}
        return currentIndex
    }
}

extension SchedulePageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex: Int = getCurrentIndex() else {return nil}
        if (currentIndex == 0) || (currentIndex == NSNotFound) {
            return nil
        }
        
        return viewControllerAtIndex(index: currentIndex - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex: Int = getCurrentIndex() else {return nil}
        if currentIndex == NSNotFound {
            return nil
        }
        
        return viewControllerAtIndex(index: currentIndex + 1)
    }
    
    func viewControllerAtIndex(index: Int) -> ScheduleTableViewController? {
        
        guard let days = self.schoolDays else {return nil}
        
        guard index < days.count else {return nil}
        let scheduleViewController = ScheduleTableViewController()
        guard
            let classes = self.classes,
            
            let cycle = self.cycleDays
            else {return nil}
        
        let schoolDay = days[index]
                
        scheduleViewController.model = ScheduleModelController.getScheduleFrom(classes, schoolDay: schoolDay, cycleDays: cycle)
        return scheduleViewController
    }
    
    func indexOfViewController( _ viewController: ScheduleTableViewController) -> Int? {
        let index = viewController.model?.schoolDay.index ?? nil
        return index
    }
}
