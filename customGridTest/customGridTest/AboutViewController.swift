//
//  AboutViewController.swift
//  customGridTest
//
//  Created by Elijah Freestone on 12/18/16.
//  Copyright © 2016 Elijah Freestone. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var aboutTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aboutString = "I didn’t know Acceptance had rules until I brought my Aaron Carter backpack to school on the first day of 6th grade. It’s the first time I remember feeling embarrassed without anyone telling me to be. I bought a new backpack that afternoon.\n..\nBefore that, I had lived unashamed in that sweet space between the very real, very visible world & the one in my mind, where I was one inch tall dodging giant feet, or I was a human ferret fighting bad guys with swords, or I was riding my Pegasus across the sky, with my own hands pulling clouds like a blanket to cover the earth with April showers, where I had a very cool boyfriend (his name—if you haven’t already guessed—was Aaron, and he was a rapping, rocking, super cute pop star with spiky bleached hair and a famous older brother).\n..\nSince then, life and art have been practices in rediscovering the magic I knew back before I knew a backpack could make me look so bad.\n..\nI’m a bit of a misfit, and I know it, and I’m tired of trying to pretend that I’m not. I’m an artist, for goodness’ sake. I live in LA but I hate trying to be cool. I love being a woman but I hate “acting like a lady.” I love the way of Jesus, but I’m afraid of the people who follow him. Teamwork makes me cry, and so does the news. I’m an artist, for goodness’ sake. I feel it all.\n..\nI love words, and how they create space for all of it to coexist—all of these self-contradictory Yesses, the Hope and the None-Of-It, the Beauty and the Heartache, the Truth and the Mystery.\n..\nSo consider my writing my best Back-to-that-Sweet-Space effort, where we create freedom by reminding one another there is power there in the choosing to let our souls breathe, and we bless the world when we allow ourselves to simply be.\n..\nHere’s to wearing that dorky backpack you like so much, and, with a big crooked smile, being proud that you do."
        
        aboutTextView.text = aboutString
        self.automaticallyAdjustsScrollViewInsets = false
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
