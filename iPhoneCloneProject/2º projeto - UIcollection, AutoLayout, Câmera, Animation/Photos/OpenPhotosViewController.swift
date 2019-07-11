//
//  OpenPhotosViewController.swift
//  2º projeto - UIcollection, AutoLayout, Câmera, Animation
//
//  Created by Gabriel Gonçalves Guimarães on 08/07/19.
//  Copyright © 2019 Gabriel Gonçalves Guimarães. All rights reserved.
//

import UIKit

class OpenPhotosViewController: UIViewController {

    @IBOutlet weak var imagemAmpliada: UIImageView!
    
    let imagemAm = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagemAmpliada.image = imagemAm
        // Do any additional setup after loading the view.
    }

    @IBAction func voltar(_ sender: Any) {
        dismiss(animated: true, completion:  nil)
    }
    
    
}
