//
//  UIImageView + Extensions.swift
//  Elements
//
//  Created by Tiffany Obi on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func getLargerImage(for lowercasedName: String , completion: @escaping (Result<UIImage, AppError>) -> ()) {
        
        let activityIndicator = UIActivityIndicatorView(style: .gray)
          activityIndicator.color = .orange
          activityIndicator.startAnimating()
          activityIndicator.center = center
          addSubview(activityIndicator)
          
          
          let pictureString = "http://images-of-elements.com/\(lowercasedName).jpg"
          
          guard let url = URL(string: pictureString) else {
            completion(.failure(.badURL(pictureString)))
            return
          }
          
          let request = URLRequest(url: url)
          
          NetworkHelper.shared.performDataTask(with: request) { [weak activityIndicator] (result) in
            DispatchQueue.main.async {
              activityIndicator?.stopAnimating() // hides when we stop animating the indicator
            }
            switch result {
            case .failure(let appError):
              DispatchQueue.main.async {
                 
              activityIndicator?.stopAnimating()
              }
              completion(.failure(.networkClientError(appError)))
            case .success(let data):
              if let image = UIImage(data: data) {
                completion(.success(image))
              }
            }
          }
        }
    
  func getImage(with elementNumber: String,
                completion: @escaping (Result<UIImage, AppError>) -> ()) {
    
  
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    activityIndicator.color = .orange
    activityIndicator.startAnimating()
    activityIndicator.center = center
    addSubview(activityIndicator)
    
    
    let pictureString = "http://www.theodoregray.com/periodictable/Tiles/\(elementNumber )/s7.JPG"
    
    guard let url = URL(string: pictureString) else {
      completion(.failure(.badURL(pictureString)))
      return
    }
    
    let request = URLRequest(url: url)
    
    NetworkHelper.shared.performDataTask(with: request) { [weak activityIndicator] (result) in
      DispatchQueue.main.async {
        activityIndicator?.stopAnimating() // hides when we stop animating the indicator
      }
      switch result {
      case .failure(let appError):
        DispatchQueue.main.async {
           
        activityIndicator?.stopAnimating()
        }
        completion(.failure(.networkClientError(appError)))
      case .success(let data):
        if let image = UIImage(data: data) {
          completion(.success(image))
        }
      }
    }
  }
}
