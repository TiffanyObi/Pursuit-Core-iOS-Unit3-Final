//
//  ElementStruct.swift
//  Elements
//
//  Created by Tiffany Obi on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Element: Codable {
    
    let name: String?
    let symbol: String
    let number: Int
    let atomic_mass: Double?
    let boil: Double?
    let melt: Double?
    let discovered_by: String?
    let favoritedBy: String?
    let density: Double?
    let source: String?
    let summary: String?
}
