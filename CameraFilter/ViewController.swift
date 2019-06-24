//
//  ViewController.swift
//  CameraFilter
//
//  Created by User on 24/6/19.
//  Copyright © 2019 amagain. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var applyFilterButton: UIButton!
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
            let photosCVC = navC.viewControllers.first as? PhotosCollectionViewController else {
                fatalError("Segue as not found")
        }
        photosCVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
            
        }).disposed(by: disposeBag)
    }
    
    private func updateUI(with image: UIImage) {
        self.photoImageView.image = image
        self.applyFilterButton.isHidden = false
    }
    
    @IBAction func applyFilterButtonPressed() {
        guard let sourceImage = self.photoImageView.image else {
            return
        }
        
        FilterService().applyFilter(inputImage: sourceImage) { filteredImage in
            DispatchQueue.main.async {
                self.photoImageView.image = filteredImage
            }
        }
    }
    
}

