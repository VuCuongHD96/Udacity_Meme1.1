//
//  ListMemeViewController.swift
//  Udacity_Meme1.1
//
//  Created by Work on 14/03/2024.
//

import Foundation
import UIKit

class ListMemeViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    let memeSource = MemeSource.shared
    lazy var memeList = memeSource.getList()
    
    struct Constant {
        static let nibName = "MemeTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        memeList = memeSource.getList()
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        let nib = UINib(nibName: Constant.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constant.nibName)
    }
}

extension ListMemeViewController: UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.nibName, for: indexPath) as? MemeTableViewCell else {
            return UITableViewCell()
        }
        let memeItem = memeList[indexPath.row]
        cell.setupContent(meme: memeItem)
        return cell
    }
}
