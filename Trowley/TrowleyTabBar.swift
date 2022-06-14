//
//  TrowleyTabBar.swift
//  Trowley
//
//  Created by Jason Kenneth on 14/06/22.
//

import UIKit

class TrowleyTabBar: UITabBar {

    @IBInspectable var height: CGFloat = 0.0

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        if height > 0.0 {
            sizeThatFits.height = height
        }
        return sizeThatFits
    }

}
