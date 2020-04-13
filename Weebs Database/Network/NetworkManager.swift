//
//  NetworkManager.swift
//  Weebs Database
//
//  Created by Octavian Metta Wisnu on 01/04/20.
//  Copyright © 2020 Octavian Metta Wisnu. All rights reserved.
//

import Foundation
import Moya

class NetworkManager: Networkable {
    
    static var provider = MoyaProvider<ApiServices>(plugins: [NetworkLoggerPlugin()])
    
    static func request(
        target: ApiServices,
        success successCallback: @escaping (Response) -> Void,
        error errorCallback: @escaping (Response) -> Void,
        failure failureCallback: ((MoyaError) -> Void)? = nil
        ) {
        //TODO: Add network manager
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode >= 200 && response.statusCode <= 399 {
                    successCallback(response)
                } else {
                    errorCallback(response)
                }
            case .failure(_):
                failureCallback
            }
        }
    
    }
}
