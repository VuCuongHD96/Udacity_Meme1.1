//
//  FontViewController.swift
//  Udacity_Meme1.1
//
//  Created by Work on 07/03/2024.
//

import UIKit

protocol FontScreenDataSource {
    
    func didSelected(font: String)
}

class FontViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    let fontsAvailable = UIFont.familyNames
    var fontScreenDataSource: FontScreenDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension FontViewController: UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontsAvailable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let item = fontsAvailable[indexPath.row]
        cell.textLabel?.text = item
        cell.textLabel?.font = UIFont(name: item, size: 20)
        return cell
    }
}

extension FontViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = fontsAvailable[indexPath.row]
        fontScreenDataSource?.didSelected(font: item)
    }
}
