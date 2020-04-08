//
//  PosterDetailViewController.swift
//  Weebs Database
//
//  Created by Octavian Metta Wisnu on 08/04/20.
//  Copyright © 2020 Octavian Metta Wisnu. All rights reserved.
//

import UIKit

class PosterDetailViewController: UIViewController {

    @IBAction func backToHome(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToAnime", sender: self)
    }
    @IBOutlet weak var posterImageView: UIImageView!
    var posterImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.posterImageView.image = posterImage
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
