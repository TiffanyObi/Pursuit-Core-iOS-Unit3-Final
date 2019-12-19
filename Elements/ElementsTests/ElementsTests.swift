//
//  ElementsTests.swift
//  ElementsTests
//
//  Created by Tiffany Obi on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest
@testable import Elements

    class ElementsTests: XCTestCase {

        func testUrlStringForData() {
            let exp = XCTestExpectation(description: "search found")
            let elementEndpointURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
            let request = URLRequest(url: URL(string: elementEndpointURL)!)
            
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                switch result {
                case .failure(let appError):
                    XCTFail("appError: \(appError)")
                    
                case .success(let data):
                    exp.fulfill()
                    
                    XCTAssertGreaterThan(data.count, 71_000, "data.count:\(data) should be greater that 71,000bytes .")
                }
            }
            
            wait(for: [exp], timeout: 5.0)
        }


    func testElementModel() {
        
        struct Element: Codable {
            let name: String
            let appearance: String
        }

        let json = """
        {
        "name": "Hydrogen",
        "appearance": "colorless gas",
        "atomic_mass": 1.008,
        "boil": 20.271,
        "category": "diatomic nonmetal",
        "color": null,
        "density": 0.08988,
        "discovered_by": "Henry Cavendish",
        "melt": 13.99,
        "molar_heat": 28.836,
        "named_by": "Antoine Lavoisier",
        "number": 1,
        "period": 1,
        "phase": "Gas",
        "source": "https://en.wikipedia.org/wiki/Hydrogen",
        "spectral_img": "https://en.wikipedia.org/wiki/File:Hydrogen_Spectra.jpg",
        "summary": "Hydrogen is a chemical element with chemical symbol H and atomic number 1. With an atomic weight of 1.00794 u, hydrogen is the lightest element on the periodic table. Its monatomic form (H) is the most abundant chemical substance in the Universe, constituting roughly 75% of all baryonic mass.",
        "symbol": "H",
        "xpos": 1,
        "ypos": 1,
        "shells": [
            1
        ]
        }
        """.data(using: .utf8)!

        let element = try! JSONDecoder().decode(Element.self, from: json)
        
        XCTAssertEqual(element.name, "Hydrogen")
        }
        
    }



