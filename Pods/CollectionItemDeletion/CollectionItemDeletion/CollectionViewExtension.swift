//
//  CollectionViewExtension.swift
//  CollectionItemDeletion
//
//  Created by Abdul Rahman on 4/10/19.
//  Copyright © 2019 Abdul Rahman. All rights reserved.
//

import Foundation

extension UICollectionView {
    
   public func setupCollectionItsmdeletion() {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            let longPressGesture = UILongPressGestureRecognizer(target: topController  , action: #selector(topController.longPress(_:)))
            longPressGesture.minimumPressDuration = 0.2
            self.addGestureRecognizer(longPressGesture)
        }
    }
    
}


public extension UICollectionView {
    struct Holder {
        static var delegate:CollectionItemDeletionDelegate? = nil
    }
    var deletionDelegate:CollectionItemDeletionDelegate? {
        get {
            return Holder.delegate
        }
        set(newValue) {
            Holder.delegate = newValue
        }
    }
}

