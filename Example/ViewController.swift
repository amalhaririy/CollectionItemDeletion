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
    let images = ["1", "2" ,"3","4","5","6","7","8","9","10","11","12","13","14","15"]
    var imagesArray = ["1", "2" ,"3","4","5","6","7","8","9","10","11","12","13","14","15"]
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
    
    @IBAction func resetButton(_ sender: Any) {
       imagesArray = images
        collectionView.reloadData()
    }
    
}

extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalCollectionCell", for: indexPath) as! VerticalCollectionCell
        cell.imageView.image = UIImage(named: imagesArray[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
    
}

extension ViewController : CollectionItemDeletionDelegate {
    func collectionArray() -> [Int] {
        return []
    }
    
    
    func item(at index: Int) -> Any {
        return imagesArray[index]
    }
    
    func insert(item: Any, at index: Int) {
        imagesArray.insert(item as! String , at: index)
    }
    
    
    
    func deleteItem(at index: Int) {
        imagesArray.remove(at: index)
    }
    
}

