//
//  MemeEditorViewController.swift
//  Udacity_Meme1.1
//
//  Created by Work on 07/03/2024.
//

import UIKit

enum TabbarTag: Int {
    case font = 0
    case album
    case camera
}

class MemeEditorViewController: UIViewController {

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
        
#if !targetEnvironment(simulator)
        let cameraImage = UIImage(named: "camera")?
            .withRenderingMode(.alwaysOriginal)
        let cameraTabbarItem = UITabBarItem(title: "Camera",
                                            image: cameraImage,
                                            tag: TabbarTag.camera.rawValue)
        tabbar.items = [fontTabbarItem, albumTabbarItem, cameraTabbarItem]
#endif
    }
    
    // MARK: - Data
    private func setupData() {
        setupTabbarDelegate()
        setupFontScreen()
        setupImagePickerManager()
        setupNotificationKeyboard()
    }
    
    private func setupNotificationKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let groupViewMaxY = groupView.frame.maxY
            let keyboardSizeMinY = keyboardSize.minY
            if groupViewMaxY > keyboardSizeMinY && bottomTextField.isFirstResponder {
                let alpha = keyboardSizeMinY - groupViewMaxY
                groupView.transform = CGAffineTransform(translationX: 0, y: alpha)
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        groupView.transform = .identity
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
        tabbarDelegate.openCameraSceen = {
            self.openCameraSceen()
        }
        tabbar.delegate = tabbarDelegate
    }

    // MARK: - Action
    @IBAction private func shareAction(_ sender: Any) {
        openShareSceen()
    }
    
    private func openPhotoLibrary() {
        imagePickerManager.openPhotoLibrary { imagePicker in
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func openCameraSceen() {
        imagePickerManager.openCamera { imagePicker in
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func openShareSceen() {
        let capturedImage = generateMemedImage()
        let shareActivityViewController = UIActivityViewController(activityItems: [capturedImage],
                                                                   applicationActivities: nil)
        shareActivityViewController.completionWithItemsHandler = { activity, completed, items, error in
            if completed {
                self.saveMeme()
                self.dismiss(animated:true, completion:nil)
            }
        }
        present(shareActivityViewController, animated: true)
    }
    
    private func saveMeme() {
        let capturedImage = generateMemedImage()
        let meme = Meme(topText: topTextField.text,
                        bottomText: bottomTextField.text,
                        originalImage: imageView.image, 
                        memedImage: capturedImage)
    }
    
    func generateMemedImage() -> UIImage {
        UIGraphicsBeginImageContext(groupView.bounds.size)
        groupView.drawHierarchy(in: groupView.bounds, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return memedImage
    }
}

extension MemeEditorViewController: FontScreenDataSource {
    
    func didSelected(font: String) {
        topTextField.font = UIFont(name: font, size: 40)
        bottomTextField.font = UIFont(name: font, size: 40)
        fontScreen.dismiss(animated: true)
    }
}
