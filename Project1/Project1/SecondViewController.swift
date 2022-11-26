//
//  SecondViewController.swift
//  Project1
//
//  Created by ashutosh deshpande on 03/11/2022.
//

import UIKit

class SecondViewController: UIViewController {
    var receivedPost : PhotoAPI?
//    var favphoto : [Favourite] = []
    var flag = 1
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        do{
//            favphoto = try context.fetch(Favourite.fetchRequest())
//
//        }catch let error{
//            print(error.localizedDescription)
//        }
//        print("select id = \(receivedPost?.id) ")
        let str = receivedPost?.thumbnailUrl
        let url = URL(string: str!)
        do{
            let data = try Data(contentsOf: url!)
            thumbnailImageView.image = UIImage(data: data)
            titleLabel.text = receivedPost?.title
        }catch let error{
            print(error.localizedDescription)
        }
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
           favImageView.isUserInteractionEnabled = true
           favImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
//        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if(flag == 1){
            favImageView.image = UIImage(systemName: "star.fill")
            let fav = Favourite(context: context)
            let a = receivedPost?.albumId
            let b = receivedPost?.id
            fav.albumId = Int32(a!)
            fav.id = Int32(b!)
            fav.title = receivedPost?.title
            fav.url = receivedPost?.url
            fav.thumbnailUrl = receivedPost?.thumbnailUrl
            fav.flag = Int32(flag)
            flag = 0
            do{
                try context.save()
            }catch let error {
                print(error.localizedDescription)
            }
        }
     
    }
}

