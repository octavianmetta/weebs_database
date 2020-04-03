//
//  Anime.swift
//  Weebs Database
//
//  Created by Octavian Metta Wisnu on 01/04/20.
//  Copyright © 2020 Octavian Metta Wisnu. All rights reserved.
//

import Foundation

struct Anime: Decodable{
    let mal_id: Int
    let title: String
    let image_url: String
    let score: Float
    
}
