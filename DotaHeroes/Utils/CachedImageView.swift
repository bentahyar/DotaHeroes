//
//  CachedImageView.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 13/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class CachedImageView: UIImageView {
    func setCacheImageURL(_ cacheImageURL: URL?) {
        guard let cacheImageURL = cacheImageURL else {
            return
        }

        AF.request(cacheImageURL).validate().responseData { response in
            switch response.result {
            case let .success(data):
                self.image = UIImage(data: data)
            case .failure:
                break
            }
        }
    }
}
