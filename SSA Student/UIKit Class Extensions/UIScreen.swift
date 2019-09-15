//
//  UIScreen.swift
//  SSA Student
//
//  Created by Nick on 8/7/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

//Barcode
extension UIScreen {
    
    private static let step: CGFloat = 0.1
    
    static func animateBrightness(to value: CGFloat) {
        guard abs(UIScreen.main.brightness - value) > step else { return }
        
        let delta = UIScreen.main.brightness > value ? -step : step
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            UIScreen.main.brightness += delta
            animateBrightness(to: value)
        }
    }
}
