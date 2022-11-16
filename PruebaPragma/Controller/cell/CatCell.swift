//
//  CatCell.swift
//  TheCatApi
//
//  Created by Andres Hidalgo on 9/11/2022.
//  Copyright © 2022 Andres Hidalgo. All rights reserved.
//

import UIKit

class CatCell: UITableViewCell {
    static let cellIdentifier = "Cell"
    let favorite = UIImage(named: "favorite")
    let notFavorite = UIImage(named: "notFavorite")
    
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var favContainView: UIView!
    @IBOutlet weak var razaLabel: UILabel!
    @IBOutlet weak var paisLabel: UILabel!
    @IBOutlet weak var inteligenciaLabel: UILabel!
    
    var viewModelService: CatViewModelService?
    var index: Int!

    func configure(index: Int, item: CatModel, viewModelService: CatViewModelService?) {
        self.index = index
        self.viewModelService = viewModelService
        

        // enviar imagen gatos
        if let image = item.image?.image {
            catImageView?.image = image
        }else {
            viewModelService?.loadImage(index: index, completion: { [weak self] (image) in
                DispatchQueue.main.async {
                    self?.catImageView.image = image
                }
            })
        }
        razaLabel?.text = item.name
        paisLabel?.text = item.origin
        inteligenciaLabel?.text = item.temperament
        inteligenciaLabel.adjustsFontSizeToFitWidth = true
    }
    
    deinit {
        print("deinit: CatCell")
    }
}
