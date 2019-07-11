//
//  PreviewViewController.swift
//  2º projeto - UIcollection, AutoLayout, Câmera, Animation
//
//  Created by Bernardo Nunes on 08/07/19.
//  Copyright © 2019 Gabriel Gonçalves Guimarães. All rights reserved.
//

import UIKit

var images = [UIImage]()

class PreviewViewController: UIViewController {

    var image: UIImage?
    
    @IBOutlet weak var preview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preview.image = image

    }
    
    @IBAction func save(_ sender: Any) {
        if let aux = image {
            images.append(aux)
            UIImageWriteToSavedPhotosAlbum(aux, self, nil, nil)
        }
        performSegue(withIdentifier: "showMain", sender: nil)
    }
}
