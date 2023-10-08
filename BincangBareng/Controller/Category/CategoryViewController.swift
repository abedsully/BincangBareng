//
//  CategoryViewController.swift
//  BincangBareng
//
//  Created by Stefanus Albert Wilson on 10/6/23.
//

import UIKit
import CLTypingLabel

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var welcomeLabel: CLTypingLabel!
    
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
        
        welcomeLabel.text = "Who do you want to play with today?"
    }
    
}

// MARK: - Collection View Delegate Methods


extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return text.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.categoryCell, for: indexPath) as! CategoryCollectionViewCell
        
        cell.labelCategory.text = text[indexPath.row]
        cell.imageCategory.image = UIImage(named: images[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width)
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
