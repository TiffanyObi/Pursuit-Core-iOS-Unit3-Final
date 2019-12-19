//
//  AppError.swift
//  Elements
//
//  Created by Tiffany Obi on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
enum AppError: Error {
  case badURL(String) // associated value
  case noResponse
  case networkClientError(Error) // no internet connection
  case noData
  case decodingError(Error)
  case encodingError(Error)
  case badStatusCode(Int) // 404, 500
  case badMimeType(String) // image/jpg
}
