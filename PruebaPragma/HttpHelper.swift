//
//  HttpHelper.swift
//  CatApi
//
//  Created by Andres Hidalgo on 9/11/2022.
//  Copyright © 2019 Andres Hidalgo. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift


enum ApiConstant {
    static let apiKey = "bda53789-d59e-46cd-9bc4-2936630fde39"
    static let baseURLPath = "https://api.thecatapi.com/v1/breeds"
    static let userId = "tldnpr"
    static var authenticationToken: String?
    static let headers = ["x-api-key":ApiConstant.apiKey]
}

final class HttpHelper: NSObject {

    class func request(_ url: URLConvertible, method: HTTPMethod, params: Parameters?, success: @escaping (DataResponse<Any>) -> Void, failure:@escaping (Error) -> Void) {
        Alamofire.request(url, method: method, parameters: params, headers: ApiConstant.headers).responseJSON { response in
            switch response.result {
            case .success:
                print(response)
                success(response)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
