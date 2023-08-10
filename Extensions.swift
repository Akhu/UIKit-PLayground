//
//  Extensions.swift
//  UIKitPlayground
//
//  Created by Anthony Da cruz on 07/08/2023.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
        
    }
}
