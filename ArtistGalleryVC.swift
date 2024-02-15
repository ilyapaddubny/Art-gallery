//
//  ArtistGalleryVC.swift
//  Art gallery
//
//  Created by Ilya Paddubny on 14.02.2024.
//

import UIKit

class ArtistGalleryVC: UIViewController {
    
    let testLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        testLabel.center = view.center
        view.addSubview(testLabel)

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
