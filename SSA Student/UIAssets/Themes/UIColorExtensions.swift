//
//  IUColorExtensions.swift
//  SSA Student
//
//  Created by Nick on 8/12/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

extension UIColor {
    
    var lighterColor: UIColor {
        return lighterColor(removeSaturation: 0.5, resultAlpha: -1)
    }
    
    func lighterColor(removeSaturation val: CGFloat, resultAlpha alpha: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0
        var b: CGFloat = 0, a: CGFloat = 0
        
        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a)
            else {return self}
        
        return UIColor(hue: h,
                       saturation: max(s - val, 0.0),
                       brightness: b,
                       alpha: alpha == -1 ? a : alpha)
    }
    
    func addColor(_ color1: UIColor) -> UIColor {
        var (r1, g1, b1, a1) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        var (r2, g2, b2, a2) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        
        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color1.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        // add the components, but don't let them go above 1.0
        return UIColor(red: min(0.75 * r1 + 0.25 * r2, 1), green: min(0.75 * g1 + 0.25 * g2, 1), blue: min(0.75 * b1 + 0.25 * b2, 1), alpha: (a1 + a2) / 2)
    }
}

extension UIColor {
    static func randomSeededColor(seed: String) -> UIColor {
        
        if seed == "null" {
            return .lightGray
        }
        
        var total: Int = 0
        for u in seed.unicodeScalars {
            total += Int(UInt32(u))
        }
        
    //    srand48(total * 200)
    //    let r = CGFloat(drand48())
        
        srand48(total)
        var g = CGFloat(drand48())
        
        let golden_ratio_conjugate = CGFloat(0.618033988749895)
        g += golden_ratio_conjugate
        g = g.truncatingRemainder(dividingBy: 1.0)
    //    srand48(total / 200)
    //    let b = CGFloat(drand48())
        
        return UIColor(hue: g, saturation: 0.4, brightness: 0.95, alpha: 1.0)
    }
}
