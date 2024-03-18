//
//  CollectionMemeViewController.swift
//  Udacity_Meme1.1
//
//  Created by Work on 18/03/2024.
//

import UIKit

class CollectionMemeViewController: UIViewController {
    
    struct Constant {
        static let nibName = "MemeCollectionViewCell"
    }
    
    @IBOutlet private var collectionView: UICollectionView!
    
    let memeSource = MemeSource.shared
    lazy var memeList = memeSource.getList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        memeList = memeSource.getList()
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let nibName = UINib(nibName: Constant.nibName, bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: Constant.nibName)
    }
}

extension CollectionMemeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.nibName, for: indexPath) as? MemeCollectionViewCell else {
            return UICollectionViewCell()
        }
        let memeItem = memeList[indexPath.row]
        cell.setupContent(data: memeItem)
        return cell
    }
}

extension CollectionMemeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.frame.width
        let itemWidth = totalWidth / 3 - 10
        return CGSize(width: itemWidth, height: 100)
    }
}
