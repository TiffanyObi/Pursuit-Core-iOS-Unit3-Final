//
//  ElementsTableViewCell.swift
//  Elements
//
//  Created by Tiffany Obi on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementsTableViewCell: UITableViewCell {

    @IBOutlet weak var elementImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    
    func configureCell(for elementNumber: Int, for element: Element){
    
        nameLabel.text = element.name.uppercased()
        
        detailLabel.text = "\(element.symbol) (\(element.number) - Atomic Mass: \(element.atomic_mass))"
        
        var specialNumber = "\(elementNumber)"
        
        if elementNumber < 10 {
            specialNumber = "00\(elementNumber)"
            print(specialNumber)
        } else if elementNumber > 9 && elementNumber < 100 {
            specialNumber = "0\(elementNumber)"
            print(specialNumber)
        } else if elementNumber > 100 {
           specialNumber = "00\(elementNumber)"
            print(specialNumber)
        }
        
        elementImageView.getImage(with: specialNumber) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.elementImageView.image = UIImage(named: "science")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.elementImageView.image = image
                }
            }
        }
    }
}
