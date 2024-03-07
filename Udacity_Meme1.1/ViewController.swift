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
    private let fontScreen = FontViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
        setupFontScreen()
    }
    
    private func setupFontScreen() {
        fontScreen.fontScreenDataSource = self
    }
    
    private func setupTabbar() {
        tabbarDelegate.openFontScreen = {
            self.present(self.fontScreen, animated: true)
        }
        tabbar.delegate = tabbarDelegate
        let editImage = UIImage(named: "edit")?
            .withRenderingMode(.alwaysOriginal)
        let fontTabbarItem = UITabBarItem(title: "Font",
                                          image: editImage,
                                          tag: TabbarTag.font.rawValue)
        tabbar.items = [fontTabbarItem]
    }
}

extension ViewController: FontScreenDataSource {
    
    func didSelected(font: String) {
        print(font)
        fontScreen.dismiss(animated: true)
    }
}
