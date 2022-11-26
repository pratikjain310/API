//
//  ViewController.swift
//  Project1
//
//  Created by ashutosh deshpande on 03/11/2022.
//

import UIKit
// Created Structure Because using API and the structure contain var same as on API
struct PhotoAPI : Decodable{
    var albumId : Int
    var id : Int
    var title : String
    var url : String
    var thumbnailUrl : String
}
class ViewController: UIViewController {

    @IBAction func favouriteBarButton(_ sender: Any) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
        //detailVC.receivedPost = photo[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    @IBOutlet weak var photoCollectionView: UICollectionView!
    var photo : [PhotoAPI] = [] // created OBJECT of Structure
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAPI() // called function that is used for fetching API
        // Do any additional setup after loading the view.
    }
    func fetchAPI(){
        let str = "https://jsonplaceholder.typicode.com/photos"
        let url = URL(string: str) // converted string to url
        //  using unowned for self as self is ViewController and it is distroyed last and there can not be 2 self so we declare self in handler as UNOWNED
        URLSession.shared.dataTask(with: url!) { [unowned self] (data, response, error) in
            do{
                if error == nil { // checked if response is nil or not
                    self.photo = try JSONDecoder().decode([PhotoAPI].self, from: data!) // here data from API is decoded using JSON Decoder and store in a variable
                    
                    DispatchQueue.main.async {
                        self.photoCollectionView.reloadData() // Collection view is reloaded
                    }
                }
            }catch let error{
                print(error.localizedDescription)
            }
        }.resume()
    }

}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainCollectionViewCell // written AS because we have made a Cocoa Touch file for a cell
        let obj = photo[indexPath.row] // fetch all the details of API wheich were store in photo is store in obj line by line
        let url = URL(string: obj.url) // image URL is converted into URL
        do{
            let data = try Data(contentsOf: url!) // DATA(contentsOf throws so its written in do catch block and the URL is converted into Data
            cell.photoImageView.image = UIImage(data: data) // now that data is passed through UIIMage to ImageView and No need to Install any third party Function
        } catch let error{
            print(error.localizedDescription)
        }
        return cell
    }
    
        // when a particular cell is selected what will happen is written here
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // after click on particular cell we get navigated to next screen
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        detailVC.receivedPost = photo[indexPath.row] // passing value fetch from API from main to second screen by creating a variable receivedPost on SecondViewController and assigning a value using storyboard variable.
        navigationController?.pushViewController(detailVC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 413, height: 232) // width and height of cell which we have used while design so it will look same at runtime
    }
}

