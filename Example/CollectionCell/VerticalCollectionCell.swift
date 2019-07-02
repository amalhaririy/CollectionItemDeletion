//
//  VerticalCollectionCell.swift
//  Example
//
//  Created by Abdul Rahman on 7/2/19.
//  Copyright © 2019 Abdul Rahman. All rights reserved.
//

import UIKit

class VerticalCollectionCell: UICollectionViewCell {

    @IBOutlet weak var XView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        XView.layer.cornerRadius = 15
    }

}
