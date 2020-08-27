//
//  TableViewCell.swift
//  2º projeto - UIcollection, AutoLayout, Câmera, Animation
//
//  Created by Lelio Jorge Junior on 08/07/19.
//  Copyright © 2019 Gabriel Gonçalves Guimarães. All rights reserved.
//

import UIKit

protocol TableViewDelegate: class {
    func delete(cell: TableViewCell) /*Por Que não implementa a funsão*/
}


class TableViewCell: UITableViewCell {
   
    @IBOutlet weak var obterButton: UIButton!
    @IBOutlet weak var labelViewCell: UILabel!
    @IBOutlet weak var subTitleViewCell: UILabel!
    @IBOutlet weak var imageTableView: UIImageView!
    
    weak var delegate: TableViewDelegate?
    
    var nameGame: String! {
        didSet{
            labelViewCell.text = nameGame
        }
    }

    var imageNameGame: String! {
        didSet{
            imageTableView.image = UIImage(named: imageNameGame)
            imageTableView.layer.cornerRadius = 12
            obterButton.layer.cornerRadius = 13
        }
    }
    
    var subTitle: String!{
        didSet{
            subTitleViewCell.text = subTitle
        }
    }
        
    
    

    @IBAction func deleteApp(_ sender: Any) {
        delegate?.delete(cell: self)
    }
    
    
    
    
    
}






