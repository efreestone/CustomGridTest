//
//  Image.swift
//  customGridTest
//
//  Created by Elijah Freestone on 12/18/16.
//  Copyright © 2016 Elijah Freestone. All rights reserved.
//

import UIKit

class Image {
    
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
    
    init(title: String, image: UIImage) { //comment: String,
        self.title = title
        self.image = image
    }
    
    convenience init(dictionary: NSDictionary) {
        let title = dictionary["Caption"] as? String
        //let comment = dictionary["Comment"] as? String
        let photo = dictionary["Photo"] as? String
        let image = UIImage(named: photo!)?.decompressedImage
        self.init(title: title!, image: image!) //comment: comment!,
    }
    
    func heightForComment(_ font: UIFont, width: CGFloat) -> CGFloat {
        let rect = NSString(string: title).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return ceil(rect.height)
    }
    
}
