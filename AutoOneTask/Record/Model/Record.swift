//
//  Record.swift
//  AutoOneTask
//
//  Created by Abdul Rauf on 04/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation

protocol IdentifiableModel: Identifiable, Equatable {
    var id: String { get }
    var name: String { get }
}

extension IdentifiableModel {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

struct Record: IdentifiableModel {
    let id: String
    let name: String
}
