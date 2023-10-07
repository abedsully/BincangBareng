//
//  CategoryViewController.swift
//  BincangBareng
//
//  Created by Stefanus Albert Wilson on 10/6/23.
//

import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images: [String] =
    [
        "partnerCategory", "familyCategory", "friendsCategory"
    ]
    
    var text: [String] =
    [
        "Partner", "Family", "Friends"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
}

// MARK: - Collection View Delegate Methods


extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return text.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.collectionViewCell, for: indexPath) as! CategoryCollectionViewCell
        
        cell.labelCategory.text = text[indexPath.row]
        cell.imageCategory.image = UIImage(named: images[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width)
        return CGSize(width: size, height: size)
    }
    
}
