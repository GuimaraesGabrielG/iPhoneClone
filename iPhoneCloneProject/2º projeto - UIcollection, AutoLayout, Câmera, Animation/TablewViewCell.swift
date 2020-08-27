//
//  TablewViewCell.swift
//  2º projeto - UIcollection, AutoLayout, Câmera, Animation
//
//  Created by Lelio Jorge Junior on 11/07/19.
//  Copyright © 2019 Gabriel Gonçalves Guimarães. All rights reserved.
//

import UIKit


protocol TableViewCellDelegate: class{
    func removeData(cell: TableViewCell)
}
class TableViewCell: UITableViewCell{
   
    @IBOutlet weak var imageViewTable: UIImageView!
    @IBOutlet weak var titleApp: UILabel!
    @IBOutlet weak var subtitleApp: UILabel!
    @IBOutlet weak var obterButton: UIButton!
    
    weak var delegate: TableViewCellDelegate?
    
    var imageTable: UIImage! {
        didSet{
          imageViewTable.image = imageTable
        }
    }
    var textTableView: UILabel! {
        didSet{
            titleApp.text = textTableView.text
            
        }
    }
    var subTextTableView: String! {
        didSet{
            subtitleApp.text = subTextTableView
        }
    }
    
    @IBAction func obterButton(_ sender: Any){
        delegate?.removeData(cell: self)
    }
}
