//
//  ViewController.swift
//  mrPic
//
//  Created by 홍정표 on 2023/03/26.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    var viewModel = RandomUserViewModel()
    var cellName = "RandomUserTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchRandomUsers()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh), for: .valueChanged)
        let nibName = UINib(nibName: cellName, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: cellName)
        
    }
    @objc func pullToRefresh(){
        viewModel.fetchRandomUsers()
//        refreshControl.endRefreshing()
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.randomUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! RandomUserTableViewCell
        let imageUrl = viewModel.randomUsers[indexPath.row].picture.medium
        cell.nameLabel.text = "\(viewModel.randomUsers[indexPath.row].name.first) \(viewModel.randomUsers[indexPath.row].name.last)"
        cell.imgView.kf.indicatorType = .activity
        cell.imgView.kf.setImage(with: URL(string: imageUrl))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            viewModel.addRandomUser()
        }
    }
}
extension ViewController: RandomUserViewModelDelegate{
    func didUpdateState(to state: RandomUserViewModelState) {
        switch state {
        case .gotRandomUser:
            self.tableView.reloadData()
            refreshControl.endRefreshing()
            
        case .error(let reason):
            print(reason)
        }
    }
}
