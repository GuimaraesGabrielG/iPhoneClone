//
//  AppCollectionViewCell.swift
//  2º projeto - UIcollection, AutoLayout, Câmera, Animation
//
//  Created by Gabriel Gonçalves Guimarães on 07/07/19.
//  Copyright © 2019 Gabriel Gonçalves Guimarães. All rights reserved.
//

import UIKit
protocol CollectionViewCellDelegate: class {
    func delete(cell: AppCollectionViewCell)
    func transform(cell: AppCollectionViewCell)
}
class AppCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: CollectionViewCellDelegate?
    
    
    @IBOutlet weak var deleteButtonCell: UIButton!
    @IBOutlet weak var imagemApp: UIImageView!
    @IBOutlet weak var labelApp: UILabel!
    
    var isPress: Bool! {
        didSet{
            deleteButtonCell.isHidden = !isPress
            deleteButtonCell.isEnabled = isPress
        }
    }
    
    
    override func awakeFromNib() {
        isPress = false
        super.awakeFromNib()
        imagemApp.contentMode = .scaleAspectFit
        imagemApp.layer.cornerRadius = 17
        deleteButtonCell.layer.cornerRadius = deleteButtonCell.bounds.width / 2.0
        deleteButtonCell.layer.masksToBounds = true
        
    }
    var isAnimation : Bool!{
        didSet{
            delegate?.transform(cell: self)

        }
    }
    
    
    public func configuracao(with model: App){
        imagemApp.image = model.imagem
        labelApp.text = model.texto
    }

    @IBAction func deleteButtonCollection(_ sender: Any){
        delegate?.delete(cell: self)

    }
    
}
