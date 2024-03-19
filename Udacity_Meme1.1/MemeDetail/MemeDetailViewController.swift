//
//  MemeDetailViewController.swift
//  Udacity_Meme1.1
//
//  Created by Work on 19/03/2024.
//

import UIKit

final class MemeDetailViewController: UIViewController {
    
    @IBOutlet private weak var memeImageView: UIImageView!
    
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        memeImageView.image = meme.memedImage
    }
}
