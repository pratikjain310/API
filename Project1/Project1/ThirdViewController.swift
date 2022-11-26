//
//  ThirdViewController.swift
//  Project1
//
//  Created by ashutosh deshpande on 04/11/2022.
//

import UIKit
import CoreData

class ThirdViewController: UIViewController {
    var favphoto : [Favourite] = []
//    var indexPath = IndexPath()
    @IBOutlet weak var favCollectionView: UICollectionView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            
            favphoto = try context.fetch(Favourite.fetchRequest())
            favCollectionView.reloadData()
          
           }catch let error{
            print(error.localizedDescription)
        }
    
    }
    
  
    

}

extension ThirdViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favphoto.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavCollectionViewCell
        let obj = favphoto[indexPath.row]
        let url = URL(string: obj.url!)
        do{
            let data = try Data(contentsOf: url!)
            cell.photoImageView.image = UIImage(data: data)
        } catch let error{
            print(error.localizedDescription)
        }
        if(obj.flag == 1){
            cell.favImageView.image = UIImage(systemName: "star.fill")
            
        }
    //    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavCollectionViewCell
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
//        cell.favImageView.isUserInteractionEnabled = true
//        cell.favImageView.addGestureRecognizer(tapGestureRecognizer)
//    
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 413, height: 232)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = favphoto[indexPath.row]

        if(obj.flag == 1){

            favphoto.remove(at: indexPath.row)
            context.delete(obj)
            do{
                try context.save()
                favCollectionView.deleteItems(at: [indexPath])
            }catch let error {
                print (error.localizedDescription)
            }
        }
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavCollectionViewCell
//
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
//        cell.favImageView.isUserInteractionEnabled = true
//        cell.favImageView.addGestureRecognizer(tapGestureRecognizer)
//
    
    }
}
