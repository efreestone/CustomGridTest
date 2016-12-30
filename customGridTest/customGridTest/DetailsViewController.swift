//
//  DetailsViewController.swift
//  customGridTest
//
//  Created by Elijah Freestone on 12/15/16.
//  Copyright © 2016 Elijah Freestone. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    var detailsImageObject: Image = imagesDictionary[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("Image name on details = \(detailsImageObject.title)")
        
        imageView.image = detailsImageObject.image
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
