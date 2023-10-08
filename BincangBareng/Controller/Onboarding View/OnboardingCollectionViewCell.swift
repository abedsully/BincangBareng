//
//  OnboardingCollectionViewCell.swift
//  BincangBareng
//
//  Created by Stefanus Albert Wilson on 10/8/23.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
        
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitle: UILabel!
    @IBOutlet weak var slideDescription: UILabel!
    
    
    func setup(_ slide: OnboardingSlide){
        slideImageView.image = slide.image
        slideTitle.text = slide.title
        slideDescription.text = slide.description
    }
    
    
}
