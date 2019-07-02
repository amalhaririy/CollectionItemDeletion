//
//  SettingVariabels.swift
//  CollectionItemDeletion
//
//  Created by Abdul Rahman on 4/10/19.
//  Copyright © 2019 Abdul Rahman. All rights reserved.
//

import Foundation
class SettingVariabels {
    
    static var cell:UICollectionViewCell?
    static var deletedItem:Any?
    static var halfScreenWidth:CGFloat = 0
    static var snapshotView:UIView?
    static var snapshotIndexPath:IndexPath?
    static var snapshotLoction:CGPoint?
    static var screenBounds = UIScreen.main.bounds
    static var xBounceConstant:CGFloat = 10
    static var yBounceConstant:CGFloat = 10
    static var yVelocity:CGFloat = 0
    static var velocityArray:[CGFloat] = []
    static var yOldLocation:CGFloat = 0
    static var isSwallowed:Bool = false
    static var isItemDeleted:Bool = false
    static var animationDuration = 0.1
    
    static func reset()  {
        SettingVariabels.halfScreenWidth = 0
        SettingVariabels.snapshotView = nil
        SettingVariabels.snapshotIndexPath = nil
        SettingVariabels.snapshotLoction = nil
        SettingVariabels.xBounceConstant = 10
        SettingVariabels.yBounceConstant = 10
        SettingVariabels.yVelocity = 0
        SettingVariabels.velocityArray = []
        SettingVariabels.yOldLocation = 0
        SettingVariabels.isSwallowed = false
        SettingVariabels.isItemDeleted = false
        SettingVariabels.animationDuration = 0.1
    }
}
