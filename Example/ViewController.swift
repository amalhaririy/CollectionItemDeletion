//
//  ViewController.swift
//  Example
//
//  Created by Abdul Rahman on 7/2/19.
//  Copyright © 2019 Abdul Rahman. All rights reserved.
//

import UIKit
import CollectionItemDeletion
class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionArray1 = [1,2,3,4,5,6,7,8,9,10]
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI()  {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setupCollectionItsmdeletion()
        collectionView.deletionDelegate = self
        let nib  = UINib(nibName: "VerticalCollectionCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "VerticalCollectionCell")
    }
    

}

extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionArray1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalCollectionCell", for: indexPath) as! VerticalCollectionCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
}

extension ViewController : CollectionItemDeletionDelegate {
    func collectionArray() -> [Int] {
        return []
    }
    
    
    func item(at index: Int) -> Any {
        return collectionArray1[index]
    }
    
    func insert(item: Any, at index: Int) {
        collectionArray1.insert(item as! Int , at: index)
    }
    
    
    
    func deleteItem(at index: Int) {
        collectionArray1.remove(at: index)
    }
    
}

