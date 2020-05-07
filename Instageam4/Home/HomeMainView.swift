//
//  HomeMainView.swift
//  Instageam4
//
//  Created by ASW-研修２ on 2020/05/07.
//  Copyright © 2020 ASW-研修２. All rights reserved.
//

import UIKit

import PGFramework
protocol HomeMainViewDelegate: NSObjectProtocol{
    func didSelectRowAt(indexPath:IndexPath)
}
extension HomeMainViewDelegate {
}
// MARK: - Property
class HomeMainView: BaseView {
    weak var delegate: HomeMainViewDelegate? = nil
    @IBOutlet weak var tableView: UITableView!
    var postModels: [PostModel] = [PostModel]()
}
// MARK: - Life cycle
extension HomeMainView {
    override func awakeFromNib() {
        super.awakeFromNib()
        setDelegate()
        loadTableViewCellFromXib(tableView: tableView, cellName: "HomeTableViewCell")
    }
}
// MARK: - Protocol
extension HomeMainView:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as?
            HomeTableViewCell else {return UITableViewCell()}
        cell.updateCell(postModel: postModels[indexPath.row])
        return cell
    }
}
extension HomeMainView:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.didSelectRowAt(indexPath: indexPath)
        }
    }
}

// MARK: - method
extension HomeMainView {
    func setDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    func getModel(postModels: [PostModel]) {
        self.postModels = postModels
        tableView.reloadData()
    }
}
