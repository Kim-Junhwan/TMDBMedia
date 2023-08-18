//
//  ReusableIdentifier.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/17.
//

import Foundation

protocol ReusableIdentifier {
    static var identifier: String {get}
}

extension ReusableIdentifier {
    static var identifier: String {
        get {
            return String(describing: Self.self)
        }
    }
}
