//
//  MemeSource.swift
//  Udacity_Meme1.1
//
//  Created by Work on 14/03/2024.
//

import Foundation

class MemeSource {
    
    static let shared = MemeSource()
    private var memeList: [Meme] = []
    
    func add(meme: Meme) {
        memeList.append(meme)
    }
    
    func getList() -> [Meme] {
        return memeList
    }
}
