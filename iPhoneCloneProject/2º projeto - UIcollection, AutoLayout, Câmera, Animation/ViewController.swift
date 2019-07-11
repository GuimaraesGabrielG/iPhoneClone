//
//  ViewController.swift
//  2º projeto - UIcollection, AutoLayout, Câmera, Animation
//
//  Created by Gabriel Gonçalves Guimarães on 07/07/19.
//  Copyright © 2019 Gabriel Gonçalves Guimarães. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var dados:[App] = [App(imagem: UIImage(named: "persist")!, texto: "Persist"), App(imagem: UIImage(named: "aiyra")!, texto: "Aiyra"), App(imagem: UIImage(named: "shadowFear")!, texto: "shadowFear"), App(imagem: UIImage(named: "redemption")!, texto: "Redemption"),App(imagem: UIImage(named: "nochickenfordinner")!, texto: "NoChickenForDinner"), App(imagem: UIImage(named: "lumi")!, texto: "Lumni"), App(imagem: UIImage(named: "ghostValley")!, texto: "Ghost Valley"), App(imagem: UIImage(named: "flua")!, texto: "Flua"), App(imagem: UIImage(named: "botwar")!, texto: "Botwar"), App(imagem: UIImage(named: "appStore")!, texto: "App Store"), App(imagem: UIImage(named: "photo")!, texto: "Fotos"), App(imagem: UIImage(named: "dystopian")!, texto: "Dystopian"), App(imagem: UIImage(named: "camera")!, texto: "Câmera") ]
    
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let ponte = AppCollectionViewCell()
    
    var statusBar: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        okButton.isHidden = true
        okButton.isEnabled = false
        self.collectionView.backgroundColor = UIColor.clear
        collectionView.allowsMultipleSelection = true
        
        let backgroundImage = UIImage.init(named: "wall")
        let backgroundImageView = UIImageView.init(frame: self.view.frame)
        
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFit
        
        self.view.insertSubview(backgroundImageView, at: 0)
        
    }
    @IBAction func ok(_ sender: Any) {
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths{
            let cell = collectionView.cellForItem(at: indexPath) as? AppCollectionViewCell
            cell?.isPress = false
            
            // Stop animation here.
            
            
            
            // ----------
        }
        okButton.isHidden = true
        okButton.isEnabled = false
        collectionView.reloadData()
    }
    //Mark: - Cell
    override var prefersStatusBarHidden: Bool{
        return statusBar
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dados.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AppCollectionViewCell
        
        cell.delegate = self
        cell.configuracao(with: dados[indexPath.row])
        
        if dados[indexPath.row].texto == "Fotos"{
            cell.accessibilityIdentifier = "Fotos"
        } else if dados[indexPath.row].texto == "App Store"{
            cell.accessibilityIdentifier = "App Store"
        } else if dados[indexPath.row].texto == "Câmera"{
            cell.accessibilityIdentifier = "Câmera"
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AppCollectionViewCell else { return }
        
        let press = UILongPressGestureRecognizer(target: self, action: #selector(self.seila))
        
        cell.addGestureRecognizer(press)
        
        if !isEditing{
            if cell.accessibilityIdentifier == "App Store"{
//                let viewController = storyboard?.instantiateViewController(withIdentifier:"TableViewController") as! UITableViewController
//                self.present(viewController, animated: true, completion: nil)
                performSegue(withIdentifier: "showApps", sender: nil)
            } else if cell.accessibilityIdentifier == "Fotos"{
//                let PhotosviewController = storyboard!.instantiateViewController(withIdentifier: "PhotosViewController")
//                self.present(PhotosviewController, animated: true, completion: nil)
                performSegue(withIdentifier: "showPhotos", sender: nil)

            } else if cell.accessibilityIdentifier == "Câmera" {
//                let CameraviewController = storyboard!.instantiateViewController(withIdentifier: "CameraViewController")
//                self.present(CameraviewController, animated: true, completion: nil)
                performSegue(withIdentifier: "showCamera", sender: nil)
            }
            
            
        }
    
    }
    @objc func seila() {
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths{
            guard let cell = collectionView.cellForItem(at: indexPath) as? AppCollectionViewCell else { return }
            cell.isPress = true
            //animation
            cell.isAnimation = true
        }
        okButton.isHidden = false
        okButton.isEnabled = true
        isEditing = true
        statusBar = true
    }
    
    @objc func tap(){
        print("normal")
    }
}




// Mark: - Delete Cell
extension ViewController: CollectionViewCellDelegate{
    func delete(cell: AppCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell){
            
            self.dados.remove(at: indexPath.row)
            var indexPaths: [IndexPath] = []
            indexPaths.append(indexPath)
            collectionView.deleteItems(at: indexPaths)
            
            let visibelItems = collectionView.indexPathsForVisibleItems
            //let finish = visibelItems.count-1
            
            for i in visibelItems{
                if let item = collectionView.cellForItem(at: i) as? AppCollectionViewCell {
                    item.isAnimation = true
                }
            }
        }
    }
    
    //    Mark: - Animation
    func transform(cell: AppCollectionViewCell) {
        
        UIView.animate(withDuration: 0.15, delay: 0, options: [.repeat,.autoreverse,.allowUserInteraction], animations: {
            cell.transform = CGAffineTransform.init(rotationAngle: -0.015 * CGFloat.pi)
            cell.transform = CGAffineTransform.init(rotationAngle: 0.015 * CGFloat.pi)
            
        }, completion: nil)
    }
}

