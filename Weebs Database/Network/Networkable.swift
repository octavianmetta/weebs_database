//
//  Networkable.swift
//  Weebs Database
//
//  Created by Octavian Metta Wisnu on 09/04/20.
//  Copyright © 2020 Octavian Metta Wisnu. All rights reserved.
//

import Foundation
import Moya

protocol Networkable {
    static var provider: MoyaProvider<ApiServices> { get }
    
}
