//
//  ElementsDetailViewController.swift
//  Elements
//
//  Created by Tiffany Obi on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementsDetailViewController: UIViewController {

    @IBOutlet weak var largerImage: UIImageView!
    
    
    @IBOutlet weak var symbolLabel: UILabel!
    
    
    @IBOutlet weak var numberLabel: UILabel!
    
    
    @IBOutlet weak var atomicMassLabel: UILabel!
    
    
    @IBOutlet weak var boilingPointLabel: UILabel!
    
    @IBOutlet weak var meltingPointLabel: UILabel!
    
    
    @IBOutlet weak var discoveredByLabel: UILabel!
    
 
    @IBOutlet weak var favoriteButton: UIButton!
    
    var element : Element!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteButton.setBackgroundImage(UIImage(named: "heart"), for: .normal)
       updateUI()
    }
    

    func updateUI () {
        navigationItem.title = element.name
        largerImage.getLargerImage(for: element.name?.lowercased() ?? "") { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.largerImage.image = UIImage(named: "science")
                }
                
            case .success(let image):
                DispatchQueue.main.async {
                    self?.largerImage.image = image
                }
            }
        }
        symbolLabel.text = element.symbol
        numberLabel.text = "Element Number: \(element.number)"
        atomicMassLabel.text = "Weight - \(element.atomic_mass ?? 0.0)"
        boilingPointLabel.text = "Boiling Point: \(element.boil ?? Double("N/A") ?? 0.0)"
        meltingPointLabel.text = "Melting Point: \(element.melt ?? Double("N/A") ?? 0.0)"
        discoveredByLabel.text = "Discovered by: \( element.discovered_by ?? "N/A")"
    }
    
    
   
    @IBAction func elementFavorited(_ sender: UIButton) {
        sender.isEnabled = false
        sender.setBackgroundImage(UIImage(named: "lastHeart"), for: .normal)
        
        let favorite = Element(name: element.name, symbol: element.symbol, number: element.number, atomic_mass: element.atomic_mass, boil: element.boil, melt: element.melt, discovered_by: element.discovered_by, favoritedBy: "Tiffany Obi", density: element.density, source: element.source, summary: element.summary)
        
        ElementsAPIClient.favoriteElement(for: favorite) { [weak self] (result) in
                switch result {
                case .failure(let appError):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Couldn't Add As Favorite", message: "\(appError)")
                }
                case .success:
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Awesome! We Love That Element Too!", message: "\(favorite.name?.uppercased() ?? "") was added to your favorites!")
                    }
            }
        }
        
    }
    
}
