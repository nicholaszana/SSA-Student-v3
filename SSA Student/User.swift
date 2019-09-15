//
//  User.swift
//  SSA Student
//
//  Created by Nick on 8/30/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import Foundation

struct User {
    let userId: String
    let type: UserType
}

var globalUser: User = User(userId: "NULL", type: .student)
