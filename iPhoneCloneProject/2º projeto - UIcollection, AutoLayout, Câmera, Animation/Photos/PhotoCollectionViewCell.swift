//
//  PhotoCollectionViewCell.swift
//  2º projeto - UIcollection, AutoLayout, Câmera, Animation
//
//  Created by Gabriel Gonçalves Guimarães on 08/07/19.
//  Copyright © 2019 Gabriel Gonçalves Guimarães. All rights reserved.
//

import UIKit



class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gallery: UIImageView!
    @IBOutlet weak var selecionar: UIImageView!
    
    var isEditing = false {
        didSet{
            if !isEditing {
                gallery.alpha = 1.0
                selecionar.isHidden = true
            }
           
        }
    }

    
    override var isSelected: Bool{
            didSet{
                print(isEditing)
                if isEditing {
                    gallery.alpha   = isSelected ? 0.5 : 1.0
                    selecionar.isHidden = isSelected ? false : true
                }
            }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gallery.layer.bounds = CGRect(x: .zero, y: .zero, width: 140, height: 140)
    }

}
