//
//  TablewViewController.swift
//  2º projeto - UIcollection, AutoLayout, Câmera, Animation
//
//  Created by Lelio Jorge Junior on 11/07/19.
//  Copyright © 2019 Gabriel Gonçalves Guimarães. All rights reserved.
//

import UIKit


class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entrou?")
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppStore.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.imageTable = AppStore[indexPath.row].imagem
        cell.titleApp.text = AppStore[indexPath.row].texto
        
        return cell
    }
    
    
}
extension TableViewController: TableViewCellDelegate{
    func removeData(cell: TableViewCell) {
        
    }
    
    
}
