//
//  CustomLayout.swift
//  customGridTest
//
//  Created by Elijah Freestone on 12/18/16.
//  Copyright © 2016 Elijah Freestone. All rights reserved.
//

import UIKit

protocol CustomLayoutDelegate {
    //Get height of image for cell
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
    //Get height of title for cell
    func collectionView(collectionView: UICollectionView, heightForTitleAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
}

class CustomLayoutAttributes: UICollectionViewLayoutAttributes {
    //Declare photo height
    var imageHeight: CGFloat = 0.0
    var titleHeight: CGFloat = 0.0
    
    //Override copyWithZone and conform to NSCopying protocol (required)
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! CustomLayoutAttributes
        copy.imageHeight = imageHeight
        copy.titleHeight = titleHeight
        return copy
    }
    
    //Override isEqual to compare attributes (required)
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? CustomLayoutAttributes {
            if attributes.imageHeight == imageHeight {
                return super.isEqual(object)
            }
        }
        //Photo heights are different, return false
        return false
    }
}

class CustomLayout: UICollectionViewLayout {
    //Set delegate
    var delegate: CustomLayoutDelegate!
    
    //Set columns and cell padding
    var numberOfColumns = 3
    var cellPadding: CGFloat = 7.0
    
    //Cache ALL cell attributes w/ custom layout
    fileprivate var cache = [CustomLayoutAttributes]()
    
    //Declare content height and width, calculated based on collection view width and insets
    fileprivate var contentHeight: CGFloat = 0.0
    fileprivate var contentWidth: CGFloat { let insets = collectionView!.contentInset
//        print("content width = \(collectionView!.bounds.width)")
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
    
    //Override and set custom attributes
    override class var layoutAttributesClass : AnyClass {
        return CustomLayoutAttributes.self
    }
    
    //Override prepare method for layout
    override func prepare() {
        //Calculate layout attributes if cache is empty
        if cache.isEmpty {
            //Calculate and fill x and y offset arrays
            let columnWidth = contentWidth / CGFloat(numberOfColumns)
            var xOffset = [CGFloat]()
            for column in 0..<numberOfColumns {
                xOffset.append(CGFloat(column) * columnWidth)
            }
            var column = 0
            var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
            
            //Loop through items in section
            for item in 0..<collectionView!.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(row: item, section: 0)
                
                //Calculate frames and insets
                let width = columnWidth - cellPadding * 2
                let imageHeight = delegate.collectionView(collectionView: collectionView!, heightForImageAtIndexPath: indexPath, withWidth: width)
                let titleHeight = delegate.collectionView(collectionView: collectionView!, heightForTitleAtIndexPath: indexPath, withWidth: width)
                
                let height = cellPadding + imageHeight + titleHeight + cellPadding
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                //Create instance of UICollectionViewLayoutAttributes & set inset
                let attributes = CustomLayoutAttributes(forCellWith: indexPath)
                attributes.imageHeight = imageHeight
                attributes.titleHeight = titleHeight
                attributes.frame = insetFrame
                //Add attributes to cache
                cache.append(attributes)
                
                //Expand content height to account for newly calculated item, advance yOffset & column
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height
                column = column >= (numberOfColumns - 1) ? 0 : column + 1
            }
        }
    }
    
    //Override content size with calculated height/width
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }
}
