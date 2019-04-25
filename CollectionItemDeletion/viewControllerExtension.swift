//
//  viewControllerExtension.swift
//  CollectionItemDeletion
//
//  Created by Abdul Rahman on 4/10/19.
//  Copyright © 2019 Abdul Rahman. All rights reserved.
//

import Foundation
extension UIViewController   {
   
    var recycleBinView : DeleteView{
        for subview in self.view.subviews{
            if subview is DeleteView{
                return subview as! DeleteView
            }
        }
        return DeleteView(frame: CGRect(x: SettingVariabels.screenBounds.width/2 ,
                                        y: SettingVariabels.screenBounds.height + 10, width: 50, height: 50))
    }                                                                      
    @objc func longPress(_ gesture:UILongPressGestureRecognizer){
        
        guard let collectionView = gesture.view as? UICollectionView  else {
            return
        }
        let cellLocation = gesture.location(in: collectionView)
        let location = gesture.location(in: self.view)
        let indexPath = collectionView.indexPathForItem(at: cellLocation)
        
        switch gesture.state {
        case .began:
            guard let indexPath = indexPath ,  let cell = collectionView.cellForItem(at: indexPath) else{
                return
            }
            SettingVariabels.reset()
            SettingVariabels.snapshotView = cell.snapshotView(afterScreenUpdates: true)
            self.view.addSubview(SettingVariabels.snapshotView!)
            SettingVariabels.snapshotView!.center = location
            SettingVariabels.cell = cell
            SettingVariabels.cell!.contentView.alpha = 0
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1,
                                                           delay: 0,
                                                           options: [],
                                                           animations: {
                                                            SettingVariabels.snapshotView?.transform  = CGAffineTransform(scaleX: 1.1, y: 1.1)
                                                                guard let  collectionView = gesture.view as? UICollectionView else{
                                                                    return
                                                                }
                                                                SettingVariabels.deletedItem = collectionView.deletionDelegate!.item(at: indexPath.row)
                                                                collectionView.performBatchUpdates({
                                                                    collectionView.deleteItems(at: [indexPath])
                                                                    collectionView.deletionDelegate!.deleteItem(at: indexPath.row)
                                                                }, completion: nil)
                                                                collectionView.reloadData()
            }) { (position) in
                self.recycleBinApearenceAnimation()
            }
            SettingVariabels.snapshotIndexPath = indexPath
            guard let  collectionView = gesture.view as? UICollectionView else{
                return
            }
            SettingVariabels.snapshotLoction =  gesture.location(in: self.view)
            SettingVariabels.velocityArray = []
            self.view.addSubview(recycleBinView)
            recycleBinView.isHidden = true
        case .changed:
            guard let snapshotView = SettingVariabels.snapshotView else{return}
            recycleBinView.center.x = (SettingVariabels.screenBounds.width/2) + ((location.x - SettingVariabels.screenBounds.width/2)/10)
            if location.y >= SettingVariabels.screenBounds.height/2{
                recycleBinView.center.y = SettingVariabels.screenBounds.height  - 80 + (location.y - SettingVariabels.screenBounds.height/2)/10
            }else{
                UIView.animate(withDuration: 0.2) {
                    self.recycleBinView.center.y  =  SettingVariabels.screenBounds.height  - 80
                }
            }
            if distance(location, recycleBinView.center) <= 110 {
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1,
                                                               delay: 0,
                                                               options: [],
                                                               animations: {
                                                                let widthRatio = self.recycleBinView.bounds.width/snapshotView.bounds.width
                                                                let HeightRatio = widthRatio
                                                                snapshotView.transform  = CGAffineTransform(scaleX: widthRatio,
                                                                                                            y: HeightRatio)
                                                                snapshotView.center  = CGPoint(x: self.recycleBinView.center.x + SettingVariabels.xBounceConstant,
                                                                                               y: self.recycleBinView.center.y + SettingVariabels.yBounceConstant)
                }) { (position) in
                    SettingVariabels.xBounceConstant = 0
                    SettingVariabels.yBounceConstant = 0
                }
                if !SettingVariabels.isSwallowed{
                    recycleBinView.swallowCircleAnimation()
                    recycleBinView.layer.zPosition = 1
                    SettingVariabels.isItemDeleted = true
                    SettingVariabels.isSwallowed = true
                }
            }else{
                SettingVariabels.xBounceConstant =  ( SettingVariabels.screenBounds.width/2 - location.x)/40
                SettingVariabels.yBounceConstant = 10
                if SettingVariabels.isSwallowed{
                    self.recycleBinView.releaseCircleAnimation()
                    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1,
                                                                   delay: 0,
                                                                   options: [],
                                                                   animations: {
                                                                    SettingVariabels.snapshotView!.center = location
                                                                    snapshotView.transform  = CGAffineTransform.identity
                    }) { (position) in
                        SettingVariabels.isSwallowed = false
                        SettingVariabels.isItemDeleted = false
                    }
                }else{
                    self.recycleBinView.releaseCircleAnimation()
                    snapshotView.center = location
                }
            }
            
            
            SettingVariabels.yVelocity = location.y - SettingVariabels.yOldLocation
            SettingVariabels.yOldLocation = location.y
            if SettingVariabels.velocityArray.count > 10{
                SettingVariabels.velocityArray.insert(SettingVariabels.yVelocity, at: 0)
                SettingVariabels.velocityArray.removeLast()
            }else{
                SettingVariabels.velocityArray.append(SettingVariabels.yVelocity)
            }
            
        case .ended :
            var velocity :Int{
                var summation = 0
                
                var zeroItemsCount = 0
                if SettingVariabels.velocityArray.count > 9{
                    for index in SettingVariabels.velocityArray.indices{
                        let velocityItem = Int(SettingVariabels.velocityArray[index])
                        if velocityItem == 0{
                            zeroItemsCount += 1
                        }
                        summation += velocityItem
                    }
                    if zeroItemsCount > 6{
                        return 0
                    }
                    return summation/SettingVariabels.velocityArray.count
                }else{
                    return 0
                }
            }
            guard let snapshotView = SettingVariabels.snapshotView else{return}
            SettingVariabels.animationDuration = 0.1
            if !SettingVariabels.isItemDeleted && velocity < 15 || SettingVariabels.yOldLocation < SettingVariabels.screenBounds.width/2  {
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3,
                                                               delay: 0,
                                                               options: [],
                                                               animations: {
                                                                snapshotView.center = SettingVariabels.snapshotLoction!
                                                                SettingVariabels.snapshotView?.transform  = CGAffineTransform(scaleX: 1, y: 1)
                                                                    guard let  collectionView = gesture.view as? UICollectionView else{
                                                                        return
                                                                    }
                                                                    
                                                                    collectionView.performBatchUpdates({
                                                                        collectionView.deletionDelegate!.insert(item: SettingVariabels.deletedItem! , at: SettingVariabels.snapshotIndexPath!.row)
                                                                       collectionView.insertItems(at: [SettingVariabels.snapshotIndexPath!])
                                                                       
                                                                    },  completion: { (result) in
                                                                        SettingVariabels.cell?.contentView.alpha = 1
                                                                    })

                }) { (position) in
                    for subview in self.view.subviews{
                        if subview == SettingVariabels.snapshotView{
                            subview.removeFromSuperview()
                        }
                    }
                    SettingVariabels.snapshotView = nil
                }
            }
            if velocity >= 15{
                SettingVariabels.animationDuration =  0.35 - Double(velocity)/250
            }
            
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: SettingVariabels.animationDuration ,
                                                           delay: 0,
                                                           options: [],
                                                           animations: {
                                                            let hidePoint = CGPoint(x: SettingVariabels.screenBounds.width/2 , y: SettingVariabels.screenBounds.height + self.recycleBinView.bounds.height )
                                                            self.recycleBinView.center  = hidePoint
                                                            if SettingVariabels.isItemDeleted || velocity >= 15 {
                                                                SettingVariabels.snapshotView!.center = hidePoint
                                                                snapshotView.transform  = CGAffineTransform(scaleX: self.recycleBinView.bounds.width/snapshotView.bounds.width,
                                                                                                            y: self.recycleBinView.bounds.height/snapshotView.bounds.height)
                                                            }
                                                            
                                                            // collectionView.reloadData()
            }) { (postion) in
                self.recycleBinView.isHidden = true
                self.recycleBinView.removeFromSuperview()
                if SettingVariabels.isItemDeleted || velocity >= 15{
                    for subview in self.view.subviews{
                        if subview == SettingVariabels.snapshotView{
                            subview.removeFromSuperview()
                        }
                    }
                    SettingVariabels.snapshotView = nil
                    SettingVariabels.cell?.contentView.alpha = 1
                }
            }
        default:
            break
        }
    }
    
    
    
    func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return CGFloat(sqrt(xDist * xDist + yDist * yDist))
    }
    
    
    func recycleBinApearenceAnimation()  {
        self.recycleBinView.isHidden = false
        recycleBinView.center  = CGPoint(x: SettingVariabels.screenBounds.width/2 ,
                                         y: SettingVariabels.screenBounds.height)
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1 ,
                                                       delay: 0,
                                                       options: [],
                                                       animations: {
                                                        self.recycleBinView.center  = CGPoint(x: SettingVariabels.screenBounds.width/2 ,
                                                                                              y: SettingVariabels.screenBounds.height  - 80)
        })
    }
    
}



