//
//  URLCellView.swift
//  Weather
//
//  Created by dant on 31/05/2019.
//  Copyright © 2019 adhumi. All rights reserved.
//

import Foundation
import UIKit
import Weather

public struct URLCellTable {
    let url : URL
    let day : String
    let description : String
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        guard let imageData = try? Data(contentsOf : url) else {
            return
        }
        let image = UIImage(data: imageData)
        DispatchQueue.main.async {
            completion(image)
        }
    }
}
