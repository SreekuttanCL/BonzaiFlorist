//
//  HomeController.swift
//  Bonzai Florist
//
//  Created by Sreekuttan C L on 2019-11-29.
//  Copyright © 2019 Sreekuttan C L. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire
import AlamofireImage

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var flowerTableView: UITableView!
    
    var flowers = [Photo]()
    
    var selectedAlbum : Flowers?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //settign nav bar title
        self.navigationItem.title = "Home"
        
        //fetching flower data
        fetchFlowerData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return flowers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "flowerTableCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FlowerTableViewCell  else {
            fatalError("The dequeued cell is not an instance of FlowerTableViewCell.")
        }
        
        let flower = flowers[indexPath.row]
        
        // Extracting thumnailUrl from photo
        let imageUrlString = (flowers[indexPath.row].url)!
        
        let imageURL = URL(string: imageUrlString)
        //Creating image view for cells
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width:cell.frame.size.width, height:cell.frame.size.height))
        cell.imageView?.contentMode = UIView.ContentMode.scaleAspectFill
        
        //Adding placeholder image for the collection cells
        let placeholderImage = UIImage(named: "AppIcon")!
        
        
        cell.descriptionLabel.text = flower.title
        cell.imageView?.af_setImage(withURL: imageURL!,placeholderImage: placeholderImage)
        
        //cell.addSubview(imageView)
        
        return cell
    }
    
    func fetchFlowerData() {
        
        Alamofire.request(baseURL + "photos/").responseArray {(response:
            DataResponse<[Photo]>) in
            
            let flowersArray = response.result.value
            self.flowers = flowersArray ?? []
            
            if let photoArray = flowersArray {
                
                for photo in photoArray {
                    
                    if self.selectedAlbum?.id == photo.albumId {
                        self.flowers.append(photo)
                    }
                }
            }
            
            self.flowerTableView.reloadData()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if  segue.identifier == "showDetailedPhoto", let destination = segue.destination as? FlowerDetailController,
            let indexPath = self.flowerTableView.indexPath(for: sender as! UITableViewCell)
        {
            // passing selected photo to PhotoDetailViewController
            destination.selectedPhoto = flowers[indexPath.row]
        }
        
    }
}
