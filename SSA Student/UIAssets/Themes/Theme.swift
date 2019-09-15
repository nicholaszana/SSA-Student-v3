//
//  Theme.swift
//  SSA Student
//
//  Created by Nick on 8/12/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class Theme {
    static var currentTheme: ThemeProtocol = DefaultTheme()
    
    static var themeDidChange = false
    
    static func setTheme(theme: ThemeProtocol) {
        Theme.currentTheme = theme
        Theme.themeDidChange = true
    }
}

protocol ThemeProtocol {
    var backgroundColor: UIColor { get }
    var primaryColor: UIColor { get }
    var accentColor: UIColor { get }
    var textOnBackground: UIColor { get }
    var textOnPrimary: UIColor { get }
    var actionTextOnBackground: UIColor { get }
}

class DefaultTheme: ThemeProtocol {
    var backgroundColor: UIColor = .white
    
    var primaryColor: UIColor = UIColor(red: 0.09, green: 0.25, blue: 0.43, alpha: 1.0);
    
    var accentColor: UIColor = UIColor(red: 0.91, green: 0.75, blue: 0.57, alpha: 1.0);
    
    var textOnBackground: UIColor = .black
    
    var textOnPrimary: UIColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.0);
    
    var actionTextOnBackground: UIColor = UIColor(red: 1.00, green: 0.95, blue: 0.76, alpha: 1.0);
    
}

class DarkTheme: ThemeProtocol {
    var backgroundColor: UIColor = .black
    
    var primaryColor: UIColor = .gray
    
    var accentColor: UIColor = .black
    
    var textOnBackground: UIColor = .white
    
    var textOnPrimary: UIColor = .black
    
    var actionTextOnBackground: UIColor = .green
    
}

class FunTheme: ThemeProtocol {
    var backgroundColor: UIColor = UIColor.red.lighterColor
    
    var primaryColor: UIColor = UIColor.blue.lighterColor
    
    var accentColor: UIColor = UIColor.white
    
    var textOnBackground: UIColor = UIColor.white
    
    var textOnPrimary: UIColor = UIColor.white
    
    var actionTextOnBackground: UIColor = UIColor.white
    
    
}

class TaylorSwiftTheme: ThemeProtocol {
    var backgroundColor: UIColor = UIColor.red.lighterColor
    
    var primaryColor: UIColor = UIColor.blue.lighterColor
    
    var accentColor: UIColor = UIColor.red.lighterColor
    
    var textOnBackground: UIColor = UIColor.white
    
    var textOnPrimary: UIColor = UIColor.white
    
    var actionTextOnBackground: UIColor = UIColor.white
    
    
}
