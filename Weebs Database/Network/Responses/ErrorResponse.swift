//
//  ErrorResponse.swift
//  Weebs Database
//
//  Created by Octavian Metta Wisnu on 14/04/20.
//  Copyright © 2020 Octavian Metta Wisnu. All rights reserved.
//

import Foundation

struct ErrorResponse : Decodable {
    let status: String
    let type: String
    let message: String
    let error: String
}
