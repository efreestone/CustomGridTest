//
//  Image.swift
//  customGridTest
//
//  Created by Elijah Freestone on 12/18/16.
//  Copyright © 2016 Elijah Freestone. All rights reserved.
//

import UIKit

class Image {
    //Grab images and captions, inserting into array. These are coming from Images asset catalog and plist for now
    class func getAllImages() -> [Image] {
        var imagesDict = [Image]()
        if let URL = Bundle.main.url(forResource: "Images", withExtension: "plist") {
            if let imagesFromPlist = NSArray(contentsOf: URL) {
                for dictionary in imagesFromPlist {
                    let imageItem = Image(dictionary: dictionary as! NSDictionary)
                    imagesDict.append(imageItem)
                }
            }
        }
        return imagesDict
    }
    
    var title: String
    var image: UIImage
    
    //Initialize image opject with title and image file
    init(title: String, image: UIImage) {
        //Adding a space before and after allows more control of padding and line wrapping without having to seperate the title width constrants from the image
        self.title = " " + title + " "
        self.image = image
    }
    
    convenience init(dictionary: NSDictionary) {
        let title = dictionary["Caption"] as? String
        let photo = dictionary["Photo"] as? String
        let image = UIImage(named: photo!)?.decompressedImage
        self.init(title: title!, image: image!)
    }
    
    //Calculate height of the title label based on text and font, currently size 17 American Typewriter
    func heightForComment(_ font: UIFont, width: CGFloat) -> CGFloat {
        let rect = NSString(string: title).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        //print("heightForComment width = \(width)")
        return ceil(rect.height)
    }
    
}
