//
//  TabbarDelegate.swift
//  Udacity_Meme1.1
//
//  Created by Work on 07/03/2024.
//

import UIKit

class TabbarDelegate: NSObject, UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("--- debug --- item = ", item.tag)
        let fontsAvailable = UIFont.familyNames
        print(fontsAvailable)
    }
}
