//
//  ViewController.swift
//  Udacity_Meme1.1
//
//  Created by Work on 07/03/2024.
//

import UIKit

enum TabbarTag: Int {
    case font = 0
}

class ViewController: UIViewController {
    
    @IBOutlet weak private var tabbar: UITabBar!
    private var tabbarDelegate = TabbarDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTabbar()
    }
    
    private func setupTabbar() {
        tabbar.delegate = tabbarDelegate
        let editImage = UIImage(named: "edit")?
            .withRenderingMode(.alwaysOriginal)
        let fontTabbarItem = UITabBarItem(title: "Font",
                                          image: editImage,
                                          tag: TabbarTag.font.rawValue)
        tabbar.items = [fontTabbarItem]
    }
}
