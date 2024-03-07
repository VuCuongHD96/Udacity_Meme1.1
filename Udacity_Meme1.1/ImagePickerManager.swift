//
//  ImagePickerManager.swift
//  Udacity_Meme1.1
//
//  Created by Work on 11/03/2024.
//

import Foundation
import UIKit

class ImagePickerManager: NSObject {
    
    typealias ImagePickerHandler = (UIImagePickerController) -> Void
    typealias ImageSelectedHandler = (UIImage?) -> Void
    
    let imagePicker = UIImagePickerController()
    var imageSelected: ImageSelectedHandler?
    
    override init() {
        super.init()
        setupImagePicker()
    }
    
    func setupImagePicker() {
        imagePicker.delegate = self
    }
    
    func openPhotoLibrary(action: ImagePickerHandler?) {
        imagePicker.sourceType = .photoLibrary
        action?(imagePicker)
    }
}

extension ImagePickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as? UIImage
        imageSelected?(selectedImage)
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
