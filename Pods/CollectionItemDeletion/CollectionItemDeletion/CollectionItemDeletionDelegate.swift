//
//  CollectionItemDeletionDelegate.swift
//  CollectionItemDeletion
//
//  Created by Abdul Rahman on 4/13/19.
//  Copyright © 2019 Abdul Rahman. All rights reserved.
//

import Foundation
public protocol CollectionItemDeletionDelegate {
    
    func collectionArray() ->[Int]
    func item(at index:Int) -> Any
    func deleteItem(at  index:Int)
    func insert(item : Any ,at  index:Int)
    
    
}



