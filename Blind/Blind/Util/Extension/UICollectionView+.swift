//
//  UICollectionView+.swift
//  Blind
//
//  Created by Khai on 2023/10/23.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(withType type: T.Type) {
        register(type.self, forCellWithReuseIdentifier: type.identifier)
    }
    
    func dequeueCell<T: UICollectionViewCell>(withType type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue reusable cell")
        }
        return cell
    }
}
