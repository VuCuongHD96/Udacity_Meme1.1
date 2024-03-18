//
//  MemeCollectionViewCell.swift
//  Udacity_Meme1.1
//
//  Created by Work on 18/03/2024.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var memeImageView: UIImageView!
 
    func setupContent(data: Meme) {
        memeImageView.image = data.memedImage
    }
}
