//
//  AnimeDetail.swift
//  Weebs Database
//
//  Created by Octavian Metta Wisnu on 02/04/20.
//  Copyright © 2020 Octavian Metta Wisnu. All rights reserved.
//

import Foundation

struct AnimeDetail: Decodable {
    let mal_id: Int?
    let title: String?
    let title_japanese: String?
    let image_url: String?
    let episodes: Int?
    let score: Float?
    let synopsis: String?
}

extension AnimeDetail {
    func getEpisodes() -> String {
        if self.episodes != nil {
            return "\(self.episodes ?? 0) episodes"
        } else {
            return "On going"
        }
    }
}
