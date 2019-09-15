//
//  Assets.swift
//  SSA Student
//
//  Created by Nick on 8/12/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

struct ImageAssets {
    static let about = UIImage(imageLiteralResourceName: "About")
    static let barcode = UIImage(imageLiteralResourceName: "Barcode")
    
    static let contacts = UIImage(imageLiteralResourceName: "Contacts")
    static let group = UIImage(imageLiteralResourceName: "Group")
    static let lunch = UIImage(imageLiteralResourceName: "Lunch")
    static let news = UIImage(imageLiteralResourceName: "News")
    static let settings = UIImage(imageLiteralResourceName: "Settings")
    static let teacherPages = UIImage(imageLiteralResourceName: "Teacher")
    static let planner = UIImage(imageLiteralResourceName: "Planner")
    static let bookmark = UIImage(imageLiteralResourceName: "Bookmark")
    static let ribbon = UIImage(imageLiteralResourceName: "Ribbon")
    static let more = UIImage(imageLiteralResourceName: "More")
    static let showCalendar = UIImage(imageLiteralResourceName: "Show Calendar")
    static let previous = UIImage(imageLiteralResourceName: "Previous")
    static let next = UIImage(imageLiteralResourceName: "Next")
    static let google = UIImage(imageLiteralResourceName: "Google")
    
    //Calendar Icons
    static let calendar = UIImage(imageLiteralResourceName: "Calendar")
    static let calendar1 = UIImage(imageLiteralResourceName: "Calendar 1")
    static let calendar2 = UIImage(imageLiteralResourceName: "Calendar 2")
    static let calendar3 = UIImage(imageLiteralResourceName: "Calendar 3")
    static let calendar4 = UIImage(imageLiteralResourceName: "Calendar 4")
    static let calendar5 = UIImage(imageLiteralResourceName: "Calendar 5")
    static let calendar6 = UIImage(imageLiteralResourceName: "Calendar 6")
    static let calendar7 = UIImage(imageLiteralResourceName: "Calendar 7")
    static let calendar8 = UIImage(imageLiteralResourceName: "Calendar 8")
    static let calendar9 = UIImage(imageLiteralResourceName: "Calendar 9")
    static let calendar10 = UIImage(imageLiteralResourceName: "Calendar 10")
    static let calendar11 = UIImage(imageLiteralResourceName: "Calendar 11")
    static let calendar12 = UIImage(imageLiteralResourceName: "Calendar 12")
    static let calendar13 = UIImage(imageLiteralResourceName: "Calendar 13")
    static let calendar14 = UIImage(imageLiteralResourceName: "Calendar 14")
    static let calendar15 = UIImage(imageLiteralResourceName: "Calendar 15")
    static let calendar16 = UIImage(imageLiteralResourceName: "Calendar 16")
    static let calendar17 = UIImage(imageLiteralResourceName: "Calendar 17")
    static let calendar18 = UIImage(imageLiteralResourceName: "Calendar 18")
    static let calendar19 = UIImage(imageLiteralResourceName: "Calendar 19")
    static let calendar20 = UIImage(imageLiteralResourceName: "Calendar 20")
    static let calendar21 = UIImage(imageLiteralResourceName: "Calendar 21")
    static let calendar22 = UIImage(imageLiteralResourceName: "Calendar 22")
    static let calendar23 = UIImage(imageLiteralResourceName: "Calendar 23")
    static let calendar24 = UIImage(imageLiteralResourceName: "Calendar 24")
    static let calendar25 = UIImage(imageLiteralResourceName: "Calendar 25")
    static let calendar26 = UIImage(imageLiteralResourceName: "Calendar 26")
    static let calendar27 = UIImage(imageLiteralResourceName: "Calendar 27")
    static let calendar28 = UIImage(imageLiteralResourceName: "Calendar 28")
    static let calendar29 = UIImage(imageLiteralResourceName: "Calendar 29")
    static let calendar30 = UIImage(imageLiteralResourceName: "Calendar 30")
    static let calendar31 = UIImage(imageLiteralResourceName: "Calendar 31")
    
