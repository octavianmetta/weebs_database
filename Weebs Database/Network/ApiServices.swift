//
//  ApiServices.swift
//  Weebs Database
//
//  Created by Octavian Metta Wisnu on 09/04/20.
//  Copyright © 2020 Octavian Metta Wisnu. All rights reserved.
//

import Foundation
import Moya

public enum ApiServices {
    
    case topAnime(page: Int)
    case topManga(page: Int)
    case animeDetail(idAnime: Int)
    case mangaDetail(idManga: Int)
    
}

extension ApiServices : TargetType {

    public var baseURL: URL {
        return URL(string: "https://api.jikan.moe/v3")!
    }
    
    public var path: String {
        switch self {
        case .topAnime(let page):
            return "/top/anime/\(page)/"
        case .topManga(let page):
            return "/top/manga/\(page)/"
        case .animeDetail(let idAnime):
            return "/anime/\(idAnime)"
        case .mangaDetail(let idManga):
            return "/manga/\(idManga)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .topAnime(_):
            return .get
        case .topManga(_):
            return .get
        case .animeDetail(_):
            return .get
        case .mangaDetail(_):
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .topAnime(_):
            return .requestPlain
        case .topManga(_):
            return .requestPlain
        case .animeDetail(_):
            return .requestPlain
        case .mangaDetail(_):
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}

