//
//  collectionViewCellExtension.swift
//  CollectionItemDeletion
//
//  Created by Abdul Rahman on 4/11/19.
//  Copyright © 2019 Abdul Rahman. All rights reserved.
//

import Foundation
extension UICollectionViewCell{
    
    override open func snapshotView(afterScreenUpdates afterUpdates: Bool) -> UIView? {
        let snapshot = super.snapshotView(afterScreenUpdates: afterUpdates)
        snapshot?.layer.masksToBounds = false
        snapshot?.layer.shadowOffset = CGSize(width: -5, height: 0)
        snapshot?.layer.shadowRadius = 5
        snapshot?.layer.shadowOpacity = 2
        snapshot?.layer.cornerRadius = 15
        snapshot?.alpha = 0.9
        snapshot?.center = center
        return snapshot
    }}
