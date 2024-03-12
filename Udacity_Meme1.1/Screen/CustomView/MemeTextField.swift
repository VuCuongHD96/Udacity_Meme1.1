//
//  MemeTextField.swift
//  Udacity_Meme1.1
//
//  Created by Work on 12/03/2024.
//

import UIKit

class MemeTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
 
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.black,
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            .strokeWidth:  -3.5,
        ]
        defaultTextAttributes = memeTextAttributes
        textAlignment = .center
        borderStyle = .none
        autocapitalizationType = .words
        textColor = .white
    }
}
