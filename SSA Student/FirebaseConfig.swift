//
//  FirebaseConfig.swift
//  SSA Student
//
//  Created by Nick on 9/8/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import Foundation
import Firebase

var ref: DatabaseReference! = Database.database().reference()

let db = Firestore.firestore()

enum FirestoreCollection: String {
    case classes = "Classes"
    case students = "Students"
}

enum FirestoreField: String {
    case classes = "classes"
}
