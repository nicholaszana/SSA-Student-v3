//
//  FriendsViewController.swift
//  SSA Student
//
//  Created by Nick on 8/12/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class FriendsViewController: UITableViewController {

    struct FriendCell {
        let name: String
        let profilePic: UIImage
        let userId: String
    }
    
    fileprivate var friends: [FriendCell]? {
        didSet {
            guard friends != nil else {return}
            self.tableView.reloadData()
        }
    }
    
    convenience init() {
        
        self.init(nibName:nil, bundle:nil)
        
        self.title = "Friends"
        
        self.tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.identifier)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.allowsSelection = false
        
        self.friends = [
            FriendCell(name: "Nick Zana", profilePic: ImageAssets.calendar, userId: "21zanan")
        ]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let friends = self.friends else {return UITableViewCell()}
        let cell = self.tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.identifier) as! FriendsTableViewCell
        cell.model = friends[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
