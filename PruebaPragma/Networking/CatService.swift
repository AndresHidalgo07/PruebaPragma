//
//  CapService.swift
//  TheCatApi
//
//  Created by Andres Hidalgo on 9/11/2022.
//  Copyright © 2022 Andres Hidalgo. All rights reserved.
//

import Foundation

//interface con la funcion value
protocol TheCatApiService {
    func value() -> String
}

enum TheCatApi: TheCatApiService {
    case subDirectory
    case fileExtension
    case fileNameDataFromServer
    case fileNameFavorites
    case fileNameFavorite
    
    func value() -> String {
        switch self {
        case .subDirectory:
            return  "TheCatApi"
        case .fileExtension:
                return "json"
        case .fileNameDataFromServer:
            return "fileFromServer"
        case .fileNameFavorites:
            return "allFavoriteCats"
        case .fileNameFavorite:
            return "favoriteCat"
        }
    }
    
}

class CatService: NSObject {
    let urlString = "https://api.thecatapi.com/v1/breeds"
    var items = [CatModel]()
    
    func loadData(completion: @escaping ([CatModel]) -> Void) {
        loadFromServer(completion: completion)
    }

    
    func loadFromServer(completion: @escaping ([CatModel]) -> Void) {
        //Load from server
        print("Load from server")
        
        HttpHelper.request(urlString, method: .get, params: nil, success: { [weak self] (dataResponse) in
            guard let self = self else { completion([]); return }
        
            do {
                let decoder =  JSONDecoder()
                self.items = try decoder.decode(Array<CatModel>.self, from: dataResponse.data!)
                    //decodifiacacion organizada por id
                    .sorted(by: { $0.id < $1.id })
                
                
            }catch let error {
                fatalError(error.localizedDescription)
            }
            completion(self.items)
            
        }) { (error) in
            fatalError(error.localizedDescription)
        }
    }
}
