//
//  TabbarDelegate.swift
//  Udacity_Meme1.1
//
//  Created by Work on 07/03/2024.
//

import UIKit

class TabbarDelegate: NSObject, UITabBarDelegate {
    
    typealias VoidHandler = () -> Void
    
    var openFontScreen: VoidHandler?
    var openAlbumSceen: VoidHandler?
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let tabbarTag = TabbarTag(rawValue: item.tag)
        switch tabbarTag {
        case .font:
            openFontScreen?()
        case .album:
            openAlbumSceen?()
        default: break
        }
    }
}
