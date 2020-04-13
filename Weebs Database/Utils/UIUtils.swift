//
//  UIUtils.swift
//  Weebs Database
//
//  Created by Octavian Metta Wisnu on 13/04/20.
//  Copyright © 2020 Octavian Metta Wisnu. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.alpha = 0
                        self?.image = image
                        UIView.animate(withDuration: 0.5, animations: {
                            self?.alpha = 1
                        })
                    }
                }
            }
        }
    }
}
