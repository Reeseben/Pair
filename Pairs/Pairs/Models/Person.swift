//
//  Person.swift
//  Pairs
//
//  Created by Ben Erekson on 8/20/21.
//

import Foundation

class Person: Codable {
    let name: String
    let id: String
    init(name: String, id: String = UUID().uuidString) {
        self.name = name
        self.id = id
    }
}
