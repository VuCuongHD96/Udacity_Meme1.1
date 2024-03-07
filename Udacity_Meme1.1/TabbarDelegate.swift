//
//  TabbarDelegate.swift
//  Udacity_Meme1.1
//
//  Created by Work on 07/03/2024.
//

import UIKit

class TabbarDelegate: NSObject, UITabBarDelegate {
    
    var openFontScreen: (() -> Void)?
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let fontsAvailable = UIFont.familyNames
        let tabbarTag = TabbarTag(rawValue: item.tag)
        switch tabbarTag {
        case .font:
            openFontScreen?()
        default: break
        }
    }
}
