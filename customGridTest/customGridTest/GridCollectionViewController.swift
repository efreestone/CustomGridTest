//
//  GridCollectionViewController.swift
//  customGridTest
//
//  Created by Elijah Freestone on 12/15/16.
//  Copyright © 2016 Elijah Freestone. All rights reserved.
//

import UIKit
import AVFoundation

//Create/grab dictionary with all images and their titles
var imagesDictionary = Image.getAllImages()

class GridCollectionViewController: UICollectionViewController {
    fileprivate let reuseIdentifier = "testCell"
    fileprivate var itemSelected: Image = imagesDictionary[0]
    fileprivate var numberOfColumns = UIApplication.shared.statusBarOrientation.isLandscape ? 3 : 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set title font
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "American Typewriter", size: 17)!]
        
        //Set delegate if CustomLayout is current layout
        if let layout = collectionView?.collectionViewLayout as? CustomLayout {
            layout.delegate = self
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("viewWillTransition")
        //Set number of columns based on orientation
        numberOfColumns = UIDevice.current.orientation.isLandscape ? 3 : 2
        self.collectionViewLayout.invalidateLayout()
    }
}

// MARK: - UICollectionViewDataSource
extension GridCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesDictionary.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GridCollectionViewCell
        //Grab image and title label text
        let cellImage = imagesDictionary[indexPath.row].image
//        print("Cell image height = \(cell.imageView.frame.height)")
//        print("Cell height = \(cell.frame.height)")
        let labelText = imagesDictionary[indexPath.row].title
        print("Char count = \(labelText.characters.count)")
        
        cell.imageView.image = cellImage
        cell.imageLabel.text = labelText //"\(indexPath.row) " +
//        print("cell label width = \(cell.imageLabel.frame.width)")
//        cell.imageLabel.backgroundColor = UIColor.lightGray
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GridCollectionViewController {
    //Majority of the standard delegate method jobs are taken care of by the custom layout
    //These include overall layout, cell size, headers & footers, and inset
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        itemSelected = imagesDictionary[indexPath.row]
        print("Selected = \(itemSelected.title)")
        
        return true
    }
}

// MARK: - Custom Layout Delegate
extension GridCollectionViewController: CustomLayoutDelegate {
    //Get height of image while reataining aspect ratio
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        let imageObject = imagesDictionary[indexPath.row]
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let imageRect = AVMakeRect(aspectRatio: imageObject.image.size, insideRect: boundingRect)
        return imageRect.size.height
    }
    
    //Get height for title
    func collectionView(collectionView: UICollectionView, heightForTitleAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        let titlePadding = CGFloat(5)
        let imageObject = imagesDictionary[indexPath.row]
        let font = UIFont(name: "American Typewriter", size: 17)
        let commentHeight = imageObject.heightForComment(font!, width: width - titlePadding)
        let heightOfTitle = titlePadding + commentHeight + titlePadding
        return heightOfTitle
    }
    
    //Set number of columns based on orientation
    func setNumberOfColumns() -> Int {
        return numberOfColumns
    }
}

// MARK: - Navigation
extension GridCollectionViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue" {
            let destinationVC = segue.destination as! DetailsViewController
            //Pass selected item and set title
            destinationVC.detailsImageObject = itemSelected
            destinationVC.title = itemSelected.title
        }
    }
}

