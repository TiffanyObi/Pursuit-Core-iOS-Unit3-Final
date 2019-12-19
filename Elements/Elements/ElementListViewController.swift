//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ElementListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var elements = [Element]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var elementNumber : Int!
    
    func loadElements() {
        ElementsAPIClient.getElements { [weak self] (result) in
            switch result {
            case .failure(let appError):
                fatalError("could not load data :\(appError)")
            case .success(let elementList):
                self?.elements = elementList
            }
        }
    }
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    loadElements()
    navigationItem.title = "E L E M E N T S"
  }


}

extension ElementListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let elementCell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementsTableViewCell else {
            fatalError("could not lovcate Cell")
        }
        
        let cellInRow = elements[indexPath.row]
        
        
        elementCell.configureCell(for: cellInRow.number, for: cellInRow)
        
        
        return elementCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? ElementsDetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("could not locate view controller")
        }
        
        let elementDetails = elements[indexPath.row]
        
        detailVC.element = elementDetails
    }
}

extension ElementListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
