//
//  ProfilePicture.swift
//  SSA Student
//
//  Created by Nick on 8/23/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class ProfilePicture: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 1.0
        let radius: CGFloat = self.bounds.size.width / 2.0
        self.layer.cornerRadius = radius
        clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}
