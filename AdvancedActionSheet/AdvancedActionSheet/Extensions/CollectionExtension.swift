//
//  CollectionExtension.swift
//  TestASAlert
//
//  Created by Ali Samaiee on 9/11/21.
//

import Foundation

internal extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
