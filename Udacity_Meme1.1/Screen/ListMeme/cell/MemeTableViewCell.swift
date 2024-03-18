//
//  MemeTableViewCell.swift
//  Udacity_Meme1.1
//
//  Created by Work on 14/03/2024.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet private weak var memeLabel: UILabel!
    @IBOutlet private weak var memeImageView: UIImageView!
    
    func setupContent(meme: Meme) {
        memeImageView.image = meme.memedImage
        let topText = meme.topText ?? ""
        let bottomText = meme.bottomText ?? ""
        memeLabel.text = topText + "..." + bottomText
    }
}
