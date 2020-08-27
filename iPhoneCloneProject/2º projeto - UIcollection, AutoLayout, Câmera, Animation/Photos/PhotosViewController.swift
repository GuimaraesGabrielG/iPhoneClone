//
//  PhotosViewController.swift
//  2º projeto - UIcollection, AutoLayout, Câmera, Animation
//
//  Created by Gabriel Gonçalves Guimarães on 08/07/19.
//  Copyright © 2019 Gabriel Gonçalves Guimarães. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionView: UICollectionView!


    @IBOutlet weak var lixeira: UIBarButtonItem!
   
    @IBOutlet weak var adicionar: UIBarButtonItem!
    
    @IBOutlet weak var compartilhar: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
        editButtonItem.title = "Selecionar"
        lixeira.isEnabled = false
        compartilhar.isEnabled = false
        adicionar.isEnabled = false
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    @IBAction func deletePhotos(_ sender: Any) {
        if let selected = collectionView.indexPathsForSelectedItems {
            let items = selected.map{$0.item}.sorted().reversed()
            for item in items{
                images.remove(at: item)
                
            }
            collectionView.deleteItems(at: selected)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCollectionViewCell
        
        cell.gallery.image = images[indexPath.row]

        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if !isEditing{
            let PhotosviewController = storyboard?.instantiateViewController(withIdentifier:
                "OpenPhotosViewController") as! OpenPhotosViewController
            self.present(PhotosviewController, animated: true, completion: nil)
            
            PhotosviewController.imagemAmpliada.image = images[indexPath.row]
        }

    }


    @IBAction func voltar(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
//        collectionView.reloadData()
        super.setEditing(editing, animated: animated)
        print(editing)
        if isEditing{
            editButtonItem.title = "Cancelar"
        }else{
            editButtonItem.title = "Selecionar"
        }

        lixeira.isEnabled = isEditing
        
        collectionView.allowsMultipleSelection = editing
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths{
            let cell = collectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
            cell.isEditing = editing
        }
    }
}

