//
//  Cat.swift
//  TheCatApi
//
//  Created by Andres Hidalgo on 9/11/2022.
//  Copyright © 2019 Andres Hidalgo. All rights reserved.
//

import Foundation
import UIKit

class CatModel: Codable{
    
    var weight: Weight?
    var id, name: String
    var cfa_url: String?
    var vetstreetURL: String?
    var vcahospitalsURL: String?
    var temperament, origin, countryCodes, countryCode: String?
    var pragmaDescription, lifeSpan: String?
    var indoor, lap: Int?
    var altNames: String?
    var adaptability, affectionLevel, childFriendly, dogFriendly: Int?
    var energyLevel, grooming, healthIssues, intelligence: Int?
    var sheddingLevel, socialNeeds, strangerFriendly, vocalisation: Int?
    var experimental, hairless, natural, rare: Int?
    var rex, suppressedTail, shortLegs: Int?
    var wikipediaURL: String?
    var hypoallergenic: Int?
    var referenceImageID: String?
    var image: Image?
    var catFriendly, bidability: Int?
}
struct Image: Codable {
    var id: String
    var imageUrl: String
    var image: UIImage?
    var isFavorite: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id 
        case imageUrl = "url"
    }
}

class Weight: Codable {
    var imperial, metric: String?

    init(imperial: String?, metric: String?) {
        self.imperial = imperial
        self.metric = metric
    }
}
