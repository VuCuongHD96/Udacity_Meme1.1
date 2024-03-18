//
//  TabbarController.swift
//  Udacity_Meme1.1
//
//  Created by Work on 13/03/2024.
//

import UIKit

final class TabbarController: UITabBarController {
    
    var memeSource = MemeSource.shared
    
    @IBAction func addAction(_ sender: Any) {
        let memeEditorScreen = MemeEditorViewController()
        let navigationController = UINavigationController(rootViewController: memeEditorScreen)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
}
