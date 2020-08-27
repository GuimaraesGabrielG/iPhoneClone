//
//  TableViewController.swift
//  2º projeto - UIcollection, AutoLayout, Câmera, Animation
//
//  Created by Lelio Jorge Junior on 08/07/19.
//  Copyright © 2019 Gabriel Gonçalves Guimarães. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    //    @IBOutlet weak var obterButton: UIView!

    var tableApps: [String] = ["lumi","nochickenfordinner","flua"]
    var tableAppsSubTitles: [String] = ["subTitle1","subTitle2","subTitle3"]
    //    var rowIndex: IndexPath
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableApps.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.nameGame = tableApps[indexPath.row]
        cell.imageNameGame = tableApps[indexPath.row]
        cell.subTitle = tableAppsSubTitles[indexPath.row]
        cell.delegate = self /*NÃO ENTENDI*/
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            tableApps.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    //    {
    //        rowIndex = indexPath
    //    }
//    @IBAction func deleteApp(_ sender: Any) {
//
//        let rowIndex = obterButton2.is
//        self.tableApps.remove(at: rowIndex!.row)
//        tableView.reloadData()
//
//    }
    
    
    
}

// MARK: - Delete Cell (Obter)

extension TableViewController: TableViewDelegate{
    func delete(cell: TableViewCell) {
        if let indexPath = tableView.indexPath(for: cell){
            self.tableApps.remove(at: indexPath.row)
            tableAppsSubTitles.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
