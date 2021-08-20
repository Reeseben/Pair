//
//  Equatible.swift
//  Pairs
//
//  Created by Ben Erekson on 8/20/21.
//

import Foundation

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id
    }
    
}
