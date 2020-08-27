//
//  ViewController.swift
//  2º projeto - UIcollection, AutoLayout, Câmera, Animation
//
//  Created by Gabriel Gonçalves Guimarães on 07/07/19.
//  Copyright © 2019 Gabriel Gonçalves Guimarães. All rights reserved.
//

import UIKit

var dados: [App] = [App(imagem: UIImage(named: "persist")!, texto: "Persist"), App(imagem: UIImage(named: "aiyra")!, texto: "Aiyra"), App(imagem: UIImage(named: "shadowFear")!, texto: "shadowFear"), App(imagem: UIImage(named: "redemption")!, texto: "Redemption"),App(imagem: UIImage(named: "nochickenfordinner")!, texto: "No Chicken For Dinner"), App(imagem: UIImage(named: "lumi")!, texto: "Lumni"), App(imagem: UIImage(named: "ghostValley")!, texto: "Ghost Valley"), App(imagem: UIImage(named: "flua")!, texto: "Flua"), App(imagem: UIImage(named: "botwar")!, texto: "Botwar"), App(imagem: UIImage(named: "appStore")!, texto: "App Store"), App(imagem: UIImage(named: "photo")!, texto: "Fotos"), App(imagem: UIImage(named: "dystopian")!, texto: "Dystopian"), App(imagem: UIImage(named: "camera")!, texto: "Câmera") ]

var AppStore: [App] = [App(imagem: UIImage(named: "linkedin")!, texto: "Linkedin")]

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let ponte = AppCollectionViewCell()
    
    var statusBar: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        okButton.layer.cornerRadius = 13
        okButton.isHidden = true
        okButton.isEnabled = false
        self.collectionView.backgroundColor = UIColor.clear
        collectionView.allowsMultipleSelection = true
        
        let backgroundImage = UIImage.init(named: "wall")
        let backgroundImageView = UIImageView.init(frame: self.view.frame)
        self.view.insertSubview(backgroundImageView, belowSubview: self.collectionView)
        
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 1).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 1).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 1).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 1).isActive = true
        
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 2, bottom: 5, right: 2)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 5
        
        layout.itemSize = CGSize(width: 90, height: 118)
        
        collectionView.collectionViewLayout = layout
        
    }
    
    @IBAction func ok(_ sender: Any) {
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths{
            let cell = collectionView.cellForItem(at: indexPath) as? AppCollectionViewCell
            cell?.isPress = false
        }
        okButton.isHidden = true
        okButton.isEnabled = false
        statusBar = false
        isEditing = false
        setNeedsStatusBarAppearanceUpdate()
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

                performSegue(withIdentifier: "showApps", sender: nil)
            } else if cell.accessibilityIdentifier == "Fotos"{

                performSegue(withIdentifier: "showPhotos", sender: nil)

            } else if cell.accessibilityIdentifier == "Câmera" {

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
        setNeedsStatusBarAppearanceUpdate()
    }
}




// Mark: - Delete Cell
extension ViewController: CollectionViewCellDelegate{
    func delete(cell: AppCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell){
            let alert = UIAlertController(title: "Apagar \"\(cell.labelApp.text!)\"?", message: "O apagamento deste app também apagará os dados nele contidos", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Apagar", style: .destructive, handler: { (UIAlertAction) in
                AppStore.append(dados[indexPath.row])
                dados.remove(at: indexPath.row)
                var indexPaths: [IndexPath] = []
                indexPaths.append(indexPath)
                self.collectionView.deleteItems(at: indexPaths)
                
                let visibelItems = self.collectionView.indexPathsForVisibleItems
                //let finish = visibelItems.count-1
                
                for i in visibelItems{
                    if let item = self.collectionView.cellForItem(at: i) as? AppCollectionViewCell {
                        item.isAnimation = true
                    }
                }
            }))

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }
    }
    
    //    Mark: - Animation
    func transform(cell: AppCollectionViewCell) {
        let delay = Double.random(in: 0..<1)
        
        UIView.animate(withDuration: 0.15, delay: 0, options: [.repeat,.autoreverse,.allowUserInteraction], animations: {
            switch(delay){
            case 0...0.5:
                cell.transform = CGAffineTransform.init(rotationAngle: -0.015 * CGFloat.pi)
                cell.transform = CGAffineTransform.init(rotationAngle: 0.015 * CGFloat.pi)
                
                break
            default:
                cell.transform = CGAffineTransform.init(rotationAngle: 0.015 * CGFloat.pi)
                cell.transform = CGAffineTransform.init(rotationAngle: -0.015 * CGFloat.pi)
            }
            
        }, completion: { _ in
            cell.transform = CGAffineTransform(rotationAngle: 0.0)
        })
    }
}





