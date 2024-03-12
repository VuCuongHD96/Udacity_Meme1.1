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
    case share
}

class ViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak private var tabbar: UITabBar!
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet private weak var groupView: UIView!
    @IBOutlet private weak var topTextField: MemeTextField!
    @IBOutlet private weak var bottomTextField: MemeTextField!

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
        setupTabbar(isSelectedImage: false)
    }
    
    private func setupTabbar(isSelectedImage: Bool) {
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

        if isSelectedImage {
            let shareImage = UIImage(named: "share")?
                .withRenderingMode(.alwaysOriginal)
            let shareTabbarItem = UITabBarItem(title: "Share",
                                               image: shareImage,
                                               tag: TabbarTag.share.rawValue)
            tabbar.items = [fontTabbarItem, albumTabbarItem, shareTabbarItem]
        }
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
            self.setupTabbar(isSelectedImage: true)
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
        tabbarDelegate.openShareSceen = {
            self.openShareSceen()
        }
        tabbar.delegate = tabbarDelegate
    }

    // MARK: - Action
    private func openPhotoLibrary() {
        imagePickerManager.openPhotoLibrary { imagePicker in
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func openShareSceen() {
        let capturedImage = generateMemedImage()
        let shareActivityViewController = UIActivityViewController(activityItems: [capturedImage],
                                                                   applicationActivities: nil)
        present(shareActivityViewController, animated: true)
    }
    
    func generateMemedImage() -> UIImage {
        UIGraphicsBeginImageContext(groupView.bounds.size)
        groupView.drawHierarchy(in: groupView.bounds, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return memedImage
    }
}

extension ViewController: FontScreenDataSource {
    
    func didSelected(font: String) {
        topTextField.font = UIFont(name: font, size: 40)
        bottomTextField.font = UIFont(name: font, size: 40)
        fontScreen.dismiss(animated: true)
    }
}
