//
//  ImageCollectionViewCell.swift
//  CollectionViewExample
//
//  Created by Bruno Bilescky on 28/09/15.
//  Copyright © 2015 bgondim. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView :UIImageView!
    @IBOutlet weak var smallImageView :UIImageView!
    
    override func awakeFromNib() {
        smallImageView.hidden = false
//        imageView.adjustsImageWhenAncestorFocused = true
//        smallImageView.adjustsImageWhenAncestorFocused = true
    }
    
}
