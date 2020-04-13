//
//  AnimeProviders.swift
//  Weebs Database
//
//  Created by Octavian Metta Wisnu on 09/04/20.
//  Copyright © 2020 Octavian Metta Wisnu. All rights reserved.
//

import Foundation
import Moya

struct AnimeProviders {
    
    func getTopAnime(
        completion: @escaping (_ response: TopResponse?, _ error: Response?) -> Void
        ){
        
        NetworkManager.request(target: .topAnime, success: { (response) in
            do {
                let resp = try response.map(TopResponse.self)
                
                completion(resp, nil)
            } catch {
                print(error.localizedDescription)
            }
        }, error: { (error) in
            completion(nil, error)
        })
    }
}
