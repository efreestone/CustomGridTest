//
//  GridCollectionViewCell.swift
//  customGridTest
//
//  Created by Elijah Freestone on 12/15/16.
//  Copyright © 2016 Elijah Freestone. All rights reserved.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var labelHeightLayoutConstraint: NSLayoutConstraint!
    
    //Override apply layout attributes to apply dynamic height for images
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        if let attributes = layoutAttributes as? CustomLayoutAttributes {
            imageViewHeightLayoutConstraint.constant = attributes.imageHeight
//            labelHeightLayoutConstraint.constant = attributes.annotationHeight
        }
    }
}
