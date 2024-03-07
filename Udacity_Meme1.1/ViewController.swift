//
//  ViewController.swift
//  Udacity_Meme1.1
//
//  Created by Work on 07/03/2024.
//

import UIKit

enum TabbarTag: Int {
    case font = 0
    case album
}

class ViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak private var tabbar: UITabBar!
    @IBOutlet weak private var imageView: UIImageView!

    // MARK: - Property
    private var tabbarDelegate = TabbarDelegate()
    private let fontScreen = FontViewController()
    let imagePickerManager = ImagePickerManager()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
    }
    
    // MARK: - View
    private func setupView() {
        setupTabbar()
    }
    
    private func setupTabbar() {
        let editImage = UIImage(named: "edit")?
            .withRenderingMode(.alwaysOriginal)
        let fontTabbarItem = UITabBarItem(title: "Font",
                                          image: editImage,
                                          tag: TabbarTag.font.rawValue)
        let albumImage = UIImage(named: "album")?
            .withRenderingMode(.alwaysOriginal)
        let albumTabbarItem = UITabBarItem(title: "Album",
                                           image: albumImage,
                                           tag: TabbarTag.album.rawValue)
        tabbar.items = [fontTabbarItem, albumTabbarItem]
    }
    
    // MARK: - Data
    private func setupData() {
        setupTabbarDelegate()
        setupFontScreen()
        setupImagePickerManager()
    }
    
    private func setupImagePickerManager() {
        imagePickerManager.imageSelected = { image in
            self.imageView.image = image
        }
    }
    
    private func setupFontScreen() {
        fontScreen.fontScreenDataSource = self
    }
    
    private func setupTabbarDelegate() {
        tabbarDelegate.openFontScreen = {
            self.present(self.fontScreen, animated: true)
        }
        tabbarDelegate.openAlbumSceen = {
            self.openPhotoLibrary()
        }
        tabbar.delegate = tabbarDelegate
    }

    func openPhotoLibrary() {
        imagePickerManager.openPhotoLibrary { imagePicker in
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension ViewController: FontScreenDataSource {
    
    func didSelected(font: String) {
        print(font)
        fontScreen.dismiss(animated: true)
    }
}
