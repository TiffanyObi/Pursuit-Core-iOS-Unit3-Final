//
//  FavoritesViewController.swift
//  Elements
//
//  Created by Tiffany Obi on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    var favorites = [Element]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getFavorites()
        configureRefreshControl()
        navigationItem.title = "F A V O R I T E S"
    }
    
    @objc func getFavorites () {
        ElementsAPIClient.getFavoritesList { [weak self] (result) in
            switch result {
                case .failure(let appError):
                    DispatchQueue.main.async {
                        self?.refreshControl.endRefreshing()
                        self?.showAlert(title: "App Error", message: "\(appError)")
                    }
                    
                case .success(let favorites):
                    DispatchQueue.main.async {
                        self?.refreshControl.endRefreshing()
                        
                        self?.favorites = favorites.filter {$0.favoritedBy == "Tiffany Obi"}
                    }
                }
            }
    }
    
    private func configureRefreshControl() {
      refreshControl = UIRefreshControl()
      tableView.refreshControl = refreshControl
      refreshControl.addTarget(self, action: #selector(getFavorites), for: .valueChanged)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let favoriteDetailsVC = segue.destination as? ElementsDetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("could not locate VC")}
        
        let details = favorites[indexPath.row]
        
        favoriteDetailsVC.element = details
           
        }
    }



extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favoriteCell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoitesTableViewCell else { fatalError("could not locate Cell")
        }
        
        let element = favorites[indexPath.row]
        
        favoriteCell.configureCell(for: element.number, for: element)
        
        return favoriteCell
    }
    
    
}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
