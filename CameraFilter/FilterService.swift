//
//  FilterService.swift
//  CameraFilter
//
//  Created by User on 24/6/19.
//  Copyright © 2019 amagain. All rights reserved.
//

import Foundation
import UIKit
import CoreImage

class FilterService {
    private var context: CIContext
    init() {
        self.context = CIContext()
    }
    
     func applyFilter(inputImage: UIImage, completion: @escaping ((UIImage) -> ())) {
        let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(4.0, forKey: kCIInputWidthKey)
        
        if let sourceImage = CIImage(image: inputImage) {
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            
            if let cgImage = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
                let processedImage = UIImage(cgImage: cgImage, scale: inputImage.scale, orientation: inputImage.imageOrientation)
                completion(processedImage)
            }
        }
        
    }
}
