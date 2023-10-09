//
//  OnboardingViewController.swift
//  BincangBareng
//
//  Created by Stefanus Albert Wilson on 10/6/23.
//

import UIKit

class OnboardingViewController: UIViewController {


    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    var slide: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            if currentPage == slide.count - 1 {
                nextButton.setTitle(Constant.newButtonTitle, for: .normal)
            }
            
            else{
                nextButton.setTitle(Constant.buttonTitle, for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slide =
        [
            OnboardingSlide(title: "Welcome to BincangBareng", description: "Your go-to app for meaningful conversations with your loved ones", image: #imageLiteral(resourceName: "couple")),
            OnboardingSlide(title: "Curated Question Lists", description: "Discover a wide range of thought-provoking questions tailored to suit various contexts, from casual hangouts to heart-to-heart talks.", image: #imageLiteral(resourceName: "family")),
            OnboardingSlide(title: "Customizable Lists", description: "Craft your own question lists based on specific topics and occasions with the people you're conversing with.", image: #imageLiteral(resourceName: "friends"))
        ]
        
        
    }
    
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        if currentPage == slide.count - 1 {
            let controller = storyboard?.instantiateViewController(withIdentifier: Constant.toCategoryIdentifier) as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)
            
        } else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentPage
        }

 
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slide.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.onboardingCell, for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setup(slide[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        
        currentPage = Int(scrollView.contentOffset.x / width)
        
        pageControl.currentPage = currentPage
    }
    
}