    static func getCalendarForDay(_ calendarDay: Int) -> UIImage {
        switch calendarDay {
        case 1:
            return ImageAssets.calendar1
        case 2:
            return ImageAssets.calendar2
        case 3:
            return ImageAssets.calendar3
        case 4:
            return ImageAssets.calendar4
        case 5:
            return ImageAssets.calendar5
        case 6:
            return ImageAssets.calendar6
        case 7:
            return ImageAssets.calendar7
        case 8:
            return ImageAssets.calendar8
        case 9:
            return ImageAssets.calendar9
        case 10:
            return ImageAssets.calendar10
        case 11:
            return ImageAssets.calendar11
        case 12:
            return ImageAssets.calendar12
        case 13:
            return ImageAssets.calendar13
        case 14:
            return ImageAssets.calendar14
        case 15:
            return ImageAssets.calendar15
        case 16:
            return ImageAssets.calendar16
        case 17:
            return ImageAssets.calendar17
        case 18:
            return ImageAssets.calendar18
        case 19:
            return ImageAssets.calendar19
        case 20:
            return ImageAssets.calendar20
        case 21:
            return ImageAssets.calendar21
        case 22:
            return ImageAssets.calendar22
        case 23:
            return ImageAssets.calendar23
        case 24:
            return ImageAssets.calendar24
        case 25:
            return ImageAssets.calendar25
        case 26:
            return ImageAssets.calendar26
        case 27:
            return ImageAssets.calendar27
        case 28:
            return ImageAssets.calendar28
        case 29:
            return ImageAssets.calendar29
        case 30:
            return ImageAssets.calendar30
        case 31:
            return ImageAssets.calendar31
        default:
            return ImageAssets.calendar
        }
    }
    
    //Class Icons
    static let art = UIImage(imageLiteralResourceName: "Art")
    static let biology = UIImage(imageLiteralResourceName: "Biology")
    static let chemistry = UIImage(imageLiteralResourceName: "Chemistry")
    static let chinese = UIImage(imageLiteralResourceName: "Chinese")
    static let computerScience = UIImage(imageLiteralResourceName: "Computer Science")
    static let economics = UIImage(imageLiteralResourceName: "Economics")
    static let english = UIImage(imageLiteralResourceName: "English")
    static let environmentalScience = UIImage(imageLiteralResourceName: "Environmental Science")
    static let french = UIImage(imageLiteralResourceName: "French")
    static let german = UIImage(imageLiteralResourceName: "German")
    static let health = UIImage(imageLiteralResourceName: "Health")
    static let history = UIImage(imageLiteralResourceName: "History")
    static let latin = UIImage(imageLiteralResourceName: "Latin")
    static let math = UIImage(imageLiteralResourceName: "Math")
    static let music = UIImage(imageLiteralResourceName: "Music")
    static let performingArts = UIImage(imageLiteralResourceName: "Performing Arts")
    static let philosophy = UIImage(imageLiteralResourceName: "Philosophy")
    static let physics = UIImage(imageLiteralResourceName: "Physics")
    static let psychology = UIImage(imageLiteralResourceName: "Psychology")
    static let spanish = UIImage(imageLiteralResourceName: "Spanish")
    
    static func getImageForClassId(_ classId: String) -> UIImage {
        let identifier = String(classId[classId.index(classId.startIndex, offsetBy: 0)]) + String(classId[classId.index(classId.startIndex, offsetBy: 1)])
        
        switch identifier {
        case "AR":
            return ImageAssets.art
        case "BI":
            return ImageAssets.biology
        case "CH":
            return ImageAssets.chemistry
        case "CN":
            return ImageAssets.chinese
        case "CS":
            return ImageAssets.computerScience
        case "DR":
            return ImageAssets.performingArts
        case "EC":
            return ImageAssets.economics
        case "EN":
            return ImageAssets.english
        case "ES":
            return ImageAssets.environmentalScience
        case "FR":
            return ImageAssets.french
        case "GM":
            return ImageAssets.german
        case "HE":
            return ImageAssets.health
        case "HI":
            return ImageAssets.history
        case "LA":
            return ImageAssets.latin
        case "MA":
            return ImageAssets.math
        case "MU":
            return ImageAssets.music
        case "PL":
            return ImageAssets.philosophy
        case "PS":
            return ImageAssets.psychology
        case "PY":
            return ImageAssets.physics
        case "SP":
            return ImageAssets.spanish
        default:
            return UIImage()
        }
    }
}
