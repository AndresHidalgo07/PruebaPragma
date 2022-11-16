//
//  ViewModel.swift
//  TheCatApi
//
//  Created by Andres Hidalgo on 9/11/2022.
//  Copyright © 2022 Andres Hidalgo. All rights reserved.
//

import Foundation
import UIKit

//interface que da funcionalidad
protocol CatViewModelService {
    func loadData(completion: @escaping () -> Void)
    func loadImage(index: Int, completion: @escaping (UIImage?) -> Void)
}

class CatViewModel: NSObject {
    var items: [CatModel]
    var catService: CatService

    init(items: [CatModel], catService: CatService) {
        self.items = items
        self.catService = catService
    }
    
    deinit {
        print("deinit: CatViewModel")
    }
}

extension CatViewModel: CatViewModelService {
    
    func loadData(completion: @escaping () -> Void) {
        catService.loadData { [weak self] (cats) in
            self?.items = cats
            completion()
        }
    }
    
    func loadImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = URL(string: items[index].image!.imageUrl) else { completion(nil); return }
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let data = try? Data(contentsOf: imageUrl) else { completion(nil); return }
            let image = UIImage(data: data)
            self?.items[index].image!.image = image
            completion(image)
        }
    }
}
